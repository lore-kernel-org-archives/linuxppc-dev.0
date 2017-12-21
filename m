Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2bbf68qhzF0BX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 02:46:38 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBLFkV3e034830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 10:46:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f0f5n9umx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 10:46:32 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Thu, 21 Dec 2017 08:44:57 -0700
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: [PATCH 0/1] Uses the system workqueue as fallback
Date: Thu, 21 Dec 2017 13:44:47 -0200
Message-Id: <20171221154448.22965-1-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to avoid kernel panic after memory hotplug in early stages of the boot
process (which the kernel is already able to handle IRQs), this patch uses the
system workqueue as a fallback to the hotplug workqueue.

After this patch I'm not able to reproduce the problem and the memory is
successfuly plugged at any stage in the boot process.

Thank you

Error scenario:

Booting Linux via __start() @ 0x0000000002000000 ...
[    0.000000] Detected Power 8 processor 
[    0.000000] Warning: Processor - this hardware has not undergone testing by Red Hat and might not be certified. Please consult https://hardware.redhat.com for certified hardware.
 -> smp_release_cpus()
spinning_secondaries = 3
 <- smp_release_cpus()
Linux ppc64le
#1 SMP Wed Nov 2[    0.021319] Unable to handle kernel paging request for data at address 0x00000100
[    0.021379] Faulting instruction address: 0xc00000000015c420
[    0.021423] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.021457] LE SMP NR_CPUS=2048 NUMA pSeries
[    0.021493] Modules linked in:
[    0.021522] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-9.el7a.ppc64le #1
[    0.021572] task: c00000047bb80000 task.stack: c00000047bbc0000
[    0.021615] NIP:  c00000000015c420 LR: c00000000015cae4 CTR: 0000000000000000
[    0.021666] REGS: c00000047ffeb920 TRAP: 0380   Not tainted  (4.14.0-9.el7a.ppc64le)
[    0.021715] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000042  XER: 20000000
[    0.021769] CFAR: c00000000015cae0 SOFTE: 0 
[    0.021769] GPR00: c00000000015cae4 c00000047ffebba0 c0000000014ca600 0000000000000800 
[    0.021769] GPR04: 0000000000000000 c00000047e1e5000 00000000000001a0 c0000000000e19e0 
[    0.021769] GPR08: 0000000fffffffe1 0000000000000000 0000000fffffffe0 0000000002001001 
[    0.021769] GPR12: c0000000000e0ea0 c000000007ac0000 c00000000000d0b8 0000000000000000 
[    0.021769] GPR16: 0000000000000000 c00000047e1e5000 0000000000000000 0000000000000000 
[    0.021769] GPR20: 0000000000000000 0000000000000001 0000000000000002 0000000000000015 
[    0.021769] GPR24: c0000001fdc075b8 0000000000000001 c0000001fdc07400 0000000000000000 
[    0.021769] GPR28: 0000000000000800 0000000000000000 0000000000000000 0000000000000800 
[    0.022196] NIP [c00000000015c420] __queue_work+0x80/0x690
[    0.022231] LR [c00000000015cae4] queue_work_on+0xb4/0xf0
[    0.022264] Call Trace:
[    0.022283] [c00000047ffebba0] [c00000000017d948] ttwu_do_wakeup+0x228/0x290 (unreliable)
[    0.022334] [c00000047ffebc90] [c00000000015cae4] queue_work_on+0xb4/0xf0
[    0.022377] [c00000047ffebcd0] [c0000000000e36d0] queue_hotplug_event+0xe0/0x160
[    0.022428] [c00000047ffebd20] [c0000000000e0fe0] ras_hotplug_interrupt+0x140/0x160
[    0.022480] [c00000047ffebdb0] [c0000000001d0a20] __handle_irq_event_percpu+0xa0/0x330
...
[    1.024963] Kernel panic - not syncing: Fatal exception in interrupt
[    1.027080] Rebooting in 10 seconds..

Test case 1: Hotplug during the boot process, after the hotplug wq
initialization

    0.554391] rtas_flash: no firmware flash support
[    0.554464] >>>>>>>>>>>>>>>> [devlog pseries_hp_wq] ALLOCed
[    0.555021] Initialise system trusted keyrings
...
...
Welcome to Red Hat Enterprise Linux Server 7.4 (Maipo) dracut-033-502.el7 (Initramfs)!
...
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
(qemu) object_add memory-backend-ram,id=mem1,size=10G
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
[    0.754432] >>>>>>>>>>>>>>>> [devlog pseries_hp_wq] 0xfec52400L
[    0.765465] pseries-hotplug-mem: Attempting to hot-add 40 LMB(s) at index 80000010
[    0.765710] radix-mmu: Mapped 0xc000000100000000-0xc000000110000000 with 2.00 MiB pages
...
(qemu) info memory-devices
Memory device [dimm]: "dimm1"
  addr: 0x100000000
  slot: 0
  node: 0
  size: 10737418240
  memdev: /objects/mem1
  hotplugged: true
  hotpluggable: true

Test case 2: Hotplug during the boot process, before the hotplug wq
initialization

[   [    0.028103] NET: Registered protocol family 1
[    0.028745] Unpacking initramfs...
(qemu) object_add memory-backend-ram,id=mem1,size=10G
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
[    0.407070] >>>>>>>>>>>>>>>> [devlog pseries_hp_wq] 0x0 (using system wq)
[    0.407420] pseries-hotplug-mem: Attempting to hot-add 40 LMB(s) at index 80000010
[    0.407749] radix-mmu: Mapped 0xc000000100000000-0xc000000110000000 with 2.00 MiB pages
...  0.627554] rtas_flash: no firmware flash support
[    0.627674] >>>>>>>>>>>>>>>> [devlog pseries_hp_wq] ALLOCed
[    0.628451] Initialise system trusted keyrings
...
(qemu) info memory-devices
Memory device [dimm]: "dimm1"
  addr: 0x100000000
  slot: 0
  node: 0
  size: 10737418240
  memdev: /objects/mem1
  hotplugged: true
  hotpluggable: true

Jose Ricardo Ziviani (1):
  powerpc/pseries: Use the system workqueue as fallback to hotplug
    workqueue

 arch/powerpc/platforms/pseries/dlpar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.14.1
