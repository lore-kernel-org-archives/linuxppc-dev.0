Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D33C6DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 21:34:55 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9VAVKeB018395
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:31:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9VAYoWX098542
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:34:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9VAYgHN031246
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 06:34:43 -0400
Date: Fri, 31 Oct 2008 06:34:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Message-ID: <20081031063448.3fcb3421@zod.rchland.ibm.com>
In-Reply-To: <200810310931.19565.sr@denx.de>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
	<200810310931.19565.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net, weo@reccoware.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Oct 2008 09:31:19 +0100
Stefan Roese <sr@denx.de> wrote:

> On Wednesday 29 October 2008, Josh Boyer wrote:
> > Looks pretty good.  Just a few minor comments/questions below.
> 
> Thanks. I also added some comments below.
> 
> > Also, do you have a patch for a DTS file that gives an example of how to
> > instantiate the SPI stuff in the device tree?
> 
> OK, I'll add a DTS patch to the next version.

Ok thanks.

> > >+	/* send the first byte */
> > >+	data = hw->tx ? hw->tx[0] : 0;
> > >+	out_8(&hw->regs->txd, data);
> > >+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
> >
> > Maybe iowrite8?  Same comment elsewhere.
> 
> Why? We use the in_/out_xxx() accessor function for all other 4xx driver as 
> well.

Yeah.  We used to have all of 4xx in arch/ppc too.  ;)

Seriously though, it doesn't really bother me too much.  The
io{read,write} functions do have a bit better clarity as to endian-ness
though.

> > >+	wait_for_completion(&hw->done);
> > >+
> > >+	return hw->count;
> > >+}
> > >+
> >
> > <snip>
> >
> > >+static struct of_device_id spi_ppc4xx_of_match[] = {
> > >+	{ .compatible = "ibm,spi", },
> > >+	{},
> > >+};
> >
> > I'm wondering if that is too generic of a match.  In theory,
> > IBM could have another SPI controller that isn't for 4xx.
> > Maybe "ibm,spi-4xx" ?
> 
> Right. I was doing it the same way as already done before, e.g. "ibm,iic". For 
> the gpio driver we already switched to "ibm,ppc4xx-gpio". So how 
> about "ibm,ppc4xx-spi"?

Sounds fine to me.

josh
