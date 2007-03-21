Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 01F0EDDF51
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 02:50:31 +1100 (EST)
Date: Wed, 21 Mar 2007 11:04:38 -0500
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PPC440EPx/440GRx EMAC support.
Message-ID: <20070321160438.GA3023@lixom.net>
References: <46003608.70308@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46003608.70308@ru.mvista.com>
From: olof@lixom.net (Olof Johansson)
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

On Tue, Mar 20, 2007 at 10:29:12PM +0300, Valentine Barshak wrote:

> diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_core.c linux/drivers/net/ibm_emac/ibm_emac_core.c
> --- linux.orig/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-16 18:03:51.000000000 +0300
> +++ linux/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-18 18:53:08.000000000 +0300
> @@ -86,7 +86,8 @@
>  static u32 busy_phy_map;
>  
>  #if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && \
> -    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR))
> +    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR) || \
> +     defined(CONFIG_440EPX) || defined(CONFIG_440GRX))

This is getting out of control. Please add a config option for this,
and add "select" statements to the Kconfig file where any of the above
CONFIG_4.* are defined. 

>  /* 405EP has "EMAC to PHY Control Register" (CPC0_EPCTL) which can help us
>   * with PHY RX clock problem.
>   * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX, which
> diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac.h linux/drivers/net/ibm_emac/ibm_emac.h
> --- linux.orig/drivers/net/ibm_emac/ibm_emac.h	2007-03-16 18:03:51.000000000 +0300
> +++ linux/drivers/net/ibm_emac/ibm_emac.h	2007-03-18 18:53:08.000000000 +0300
> @@ -26,7 +26,7 @@
>  #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
>      !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
>      !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
> -    !defined(CONFIG_440GR)
> +    !defined(CONFIG_440GR) && !defined(CONFIG_440EPX) && !defined(CONFIG_440GRX)

Same here. I know you only added a couple more, but it's reached critical
mass (well, it did a while ago).



-Olof
