Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 576481A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:43:24 +1000 (AEST)
Message-ID: <55A55846.5080904@redhat.com>
Date: Tue, 14 Jul 2015 20:43:18 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
CC: kvm-ppc@vger.kernel.org, anton@samba.org
Subject: BUG: sleeping function called from ras_epow_interrupt context
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 Hi all!

A colleague recently ran into some kernel BUG messages that happen when
hot-plugging a virtio disk to a KVM guest on powerpc (with "virsh
attach-disk"), and IIRC CONFIG_DEBUG_ATOMIC_SLEEP enabled. I've tried to
re-create the problem with an up-to-date kernel (4.2.0-rc2) and the
problem still seems to be there:

The hotplug action triggers the ras_epow_interrupt() in
arch/powerpc/platforms/pseries/ras.c, which again calls
rtas_get_sensor(). That function then uses rtas_busy_delay() to wait in
case the RTAS call did not succeed immediately. But rtas_busy_delay()
uses msleep() for sleeping - which is forbidden during an atomic
interrupt context!

Following backtrace is printed out by the kernel:

[   33.920528] BUG: sleeping function called from invalid context at
/home/thuth/devel/linux-up/arch/powerpc/kernel/rtas.c:496
[   33.920590] in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
[   33.920624] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-rc2-thuth #1
[   33.920657] Call Trace:
[   33.920677] [c00000007ffe79b0] [c0000000007e43f4]
.dump_stack+0x98/0xd4 (unreliable)
[   33.920729] [c00000007ffe7a30] [c0000000000dcc78]
.___might_sleep+0x128/0x170
[   33.920769] [c00000007ffe7aa0] [c000000000029f38]
.rtas_busy_delay+0x28/0xe0
[   33.920809] [c00000007ffe7b20] [c00000000002adb4]
.rtas_get_sensor+0x74/0xe0
[   33.920850] [c00000007ffe7bc0] [c00000000007ff58]
.ras_epow_interrupt+0x48/0x450
[   33.920896] [c00000007ffe7c80] [c000000000119d94]
.handle_irq_event_percpu+0xa4/0x310
[   33.920942] [c00000007ffe7d70] [c00000000011a05c]
.handle_irq_event+0x5c/0xa0
[   33.920982] [c00000007ffe7e00] [c00000000011e7a8]
.handle_fasteoi_irq+0xe8/0x270
[   33.921028] [c00000007ffe7e90] [c0000000001190bc]
.generic_handle_irq+0x4c/0x80
[   33.921074] [c00000007ffe7f10] [c000000000010a48] .__do_irq+0x88/0x1f0
[   33.921115] [c00000007ffe7f90] [c000000000022a0c] .call_do_irq+0x14/0x24
[   33.921155] [c00000007e6f37e0] [c000000000010c3c] .do_IRQ+0x8c/0x100
[   33.921195] [c00000007e6f3880] [c000000000002594]
hardware_interrupt_common+0x114/0x180
[   33.921243] --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20
[   33.921243]     LR = .check_and_cede_processor+0x24/0x40
[   33.921300] [c00000007e6f3b70] [0000000000000000]           (null)
(unreliable)
[   33.921347] [c00000007e6f3be0] [c000000000628068]
.shared_cede_loop+0x58/0x160
[   33.921393] [c00000007e6f3c70] [c0000000006259ac]
.cpuidle_enter_state+0xbc/0x3b0
[   33.921439] [c00000007e6f3d30] [c0000000000fe32c] .call_cpuidle+0x4c/0xa0
[   33.921479] [c00000007e6f3db0] [c0000000000fe700]
.cpu_startup_entry+0x380/0x4a0
[   33.921526] [c00000007e6f3ed0] [c000000000043110]
.start_secondary+0x320/0x350
[   33.921571] [c00000007e6f3f90] [c000000000008b6c]
start_secondary_prolog+0x10/0x14

I think that bug might have been introduced by commit
587f83e8dd50d22bc0c62 ("Use rtas_get_sensor in RAS code") since the
rtas_busy_delay() was not called before that commit, as far as I can see.

Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
mdelay() instead of msleep() in rtas_busy_delay()? Something more fancy?

 Thanks,
  Thomas
