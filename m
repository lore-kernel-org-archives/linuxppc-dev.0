Return-Path: <mfend@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 8E6DC6838F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 21:07:34 +1000 (EST)
Message-ID: <8D4C69676E66D511A1CB00508BBBB192052D4395@ranmx1.cs.myharris.net>
From: "Fend, Matthias" <mfend@harris.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 30 Sep 2005 07:07:29 -0400
MIME-Version: 1.0
Content-Type: text/plain
Subject: AW: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


first thank you all for your inputs, but there are some questions left.


> Well, check carefully.  As I recall, those parts have been
> discontinued.  Although there is software, you may not be able to
> build products once it is done.  I'd suggest looking first at
> Fujitsu, and second at Silicon Motion.  Both of these companies
> have claimed to be dedicated to providing the embedded
> parts for a long time.

As I know at least the S1D13700 is brand new (the people from Epson are working
on a 
Linux driver at the moment).

Do you think it's possible to write the device driver in such a way that
he also translates the pixel data into the indirect register mode of the
S1D13700 ?

> > Has anybody else implemented a LCD into a mpc8xx (not 823) board 
> > successfully ?

> Of course.  It has an internal LCD/video controller, and there should be
> drivers in various kernels.

? You mean the 823 has an internal LCD controller - I know that but I want to 
use a 860 or 855 (we already use them in other products). 

Do you think it would be the best way to use an 823 and a driver-only display ?


As there are so many devices with LCD display in use, I thought there could be a
an easy going standard solution for this, but it seems to be a little bit tricky
...
 

 matthias


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
