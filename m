Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13E601A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 17:42:57 +1100 (AEDT)
Date: Wed, 21 Oct 2015 17:42:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/msi: fix section mismatch warning
Message-ID: <20151021174256.635a4cb4@canb.auug.org.au>
In-Reply-To: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
References: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Denis,

On Wed, 21 Oct 2015 08:56:44 +0300 Denis Kirjanov <kda@linux-powerpc.org> wrote:
>
> diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
> index 1ec7125..fbd3424 100644
> --- a/arch/powerpc/include/asm/msi_bitmap.h
> +++ b/arch/powerpc/include/asm/msi_bitmap.h
> @@ -29,7 +29,7 @@ void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq);
>  
>  int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp);
>  
> -int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
> +int __init_refok msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
>  		     struct device_node *of_node);

I am pretty sure that we don't want or need the annotation in the header file.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
