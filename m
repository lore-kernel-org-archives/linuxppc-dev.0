Return-Path: <wladislav.kw@gmail.com>
Received: from mail-ee0-x234.google.com (mail-ee0-x234.google.com
 [IPv6:2a00:1450:4013:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B984F2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 02:34:25 +1000 (EST)
Received: by mail-ee0-f52.google.com with SMTP id c41so472059eek.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 09:34:20 -0700 (PDT)
Message-ID: <51F93C64.4090601@gmail.com>
Date: Wed, 31 Jul 2013 18:33:40 +0200
From: Wladislav Wiebe <wladislav.kw@gmail.com>
MIME-Version: 1.0
To: Christoph Lameter <cl@gentwo.org>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
References: <51F8F827.6020108@gmail.com>
 <alpine.DEB.2.02.1307310858150.30572@gentwo.org>
 <alpine.DEB.2.02.1307311015320.30997@gentwo.org>
 <000001403567762a-60a27288-f0b2-4855-b88c-6a6f21ec537c-000000@email.amazonses.com>
In-Reply-To: <000001403567762a-60a27288-f0b2-4855-b88c-6a6f21ec537c-000000@email.amazonses.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dedekind1@gmail.com, Mel Gorman <mel@csn.ul.ie>, dwmw2@infradead.org,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On 31/07/13 17:45, Christoph Lameter wrote:
> Crap you cannot do PAGE_SIZE allocations with kmalloc_large. Fails when
> freeing pages. Need to only do the multiple page allocs with
> kmalloc_large.
> 
> Subject: seq_file: Use kmalloc_large for page sized allocation
> 
> There is no point in using the slab allocation functions for
> large page order allocation. Use kmalloc_large().
> 
> This fixes the warning about large allocs but it will still cause
> large contiguous allocs that could fail because of memory fragmentation.

Thanks for the point, do you plan to make kmalloc_large available for extern access in a separate mainline patch?
Since kmalloc_large is statically defined in slub_def.h and when including it to seq_file.c
we have a lot of conflicting types:
..
In file included from ../linux/fs/seq_file.c:8:0:
../linux/include/linux/slub_def.h: In function 'kmalloc':
../linux/include/linux/slub_def.h:161:14: error: 'KMALLOC_MAX_CACHE_SIZE' undeclared (first use in this function)
../results/linux/include/linux/slub_def.h:161:14: note: each undeclared identifier is reported only once for each function it appears in
../linux/include/linux/slub_def.h:165:4: error: implicit declaration of function 'kmalloc_index' [-Werror=implicit-function-declaration]
../linux/include/linux/slub_def.h:168:12: error: 'ZERO_SIZE_PTR' undeclared (first use in this function)
../linux/include/linux/slub_def.h:170:34: error: 'kmalloc_caches' undeclared (first use in this function)
..


Thanks & BR
Wladislav Wiebe

> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/fs/seq_file.c
> ===================================================================
> --- linux.orig/fs/seq_file.c	2013-07-31 10:39:03.050472030 -0500
> +++ linux/fs/seq_file.c	2013-07-31 10:39:03.050472030 -0500
> @@ -136,7 +136,7 @@ static int traverse(struct seq_file *m,
>  Eoverflow:
>  	m->op->stop(m, p);
>  	kfree(m->buf);
> -	m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
> +	m->buf = kmalloc_large(m->size <<= 1, GFP_KERNEL);
>  	return !m->buf ? -ENOMEM : -EAGAIN;
>  }
> 
> @@ -232,7 +232,7 @@ ssize_t seq_read(struct file *file, char
>  			goto Fill;
>  		m->op->stop(m, p);
>  		kfree(m->buf);
> -		m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
> +		m->buf = kmalloc_large(m->size <<= 1, GFP_KERNEL);
>  		if (!m->buf)
>  			goto Enomem;
>  		m->count = 0;
> 
