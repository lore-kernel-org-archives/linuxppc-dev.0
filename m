Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B781DDDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 20:44:05 +1000 (EST)
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090430103528.GA6900@wotan.suse.de>
References: <20090428165343.2e357d7a.sfr@canb.auug.org.au>
	<49F6E421.401@in.ibm.com>
	<84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
	<20090429113604.GE3398@wotan.suse.de> <49F87FAB.9050408@in.ibm.com>
	<20090430041146.GB23746@wotan.suse.de> <49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de> <49F973A0.8070106@in.ibm.com>
	<20090430103528.GA6900@wotan.suse.de>
Date: Thu, 30 Apr 2009 13:38:04 +0300
Message-Id: <1241087884.19252.5.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 12:35 +0200, Nick Piggin wrote:
> On Thu, Apr 30, 2009 at 03:17:12PM +0530, Sachin Sant wrote:
> > Nick Piggin wrote:
> > >Hmm, forget that. Actually my last patch had a silly mistake because I
> > >forgot MAX_ORDER shift is applied to PAGE_SIZE, rather than 1. So
> > >kmalloc(PAGE_SIZE) was failing as too large.
> > >
> > >This patch should do the trick I hope.
> > >  
> > Yes this patch fixed the issue for me. Thanks Nick.
> 
> Thanks very much for reporting and testing.
> 
> Pekka, can you apply this patch please?

Sure. Sachin, can I add a "Reported-by" and "Tested-by" tags from you to
the patch description?

Stephen, does this patch fix all the boot problems for you as well?

> --
> SLQB: fix slab calculation
> 
> SLQB didn't consider MAX_ORDER when defining which sizes of kmalloc
> slabs to create. It panics at boot if it tries to create a cache
> which exceeds MAX_ORDER-1.

Nit: this _really_ needs a pointer to the discussion or bit more details
on the issue. But I can fix that when I merge the patch.

> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
>  include/linux/slqb_def.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/slqb_def.h
> ===================================================================
> --- linux-2.6.orig/include/linux/slqb_def.h
> +++ linux-2.6/include/linux/slqb_def.h
> @@ -172,7 +172,8 @@ struct kmem_cache {
>  #endif
>  
>  #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
> -#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 9)
> +#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 			\
> +				 ((9 <= (MAX_ORDER - 1)) ? 9 : (MAX_ORDER - 1)))
>  
>  extern struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_SLQB_HIGH + 1];
>  extern struct kmem_cache kmalloc_caches_dma[KMALLOC_SHIFT_SLQB_HIGH + 1];
