Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id 9BEE367B3C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 May 2006 03:18:09 +1000 (EST)
Date: Sun, 30 Apr 2006 13:53:25 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: Linux 2.6 sources for MPC852T processor
Message-ID: <20060430165325.GB4631@dmt>
References: <20060426025008.C8A7D773@resin02.mta.everyone.net>
	<200604261350.05295.david.jander@protonic.nl>
	<0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 26, 2006 at 07:32:13PM -0400, Dan Malek wrote:
> 
> On Apr 26, 2006, at 7:50 AM, David Jander wrote:
> 
> > Yes, MPC852T is supported, although I might add that I have been  
> > using 2.6.14
> > and 2.6.15 sucessfully with our own MPC852T-based board, but 2.6.16  
> > did not
> > boot and as of today I don't know why, or whether this is an issue  
> > at all
> > with boards other than ours.
> 
> There is a horrible bug in the 8xx TLB miss handler that is in the  
> 2.6.16
> sources.  I don't know when it appeared.  Enable the CPU6 Errata
> workaround to see if that solves the problem and please report back
> to me.  I'm working on a solution.

Hi Dan,

Shame on me! I screwed up.

David, can you please try the following patch on top of vanilla v2.6.16?

The large TLB change introduced in v2.6.16 (which is broken as is for
configurations without CPU6 errata enabled as Dan noted) should boost
performance significantly, so you might want to rerun the lmbench
tests...

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index ec53c7d..7a2f205 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -355,9 +355,7 @@ #endif
 
 	. = 0x1200
 DataStoreTLBMiss:
-#ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-#endif
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
@@ -417,9 +415,7 @@ #endif
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
