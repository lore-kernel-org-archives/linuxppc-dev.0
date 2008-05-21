Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 04BC8DE6DA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:48:42 +1000 (EST)
Date: Wed, 21 May 2008 20:48:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
Message-ID: <20080521164841.GA17813@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0805211820460.5386@axis700.grange>
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

On Wed, May 21, 2008 at 06:24:58PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 21 May 2008, Anton Vorontsov wrote:
> 
> > On Wed, May 21, 2008 at 05:56:33PM +0200, Guennadi Liakhovetski wrote:
> > > 
> > > Hm, I might well misunderstand something here, but it looks to me like you 
> > > are again trying to use both OF _and_ platform (spi_board_info) bindings 
> > > for your SPI setup?
> > 
> > Yes, you didn't misunderstand. ;-)
> > 
> > > And this is exactly what we are trying to avoid in 
> > > Grant's series of patches...
> > 
> > I didn't find other way... The show stopper is "master" argument,
> > drivers don't know about masters (and should not, since if they should,
> > then this implies that masters should be registered prior to devices,
> > and that complicates everything).
> > 
> > What is the problem with board infos, btw? I missed that part. Board
> 
> In short: board infos are not bad as such. I find it bad if you have to 
> use both OF and platform bindings to describe _one_ piece of hardware.

This particular discussion isn't about describing hardware (since
we're describing it via device tree), but about implementation
details, such as:

1. Passing platform_data to the drivers;
2. Creating "SPI Linux devices" from the OF description.

I see there ways:

1. Grant Likely's approach (works great for simple drivers which don't
   need SPI platform_data).
2. Old board infos approach, there we can do whatever we want.
3. Implementing OF bindings for the every SPI driver that needs
   platform_data.

I could do "3", let's see what it will look like...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
