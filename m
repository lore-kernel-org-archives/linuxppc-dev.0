Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 453C72C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 21:19:09 +1000 (EST)
Message-ID: <1349349544.4260.24.camel@pasglop>
Subject: Re: [PATCH] PPC: Correct the tophys/tovirt macros
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 04 Oct 2012 21:19:04 +1000
In-Reply-To: <20120930232847.GG30637@obsidianresearch.com>
References: <20120930232847.GG30637@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-09-30 at 17:28 -0600, Jason Gunthorpe wrote:
> asm/page.h discusses the calculation for v2p and p2v, it should be:
>  va = pa + KERNELBASE - PHYSICAL_START
> which is the same as:
>  va = pa + LOAD_OFFSET
> 
> tophys/tovirt were using PAGE_OFFSET, which as page.h says, is almost
> always the same thing.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

It's a bit gross tho in that KERNEL_BASE, PHYSICAL_START and LOAD_OFFSET
are about where the kernel is linked/running, and while the value ends
up happening to also be the p->v offset (and indeed not by accident), it
makes the code less clear and more confusing.

I think the main issue is that we did things wrong when implementing
non-0 based setups. PAGE_OFFSET should have remained what its name
implies which is the offset between p and v.

I don't have the bandwidth to revisit all that, but I really think that
whole are area where PAGE_OFFSET doesn't map 0 needs revisiting.

Ben.

> ---
>  arch/powerpc/include/asm/ppc_asm.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index ea2a86e..44edc3a 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -461,14 +461,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
>  #define fromreal(rd)	tovirt(rd,rd)
>  
>  #define tophys(rd,rs)				\
> -0:	addis	rd,rs,-PAGE_OFFSET@h;		\
> +0:	addis	rd,rs,-LOAD_OFFSET@h;		\
>  	.section ".vtop_fixup","aw";		\
>  	.align  1;				\
>  	.long   0b;				\
>  	.previous
>  
>  #define tovirt(rd,rs)				\
> -0:	addis	rd,rs,PAGE_OFFSET@h;		\
> +0:	addis	rd,rs,LOAD_OFFSET@h;		\
>  	.section ".ptov_fixup","aw";		\
>  	.align  1;				\
>  	.long   0b;				\
