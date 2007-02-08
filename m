Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7FE8DDECF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 18:52:30 +1100 (EST)
In-Reply-To: <20070207234845.GA26092@Krystal>
References: <20070207234845.GA26092@Krystal>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <4CCA1279-2782-4184-AF1D-77A043C18768@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC : missing request_dma and free_dma on PPC 405
Date: Thu, 8 Feb 2007 01:51:34 -0600
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 5:48 PM, Mathieu Desnoyers wrote:

> PPC : missing request_dma and free_dma on PPC 405
>
> The solution I have found to correct this linking error for modules
> that use DMA is to allow 4xx to select GENERIC_ISA_DMA in arch/ppc/=20
> Kconfig.
> It applies on 2.6.20.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Are you actually using request_dma/free_dma?

The reason this was Kconfig'd this way is that ISA_DMA doesn't make =20
sense on 4xx or the majority of PPC's because of the lack of an ISA bus.

- k

>
> --- a/arch/ppc/Kconfig
> +++ b/arch/ppc/Kconfig
> @@ -1188,7 +1188,7 @@ config ISA
>
>  config GENERIC_ISA_DMA
>  	bool
> -	depends on 6xx && !CPM2
> +	depends on 4xx || 6xx && !CPM2
>  	default y
>
>  config PPC_I8259
> --=20
> Mathieu Desnoyers
> Computer Engineering Graduate Student, =C9cole Polytechnique de =
Montr=E9al
> OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE =20
> 3BAE 9A68
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
