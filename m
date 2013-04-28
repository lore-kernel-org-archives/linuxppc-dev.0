Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFBCC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2013 19:57:25 +1000 (EST)
Date: Sun, 28 Apr 2013 17:56:34 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 12/15] powerpc/85xx: add time base sync support for
 e6500
Message-ID: <20130428095634.GA27100@localhost.localdomain>
References: <20130425002818.GE3172@localhost.localdomain>
 <1366934844.30341.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366934844.30341.16@snotra>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 07:07:24PM -0500, Scott Wood wrote:
> On 04/24/2013 07:28:18 PM, Zhao Chenhui wrote:
> >On Wed, Apr 24, 2013 at 05:38:16PM -0500, Scott Wood wrote:
> >> On 04/24/2013 06:29:29 AM, Zhao Chenhui wrote:
> >> >On Tue, Apr 23, 2013 at 07:04:06PM -0500, Scott Wood wrote:
> >> >> On 04/19/2013 05:47:45 AM, Zhao Chenhui wrote:
> >> >> >From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
> >> >> >
> >> >> >For e6500, two threads in one core share one time base. Just
> >need
> >> >> >to do time base sync on first thread of one core, and skip it on
> >> >> >the other thread.
> >> >> >
> >> >> >Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> >> >> >Signed-off-by: Li Yang <leoli@freescale.com>
> >> >> >Signed-off-by: Andy Fleming <afleming@freescale.com>
> >> >> >---
> >> >> > arch/powerpc/platforms/85xx/smp.c |   52
> >> >> >+++++++++++++++++++++++++++++++-----
> >> >> > 1 files changed, 44 insertions(+), 8 deletions(-)
> >> >> >
> >> >> >diff --git a/arch/powerpc/platforms/85xx/smp.c
> >> >> >b/arch/powerpc/platforms/85xx/smp.c
> >> >> >index 74d8cde..5f3eee3 100644
> >> >> >--- a/arch/powerpc/platforms/85xx/smp.c
> >> >> >+++ b/arch/powerpc/platforms/85xx/smp.c
> >> >> >@@ -53,26 +55,40 @@ static inline u32 get_phy_cpu_mask(void)
> >> >> > 	u32 mask;
> >> >> > 	int cpu;
> >> >> >
> >> >> >-	mask = 1 << cur_booting_core;
> >> >> >-	for_each_online_cpu(cpu)
> >> >> >-		mask |= 1 << get_hard_smp_processor_id(cpu);
> >> >> >+	if (smt_capable()) {
> >> >> >+		/* two threads in one core share one time base */
> >> >> >+		mask = 1 << cpu_core_index_of_thread(cur_booting_core);
> >> >> >+		for_each_online_cpu(cpu)
> >> >> >+			mask |= 1 << cpu_core_index_of_thread(
> >> >> >+					get_hard_smp_processor_id(cpu));
> >> >> >+	} else {
> >> >> >+		mask = 1 << cur_booting_core;
> >> >> >+		for_each_online_cpu(cpu)
> >> >> >+			mask |= 1 << get_hard_smp_processor_id(cpu);
> >> >> >+	}
> >> >>
> >> >> Where is smt_capable defined()?  I assume somewhere in the
> >patchset
> >> >> but it's a pain to search 12 patches...
> >> >>
> >> >
> >> >It is defined in arch/powerpc/include/asm/topology.h.
> >> >	#define smt_capable()           (cpu_has_feature(CPU_FTR_SMT))
> >> >
> >> >Thanks for your review again.
> >>
> >> We shouldn't base it on CPU_FTR_SMT.  For example, e6500 doesn't
> >> claim that feature yet, except in our SDK kernel.  That doesn't
> >> change the topology of CPU numbering.
> >>
> >
> >Then, where can I get the thread information? dts?
> >Or, wait for upstream of the thread suppport of e6500.
> 
> It's an inherent property of e6500 (outside of some virtualization
> scenarios, but you wouldn't run this code under a hypervisor) that
> you have two threads per core (whether Linux uses them or not).  Or
> you could read TMCFG0[NTHRD] if you know you're on a chip that has
> TMRs but aren't positive it's an e6500, but I wouldn't bother.  If
> we do ever have such a chip, there are probably other things that
> will need updating.
> 

But how to know that there are TMRs on a chip except by CPU_FTR_SMT.

> >> >static inline u32 get_phy_cpu_mask(void)
> >> >{
> >> >	u32 mask;
> >> >	int cpu;
> >> >
> >> >	mask = 1 << cpu_core_index_of_thread(cur_booting_core);
> >> >	for_each_online_cpu(cpu)
> >> >		mask |= 1 << cpu_core_index_of_thread(
> >> >				get_hard_smp_processor_id(cpu));
> >> >
> >> >	return mask;
> >> >}
> >>
> >> Likewise, this will get it wrong if SMT is disabled or not yet
> >> implemented on a core.
> >>
> >> -Scott
> >
> >Let's look into cpu_core_index_of_thread() in
> >arch/powerpc/kernel/smp.c.
> >
> >  int cpu_core_index_of_thread(int cpu)
> >  {
> >      return cpu >> threads_shift;
> >  }
> >
> >If no thread, the threads_shift is equal to 0. It can work with no
> >thread.
> 
> My point is that if threads are disabled, threads_shift will be 0,
> but e6500 cores will still be numbered 0, 2, 4, etc.
> 
> >Perhaps, I should submit this patch after the thread patches for
> >e6500.
> 
> Why?
> 
> -Scott

Even if threads are disabled, the threads_shift derived from dts is right.
But, if there aren't the thread related patches existed in SDK, the threads_shift
gets a wrong value on T4.

-Chenhui
