Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 52A3467B48
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 00:44:18 +1000 (EST)
Message-ID: <00c501c5c504$96c59780$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Fend, Matthias" <mfend@harris.com>,
	<linuxppc-embedded@ozlabs.org>
References: <8D4C69676E66D511A1CB00508BBBB192052D435D@ranmx1.cs.myharris.net>
Date: Thu, 29 Sep 2005 10:44:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,

>>Can you send a couple of links to the modules you are considering?

>there are some 320x240 from EDT (Emerging Display Technologies) with
S1D13305
>S1D13700
>http://www.actron.de/graphic_displays_edt.htm
>
>also from Powertip a 320x240 with S1D13305/ S1D13704 is available
>http://www.actron.de/graphic_displays_powertip.htm
>
>and also from ampire is one ... (available /w or w/o Epson's S1D
controller)
>http://www.ampire.com.tw/AmpireCatalogue/P082-AT320240Q3.pdf
>

Ok, I see the problem with the S1D13305, but the S1D13704 looks ok.
In order to work as a linux framebuffer, the cpu must be able to directly
address
pixels.  You can't have a controller like the 13305 that makes you write a
pixel address and then write the pixel.  A controller like the 13704 just
makes
the pixel memory look like RAM, so it's easy to interface.  The only thing
different is that you must be able to handle wait states, because the pixel
memory is shared between the controller and the cpu.  The 13704 manual
has a section showing how to interface to an MPC821, so that's basically
the same as MPC860.  However, watch your DSACK0 signal closely - this
signal is shared with 8xx internal logic.  It must be synchronized with the
cpu clock, and you may not be able to just let a pullup resistor handle the
rising edge - if that rising edge leaks into the succeeding cycle you can
see
some weird intermittent problems.  So plan on needing to run WAIT from any
controller through some glue logic to clean it up for the 8xx.

Or you may be able to just get by with making your cycle time long enough
that you can ignore WAIT.  It sounds a bit ugly but as a practical matter
it won't affect performance much.

Mark Chambers
