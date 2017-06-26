Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx82Q187BzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 22:46:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Jurgen Schindele <schindele@nentec.de>
Subject: Re: [PATCH] powerpc/ipic: Support edge on IRQ0
In-Reply-To: <20170625023905.24649-1-oss@buserror.net>
References: <20170625023905.24649-1-oss@buserror.net>
Date: Mon, 26 Jun 2017 22:46:52 +1000
Message-ID: <878tkeex1f.fsf@concordia.ellerman.id.au>
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

Scott Wood <oss@buserror.net> writes:

> External IRQ0 has the same capabilities as the other IRQ1-7 and is
> handled by the same register IPIC_SEPNR.  When this register is not
> specified for "ack" in "ipic_info", you cannot configure this IRQ as
> IRQ_TYPE_EDGE_FALLING.  This oversight was probably due to the
> non-contiguous hwirq numbering of IRQ0 in the IPIC.

I don't know this code at all, but nothing in the diff says "IRQ0" to
me?

cheers

> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index f267ee0afc08..16f1edd78c40 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] = {
>  		.prio_mask = 7,
>  	},
>  	[48] = {
> +		.ack	= IPIC_SEPNR,
>  		.mask	= IPIC_SEMSR,
>  		.prio	= IPIC_SMPRR_A,
>  		.force	= IPIC_SEFCR,
> -- 
> 2.11.0
