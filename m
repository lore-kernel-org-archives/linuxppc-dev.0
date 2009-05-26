Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43832DE059
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 06:25:36 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4QKPV37021769
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 13:25:31 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4QKPVTF012557
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 15:25:31 -0500 (CDT)
Date: Tue, 26 May 2009 15:25:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Carl-Erwin GRIFFITH <carl.erwin@gmail.com>
Subject: Re: 82xx multiple soc support/initialization
Message-ID: <20090526202530.GA2342@b07421-ec1.am.freescale.net>
References: <5c90346a0905250723t2c9d30a0qd4fbebed38917cd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c90346a0905250723t2c9d30a0qd4fbebed38917cd7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 04:23:37PM +0200, Carl-Erwin GRIFFITH wrote:
> Hi guys,
> 
> 
>  I'm working on an derived muas3001 board (kernel version 2.6.30-rc5),
> 
> and so far I did not find an example of multiple SOCs initialization.
> 
> The board has 3 cpus (only one core activated).

This is not currently supported -- there are lots of places, especially
in 82xx/CPM code, that assume there's only one instance of the SoC.

> 1) Is there a special syntax to use in the device tree ?

You'd have multiple instances of the soc node (plus kernel changes to
make this work).  You'll probably need some way of indicating which one
contains the running core.

-Scott
