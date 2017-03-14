Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhzg90kzvzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 13:47:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E2d5IP036470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:47:39 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 295vx6ngh8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:47:39 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 08:17:36 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E2lXbZ36175882
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 08:17:33 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E2lWRn012739
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 08:17:33 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH] kernfs: Check KERNFS_HAS_RELEASE before calling
 kernfs_release_file()
Date: Tue, 14 Mar 2017 08:17:00 +0530
Message-Id: <20170314024700.6167-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently started seeing a kernel oops when a module tries removing a
memory mapped sysfs bin_attribute. On closer investigation the root
cause seems to be kernfs_release_file() trying to call
kernfs_op.release() callback that's NULL for such sysfs
bin_attributes. The oops occurs when kernfs_release_file() is called from
kernfs_drain_open_files() to cleanup any open handles with active
memory mappings.

The patch fixes this by checking for flag KERNFS_HAS_RELEASE before
calling kernfs_release_file() in function kernfs_drain_open_files().

On ppc64-le arch with cxl module the oops back-trace is of the
form below:
[  861.381126] Unable to handle kernel paging request for instruction fetch
[  861.381360] Faulting instruction address: 0x00000000
[  861.381428] Oops: Kernel access of bad area, sig: 11 [#1]
....
[  861.382481] NIP: 0000000000000000 LR: c000000000362c60 CTR:
0000000000000000
....
Call Trace:
[c000000f1680b750] [c000000000362c34] kernfs_drain_open_files+0x104/0x1d0 (unreliable)
[c000000f1680b790] [c00000000035fa00] __kernfs_remove+0x260/0x2c0
[c000000f1680b820] [c000000000360da0] kernfs_remove_by_name_ns+0x60/0xe0
[c000000f1680b8b0] [c0000000003638f4] sysfs_remove_bin_file+0x24/0x40
[c000000f1680b8d0] [c00000000062a164] device_remove_bin_file+0x24/0x40
[c000000f1680b8f0] [d000000009b7b22c] cxl_sysfs_afu_remove+0x144/0x170 [cxl]
[c000000f1680b940] [d000000009b7c7e4] cxl_remove+0x6c/0x1a0 [cxl]
[c000000f1680b990] [c00000000052f694] pci_device_remove+0x64/0x110
[c000000f1680b9d0] [c0000000006321d4] device_release_driver_internal+0x1f4/0x2b0
[c000000f1680ba20] [c000000000525cb0] pci_stop_bus_device+0xa0/0xd0
[c000000f1680ba60] [c000000000525e80] pci_stop_and_remove_bus_device+0x20/0x40
[c000000f1680ba90] [c00000000004a6c4] pci_hp_remove_devices+0x84/0xc0
[c000000f1680bad0] [c00000000004a688] pci_hp_remove_devices+0x48/0xc0
[c000000f1680bb10] [c0000000009dfda4] eeh_reset_device+0xb0/0x290
[c000000f1680bbb0] [c000000000032b4c] eeh_handle_normal_event+0x47c/0x530
[c000000f1680bc60] [c000000000032e64] eeh_handle_event+0x174/0x350
[c000000f1680bd10] [c000000000033228] eeh_event_handler+0x1e8/0x1f0
[c000000f1680bdc0] [c0000000000d384c] kthread+0x14c/0x190
[c000000f1680be30] [c00000000000b5a0] ret_from_kernel_thread+0x5c/0xbc

Fixes: f83f3c515654("kernfs: fix locking around kernfs_ops->release()
callback")
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 fs/kernfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e4dc7a..ac2dfe0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -809,7 +809,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		if (kn->flags & KERNFS_HAS_MMAP)
 			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
 
-		kernfs_release_file(kn, of);
+		if (kn->flags & KERNFS_HAS_RELEASE)
+			kernfs_release_file(kn, of);
 	}
 
 	mutex_unlock(&kernfs_open_file_mutex);
-- 
2.9.3
