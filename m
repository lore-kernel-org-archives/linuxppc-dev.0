Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42D0FDDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:30:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1U0qF007924
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:30:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1U0rT160704
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:30:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1U0Ua005788
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:30:00 -0600
Subject: Re: [PATCH 3/3] Bamboo wrapper
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070515012825.GD565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154791.3420.26.camel@zod.rchland.ibm.com>
	<20070515012825.GD565@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 May 2007 20:29:50 -0500
Message-Id: <1179192590.3420.87.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:28 +1000, David Gibson wrote:
> On Mon, May 14, 2007 at 09:59:51AM -0500, Josh Boyer wrote:
> > Add a bootwrapper for Bamboo
> 
> [snip]
> > +#define DCRN_MAL0_CFG 0x180
> > +static void ibm440ep_reset_eth(void)
> > +{
> > +	/* reset the MAL and EMACs since PIBS doesn't do this for us */
> > +	u32 *emac0 = (u32 *)0xef600e00;
> > +	u32 *emac1 = (u32 *)0xef600f00;
> > +
> > +	*emac0 = 0x20000000;
> > +	*emac1 = 0x20000000;
> > +	mtdcr(DCRN_MAL0_CFG, 0x80000000);
> > +}
> 
> Since a number of 4xx board firmware suffer from this EMAC/MAL reset
> problem it would be nice to factor this out into a common file.

Ok, I can look at doing that.  Shouldn't be difficult.

> > +static void ibm440ep_clear_uics(void)
> > +{
> > +	/* Clear the UIC registers so we don't get spurious interrupts
> > +	 * in the kernel
> > +	 */
> > +	mtdcr(DCRN_UIC0_ER, 0x0);
> > +	mtdcr(DCRN_UIC0_SR, 0xffffffff);
> > +	mtdcr(DCRN_UIC1_ER, 0x0);
> > +	mtdcr(DCRN_UIC1_SR, 0xffffffff);
> > +}
> 
> I don't think we should need this.  As you suggested I added such a
> clear to my UIC driver in the kernel proper.

Ah, true.  Leftover cruft from before that was added.  I'll remove.

josh
