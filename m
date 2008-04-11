Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B56BDEB00
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:31:06 +1000 (EST)
Date: Fri, 11 Apr 2008 10:31:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] gianfar: Determine TBIPA value dynamically
Message-ID: <20080411153125.GA2588@loki.buserror.net>
References: <1207870471-3601-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207870471-3601-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	paul.gortmaker@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 06:34:31PM -0500, Andy Fleming wrote:
>  
> +	/*
> +	 * This is mildly evil, but so is our hardware for doing this.
> +	 * Also, we have to cast back to struct gfar_mii because of
> +	 * definition weirdness done in gianfar.h.
> +	 */
> +	enet_regs = (struct gfar __iomem *)
> +		((char *)regs - offsetof(struct gfar, gfar_mii_regs));

Can we use to_container() here?

-Scott
