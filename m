Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 36DA867A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 18:18:08 +1000 (EST)
Date: Fri, 6 May 2005 01:18:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050506081805.GA19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427B22A0.8010704@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 06, 2005 at 11:54:08AM +0400, Vitaly Bordug wrote:

[snip]

> +static struct cpm2_fec_platform_data mpc82xx_fcc1_pdata = {
> +	.cp_page	= CPM_CR_FCC1_PAGE,
> +	.cp_block 	= CPM_CR_FCC1_SBLOCK,
> +	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
> +	.clk_route	= CMX1_CLK_ROUTE,
> +	.clk_mask	= CMX1_CLK_MASK,
> +	.mdio		= PC_MDIO,
> +	.mdck		= PC_MDCK,
> +	
> +	.device_flags	= FSL_CPM2_FEC_BRD_HAS_PHY_INTR,
> +	.phyid 		= 0,
> +	.interruptPHY	= SIU_INT_IRQ5,
> +};

Hmm, interruptPHY here still looks somewhat odd. Why not use the same 
approach as for the rest of the fields - "default" if corresponding 
define wasn't defined by the board port? 

Not that I like this approach, IMHO there should be _NO_ defines at 
all here and board setup code must fill them, but I guess it's OK 
for now, mostly because there is no board specific files for 82xx 
boards yet and this makes the patch quite small.

-- 
Eugene
