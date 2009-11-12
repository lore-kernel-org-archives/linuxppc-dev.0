Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F108B7B95
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 10:30:08 +1100 (EST)
In-Reply-To: <4AFC84E7.6050706@freescale.com>
References: <4AF99695.800@freescale.com> <4AF99B00.6080504@freescale.com>
	<OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
	<4AF9CC99.1030500@freescale.com>
	<OFDF13AF8E.1B38CEA9-ONC125766A.0073E59F-C125766A.0075ABE6@transmode.se>
	<4AF9DCE0.4030805@freescale.com>
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
	<4AF9E2E2.7030100@freescale.com> <4AF9F56E.9080104@freescale.com>
	<OF2843D474.207958C1-ONC125766A.00828F87-C125766B.00009091@transmode.se>
	<20091111152653.GA688@loki.buserror.net>
	<OFE47A9BB7.59140781-ONC125766C.00322B87-C125766C.003266AD@transmode.se>
	<4AFC65F7.4050600@freescale.com>
	<OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
	<4AFC84E7.6050706@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF9A8AE2F7.5F8AC107-ONC125766C.008051C5-C125766C.00810B6D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.com>
Date: Fri, 13 Nov 2009 00:29:30 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Scott Wood <scottwood@freescale.com> wrote on 12/11/2009 22:57:59:
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 12/11/2009 20:45:59:
> >> One other concern with pinning on 8xx -- could it cause problems with
> >> uncached DMA mappings?  What happens if a speculative load pulls in a
> >> cache line in an area that's supposed to be uncached?
> >
> > hmm, why should this be a problem?
>
> Because then you would be accessing potentially stale DMA data -- and
> more generally, the architecture prohibits such mixing.
>
> > Pinning has been around as a config option
> > for a long time so any problems should have surfaced by now.
>
> It has existed as an option, which is going to get less test coverage
> than something that is always on.  Plus, it would not be a particularly
> common failure -- easy to blame one-off weirdness on something else.
>
> > Secondly, I was thinking that we could just make the ITLB pinning
> > mandatory and let the DTLB pinning be as is, configurable.
>
> That could work.  We could also limit the pool of memory
> dma_alloc_coherent() uses to not overlap with anything pinned.

And try using the remaing 3 ITLBs which are unused when pinning to
cover the module space. Probably not going to be perfect.

Anyhow, lets start simple and just do the pinned ITLB so the
new TLB code can be applied. Can you confirm this works for you?

>From 0c30d6c1ee45341fcfc5643bd2ba876e3c9a416e Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 13 Nov 2009 00:26:59 +0100
Subject: [PATCH] 8xx: Always pin kernel instruction TLB

---
 arch/powerpc/kernel/head_8xx.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index adc5a32..c7a4e60 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -767,7 +767,7 @@ start_here:
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB
+#ifdef 1 /* CONFIG_PIN_TLB */
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
 #else
--
1.6.4.4
