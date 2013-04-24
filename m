Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8938B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 08:38:29 +1000 (EST)
Date: Wed, 24 Apr 2013 17:38:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 12/15] powerpc/85xx: add time base sync support for
 e6500
To: Zhao Chenhui <chenhui.zhao@freescale.com>
In-Reply-To: <20130424112929.GC3172@localhost.localdomain> (from
 chenhui.zhao@freescale.com on Wed Apr 24 06:29:29 2013)
Message-ID: <1366843096.17465.17@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 04/24/2013 06:29:29 AM, Zhao Chenhui wrote:
> On Tue, Apr 23, 2013 at 07:04:06PM -0500, Scott Wood wrote:
> > On 04/19/2013 05:47:45 AM, Zhao Chenhui wrote:
> > >From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
> > >
> > >For e6500, two threads in one core share one time base. Just need
> > >to do time base sync on first thread of one core, and skip it on
> > >the other thread.
> > >
> > >Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > >Signed-off-by: Li Yang <leoli@freescale.com>
> > >Signed-off-by: Andy Fleming <afleming@freescale.com>
> > >---
> > > arch/powerpc/platforms/85xx/smp.c |   52
> > >+++++++++++++++++++++++++++++++-----
> > > 1 files changed, 44 insertions(+), 8 deletions(-)
> > >
> > >diff --git a/arch/powerpc/platforms/85xx/smp.c
> > >b/arch/powerpc/platforms/85xx/smp.c
> > >index 74d8cde..5f3eee3 100644
> > >--- a/arch/powerpc/platforms/85xx/smp.c
> > >+++ b/arch/powerpc/platforms/85xx/smp.c
> > >@@ -26,6 +26,7 @@
> > > #include <asm/cacheflush.h>
> > > #include <asm/dbell.h>
> > > #include <asm/fsl_guts.h>
> > >+#include <asm/cputhreads.h>
> > >
> > > #include <sysdev/fsl_soc.h>
> > > #include <sysdev/mpic.h>
> > >@@ -45,6 +46,7 @@ static u64 timebase;
> > > static int tb_req;
> > > static int tb_valid;
> > > static u32 cur_booting_core;
> > >+static bool rcpmv2;
> > >
> > > #ifdef CONFIG_PPC_E500MC
> > > /* get a physical mask of online cores and booting core */
> > >@@ -53,26 +55,40 @@ static inline u32 get_phy_cpu_mask(void)
> > > 	u32 mask;
> > > 	int cpu;
> > >
> > >-	mask =3D 1 << cur_booting_core;
> > >-	for_each_online_cpu(cpu)
> > >-		mask |=3D 1 << get_hard_smp_processor_id(cpu);
> > >+	if (smt_capable()) {
> > >+		/* two threads in one core share one time base */
> > >+		mask =3D 1 << cpu_core_index_of_thread(cur_booting_core);
> > >+		for_each_online_cpu(cpu)
> > >+			mask |=3D 1 << cpu_core_index_of_thread(
> > >+					get_hard_smp_processor_id(cpu));
> > >+	} else {
> > >+		mask =3D 1 << cur_booting_core;
> > >+		for_each_online_cpu(cpu)
> > >+			mask |=3D 1 << get_hard_smp_processor_id(cpu);
> > >+	}
> >
> > Where is smt_capable defined()?  I assume somewhere in the patchset
> > but it's a pain to search 12 patches...
> >
>=20
> It is defined in arch/powerpc/include/asm/topology.h.
> 	#define smt_capable()           (cpu_has_feature(CPU_FTR_SMT))
>=20
> Thanks for your review again.

We shouldn't base it on CPU_FTR_SMT.  For example, e6500 doesn't claim =20
that feature yet, except in our SDK kernel.  That doesn't change the =20
topology of CPU numbering.

> > Is this really about whether we're SMT-capable or whether we have
> > rcpm v2?
> >
> > -Scott
>=20
> I think this "if" statement can be removed. The =20
> cpu_core_index_of_thread()
> can return the correct cpu number with thread or without thread.
>=20
> Like this:
> static inline u32 get_phy_cpu_mask(void)
> {
> 	u32 mask;
> 	int cpu;
>=20
> 	mask =3D 1 << cpu_core_index_of_thread(cur_booting_core);
> 	for_each_online_cpu(cpu)
> 		mask |=3D 1 << cpu_core_index_of_thread(
> 				get_hard_smp_processor_id(cpu));
>=20
> 	return mask;
> }

Likewise, this will get it wrong if SMT is disabled or not yet =20
implemented on a core.

-Scott=
