Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A774167D8B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 01:11:57 +1000 (EST)
In-Reply-To: <20050723142210.GA24313@gate.ebshome.net>
References: <528646bc05072307074e8fce3e@mail.gmail.com>
	<20050723142210.GA24313@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f9aee3d7921497b1309fb9c67caa914c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Jul 2005 11:11:57 -0400
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/3] SPI bus core infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 23, 2005, at 10:22 AM, Eugene Surovegin wrote:

> This isn't enough.
>
> You must have a way to specify clock frequency, data order (which bit
> goes first, char length.

...  and there is more.  Some devices, even when not selected, still
use the SPI clock for clocking internal logic.  You have to ensure with
such devices you don't ever run the SPI faster than their spec.  This
is application specific, but something that has to be considered when
there are multiple devices on the SPI bus.

Also, many boards use external logic for the assertion of the
device select, which is necessary if there is more than one device
on the bus.  Sometimes it's a multiplexer that routes the controller
SPI select, other times the multiplexer drives the selects directly.
In my review of the patch, I didn't see anything that would provide
for this.

I think the SPI driver is a great idea, I hope we can find a way
to make it work at least as well as the I2C.

Thanks!


	-- Dan
