Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 80237DDF60
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:02:19 +1000 (EST)
Date: Tue, 19 Jun 2007 14:02:17 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 6/6] ps3: FLASH ROM Storage Driver
In-Reply-To: <89ca7c200ed0f7c47387af99643df6a1@bga.com>
Message-ID: <Pine.LNX.4.62.0706191354380.4069@pademelon.sonytel.be>
References: <89ca7c200ed0f7c47387af99643df6a1@bga.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2028617346-1182254537=:4069"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-2028617346-1182254537=:4069
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Milton,

Thanks for your comments!

On Mon, 18 Jun 2007, Milton Miller wrote:
> You indicated that the primary reasons to use this driver were to boot back
> into GameOS, or reinstall the boot loader, yet your Kconfig entry says "In
> general, all users will say Y or M".  This could give a bit more guidance.

Normal users boot back into GameOS from time to time (I don't consider myself a
normal user ;-)

> ps3flash_read_write_sectors chooses a string every call that is only used on
> the error path.

Fixed.

> ps3flash_read gives priority to returning an encountered error.  If it made
> partial progress (eg partially mapped user buffer) it should return the count
> of bytes sent to the user.

Apparently all character drivers in drivers/char/mem.c immediately return
-EFAULT if copy_to_user() fails. The behavior of ps3flash is consistent with
this.

> ps3_write will call the hypervisor to write an aligned chunk of memory every
> call.  I'm guessing the hypervisor does no buffering of the flash.  If the
> file is written with a small block size, this will
> cause unnecessary flash wear.  Have you considered requiring the application
> to write the full 256MiB, or alternatively delaying the actual write call
> until either close, the write reaches the boundary, or a read or write
> accesses another chunk?   Yes, the later would mean short writes would receive
> the error on close.

I do not know how the hypervisor handles this internally.
But as the only time you write to the FLASH ROM is to change some boot flags or
upgrade the boot loader, I don't think this is a big problem.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-2028617346-1182254537=:4069--
