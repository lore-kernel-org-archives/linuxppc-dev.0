Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1977267AC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 00:30:53 +1000 (EST)
In-Reply-To: <427A2604.8040808@ru.mvista.com>
References: <4278DDA4.7060200@ru.mvista.com>
	<20050504164624.GB11439@gate.ebshome.net>
	<427A2604.8040808@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <47856218c8d9bef3dfdb6a00d67aafc6@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 5 May 2005 09:30:51 -0500
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
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

Can you send just an updated patch for just the base platform 
additions.  What I'm looking for is just changes/additions of the 
following files:

arch/ppc/syslib/mpc82xx_device.c
arch/ppc/syslib/mpc82xx_sys.c
include/asm-ppc/mpc8260.h
include/asm-ppc/ppc_sys.h

thanks

- kumar

On May 5, 2005, at 8:56 AM, Vitaly Bordug wrote:

>  Eugene Surovegin wrote:
> On Wed, May 04, 2005 at 06:35:16PM +0400, Vitaly Bordug wrote:
>
> This patch adds generic PlatformDevice support to the 82xx family.
> Only FCC's exist currently in the structure, as there is the driver
> which will utilize this.
>
>
> [snip]
>
>
> +#ifdef CONFIG_CPM2
> +       identify_ppc_sys_by_id(cpm2_immr->im_memctl.memc_immr << 16);
> +
> +       /* Set up the MAC addresses for the FECs
> +        */
> +       fec = ppc_sys_platform_devices[MPC82xx_FCC1].dev.platform_data;
> +       memcpy(fec->mac_addr,bi->bi_enetaddr,6);
> +
> +       fec = ppc_sys_platform_devices[MPC82xx_FCC2].dev.platform_data;
> +#ifdef CONFIG_ADS8272
> +       memcpy(fec->mac_addr,bi->bi_enet1addr,6);
> +#else
> +       memcpy(fec->mac_addr,bi->bi_enetaddr,6);
> +       fec->macaddr[5] ^= 1;
> +#endif
> +#endif
>
> What is this? Why does common file contain board specific ifdefs????
>
> [snip]
>
>
> +/* FCC1 Clock Source Configuration.  There are board specific.
> +   Can only choose from CLK9-12 */
> +#if defined(CONFIG_ADS8272)
> +#define F1_RXCLK       11
> +#define F1_TXCLK       10
> +#else
> +#define F1_RXCLK       12
> +#define F1_TXCLK       11
> +#endif
>
> Same thing. Why on earth you continue current 8xxx trend of putting
> board specific crap into common files?
>
>
> +
> +/* FCC2 Clock Source Configuration.  There are board specific.
> +   Can only choose from CLK13-16 */
> +#ifdef CONFIG_ADS8272
> +#define F2_RXCLK       15
> +#define F2_TXCLK       16
> +#else
> +#define F2_RXCLK       13
> +#define F2_TXCLK       14
> +#endif
>
> Ditto.
>
>
> +#ifdef CONFIG_ADS8272
> +#define PC_MDIO                0x00002000U
> +#define PC_MDCK                0x00001000U
> +#else
> +#define PC_MDIO                0x00000004U
> +#define PC_MDCK                0x00000020U
> +#endif
>
> Ditto.
>
>
> +                               .name   = "phyinterrupt",
> +                               .start  = SIU_INT_IRQ5,
> +                               .end    = SIU_INT_IRQ5,
> +                               .flags  = IORESOURCE_IRQ,
> +                       },
>
> Why is this here? PHY interrupt routing is _board_ specific.
>
>
>  I have fixed these yet, but I think it will be more reasonable to 
> update this together with respective driver which I'll work on 
> together with Pantelis.
>  Thank you for review.
>
>
> -- 
> Sincerely,
> Vitaly
>
> <ATT400050.txt>
