Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E1EA6DDEF1
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:51:26 +1000 (EST)
Date: Thu, 25 Oct 2007 16:51:24 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
In-Reply-To: <200710251620.50218.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0710251649520.3812@pademelon.sonytel.be>
References: <1193229045.4510.35.camel@johannes.berg>
	<1193319517.14136.2.camel@johannes.berg>
	<Pine.LNX.4.62.0710251542500.3812@pademelon.sonytel.be>
	<200710251620.50218.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1907371068-1193323884=:3812"
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
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

---584337861-1907371068-1193323884=:3812
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 25 Oct 2007, Arnd Bergmann wrote:
> On Thursday 25 October 2007, Geert Uytterhoeven wrote:
> > If you want to look into this, the question is just why these messages are
> > printed now, while they weren't printed before. I don't think any other
> > behavior got changed.
> 
> I'm not so sure about that. The reason that the messages are printed now
> is that there is no fallback handler for these ioctl numbers any more,
> but they are instead expected to be handled by the compat_blkdev_ioctl()
> function, which is only called for block devices.
> 
> My first idea was that the ioctl numbers are used on files that are
> not block devices, in this case the warning message would be (somewhat)
> appropriate.
> 
> Whenever we get one of these messages on a real block device, that is
> supposed to mean that an ioctl that was actually valid could not be
> executed, and compat_blkdev_ioctl() returned -ENOIOCTLCMD.

In many cases these ioctls can indeed not be handled.
E.g. when using `hdparm -tT /dev/ps3da', hdparm issues an ioctl to flush the
cache. But this ioctl is not supported, not before and not after 2.6.23.
Before 2.6.23, it didn't print the message, in 2.6.23, it does.

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
---584337861-1907371068-1193323884=:3812--
