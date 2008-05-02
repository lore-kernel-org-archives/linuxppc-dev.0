Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9D30DDED8
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 04:37:21 +1000 (EST)
Message-ID: <481B5F59.8020201@freescale.com>
Date: Fri, 02 May 2008 13:37:13 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] powerpc: Fix a bunch of sparse warnings in the
	qe_lib
References: <1209751415-25612-1-git-send-email-afleming@freescale.com>
In-Reply-To: <1209751415-25612-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:

>  int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret)
>  {
>  	struct ucc_fast_private *uccf;
> -	struct ucc_fast *uf_regs;
> +	struct ucc_fast __iomem *uf_regs;
>  	u32 gumr;
>  	int ret;
>  
> @@ -216,10 +216,10 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>  	uccf->stopped_tx = 0;
>  	uccf->stopped_rx = 0;
>  	uf_regs = uccf->uf_regs;
> -	uccf->p_ucce = (u32 *) & (uf_regs->ucce);
> -	uccf->p_uccm = (u32 *) & (uf_regs->uccm);
> +	uccf->p_ucce = (u32 __iomem *) & (uf_regs->ucce);
> +	uccf->p_uccm = (u32 __iomem *) & (uf_regs->uccm);

Since you've already made uf_regs into an __iomem pointer, do you really need to
cast it?

And please remember to CC: me on any QE library patches.

-- 
Timur Tabi
Linux kernel developer at Freescale
