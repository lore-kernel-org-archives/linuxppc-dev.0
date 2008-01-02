Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4975EDDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 05:12:48 +1100 (EST)
Date: Wed, 2 Jan 2008 12:12:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ucc_uart: add support for Freescale QUICCEngine UART
Message-ID: <20080102181226.GA4486@loki.buserror.net>
References: <11970458703666-git-send-email-timur@freescale.com>
	<20071226165816.GB11449@localhost.localdomain>
	<4776C5EE.70004@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4776C5EE.70004@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 29, 2007 at 04:10:54PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >> +		ucc@2400 {
> >> +			device_type = "serial";
> >> +			compatible = "ucc_uart";
> >> +			model = "UCC";
> > 
> > model isn't used, is it needed at all?
> 
> I have no idea, but all the other UCC nodes have it, so I'm going to 
> keep it.  Maybe one day we'll merge QE and CPM drivers, so this would be 
> useful.

No, it wouldn't -- that's what compatible is for.

> >> +static struct of_platform_driver ucc_uart_of_driver = {
> >> +	.owner  	= THIS_MODULE,
> >> +	.name   	= "ucc_uart",
> > 
> > Maybe better fsl,ucc_uart?

fsl,qe-uart is defined by Documentation/powerpc/booting-without-of.txt.

> The CPM serial driver uses "cpm_uart" and the QE ethernet driver uses 
> "ucc_geth", so ucc_uart matches the pattern.

cpm_uart is a legacy match -- the current binding specifies
fsl,cpm1-smc-uart, fsl,cpm2-scc-uart, etc.

-Scott
