Return-Path: <jallen@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6471A029B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 09:30:35 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Wed, 6 Jan 2016 15:30:31 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7773C3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 15:30:04 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u06MU4KH25493504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jan 2016 22:30:04 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u06MU3gj025322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jan 2016 17:30:03 -0500
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, akpm@linux-foundation.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH v4] memory-hotplug: Fix kernel warning during memory hotplug
 on ppc64
To: gregkh@linuxfoundation.org
Message-ID: <568D9568.1010808@linux.vnet.ibm.com>
Date: Wed, 6 Jan 2016 16:30:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a bug where a kernel warning is triggered when performing
a memory hotplug on ppc64. This warning may also occur on any architecture
that uses the memory_probe_store interface.

WARNING: at drivers/base/memory.c:200
CPU: 9 PID: 13042 Comm: systemd-udevd Not tainted 4.4.0-rc4-00113-g0bd0f1e-dirty #7
NIP [c00000000055e034] pages_correctly_reserved+0x134/0x1b0
LR [c00000000055e7f8] memory_subsys_online+0x68/0x140
Call Trace:
[c0000000fa9e7b50] [c0000000fa9e7b90] 0xc0000000fa9e7b90 (unreliable)
[c0000000fa9e7bb0] [c00000000055e7f8] memory_subsys_online+0x68/0x140
[c0000000fa9e7bf0] [c000000000540064] device_online+0xb4/0x120
[c0000000fa9e7c30] [c00000000055e6c0] store_mem_state+0xb0/0x180
[c0000000fa9e7c70] [c00000000053c5e4] dev_attr_store+0x34/0x60
[c0000000fa9e7c90] [c0000000002db0a4] sysfs_kf_write+0x64/0xa0
[c0000000fa9e7cb0] [c0000000002da0cc] kernfs_fop_write+0x17c/0x1e0
[c0000000fa9e7d00] [c0000000002481b0] __vfs_write+0x40/0x160
[c0000000fa9e7d90] [c000000000248ce8] vfs_write+0xb8/0x200
[c0000000fa9e7de0] [c000000000249b40] SyS_write+0x60/0x110
[c0000000fa9e7e30] [c000000000009260] system_call+0x38/0xd0

The warning is triggered because there is a udev rule that automatically
tries to online memory after it has been added. The udev rule varies from
distro to distro, but will generally look something like:

SUBSYSTEM=="memory", ACTION=="add", ATTR{state}=="offline", ATTR{state}="online"

On any architecture that uses memory_probe_store to reserve memory, the
udev rule will be triggered after the first section of the block is
reserved and will subsequently attempt to online the entire block,
interrupting the memory reservation process and causing the warning.
This patch modifies memory_probe_store to add a block of memory with
a single call to add_memory as opposed to looping through and adding
each section individually. A single call to add_memory is protected by
the mem_hotplug mutex which will prevent the udev rule from onlining
memory until the reservation of the entire block is complete.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
v2: -Move call to unlock_device_hotplug under "out" label
v3: -Update changelog with trimmed traces from newer kernel
    -After further testing and reviewing the original purpose of
     the lock_device_hotplug_sysfs mutex, modified solution to
     fix the issue by replacing loop that adds memory section
     by section with a single call to add_memory.
v4: -Remove unused variable 'i'

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 25425d3..e5c6ff0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -450,8 +450,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
 	u64 phys_addr;
-	int nid;
-	int i, ret;
+	int nid, ret;
 	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;

 	ret = kstrtoull(buf, 0, &phys_addr);
@@ -461,15 +460,12 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
 		return -EINVAL;

-	for (i = 0; i < sections_per_block; i++) {
-		nid = memory_add_physaddr_to_nid(phys_addr);
-		ret = add_memory(nid, phys_addr,
-				 PAGES_PER_SECTION << PAGE_SHIFT);
-		if (ret)
-			goto out;
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	ret = add_memory(nid, phys_addr,
+			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);

-		phys_addr += MIN_MEMORY_BLOCK_SIZE;
-	}
+	if (ret)
+		goto out;

 	ret = count;
 out:
