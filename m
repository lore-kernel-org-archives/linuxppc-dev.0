Return-Path: <B35336@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB7A52C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 21:30:23 +1000 (EST)
Date: Wed, 24 Apr 2013 19:29:29 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 12/15] powerpc/85xx: add time base sync support for
 e6500
Message-ID: <20130424112929.GC3172@localhost.localdomain>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
 <1366368468-29143-12-git-send-email-chenhui.zhao@freescale.com>
 <1366761846.5825.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366761846.5825.21@snotra>
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

On Tue, Apr 23, 2013 at 07:04:06PM -0500, Scott Wood wrote:
> On 04/19/2013 05:47:45 AM, Zhao Chenhui wrote:
> >From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
> >
> >For e6500, two threads in one core share one time base. Just need
> >to do time base sync on first thread of one core, and skip it on
> >the other thread.
> >
> >Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> >Signed-off-by: Li Yang <leoli@freescale.com>
> >Signed-off-by: Andy Fleming <afleming@freescale.com>
> >---
> > arch/powerpc/platforms/85xx/smp.c |   52
> >+++++++++++++++++++++++++++++++-----
> > 1 files changed, 44 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/powerpc/platforms/85xx/smp.c
> >b/arch/powerpc/platforms/85xx/smp.c
> >index 74d8cde..5f3eee3 100644
> >--- a/arch/powerpc/platforms/85xx/smp.c
> >+++ b/arch/powerpc/platforms/85xx/smp.c
> >@@ -26,6 +26,7 @@
> > #include <asm/cacheflush.h>
> > #include <asm/dbell.h>
> > #include <asm/fsl_guts.h>
> >+#include <asm/cputhreads.h>
> >
> > #include <sysdev/fsl_soc.h>
> > #include <sysdev/mpic.h>
> >@@ -45,6 +46,7 @@ static u64 timebase;
> > static int tb_req;
> > static int tb_valid;
> > static u32 cur_booting_core;
> >+static bool rcpmv2;
> >
> > #ifdef CONFIG_PPC_E500MC
> > /* get a physical mask of online cores and booting core */
> >@@ -53,26 +55,40 @@ static inline u32 get_phy_cpu_mask(void)
> > 	u32 mask;
> > 	int cpu;
> >
> >-	mask = 1 << cur_booting_core;
> >-	for_each_online_cpu(cpu)
> >-		mask |= 1 << get_hard_smp_processor_id(cpu);
> >+	if (smt_capable()) {
> >+		/* two threads in one core share one time base */
> >+		mask = 1 << cpu_core_index_of_thread(cur_booting_core);
> >+		for_each_online_cpu(cpu)
> >+			mask |= 1 << cpu_core_index_of_thread(
> >+					get_hard_smp_processor_id(cpu));
> >+	} else {
> >+		mask = 1 << cur_booting_core;
> >+		for_each_online_cpu(cpu)
> >+			mask |= 1 << get_hard_smp_processor_id(cpu);
> >+	}
> 
> Where is smt_capable defined()?  I assume somewhere in the patchset
> but it's a pain to search 12 patches...
> 

It is defined in arch/powerpc/include/asm/topology.h.
	#define smt_capable()           (cpu_has_feature(CPU_FTR_SMT))

Thanks for your review again.

> Is this really about whether we're SMT-capable or whether we have
> rcpm v2?
> 
> -Scott

I think this "if" statement can be removed. The cpu_core_index_of_thread()
can return the correct cpu number with thread or without thread.

Like this:
static inline u32 get_phy_cpu_mask(void)
{
	u32 mask;
	int cpu;

	mask = 1 << cpu_core_index_of_thread(cur_booting_core);
	for_each_online_cpu(cpu)
		mask |= 1 << cpu_core_index_of_thread(
				get_hard_smp_processor_id(cpu));

	return mask;
}

-Chenhui
