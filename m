Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id BA3E6DEE94
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:17:50 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so2380075wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:17:49 -0700 (PDT)
Message-ID: <fa686aa40805211017x493e69ecqbcf823333979a6e1@mail.gmail.com>
Date: Wed, 21 May 2008 11:17:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/4] [SPI] spi_mpc83xx: convert to the OF platform driver
In-Reply-To: <20080521170506.GA22021@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154137.GA4566@polina.dev.rtsoft.ru>
	<fa686aa40805210950i2df67158p139770f675ef2032@mail.gmail.com>
	<20080521170506.GA22021@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 11:05 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, May 21, 2008 at 10:50:02AM -0600, Grant Likely wrote:
> [..]
>> > +
>> > +       master->num_chipselect = of_num_children(np);
>>
>> This assumes that there are no gaps in the assigned CS numbers of
>> child nodes, or that the child nodes are an exhaustive list of
>> attached devices, neither of which may be true.  num_chipselect should
>> be calculated from the number of GPIOs specified instead.
>
> [I'm not arguing just a thought.]

:-)

Here's some quick feedback off the top of my head...

> - every SPI device must have its own chip-select, otherwise SPI device
>  node should not be a part of a SPI controller node;

How about this example:  Board has SPI controller with 4 CS lines and
4 devices.  Board vendor has 3 versions of board with different
devices populated (Ver1 has all 4; Ver2 has 1 and 3; Ver3 has 1, 3 and
4).  Board firmware drops nodes from tree for non-present devices
before booting kernel (not arguing if this is the best way for
firmware to behave; but it is valid and legal).  Therefore there may
be gaps in the CS assignments.

Or how about this one: the SPI devices are off board and are plugged
in after boot.  They aren't available to be described in the device
tree, but are added at a later time in response to some hot plug
event.  The SPI bus needs to be already set up with the correct number
of CS lines.

I don't think you can assume that the device tree data will be exhaustive.

> - or there is just once device on the SPI bus with chip-select always
>  asserted, no gpios = <> is specified (this case is implemented);
> - or the SPI is bridged, gpios = <> should list behind-the-bridge devices'
>  chip-selects, and driver should understand that there is a "special"
>  (bridge) device somewhere on the bus (not implemented).

In this case, I think the gpios would be a property of the spi-bridge,
not the spi-master.  The gpios of the spi-master would have to specify
how to address the bridge; not the downstream devices.  The bridge;
when addressed correctly; would then proceed with addressing the
downstream.  In other words; the 'reg' of spi-devices attached to a
bridge would be an address that the bridge understands, not an address
that the master understands.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
