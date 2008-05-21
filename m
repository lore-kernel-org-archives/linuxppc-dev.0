Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4EA9ADE598
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:05:08 +1000 (EST)
Date: Wed, 21 May 2008 21:05:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] [SPI] spi_mpc83xx: convert to the OF platform driver
Message-ID: <20080521170506.GA22021@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154137.GA4566@polina.dev.rtsoft.ru>
	<fa686aa40805210950i2df67158p139770f675ef2032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40805210950i2df67158p139770f675ef2032@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 10:50:02AM -0600, Grant Likely wrote:
[..]
> > +
> > +       master->num_chipselect = of_num_children(np);
> 
> This assumes that there are no gaps in the assigned CS numbers of
> child nodes, or that the child nodes are an exhaustive list of
> attached devices, neither of which may be true.  num_chipselect should
> be calculated from the number of GPIOs specified instead.

[I'm not arguing just a thought.]

- every SPI device must have its own chip-select, otherwise SPI device
  node should not be a part of a SPI controller node;
- or there is just once device on the SPI bus with chip-select always
  asserted, no gpios = <> is specified (this case is implemented);
- or the SPI is bridged, gpios = <> should list behind-the-bridge devices'
  chip-selects, and driver should understand that there is a "special"
  (bridge) device somewhere on the bus (not implemented).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
