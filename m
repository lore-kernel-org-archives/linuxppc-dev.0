Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBkDK1DcwzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 08:13:04 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w03LCv6G121075
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jan 2018 16:13:02 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f965yhnyf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 16:13:02 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 3 Jan 2018 16:13:00 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: [PATCH v3 0/1] Make RAS IRQ explicitly dependent on DLPAR workqueue
Date: Wed,  3 Jan 2018 19:12:51 -0200
Message-Id: <20180103211252.24615-1-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch replaces "[PATCH v2 0/1] Increase dlpar initcall priority"

1. Testing without this patch, using QEMU:

[    0.022800] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
[    0.022865] NET: Registered protocol family 1
[    0.023435] Unpacking initramfs...
(qemu) object_add memory-backend-ram,id=mem1,size=10G                                   
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1                                          
[    0.095354] Unable to handle kernel paging request for data at address 0xf94d03007c421378
[    0.095409] Faulting instruction address: 0xc00000000012d744
[    0.095450] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.095482] LE SMP NR_CPUS=2048 NUMA pSeries
[    0.095516] Modules linked in:
[    0.095542] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-ziviani+ #26
[    0.095592] task:         (ptrval) task.stack:         (ptrval)
[    0.095634] NIP:  c00000000012d744 LR: c00000000012d744 CTR: 0000000000000000
[    0.095683] REGS:         (ptrval) TRAP: 0380   Not tainted  (4.15.0-rc2-ziviani+)
[    0.095729] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088042  XER: 20040000
[    0.095780] CFAR: c00000000012d3c4 SOFTE: 0 
[    0.095780] GPR00: c00000000012d744 c0000000fffefb90 c000000001290c00 0000000000000000 
[    0.095780] GPR04: 000000007fffffff c0000000fe20bb40 00000000000003d7 c0000000012cdd78 
[    0.095780] GPR08: 0000000000000001 00000000ffffffff 00000000fed10000 0000000000001001 
[    0.095780] GPR12: c0000000000c6800 c00000000fac0000 c00000000000d1a8 0000000000008000 
[    0.095780] GPR16: 0000000000000000 c0000000fea0a007 c000000000c44d78 0000000000000001 
[    0.095780] GPR20: 0000000000000000 c000000000e2c8a8 c000000001452af8 0000000000000000 
[    0.095780] GPR24: c000000001452af0 c0000000fffefe70 0000000000000000 c000000000e2c8a8 
[    0.095780] GPR28: 0000000000000800 0000000000000000 c0000000fe20bb40 f94d03007c421378 
[    0.096174] NIP [c00000000012d744] __queue_work+0xd4/0x5c0
[    0.096207] LR [c00000000012d744] __queue_work+0xd4/0x5c0
[    0.096241] Call Trace:
[    0.096258] [c0000000fffefb90] [c00000000012d744] __queue_work+0xd4/0x5c0 (unreliable)
[    0.096308] [c0000000fffefc70] [c00000000012dce4] queue_work_on+0xb4/0xf0
snip
[    0.097459] ---[ end trace b527625ce4033fad ]---
[    0.099233] 
[    1.099254] Kernel panic - not syncing: Fatal exception in interrupt
[    1.103312] Rebooting in 10 seconds..

2. Testing with this patch, with QEMU again:

[    0.023086] NET: Registered protocol family 1
[    0.023664] Unpacking initramfs...
(qemu) object_add memory-backend-ram,id=mem1,size=10G                                   
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1                                          
[    0.163178] pseries-hotplug-mem: Attempting to hot-add 40 LMB(s) at index 80000010
[    0.163416] radix-mmu: Mapped 0xc000000100000000-0xc000000110000000 with 2.00 MiB pages
[    0.163830] radix-mmu: Mapped 0xc000000110000000-0xc000000120000000 with 2.00 MiB pages
snip
[    0.189706] pseries-hotplug-mem: Memory at 100000000 (drc index 80000010) was hot-added
[    0.189753] pseries-hotplug-mem: Memory at 110000000 (drc index 80000011) was hot-added
snip
...normal initialization

(qemu)  info memory-devices 
Memory device [dimm]: "dimm1"
  addr: 0x100000000
  slot: 0
  node: 0
  size: 10737418240
  memdev: /objects/mem1
  hotplugged: true
  hotpluggable: true

Jose Ricardo Ziviani (1):
  powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ

 arch/powerpc/platforms/pseries/dlpar.c   | 21 ++++++++++++++++++---
 arch/powerpc/platforms/pseries/pseries.h |  2 ++
 arch/powerpc/platforms/pseries/ras.c     |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.14.1
