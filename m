Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D366DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:13:49 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8EFMcv010655
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:15:22 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8EDklu467962
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:13:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8EDkpv024400
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:13:46 -0500
Date: Thu, 8 Nov 2007 08:09:31 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] ioremap/iounmap issue in
	yucca_setup_pcie_fpga_rootpoint(); arch/ppc/platforms/4xx/yucca.c
Message-ID: <20071108080931.4278d4f5@zod.rchland.ibm.com>
In-Reply-To: <47323AB8.3060804@tiscali.nl>
References: <47323AB8.3060804@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Nov 2007 23:22:48 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> iounmap pcie_reg_fpga_base in default case
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Looks good, thanks.

josh

> ---
> diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
> index a83b0ba..66a44ff 100644
> --- a/arch/ppc/platforms/4xx/yucca.c
> +++ b/arch/ppc/platforms/4xx/yucca.c
> @@ -211,6 +211,7 @@ static void __init yucca_setup_pcie_fpga_rootpoint(int port)
>  		break;
> 
>  	default:
> +		iounmap(pcie_reg_fpga_base);
>  		return;
>  	}
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
