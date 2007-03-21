Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B767DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 00:30:48 +1100 (EST)
In-Reply-To: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Wed, 21 Mar 2007 14:30:30 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> To allow more robust association of each network device node with an
> index (such as is used by the firmware or an EEPROM to indicate MAC
> addresses), a network device's node may specify the index explicitly.

> +   - linux,network-index : This is the intended "index" of this
> +     network device.  This is used by the bootwrapper to interpret
> +     MAC addresses passed by the firmware when no information other
> +     than indices is available to associate an address with a device.

What a nasty thing, and quite a misnomer too.  Linux
_already_ knows how to bind ethN to which device, based
on user preferences; what you are really after is a way
to label the several network devices in your device tree
for use by firmware.

There already is a completely generic such mechanism; it's
called "aliases".

And yes I still believe the flattened dev tree should
implement the "/aliases" node and drop the other alias
mechanism, the OF-defined way is so much more flexible.
It even shows up in /proc/device-tree :-)


Segher
