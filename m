Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238]) by ozlabs.org (Postfix) with SMTP id 51CD06843C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 03:06:08 +1000 (EST)
In-Reply-To: <433E2530.7090503@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Sun, 2 Oct 2005 12:59:11 -0400
To: Kalle Pokki <kalle.pokki@iki.fi>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 1, 2005, at 1:57 AM, Kalle Pokki wrote:

> Yes I'm sure the code in Linux is right. It may be missing some 
> initialisation it depends on, but anyway.

Did you mention in the past you have a custom boot loader?  Is this 
something
other than the PlanetCore boot rom?

> My board is an Embedded Planet EP8248 that came with a pre-installed 
> version of Linux 2.4. That version works ok, though I don't know what 
> modifications were made to the kernel. The source wasn't included...

I doubt they made any modifications to the generic driver.  The only 
thing
they may have done is added some board control register/GPIO to enable
the RS-232 transceiver.  If you don't have their board initialization 
functions,
though, this would be useful.

> Currently I boot with PlanetCore, load my own boot loader (I'm going 
> to use it exclusively when my own custom board based on 8247 comes 
> out) via tftp, and start the most recent kernel.org kenel from it.

What about just trying to boot the new kernel from PlanetCore boot rom?

Of course, if you are doing your own boot rom and have a board to bring 
up,
you should have invested in something like a BDI2000 long ago because 
it will
have paid for itself many times over by the time you are done :-)  It 
would have
also allowed you to debug this problem rather quickly.

You are going to have to investigate your processor state prior to 
calling
Linux (HIDx registers, cache and MMU state, SIU configuration, etc) to 
see
how it differs from what PlanetCore does.  There are lots and lots of 
options
on these processors, and one bit in one configuration register that is
incorrect can cause lots of grief.


	-- Dan
