Return-Path: <jallen@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6758B1A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:51:40 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Mon, 2 Nov 2015 13:51:38 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7A9B31FF004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 13:39:47 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2KpZBN53608490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 13:51:35 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2KpZ2r008055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 13:51:35 -0700
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH] memory-hotplug: Fix kernel warning during memory hotplug on
 ppc64
Message-ID: <5637CCD5.2080202@linux.vnet.ibm.com>
Date: Mon, 2 Nov 2015 14:51:33 -0600
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
that has multiple sections per memory block.

[   78.300767] ------------[ cut here ]------------
[   78.300768] WARNING: at ../drivers/base/memory.c:210
[   78.300769] Modules linked in: rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag af_packet xfs libcrc32c ibmveth(X) rtc_generic btrfs xor raid6_pq xts gf128mul dm_crypt sd_mod sr_mod cdrom crc_t10dif ibmvscsi(X) scsi_transport_srp scsi_tgt dm_mod sg scsi_mod autofs4
[   78.300789] Supported: Yes, External
[   78.300791] CPU: 1 PID: 3090 Comm: systemd-udevd Tainted: G              X 3.12.45-1-default #1
[   78.300793] task: c0000004d7d1d970 ti: c0000004d7b90000 task.ti: c0000004d7b90000
[   78.300794] NIP: c0000000004fcff8 LR: c0000000004fda84 CTR: 0000000000000000
[   78.300795] REGS: c0000004d7b93930 TRAP: 0700   Tainted: G              X  (3.12.45-1-default)
[   78.300796] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24088848  XER: 00000000
[   78.300800] CFAR: c0000000004fcf98 SOFTE: 1
GPR00: 0000000000000537 c0000004d7b93bb0 c000000000e7f200 0000000000053000
GPR04: 0000000000001000 0000000000000001 c000000000e0f200 0000000000000000
GPR08: 0000000000000000 0000000000000001 0000000000000537 00000000014dc000
GPR12: 0000000000054000 c00000000e7f0900 0000000010041040 0000000000000000
GPR16: 00000100206f0010 000000001003ff78 000000001006c824 00000000100410b0
GPR20: 000000001003ff90 000000001006c00c 000001002073cd20 00000100206f0760
GPR24: 00000100206f85a0 c00000000076d950 c0000004ef7c95e0 c0000004d7b93e00
GPR28: c0000004de601738 0000000000000001 c000000001218f80 00000000003fffff
[   78.300818] NIP [c0000000004fcff8] memory_block_action+0x258/0x2e0
[   78.300820] LR [c0000000004fda84] memory_subsys_online+0x54/0x100
[   78.300821] Call Trace:
[   78.300822] [c0000004d7b93bb0] [c000000009071ce0] 0xc000000009071ce0 (unreliable)
[   78.300824] [c0000004d7b93c40] [c0000000004fda84] memory_subsys_online+0x54/0x100
[   78.300826] [c0000004d7b93c70] [c0000000004df784] device_online+0xb4/0x120
[   78.300828] [c0000004d7b93cb0] [c0000000004fd738] store_mem_state+0x88/0x220
[   78.300830] [c0000004d7b93cf0] [c0000000004db448] dev_attr_store+0x68/0xa0
[   78.300833] [c0000004d7b93d30] [c00000000031f938] sysfs_write_file+0xf8/0x1d0
[   78.300835] [c0000004d7b93d90] [c00000000027d29c] vfs_write+0xec/0x250
[   78.300837] [c0000004d7b93de0] [c00000000027dfdc] SyS_write+0x6c/0xf0
[   78.300839] [c0000004d7b93e30] [c00000000000a17c] syscall_exit+0x0/0x7c
[   78.300840] Instruction dump:
[   78.300841] 780a0560 79482ea4 7ce94214 2fa70000 41de0014 7d09402a 396b4000 7907ffe3
[   78.300844] 4082ff54 3cc2fff9 8926b83a 69290001 <0b090000> 2fa90000 40de006c 3860fff0
[   78.300847] ---[ end trace dfec8da06ebbc762 ]---

The warning is triggered because there is a udev rule that automatically
tries to online memory after it has been added. The udev rule varies from
distro to distro, but will generally look something like:

SUBSYSTEM=="memory", ACTION=="add", ATTR{state}=="offline", ATTR{state}="online"

On any architecture that uses memory_probe_store to reserve memory,
this can interrupt the memory reservation process. This patch modifies
memory_probe_store to take the hotplug sysfs lock to prevent the online
of added memory before the completion of the probe.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2804aed..baf7a22 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -457,6 +457,10 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
 		return -EINVAL;

+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
 	for (i = 0; i < sections_per_block; i++) {
 		nid = memory_add_physaddr_to_nid(phys_addr);
 		ret = add_memory(nid, phys_addr,
@@ -467,6 +471,8 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;
 	}

+	unlock_device_hotplug();
+
 	ret = count;
 out:
 	return ret;
