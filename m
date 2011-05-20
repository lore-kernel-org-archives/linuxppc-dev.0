Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E140B71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 10:36:19 +1000 (EST)
Subject: Re: [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
In-Reply-To: <1305753895-24845-5-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-5-git-send-email-ericvh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 10:36:09 +1000
Message-ID: <1305851769.7481.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
> For BGP, it is convenient for 'kmalloc' to come back with 32-byte
> aligned units for torus DMA
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> ---
>  arch/powerpc/include/asm/page_32.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
> index 68d73b2..fb0a7ae 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -9,7 +9,7 @@
>  
>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
>  
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> +#if defined(CONFIG_NOT_COHERENT_CACHE) || defined(CONFIG_BGP)
>  #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
>  #endif

Is DMA cache coherent on BG/P ? That's odd for a 4xx base :-)

Cheers,
Ben.
