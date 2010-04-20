Return-Path: <brking@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0761B7D08
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 08:17:18 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3KM7eOC029040
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 18:07:40 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3KMHEwv2064506
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 18:17:14 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3KMHE2L017663
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 19:17:14 -0300
Received: from [9.10.86.48] (skaro.rchland.ibm.com [9.10.86.48])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3KMHEkT017640
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 19:17:14 -0300
Message-ID: <4BCE27E8.4090101@linux.vnet.ibm.com>
Date: Tue, 20 Apr 2010 17:17:12 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Badness in xics_ipi_dispatch
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In stress testing enabling and disabling of SMT, we are regularly
seeing the badness warning below. Looking through the cpu offline
path, this is what I see:

1. stop_cpu: IRQ's get disabled
2. pseries_cpu_disable: set cpu offline (no barriers after this)
3. xics_migrate_irqs_away: Remove ourselves from the GIQ, but still allow
    IPIs
4. stop_cpu: IRQ's get enabled again (local_irq_enable)

It looks to me like there is plenty of opportunity between 1 and 2 for
an IPI to get queued, resulting in the badness below. Is there something
in xics_migrate_irqs_away that should clear any pending IPIs? If there
is, maybe the solution is as simple as adding a barrier after marking
the cpu offline. Or is the warning bogus and we should just remove it?

Thanks,

Brian


<3>Badness at arch/powerpc/platforms/pseries/xics.c:511
<4>NIP: c0000000000673f0 LR: c00000000010fc6c CTR: 000000000171b0b0
<4>REGS: c00000000f2e3b30 TRAP: 0700   Tainted: G           X  (2.6.32.11-0.3.1.bk2-ppc64)
<4>MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000024  XER: 00000001
<4>TASK = c000000079216ce0[421] 'kstop/9' THREAD: c00000003fe30000 CPU: 9
<4>GPR00: 0000000000000001 c00000000f2e3db0 c000000000ea4008 0000000000000009
<4>GPR04: 0000000000000000 0000000000000000 fffffffffffffff0 0000000000000000
<4>GPR08: 0000000000000009 0000000000000000 c000000000600930 c000000000f55ba8
<4>GPR12: 0000000000000100 c000000000f73800 00000000000532b3 0000000000053191
<4>GPR16: 00000000000532ab 000000000004003c 0000000000055138 0000000000054c46
<4>GPR20: 00000000000547bc 00000000000655a8 0000000000065594 0000000000000000
<4>GPR24: 0000000000000004 0000000000000010 0000000000000001 0000000000000010
<4>GPR28: 0000000000000000 0000000000000000 c000000000e1c7a0 c00000007e023500
<4>NIP [c0000000000673f0] .xics_ipi_dispatch+0x50/0x1f8
<4>LR [c00000000010fc6c] .handle_IRQ_event+0x9c/0x1d8
<4>Call Trace:
<4>[c00000000f2e3db0] [c0000000000674f4] .xics_ipi_dispatch+0x154/0x1f8 (unreliable)
<4>[c00000000f2e3e50] [c00000000010fc6c] .handle_IRQ_event+0x9c/0x1d8
<4>[c00000000f2e3f00] [c000000000112b0c] .handle_percpu_irq+0x74/0xf8
<4>[c00000000f2e3f90] [c000000000030720] .call_handle_irq+0x1c/0x2c
<4>[c00000003fe33860] [c00000000000e380] .do_IRQ+0x118/0x208
<4>[c00000003fe33910] [c000000000004c98] hardware_interrupt_entry+0x18/0x1c
<4>--- Exception: 501 at .raw_local_irq_restore+0x70/0xc8
<4>    LR = .stop_cpu+0xfc/0x1c0
<4>[c00000003fe33c00] [c00000003fe33c90] 0xc00000003fe33c90 (unreliable)
<4>[c00000003fe33c90] [c000000000100b64] .stop_cpu+0xfc/0x1c0
<4>[c00000003fe33d40] [c0000000000c6f0c] .run_workqueue+0xf4/0x1e0
<4>[c00000003fe33e00] [c0000000000c70b8] .worker_thread+0xc0/0x180
<4>[c00000003fe33ed0] [c0000000000cce74] .kthread+0xb4/0xc0
<4>[c00000003fe33f90] [c0000000000309fc] .kernel_thread+0x54/0x70
<4>Instruction dump:
<4>fb61ffd8 e96a0000 fb81ffe0 79291f24 fba1ffe8 fbc1fff0 fbe1fff8 f821ff61
<4>7c0b482a 7c004436 68000001 540007fe <0b000000> 7c0004ac e802a2d8 78633e24



-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
