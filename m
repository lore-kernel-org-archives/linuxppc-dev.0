Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B9ECA67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 03:37:21 +1000 (EST)
Date: Wed, 6 Apr 2005 10:37:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20050406173716.GB18166@gate.ebshome.net>
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112808085.24527.296.camel@rhino.az.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2005 at 10:21:25AM -0700, Wade Farnsworth wrote:
> 
> This patch adds support for the IBM/AMCC PPC440EP SoC and the Bamboo
> reference board.

[snip]

> + * Bamboo external IRQ triggering/polarity settings
> + */
> +unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ0: Ethernet transceiver */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE), /* IRQ1: Expansion connector */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ2: PCI slot 0 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ3: PCI slot 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ4: PCI slot 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ5: PCI slot 3 */
> +	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE), /* IRQ6: SMI pushbutton */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ7: EXT */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ8: EXT */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ9: EXT */
> +};

You need to define ppc4xx_core_uic_cfg[] in ibm440ep.c for this thing 
to work, otherwise it's ignored.

--
Eugene
