Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 487F8B6EED
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 02:13:17 +1100 (EST)
In-Reply-To: <1260348995.16132.37.camel@pasglop>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1260332399.16132.7.camel@pasglop>
	<OFB03B60EA.0352DA78-ONC1257687.002955A6-C1257687.002A145F@transmode.se>
	<1260348995.16132.37.camel@pasglop>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFF526DBEE.8B45ADD7-ONC125769B.0053251C-C125769B.0053670A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 Dec 2009 16:10:58 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 09/12/2009 09:56:35:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Rex Feany
> <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
> Date: 09/12/2009 09:56
> Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
>
> On Wed, 2009-12-09 at 08:39 +0100, Joakim Tjernlund wrote:
> > The later isn't as simple :) I believe the bulk of such code in
> > entry_32.S.
>
> Yeah but it would be useful for hash I suppose if one really wants to
> boot with nobats. Though at least on hash most of the time we have ways
> to recover by mean of MSR:RI being cleared, which your TLB miss code
> doesn't check...
>
> > Anyhow, the config option is still valid as if enabled
> > it will pin several DTLB's too. Scott had some concerns about removing
> > the config option completely so this was the next best thing.
>
> Well, if you want to pin at least one entry, then just remove the #if
> completely but don't leave a #if 1 :-)

As you wish. Here is a new version without the #if 1
This is required for 8xx to work in Linus current tree.

>From 5a4fa5078ba1774b037dbfd88b9c87b74cf76db7 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 13 Nov 2009 00:26:59 +0100
Subject: [PATCH] 8xx: Always pin kernel instruction TLB

Various kernel asm modifies SRR0/SRR1 just before executing
a rfi. If such code crosses a page boundary you risk a TLB miss
which will clobber SRR0/SRR1. Avoid this by always pinning
kernel instruction TLB space.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index adc5a32..c80e7c5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -767,12 +767,12 @@ start_here:
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB
+/* Always pin the first 8 MB ITLB to prevent ITLB
+   misses while mucking around with SRR0/SRR1 in asm
+*/
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
-#else
-	li	r8, 0
-#endif
+
 	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */

 #ifdef CONFIG_PIN_TLB
--
1.6.4.4
