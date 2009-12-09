Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CD24B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 18:08:52 +1100 (EST)
Subject: Re: Badness at arch/powerpc/mm/pgtable.c:286
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kordex - <kordex@gmail.com>
In-Reply-To: <8b8dd87a0912080914h3d71ea6x3052582b662d5f73@mail.gmail.com>
References: <8b8dd87a0912080914h3d71ea6x3052582b662d5f73@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 18:08:44 +1100
Message-ID: <1260342524.16132.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 19:14 +0200, kordex - wrote:
> Hello,
> 
> I turned some debuging options in order to trace rcutree problems but
> after turning debugging on it began just to loop on this:
> 
> http://xnet.fi/opt/pics/pgtable_badness.jpg
> 1.5M   pgtable_badness.jpg
> 
> I am sorry that I could not produce full dmesg.
> 
> Kernel config: http://xnet.fi/opt/apps/lkml-2.6.32-vanilla.debug.config.txt

Thanks for your report.

Does that patch fixes it ?

powerpc/mm: Fix a WARN_ON() with CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_VM

Set need to call __set_pte_at() and not set_pte_at() from __change_page_attr()
since the later will perform checks with CONFIG_DEBUG_VM that aren't suitable
to the way we override an existing PTE. (More specifically, it doesn't let
you write over a present PTE).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_32.c	2009-12-09 18:06:14.000000000 +1100
+++ linux-work/arch/powerpc/mm/pgtable_32.c	2009-12-09 18:06:16.000000000 +1100
@@ -356,7 +356,7 @@ static int __change_page_attr(struct pag
 		return 0;
 	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
 		return -EINVAL;
-	set_pte_at(&init_mm, address, kpte, mk_pte(page, prot));
+	__set_pte_at(&init_mm, address, kpte, mk_pte(page, prot));
 	wmb();
 #ifdef CONFIG_PPC_STD_MMU
 	flush_hash_pages(0, address, pmd_val(*kpmd), 1);
