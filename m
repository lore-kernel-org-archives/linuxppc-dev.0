Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0E195DE033
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:01:29 +1000 (EST)
Date: Wed, 21 May 2008 20:01:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC/DRAFT] SPI OF bindings, MMC-over-SPI, chip-selects and so on
Message-ID: <20080521160127.GA7812@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211751160.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0805211751160.5386@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 05:54:20PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 21 May 2008, Anton Vorontsov wrote:
> 
> > This is just a bait for further discussion of OF/SPI, chip-selects,
> > e.t.c.
> > 
> > I've converted the spi_mpc83xx to the OF driver (using Grant's
> > SPI_MASTER_OF work + some additions), and implemented MMC-over-SPI
> > bindings. This stuff extensively using GPIOs, and I think this will
> > work for the "bridged SPI" too, since the SPI bridge could be
> > represented as GPIO controller (inside the SPI controller node).
> 
> Yes, but do you really _want_ to represent them as GPIOs? Firstly they are 
> not really "G" P, secondly, they are not even "I", rather only "O".

"General Purpose Input/Output" implies that lines could be only I or
only O, or both. (plus "dedicated function", though, here David Brownell
will probably disagree ;-) GPIOs are really general.

> And do 
> you really want to register your SPI CS lines to the whole system for 
> everyone's (ab)use?...

This is represented via device tree, so the only abusers could be
hardware designers. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
