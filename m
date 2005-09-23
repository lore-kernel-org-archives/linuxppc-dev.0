Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7AA4C6833B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:29:51 +1000 (EST)
Date: Thu, 22 Sep 2005 20:29:49 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923032949.GB10089@gate.ebshome.net>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 08:03:35PM -0700, Roland Dreier wrote:
> Add support for the AMCC PowerPC 440SPe SoC.

[snip]

> +static struct ocp_func_mal_data amc440spe_mal0_def = {
> +	.num_tx_chans   = 1,    	/* Number of TX channels */
> +	.num_rx_chans   = 1,    	/* Number of RX channels */
> +	.txeob_irq	= 38,		/* TX End Of Buffer IRQ  */
> +	.rxeob_irq	= 39,		/* RX End Of Buffer IRQ  */
> +	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
> +	.rxde_irq	= 35,		/* RX Descriptor Error IRQ */
> +	.serr_irq	= 33,		/* MAL System Error IRQ    */
> +};
> +OCP_SYSFS_MAL_DATA()

Roland, I recently added new field (.dcr_base) to this structure (as a 
preparation step for new EMAC driver), could you do this for 440SPe as 
well? It's not needed right now, but as soon as new EMAC driver is in, 
440SPe will stop working.

[snip]

> +static void __init ppc4xx_pic_impl_init(void)
> +{
> +	/* Enable cascade interrupts in UIC0 */
> +	/* Enable cascade interrupt in UIC0 */

I think you probably missed this part :)

-- 
Eugene
