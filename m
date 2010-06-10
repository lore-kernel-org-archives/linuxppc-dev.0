Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1748FB7D48
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 18:59:26 +1000 (EST)
Subject: Re: [PATCH 5b/5] Removing dead CONFIG_PPC47x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100609120522.GH7801@zod.rchland.ibm.com>
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<20100609110239.GA28290@faui48a.informatik.uni-erlangen.de>
	<20100609120522.GH7801@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 18:59:04 +1000
Message-ID: <1276160344.1962.65.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	vamos@i4.informatik.uni-erlangen.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Christoph Egger <siccegge@cs.fau.de>, Paul Mackerras <paulus@samba.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-09 at 08:05 -0400, Josh Boyer wrote:
> On Wed, Jun 09, 2010 at 01:02:39PM +0200, Christoph Egger wrote:
> >CONFIG_PPC47x should actually be spelled CONFIG_PPC_47x as reported by
> >Andreas Schwab.
> >
> >Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> Thanks, I'll pull this one in and get it merged.

I pulled your tree along with a couple of other things. I'll do a few
tests tomorrow before sending to Linus.

Cheers,
Ben.

> josh
> 
> >---
> > arch/powerpc/mm/44x_mmu.c |    4 ----
> > 1 files changed, 0 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
> >index d8c6efb..f70da7e 100644
> >--- a/arch/powerpc/mm/44x_mmu.c
> >+++ b/arch/powerpc/mm/44x_mmu.c
> >@@ -76,11 +76,11 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
> > 		"tlbwe	%1,%3,%5\n"
> > 		"tlbwe	%0,%3,%6\n"
> > 	:
> >-#ifdef CONFIG_PPC47x
> >+#ifdef CONFIG_PPC_47x
> > 	: "r" (PPC47x_TLB2_S_RWX),
> > #else
> > 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
> > #endif
> > 	  "r" (phys),
> > 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
> > 	  "r" (entry),
> >-- 
> >1.6.3.3
> >
