Return-Path: <srs0=dnb0=j4=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RHCP3vHfzDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 23:41:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41RHCP1zRLz8vBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 23:41:21 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41RHCN10GCz9s1R
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2018 23:41:18 +1000 (AEST)
Date: Thu, 12 Jul 2018 15:41:13 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: "Mahesh J Salgaonkar" <mahesh@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, "Laurent Dufour"
 <ldufour@linux.vnet.ibm.com>, "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 5/7] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
Message-ID: <20180712154113.46845936@kitsune.suse.cz>
In-Reply-To: <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
 <153051042206.30541.2156877677180900261.stgit@jupiter.in.ibm.com>
 <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Jul 2018 08:08:14 +1000
"Nicholas Piggin" <npiggin@gmail.com> wrote:

> On Mon, 02 Jul 2018 11:17:06 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > On pseries, as of today system crashes if we get a machine check
> > exceptions due to SLB errors. These are soft errors and can be
> > fixed by flushing the SLBs so the kernel can continue to function
> > instead of system crash. We do this in real mode before turning on
> > MMU. Otherwise we would run into nested machine checks. This patch
> > now fetches the rtas error log in real mode and flushes the SLBs on
> > SLB errors.
> > 
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
> >  arch/powerpc/include/asm/machdep.h            |    1 
> >  arch/powerpc/kernel/exceptions-64s.S          |   42
> > +++++++++++++++++++++ arch/powerpc/kernel/mce.c
> > |   16 +++++++- arch/powerpc/mm/slb.c                         |
> > 6 +++ arch/powerpc/platforms/powernv/opal.c         |    1 
> >  arch/powerpc/platforms/pseries/pseries.h      |    1 
> >  arch/powerpc/platforms/pseries/ras.c          |   51
> > +++++++++++++++++++++++++
> > arch/powerpc/platforms/pseries/setup.c        |    1 9 files
> > changed, 116 insertions(+), 4 deletions(-) 
> 
> 
> > +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
> > +BEGIN_FTR_SECTION
> > +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> > +	mr	r10,r1			/* Save r1 */
> > +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency
> > stack */
> > +	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack
> > frame		*/
> > +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> > +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
> > +	EXCEPTION_PROLOG_COMMON_1()
> > +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> > +	EXCEPTION_PROLOG_COMMON_3(0x200)
> > +	addi	r3,r1,STACK_FRAME_OVERHEAD
> > +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call
> > ABI */  
> 
> Is there any reason you can't use the existing
> machine_check_powernv_early code to do all this?
> 
> > diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> > index efdd16a79075..221271c96a57 100644
> > --- a/arch/powerpc/kernel/mce.c
> > +++ b/arch/powerpc/kernel/mce.c
> > @@ -488,9 +488,21 @@ long machine_check_early(struct pt_regs *regs)
> >  {
> >  	long handled = 0;
> >  
> > -	__this_cpu_inc(irq_stat.mce_exceptions);
> > +	/*
> > +	 * For pSeries we count mce when we go into virtual mode
> > machine
> > +	 * check handler. Hence skip it. Also, We can't access per
> > cpu
> > +	 * variables in real mode for LPAR.
> > +	 */
> > +	if (early_cpu_has_feature(CPU_FTR_HVMODE))
> > +		__this_cpu_inc(irq_stat.mce_exceptions);
> >  
> > -	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> > +	/*
> > +	 * See if platform is capable of handling machine check.
> > +	 * Otherwise fallthrough and allow CPU to handle this
> > machine check.
> > +	 */
> > +	if (ppc_md.machine_check_early)
> > +		handled = ppc_md.machine_check_early(regs);
> > +	else if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> >  		handled =
> > cur_cpu_spec->machine_check_early(regs);  
> 
> Would be good to add a powernv ppc_md handler which does the
> cur_cpu_spec->machine_check_early() call now that other platforms are
> calling this code. Because those aren't valid as a fallback call, but
> specific to powernv.
> 

Something like this (untested)?

Subject: [PATCH] powerpc/powernv: define platform MCE handler.

---
 arch/powerpc/kernel/mce.c              |  3 ---
 arch/powerpc/platforms/powernv/setup.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 221271c96a57..ae17d8aa60c4 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -498,12 +498,9 @@ long machine_check_early(struct pt_regs *regs)
 
 	/*
 	 * See if platform is capable of handling machine check.
-	 * Otherwise fallthrough and allow CPU to handle this machine check.
 	 */
 	if (ppc_md.machine_check_early)
 		handled = ppc_md.machine_check_early(regs);
-	else if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
-		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
 }
 
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index f96df0a25d05..b74c93bc2e55 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -431,6 +431,16 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
 	return ret_freq;
 }
 
+static long pnv_machine_check_early(struct pt_regs *regs)
+{
+	long handled = 0;
+
+	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
+		handled = cur_cpu_spec->machine_check_early(regs);
+
+	return handled;
+}
+
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
@@ -442,6 +452,7 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = NULL,
 	.calibrate_decr		= generic_calibrate_decr,
+	.machine_check_early	= pnv_machine_check_early,
 #ifdef CONFIG_KEXEC_CORE
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
-- 
2.13.7
