To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux not outputting to serial console on sbc8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Dec 2001 11:27:24 EST."
             <3C10EDEC.630AE7DD@seranoa.com>
Date: Sat, 08 Dec 2001 00:02:49 +0100
Message-Id: <20011207230254.9A0D6F9C2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C10EDEC.630AE7DD@seranoa.com> you wrote:
>
> I'm trying to get Linux up on an sbc8260.  I'm working with Linux-2.4.16
> and PPCBoot-1.1.0.  I'm booting from the flash simm on the sbc8260 and
> I'm using the 33mhz oscillator.

Check the definition of the bd_info structure in the est8260.h  Linux
kernel header file; it must match the definition defined and exported
by PPCBoot.

You can simply replace the whole file by this:

----- cut here -----
/*
 * Board information for the EST8260.
 */

#define IMAP_ADDR ((uint)0xf0000000)

#include <asm/ppcboot.h>
----- cut here -----

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
C makes it easy for you to shoot yourself in the foot. C++ makes that
harder, but when you do, it blows away your whole leg.
                                                 -- Bjarne Stroustrup

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
