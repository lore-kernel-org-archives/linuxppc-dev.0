Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6B06FDDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:49:08 +1000 (EST)
Date: Mon, 15 Oct 2007 11:55:05 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Refactor booting-without-of.txt
Message-ID: <20071015165505.GA16040@lixom.net>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 10:08:44AM -0600, Grant Likely wrote:
> Adding the Linux expected device tree bindings to
> booting-without-of.txt seems to be getting a little unwieldy.  Plus
> with more than one arch using the device tree (powerpc, sparc &
> microblaze) the device tree bindings aren't necessarily powerpc only
> (the Xilinx devices certainly fall in this category).
> 
> Anyone have comments about splitting the expected device tree bindings
> out of booting-without-of.txt into a separate directory?

The flat device tree is, in spite of what some people would like it to be,
not open firmware, nor is it the same as their bindings. So I think we'd
be doing ourselves a disservice by continuing to associate them together.
All it would take is a rename of the directory, unfortunately i don't
have any suggestions on better names though.

> Perhaps something like this; each file contains common bindings for
> the type of device and device specific properties:
>
> Documentation/of/
> Documentation/of/README - Description of the purpose and layout of
> this directory
> Documentation/of/net.txt - network device bindings (eth, MDIO, phy, etc)
> Documentation/of/serial.txt - serial device bindings
> Documentation/of/misc.txt - anything that doesn't fit anywhere else yet.
> Documentation/of/soc/* - System on chip stuff that doesn't fit will
> into established device types; possibly a separate file for each chip.
> Documentation/of/usb.txt - usb blah blah blah
> Documentation/of/whatever - you get the picture.
> 
> Thoughts?

Looks reasonable. The other way to cut it would be to slice along vendor
boundaries, but I think I like the functional partitioning you suggested
better.


-Olof
