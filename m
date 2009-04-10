Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67E7DDE21F
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 04:52:18 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3AIqE8M021790
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 11:52:14 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3AIqEAw025667
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 13:52:14 -0500 (CDT)
Date: Fri, 10 Apr 2009 13:52:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: Regarding Level/Edge of Interrupt sense values
Message-ID: <20090410185213.GA31220@ld0162-tx32.am.freescale.net>
References: <f234e2140902230357r16bc5083uebe1d1d28deb3ac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f234e2140902230357r16bc5083uebe1d1d28deb3ac5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2009 at 05:27:53PM +0530, Vijay Nikam wrote:
> Hello,

Sorry for the late reply; I just noticed this sitting in my inbox.

> I created a device node for gpio-controller for evaluation board
> mpc83313erdb. I created the dtb and loaded on target and the interrupt
> is generated successfully.
> 
> But in dts at interrupts = <74 0x2> I set sense as Edge (sense== 2:
> Edge, high-to-low change),  when I load the driver module and checked
> the entry in /proc/interrupts it shows the sense as Level i.e. 8
> (sense == 8: Level, low assertion) as follows;
> 
> 74:          1   IPIC   Level     gpio

Internal interrupts are inherently level-triggered.  The sense/trigger of
the gpio interrupt itself (as configured in the IPIC) has nothing to do
with the sense/trigger of the gpio *pin* (as configured in the GPIO
block).

-Scott
