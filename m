Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFEE867A3E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 10:41:18 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for
	mpc7448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AF039DA5-BAED-4646-904A-18BE025989AD@kernel.crashing.org>
References: <9FCDBA58F226D911B202000BDBAD46730626D619@zch01exm40.ap.freescale.net>
	<AF039DA5-BAED-4646-904A-18BE025989AD@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:41:07 +1000
Message-Id: <1147912867.10703.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 08:45 -0500, Kumar Gala wrote:

> > +#ifdef TSI108_ETH
> > +hw_info hw_info_table[TSI108_ETH_MAX_PORTS + 1] = {
> > +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > +	 TSI108_PHY0_ADDR, IRQ_TSI108_GIGE0},
> > +
> > +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET + 0x400,
> > +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > +	 TSI108_PHY1_ADDR, IRQ_TSI108_GIGE1},
> > +
> > +	{TBL_END, TBL_END, TBL_END, TBL_END}
> > +};
> > +#endif
> 
> This table looks problematic.  Look at using something like a  
> platform device.

Bzzzt ... wrong answer :) That's a textbook example of stuff that should
be provided via the device-tree.
