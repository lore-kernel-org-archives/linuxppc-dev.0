Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 09DD8DDF5D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:51:20 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 03 Mar 2008 20:51:17 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1204498569.15052.488.camel@pasglop>
Message-ID: <20080303195117.7040@gmx.net>
MIME-Version: 1.0
References: <20071125234254.B4405DDE49@ozlabs.org>	
	<20080302110505.175270@gmx.net> <1204490829.15052.482.camel@pasglop>	
	<20080302223012.90210@gmx.net> <1204498569.15052.488.camel@pasglop>
Subject: Re: [BUG/RFC/PATCH] drm: Fix for non-coherent DMA PowerPC
To: benh@kernel.crashing.org
Cc: airlied@linux.ie, linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 03 Mar 2008 09:56:09 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, airlied@linux.ie
> Betreff: Re: [BUG/RFC/PATCH] drm: Fix for non-coherent DMA PowerPC

> Bah, I think I found the problem:
> 
> +static inline void *drm_vmalloc_dma(unsigned long size)
> +{
> +#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> +       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM,
> +                        PAGE_KERNEL | _PAGE_NO_CACHE);
> +#else
> +       return vmalloc_32(size);
> +#endif
> +}
> +
> 
> Remove the GFP_HIGHMEM from the above. It looks like our cache
> flushing isn't going to work for highmem, it would need some
> kmap's for that.
Yes, it looks like this was the problem. No kernel oops anymore.
The machine locks up anyway (which is a well known hardware problem).
It doesn't lock up with CPPIOMode=true, but probably only because the
initialization of DRI fails with "BAD cp_mode (f0000000)!".

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
