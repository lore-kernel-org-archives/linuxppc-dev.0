Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9755A2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 20:10:42 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 26 Sep 2012 20:07:43 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8QA14ae45875268
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 20:01:04 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8QAAaEU014538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 20:10:37 +1000
Message-ID: <1348654234.2635.31.camel@ThinkPad-T420>
Subject: Re: [RFC PATCH powerpc] Fix a lazy irq related WARING in
 arch_local_irq_restore()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 26 Sep 2012 18:10:34 +0800
In-Reply-To: <1348464657.1132.86.camel@pasglop>
References: <1348458962.2475.8.camel@ThinkPad-T420>
 <1348464657.1132.86.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-24 at 15:30 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-24 at 11:56 +0800, Li Zhong wrote:
> > This patch tries to fix a WARNING in irq.c(below), when doing cpu offline/online. 
> > 
> > The reason is that if the preferred offline state is CPU_STATE_INACTIVE, when
> > cpu offline, pseries_mach_cpu_die() calls extended_cede_processor() to cede
> > the processor. After the hv call returns, the MSR_EE is enabled, while
> > the irq_happened in paca should already be set as PACA_IRQ_HARD_DIS.
> > 
> > Then when the cpu is put online again, the warning is reported when
> > start_secondary() tries to enable irq. [ Sometimes, we don't see this warning,
> > that's because when we come to local_irq_enable(), there might already have been
> > some interrupts occurred, e.g. PACA_IRQ_DEC is already set. ]
> > 
> > The patch tries to clear MSR_EE by calling __hard_irq_disable() after cede
> > returns, and before calling start_secondary_resume(). 
> 
> Is that enough ? Do we know for sure we won't get a stray IPI or
> interrupt which then will reach us with an inconsistent HW/SW enable
> state ?
> 
> We might need to "sanitize" the enable state in the PACA before we
> actually enter NAP or in the return from NAP code, like we do for normal
> idle code...

Hi Ben, 

After some further reading of the code, I updated the code as following,
but I'm not very sure, and guess it most probably has some issues ...
Could you please help to review and give your comments? 

In extended_cede_processor(), if there is still lazy irq pending, I used
local_irq_enable() to make sure the irq replayed and flags cleared, but
I'm not sure whether it is a proper way. 

In pseries_mach_cpu_die(), I added local_irq_disable() after cede, and
prepare for the start_secondary_resume(), but I'm not sure whether we
also need a hard_irq_disable() here. 

I'm still a little confused by the meaning of PACA_IRQ_HARD_DIS in
irq_happened. From the checking at the warning point, it seems only
irq_happened equaling 0x1(PACA_IRQ_HARD_DIS) means hard irqs are
disabled.

Is it possible to set this bit at anyplace the hard irqs are disabled,
so then we could check whether this bit is set to know whether hard irqs
are disabled? Then it seems that in MASKED_INTERRUPT, we need set this
bit where MSR_EE is cleared for something other than decrementer. Maybe
I missed too much things?

Thanks, Zhong 

===================
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 64c97d8..b5f7597 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -130,6 +130,8 @@ static void pseries_mach_cpu_die(void)
 			extended_cede_processor(cede_latency_hint);
 		}
 
+		local_irq_disable();
+
 		if (!get_lppaca()->shared_proc)
 			get_lppaca()->donate_dedicated_cpu = 0;
 		get_lppaca()->idle = 0;
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index 13e8cc4..07560d8 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -2,6 +2,7 @@
 #define _PSERIES_PLPAR_WRAPPERS_H
 
 #include <linux/string.h>
+#include <linux/irqflags.h>
 
 #include <asm/hvcall.h>
 #include <asm/paca.h>
@@ -41,7 +42,19 @@ static inline long extended_cede_processor(unsigned long latency_hint)
 	u8 old_latency_hint = get_cede_latency_hint();
 
 	set_cede_latency_hint(latency_hint);
+
+	while (!prep_irq_for_idle()) {
+		local_irq_enable();
+		local_irq_disable();
+	}
+
 	rc = cede_processor();
+#ifdef CONFIG_TRACE_IRQFLAGS
+		/* Ensure that H_CEDE returns with IRQs on */
+		if (WARN_ON(!(mfmsr() & MSR_EE)))
+			__hard_irq_enable();
+#endif
+
 	set_cede_latency_hint(old_latency_hint);
 
 	return rc;
===================


> 
> Cheers,
> Ben.
> 
> > [   56.618846] WARNING: at arch/powerpc/kernel/irq.c:240
> > [   56.618851] Modules linked in: rcutorture ipv6 dm_mod ext3 jbd mbcache sg sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt ibmveth
> > [   56.618883] NIP: c00000000000ff94 LR: c00000000067a5e0 CTR: 0000000000000001
> > [   56.618889] REGS: c0000001fef6bbe0 TRAP: 0700   Not tainted  (3.6.0-rc1-autokern1)
> > [   56.618894] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 42000082  XER: 20000000
> > [   56.618913] SOFTE: 1
> > [   56.618916] CFAR: c00000000067a5dc
> > [   56.618920] TASK = c0000001feed79a0[0] 'swapper/5' THREAD: c0000001fef68000 CPU: 5
> > GPR00: 0000000000000001 c0000001fef6be60 c000000000f9ca08 0000000000000001 
> > GPR04: 0000000000000001 0000000000000008 0000000000000001 0000000000000000 
> > GPR08: 0000000000000000 c0000001feed79a0 0008a80000000000 0000000000000000 
> > GPR12: 0000000022000082 c00000000f330f00 c0000001fef6bf90 000000000f394b4c 
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR24: c000000000fe8f80 0000000000000008 0000000000000028 0000000000000000 
> > GPR28: 0000000000000000 0000000000000020 c000000000f1ab40 0000000000000001 
> > [   56.619014] NIP [c00000000000ff94] .arch_local_irq_restore+0x34/0xa0
> > [   56.619020] LR [c00000000067a5e0] .start_secondary+0x368/0x37c
> > [   56.619025] Call Trace:
> > [   56.619030] [c0000001fef6be60] [c000000001ba0500] 0xc000000001ba0500 (unreliable)
> > [   56.619038] [c0000001fef6bed0] [c00000000067a5e0] .start_secondary+0x368/0x37c
> > [   56.619046] [c0000001fef6bf90] [c000000000009380] .start_secondary_resume+0x10/0x14
> > [   56.619052] Instruction dump:
> > [   56.619056] f8010010 f821ff91 986d022a 2fa30000 419e0054 880d022b 78000621 41820048 
> > [   56.619071] 2f800001 40de0064 7c0000a6 78008fe2 <0b000000> 2fa00000 40de0050 38000000 
> > [   56.619088] ---[ end trace 0199c0d783d7f9ba ]---
> > 
> > Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > index 64c97d8..8de539a 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -137,6 +137,8 @@ static void pseries_mach_cpu_die(void)
> >  		if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
> >  			unregister_slb_shadow(hwcpu);
> >  
> > +			__hard_irq_disable();
> > +
> >  			/*
> >  			 * Call to start_secondary_resume() will not return.
> >  			 * Kernel stack will be reset and start_secondary()
> 
> 
