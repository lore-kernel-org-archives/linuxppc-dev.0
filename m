Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2E54C687E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 01:54:43 +1100 (EST)
To: "Peter Fercher" <peter.fercher@scs.ch>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Nov 2005 10:59:10 +0100."
	<006101c5f402$613ac2c0$dbe5fed4@scsad.scs.ch>
Date: Mon, 28 Nov 2005 15:54:41 +0100
Sender: wd@denx.de
Message-Id: <20051128145441.2DCE7353F54@atlas.denx.de>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: Re: yosemite flash confusion 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Peter,

in message <006101c5f402$613ac2c0$dbe5fed4@scsad.scs.ch> you wrote:
>
> the yosemite (revision 1.1) i got has a 512 MBit Flash chip on it (S29GL512).
> u-boot 1.1.3 that came with it was configured to use only 32 Mbytes ???

Seems they installed an old version of U-Boot.

> when i try to use the u-boot.bin (newest from the denx homepage:
> ftp://ftp.denx.de/pub/u-boot/images/amcc/yosemite/) then i get:
> (reprogrammed using the yosemite.cfg that was mailed to this list some days ago)
> U-Boot 1.1.4 (Oct 24 2005 - 09:23:33)
...
> FLASH: 64 MB
> *** Warning - bad CRC, using default environment

This means you did not set up your environment and used "saveenv"  to
store it. This also means that your MAC address is undefined.

...
> Net:   No ethernet found.
...
> it sees the 64MB flash but somehow can't find the ethernet anymore..
> does anybody know what the problem is there ?

You forgot to set the MAC address...

Please set the "ethaddr" environment variable to define a  valid  MAC
address,  then  use "saveenv" to save it to flash, and then reset the
board...


BTW:  this  is  off  topic  here.  You  should  have  posted  on  the
U-Boot-Users mailing list instead.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never put off until tomorrow what you can put off indefinitely.
