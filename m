Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 1827168389
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 22:49:45 +1000 (EST)
Message-ID: <003301c5c5bd$c0d89f40$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Fend, Matthias" <mfend@harris.com>,
	<linuxppc-embedded@ozlabs.org>
References: <8D4C69676E66D511A1CB00508BBBB192052D4395@ranmx1.cs.myharris.net>
Date: Fri, 30 Sep 2005 08:50:12 -0400
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

>
> Do you think it's possible to write the device driver in such a way that
> he also translates the pixel data into the indirect register mode of the
> S1D13700 ?
>

No, not directly.  The thing about frame buffer devices is that applications
write directly into the pixel memory (via mmap) so that's why hardware
compatibility is important.  But as Chuck Meade pointed  out, you can make
most anything work by writing a driver that copies from a virtual
framebuffer
to your hardware.

But if this is a new design, forget these indirect chips.  Step one, you
have
to find a controller that can drive your LCD.  Step two, make sure the
controller allows random access to pixels on the host side.  Step three,
if it comes with a driver, great, but if not, framebuffer drivers (for an
LCD)
are pretty simple and you should be able to modify one of the stock
kernel drivers to work for you.  Basically you just have to initialize your
chip and then implement a couple of IOCTLs to query and optionally set
the format of your pixels (and the mmap(), of course).

 --Mark
