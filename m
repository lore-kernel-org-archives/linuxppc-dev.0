Return-Path: <darrick.wong@oracle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVVrX2827zDqlV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 14:33:48 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVVrW5pjXz9t1H
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 14:33:47 +1000 (AEST)
Date: Wed, 15 Jun 2016 21:33:40 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: kernel bug in "Drop WIMG in favour of new constants"?
Message-ID: <20160616043340.GB22590@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
boots.  4.6 booted just fine, so I bisected the kernel to the commit
30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
favour of new constants".  The changelog suggests that the KVM changes need
closer review, and here's an actual crash:

(I can send libvirt's machine xml, .config, and full dmesg if that helps.)

--Darrick

dmesg from the crash looks like:

[    0.474264] mm: Hashing failure ! EA=0xd000080080000010 access=0x800000000000000c current=swapper
[    0.474777]     trap=0x300 vsid=0x13d349c ssize=1 base psize=0 psize 0 pte=0xc0000101200001ae
[    0.475102] mm: Hashing failure ! EA=0xd000080080000010 access=0x800000000000000c current=swapper
[    0.475363]     trap=0x300 vsid=0x13d349c ssize=1 base psize=0 psize 0 pte=0xc0000101200001ae
[    0.475805] Unable to handle kernel paging request for data at address 0xd000080080000010
[    0.476060] Faulting instruction address: 0xc00000000053b4bc
[    0.476415] Oops: Kernel access of bad area, sig: 7 [#1]
[    0.476604] PREEMPT pSeries
[    0.476904] Modules linked in:
[    0.477192] CPU: 0 PID: 1 Comm: swapper Not tainted 4.7.0-rc3-pcsum #11
[    0.477523] task: c00000007f950000 ti: c00000007f94c000 task.ti: c00000007f94c000
[    0.477757] NIP: c00000000053b4bc LR: c00000000053b4a8 CTR: 0000000000000000
[    0.477985] REGS: c00000007f94f740 TRAP: 0300   Not tainted  (4.7.0-rc3-pcsum)
[    0.478205] MSR: 8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 84000242  XER: 00000000
[    0.478640] CFAR: c0000000000083b4 DAR: d000080080000010 DSISR: 40000000 SOFTE: 1 
GPR00: c00000000053b4a8 c00000007f94f9c0 c000000000e24000 d000080080000010 
GPR04: d000080080003000 c00000007aecf018 4000000000000000 000000007f9c8000 
GPR08: 000000007aecf000 c0000101200031ae 00000000000001ff 0000000000000300 
GPR12: 0000000084000242 c00000000ffff000 c00000000000b2a0 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 c00000000094a3b8 
GPR24: c000000000d952a8 c00000000099a098 c00000000102c250 c000000000e51088 
GPR28: 000000000000ffff d000080080000000 0000000000004000 c00000007ae1b000 
[    0.481144] NIP [c00000000053b4bc] .quirk_usb_early_handoff+0x48c/0xd00
[    0.481365] LR [c00000000053b4a8] .quirk_usb_early_handoff+0x478/0xd00
[    0.481602] Call Trace:
[    0.481763] [c00000007f94f9c0] [c00000000053b4a8] .quirk_usb_early_handoff+0x478/0xd00 (unreliable)
[    0.482119] [c00000007f94fab0] [c0000000004312ac] .pci_do_fixups+0xdc/0x140
[    0.482368] [c00000007f94fb60] [c00000000098427c] .pci_apply_final_quirks+0xb0/0x194
[    0.482621] [c00000007f94fc10] [c00000000000aa48] .do_one_initcall+0x68/0x1e0
[    0.482853] [c00000007f94fcf0] [c000000000957278] .kernel_init_freeable+0x238/0x320
[    0.483108] [c00000007f94fdb0] [c00000000000b2c4] .kernel_init+0x24/0x160
[    0.483351] [c00000007f94fe30] [c000000000009230] .ret_from_kernel_thread+0x58/0xa8
[    0.483618] Instruction dump:
[    0.483808] 7d3e07b4 4bfff9e1 2fa30000 41befc8c e87f0320 7fc4f378 4bb093fd 60000000 
[    0.484163] 7c7d1b79 4182fc74 387d0010 7c0004ac <7d201c2c> 0c090000 4c00012c 2f89ffff 
[    0.485685] ---[ end trace 38f2f4e017e75b42 ]---
[    0.509029] 
[    1.512619] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
