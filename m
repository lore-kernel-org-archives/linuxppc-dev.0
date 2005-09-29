Return-Path: <chuck@theptrgroup.com>
Received: from fall-curlleaf.atl.sa.earthlink.net (unknown [207.69.195.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21E9668351
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 05:27:11 +1000 (EST)
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72])
	by fall-curlleaf.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1EL2FH-000292-Mn
	for linuxppc-embedded@ozlabs.org; Thu, 29 Sep 2005 13:30:59 -0400
From: "Chuck Meade" <chuck@ThePTRGroup.com>
To: "Mark Chambers" <markc@mail.com>, "Fend, Matthias" <mfend@harris.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Thu, 29 Sep 2005 13:31:52 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGMEIAIMAA.chuck@ThePTRGroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <00c501c5c504$96c59780$0301a8c0@chuck2>
Subject: RE: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >>Can you send a couple of links to the modules you are considering?
> 
> >there are some 320x240 from EDT (Emerging Display Technologies) with
> S1D13305
> >S1D13700
> >http://www.actron.de/graphic_displays_edt.htm
> >
> >also from Powertip a 320x240 with S1D13305/ S1D13704 is available
> >http://www.actron.de/graphic_displays_powertip.htm
> >
> >and also from ampire is one ... (available /w or w/o Epson's S1D
> controller)
> >http://www.ampire.com.tw/AmpireCatalogue/P082-AT320240Q3.pdf
> >
> 
> Ok, I see the problem with the S1D13305, but the S1D13704 looks ok.
> In order to work as a linux framebuffer, the cpu must be able to directly
> address
> pixels.  You can't have a controller like the 13305 that makes you write a
> pixel address and then write the pixel.  A controller like the 13704 just
> makes
> the pixel memory look like RAM, so it's easy to interface.

I have done this in the past when the cpu could not directly access the
pixels.  I created a virtual framebuffer in RAM, and had a timer-driven
routine that regularly sent the contents of the virtual framebuffer to 
the LCD device through the "register bottleneck" of the LCD device interface.
It actually worked well.  I expected a big performance hit with all the 
additional bus activity, but it was not bad (no, I don't remember any
numbers).  The platform had a 48 MHz mpc8xx if I remember correctly,
and the LCD device was an old Epson chip that had a registered interface
(no direct access to pixels).

It is not an optimal situation, but if you find yourself stuck with an LCD
device that does not provide a RAM-like interface to the pixels, then it is
at least a known-working solution.

Chuck Meade
The PTR Group
