Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 33E38679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 02:46:27 +1000 (EST)
Date: Wed, 4 May 2005 09:46:24 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050504164624.GB11439@gate.ebshome.net>
References: <4278DDA4.7060200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4278DDA4.7060200@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 1/3] FCC Ethernet PlatformDevice support
	for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 04, 2005 at 06:35:16PM +0400, Vitaly Bordug wrote:
> This patch adds generic PlatformDevice support to the 82xx family.
> Only FCC's exist currently in the structure, as there is the driver 
> which will utilize this.
> 

[snip]

> +#ifdef CONFIG_CPM2
> +	identify_ppc_sys_by_id(cpm2_immr->im_memctl.memc_immr << 16);
> +
> +	/* Set up the MAC addresses for the FECs
> +	 */
> +	fec = ppc_sys_platform_devices[MPC82xx_FCC1].dev.platform_data;
> +	memcpy(fec->mac_addr,bi->bi_enetaddr,6);
> +
> +	fec = ppc_sys_platform_devices[MPC82xx_FCC2].dev.platform_data;
> +#ifdef CONFIG_ADS8272
> +	memcpy(fec->mac_addr,bi->bi_enet1addr,6);
> +#else
> +	memcpy(fec->mac_addr,bi->bi_enetaddr,6);
> +	fec->macaddr[5] ^= 1;
> +#endif
> +#endif

What is this? Why does common file contain board specific ifdefs????

[snip]

> +/* FCC1 Clock Source Configuration.  There are board specific.
> +   Can only choose from CLK9-12 */
> +#if defined(CONFIG_ADS8272)
> +#define F1_RXCLK	11
> +#define F1_TXCLK	10
> +#else
> +#define F1_RXCLK	12
> +#define F1_TXCLK	11
> +#endif

Same thing. Why on earth you continue current 8xxx trend of putting 
board specific crap into common files?

> +
> +/* FCC2 Clock Source Configuration.  There are board specific.
> +   Can only choose from CLK13-16 */
> +#ifdef CONFIG_ADS8272
> +#define F2_RXCLK	15
> +#define F2_TXCLK	16
> +#else
> +#define F2_RXCLK	13
> +#define F2_TXCLK	14
> +#endif

Ditto.

> +#ifdef CONFIG_ADS8272
> +#define PC_MDIO		0x00002000U
> +#define PC_MDCK		0x00001000U
> +#else
> +#define PC_MDIO		0x00000004U
> +#define PC_MDCK		0x00000020U
> +#endif

Ditto.

> +				.name	= "phyinterrupt",
> +				.start	= SIU_INT_IRQ5,
> +				.end	= SIU_INT_IRQ5,
> +				.flags	= IORESOURCE_IRQ,
> +			},

Why is this here? PHY interrupt routing is _board_ specific.

-- 
Eugene
