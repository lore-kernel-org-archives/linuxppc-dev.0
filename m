Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42B09685C4
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 20:47:55 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 23 Oct 2005 13:03:33 +0200
References: <200510221554.03810.rupert@ces.ch>
	<200510231136.51548.rupert@ces.ch>
	<1130061332.7919.63.camel@gaston>
In-Reply-To: <1130061332.7919.63.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510231303.33828.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 23 October 2005 11:55, Benjamin Herrenschmidt wrote:
> On Sun, 2005-10-23 at 11:36 +0200, Rupert Eibauer wrote:
> > On Sunday 23 October 2005 02:39, Paul Mackerras wrote:
> > > Rupert Eibauer writes:
> > > 
> > > > What this patch actually does:
> > > > - Make CONFIG_PHYS_64BIT selectable for the 6xx family
> > > 
> > > Why?  What does this gain us?  
> > 
> > I have I/O resources there which are not reachable in 32 bit mode.
> > 
> > > We still can't use RAM above the 4GB point AFAICS.
> > 
> > Does this mean the page tables do not support 63 bit?
> 
> Not with the current code. At least not for those CPUs.

I meant 36 bit, but I think you have guessed correctly what I mean.
CONFIG_PHYS_64BIT should really be named CONFIG_PHYS_36BIT.

I have put some more effort into understanding how the page tables work,
and came to the following patch. Maybe this addition makes my previous
patch more attractive to Paul.

Correctness not guaranted, I cannot test it on my hardware.

Rupert

--- pgtable.h.orig	Sun Oct 23 12:18:18 2005
+++ pgtable.h	Sun Oct 23 12:36:55 2005
@@ -446,11 +446,23 @@
 #define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
 #endif
 
-#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
+#if !defined(CONFIG_PTE_64BIT) && defined(CONFIG_PHYS_64BIT)
+#define pfn_36bit_pte_bits(pfn)		((pfn >> (32 - 2 - PAGE_SHIFT) & 4) |\
+					((pfn >> (33 - 9 - PAGE_SHIFT)) & 0xe00))
+
+#define pte_36bit_pfn_bits(pte_val)	((((pte) & 4) << (32 - 2 - PAGE_SHIFT) |\
+					(((pte) & 0xe00) << (33 - 9 - PAGE_SHIFT))
+#else
+#define pfn_36bit_pte_bits(pfn)		0
+#define pte_36bit_pfn_bits(pte_val)	0
+#endif
+
+#define pte_pfn(x)		((pte_val(x) >> PFN_SHIFT_OFFSET) | \
+					((get_highbits_36(pte_val(x))) << (32 - PAGE_SHIFT)))
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
 #define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
-					pgprot_val(prot))
+					pgprot_val(prot) | pfn_36bit_pte_bits(pfn))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 /*
