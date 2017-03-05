Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbNzL1PhHzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 11:27:25 +1100 (AEDT)
Message-ID: <1488673630.2870.110.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@ozlabs.org>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sun, 05 Mar 2017 11:27:10 +1100
In-Reply-To: <1488673507.2870.109.camel@kernel.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <1488673507.2870.109.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-03-05 at 11:25 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2017-03-05 at 10:54 +1100, Anton Blanchard wrote:
> > From: Anton Blanchard <anton@samba.org>
> > 
> > I see a panic in early boot when building with a recent gcc
> > toolchain.
> > The issue is a divide by zero, which is undefined. Older toolchains
> > let us get away with it:
> 
> Maybe we should panic though ... not having a valid cache block size
> is going to be fatal in other areas...

 ... Unless it's for L2/L3 caches. Of course...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> > int foo(int a) { return a / 0; }
> > 
> > foo:
> > 	li 9,0
> > 	divw 3,3,9
> > 	extsw 3,3
> > 	blr
> > 
> > But newer ones catch it:
> > 
> > foo:
> > 	trap
> > 
> > Add a check to avoid the divide by zero.
> > 
> > Fixes: bd067f83b084 ("powerpc/64: Fix naming of cache block vs.
> > cache
> > line")
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > ---
> >  arch/powerpc/kernel/setup_64.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/setup_64.c
> > b/arch/powerpc/kernel/setup_64.c
> > index adf2084..afd1c26 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -408,7 +408,8 @@ static void init_cache_info(struct
> > ppc_cache_info
> > *info, u32 size, u32 lsize,
> >  	info->line_size = lsize;
> >  	info->block_size = bsize;
> >  	info->log_block_size = __ilog2(bsize);
> > -	info->blocks_per_page = PAGE_SIZE / bsize;
> > +	if (bsize)
> > +		info->blocks_per_page = PAGE_SIZE / bsize;
> >  
> >  	if (sets == 0)
> >  		info->assoc = 0xffff;
