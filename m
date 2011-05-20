Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F966B71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 10:39:13 +1000 (EST)
Subject: Re: [PATCH 6/7] [RFC] enable early TLBs for BG/P
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
In-Reply-To: <1305753895-24845-6-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-6-git-send-email-ericvh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 10:39:01 +1000
Message-ID: <1305851941.7481.92.camel@pasglop>
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
> BG/P maps firmware with an early TLB

That's a bit gross. How often do you call that firmware in practice ?
Aren't you better off instead inserting a TLB entry for it when you call
it instead ? A simple tlbsx. + tlbwe sequence would do. That would free
up a TLB entry for normal use.

Cheers,
Ben.

> Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> ---
>  arch/powerpc/include/asm/mmu-44x.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
> index ca1b90c..2807d6e 100644
> --- a/arch/powerpc/include/asm/mmu-44x.h
> +++ b/arch/powerpc/include/asm/mmu-44x.h
> @@ -115,8 +115,12 @@ typedef struct {
>  #endif /* !__ASSEMBLY__ */
>  
>  #ifndef CONFIG_PPC_EARLY_DEBUG_44x
> +#ifndef CONFIG_BGP
>  #define PPC44x_EARLY_TLBS	1
> -#else
> +#else /* CONFIG_BGP */
> +#define PPC44x_EARLY_TLBS	2
> +#endif /* CONFIG_BGP */
> +#else /* CONFIG_PPC_EARLY_DEBUG_44x */
>  #define PPC44x_EARLY_TLBS	2
>  #define PPC44x_EARLY_DEBUG_VIRTADDR	(ASM_CONST(0xf0000000) \
>  	| (ASM_CONST(CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW) & 0xffff))
