Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DB79DDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Jan 2007 08:30:03 +1100 (EST)
To: "David Gamez" <dgalari@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: flash problem in a LITE5200B 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Jan 2007 11:49:01 +0100."
	<3184691b0701150249g55d2472ax583acca96f0efb30@mail.gmail.com>
Date: Mon, 15 Jan 2007 22:30:00 +0100
Sender: wd@denx.de
Message-Id: <20070115213000.F1DC735264F@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3184691b0701150249g55d2472ax583acca96f0efb30@mail.gmail.com> you wrote:
>
> I work with a Freescale LITE5200B, but I have a problem, when I download a
> rootfs image to a flash memory in the board, hi have one error:

You don't provide much information (like which software you use to do
the copying - U-Boot, Linux, ... ?), but let me guess...

> => Copy To Flash ............. Outside available Flash
> 
> The size of the image is of 3285336 bytes, but the flash memory capacity is
> 32 MBytes, and I load the image in the first sector on the flash memory.

Let me guess: you do this in U-Boot, and forget

* that U-Boot commands take are usually interpreted in hex, i. e.  if
  you  enter  a byte count of '3285336' than this is 52974390 decimal
  or 50+ MB which definitely *is* outside the available flash

and/or

* that the U-Boot "cp" command operates on 32 bit words (= 4  bytes),
  so when you want to specify a byte count you have to use the "cp.b"
  variant of this command

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Just think, with VLSI we can have 100 ENIACS on a chip!"
- Alan Perlis
