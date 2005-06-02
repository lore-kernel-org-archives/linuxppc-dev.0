Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 673EF679F4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2005 21:23:41 +1000 (EST)
Message-ID: <429F892C.7030603@am.sony.com>
Date: Thu, 02 Jun 2005 15:33:16 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1117424155.5228.28.camel@gaston>
In-Reply-To: <1117424155.5228.28.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I had a problem when building for ppc440 (gcc -m405).  I wonder if we 
need some conditionals on the DSSALL statement as below, or is DSSALL 
intended to be a perprocessor macro that would expand to a blank line
in this case?

-Geoff


dssall-fix.patch:

Index: linux-2.6.12-bhpm/arch/ppc/kernel/swsusp.S
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/kernel/swsusp.S	2005-06-02 15:09:22.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/kernel/swsusp.S	2005-06-02 15:29:56.000000000 -0700
@@ -134,11 +134,13 @@
 /* Resume code */
 _GLOBAL(swsusp_arch_resume)
 
+#ifdef CONFIG_ALTIVEC
 	/* Stop pending alitvec streams and memory accesses */
 BEGIN_FTR_SECTION
 	DSSALL
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
- 	sync
+#endif
+	sync
 
 	/* Disable MSR:DR to make sure we don't take a TLB or
 	 * hash miss during the copy, as our hash table will


Benjamin Herrenschmidt wrote:
> Ok, the patch is now getting "good enough" for wider testing. It applies
> on current "git" tree (or 2.6.12-rc6 when/if that is ever released). It
> requires one other patch to be applied first:
> 
> http://gate.crashing.org/~benh/ppc32-remove-macserial.diff
> 
> The PM patch itself can be found at:
> 
> http://gate.crashing.org/~benh/ppc32-rework-pm.diff
> 
> This patch completely reworks both suspend-to-ram and suspend-to-disk
> support on PowerMac:
> 
>  - suspend-to-ram code is moved away from the via-pmu.c driver
>  - both suspend-to-disk & to-ram consolidated to use the same
> infrastructure and code base in a new pmac_pm.c file
>  - significants fixes & improvements to suspend-to-disk
>  - for now (may change), use the "refrigerator" with suspend-to-ram as
> well as suspend-to-disk. This may help make it a bit more robust vs.
> userland activity during the sleep process
>  - CONFIG_PMAC_PBOOK is gone. CONFIG_PMAC_MEDIABAY is new and controls
> wether the powerbook hostwap bay driver is included. The rest of bits
> formerly under CONFIG_PMAC_PBOOK control are now either always on
> (like /dev/pmu interface on PMU based machines) or dependent on other
> config options (like CONFIG_PM, CONFIG_PPC_PMAC, ...)
> 
> The patch will not be in 2.6.12 (though will probably apply on top of
> it). I aim for a 2.6.13 release, knowing that the patch changes a bunch
> of non-ppc-specific power management bits, and thus may need some time
> to be fully merged upstream.
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
