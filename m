Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0CE00679F5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 10:51:09 +1000 (EST)
Date: Fri, 3 Jun 2005 17:51:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Message-ID: <20050604005106.GB12513@gate.ebshome.net>
References: <42A0E640.4020304@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A0E640.4020304@am.sony.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2005 at 04:22:40PM -0700, Geoff Levand wrote:

[snip]

> +	/* save current CPM */
> +	cpm_save_er = mfdcr(DCRN_CPC0_ER);
> +
> +	/* save UIC0 enable registers */
> +	uic_save_er = mfdcr(DCRN_UIC_ER(UIC0));
> +
> +#ifdef USE_ETHER_TO_RESUME
> +	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT|UIC0_UIC1NC_BIT);
> +#else
> +	/* mask UIC0 interrupts, except External Intr #5 */
> +	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT);
> +#endif

Why UIC PM code is here and not in ppc4xx_pic.c? I don't think this is 
the right place to mess with UIC registers.

[snip]

> ===================================================================
> --- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ibm440gp_sleep.S	2005-06-01 08:52:49.947684744 -0700
> +++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ibm440gp_sleep.S	2005-06-03 16:15:07.000000000 -0700

I think it should be in arch/ppc/syslib not in arch/ppc/platforms/4xx.

-- 
Eugene
