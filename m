Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A2CFDDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:00:59 +1100 (EST)
In-Reply-To: <1171500782.20192.204.camel@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<1171488643.20192.177.camel@localhost.localdomain>
	<7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
	<1171500782.20192.204.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <692d02b69479653f689a50a1257f43e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 02:00:52 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Note that the "open-pic" node does not have a "#address-cells"
>>> property, so that  the number of cells for the parent unit interrupt
>>> specifiers is 2 (which is the value of its "#interrupt-cells"
>>> property).

> Yes, "missing" is equivalent to 0,

...and the reason for that is that nodes without physical
children should not _have_ a "#address-cells" property.

> but the common practice has always
> been to specify it explicitely. Check existing Apple and IBM
> device-trees for example.

You do realise how many other borderline (or outright
wrong) things are done in those trees, right?

It doesn't really hurt to have a "#a = 0" prop, but it's
better to just not have a #a prop if you shouldn't have one.


Segher
