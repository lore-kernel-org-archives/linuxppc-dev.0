Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHcMY4nHBzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 16:06:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: ipic - fix status get and status clear
In-Reply-To: <20171018091647.B9E9F6872C@po15668-vm-win7.idsi0.si.c-s.fr>
References: <20171018091647.B9E9F6872C@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Thu, 19 Oct 2017 16:06:01 +1100
Message-ID: <8760bbn2va.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> IPIC Status is provided by register IPIC_SERSR and not by IPIC_SERMR
> which is the mask register.

This seems like it would be a bad bug. But I guess it hasn't mattered
for some reason?

cheers

> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index 16f1edd78c40..535cf1f6941c 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -846,12 +846,12 @@ void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
>  
>  u32 ipic_get_mcp_status(void)
>  {
> -	return ipic_read(primary_ipic->regs, IPIC_SERMR);
> +	return ipic_read(primary_ipic->regs, IPIC_SERSR);
>  }
>  
>  void ipic_clear_mcp_status(u32 mask)
>  {
> -	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
> +	ipic_write(primary_ipic->regs, IPIC_SERSR, mask);
>  }
>  
>  /* Return an interrupt vector or 0 if no interrupt is pending. */
> -- 
> 2.13.3
