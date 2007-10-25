Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 1B52FDDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 23:45:31 +1000 (EST)
Date: Thu, 25 Oct 2007 15:45:29 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
In-Reply-To: <1193319517.14136.2.camel@johannes.berg>
Message-ID: <Pine.LNX.4.62.0710251542500.3812@pademelon.sonytel.be>
References: <1193229045.4510.35.camel@johannes.berg>
	<200710241627.18284.arnd@arndb.de>
	<1193319517.14136.2.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-507282801-1193319929=:3812"
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
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

---584337861-507282801-1193319929=:3812
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 25 Oct 2007, Johannes Berg wrote:
> On Wed, 2007-10-24 at 16:27 +0200, Arnd Bergmann wrote:
> > On Wednesday 24 October 2007, Johannes Berg wrote:
> > >   Show Details
> > >   I've been getting these warnings (many more of them but this is a list
> > > of unique ones) on my quad G5 with 32-bit userspace:
> > > 
> > > ioctl32(cdrom_id:1078): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg(00000000) on /dev/.tmp-3-0
> > > ioctl32(ata_id:1095): Unknown cmd fd(3) cmd(0000030d){t:03;sz:0} arg(ff863970) on /dev/.tmp-3-0
> > > ioctl32(smartd:3563): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(ffeb5480) on /dev/sda
> > > ioctl32(hald-probe-stor:3761): Unknown cmd fd(4) cmd(00005320){t:'S';sz:0} arg(00000004) on /dev/hda
> > > ioctl32(gnome-terminal:4187): Unknown cmd fd(19) cmd(0000530b){t:'S';sz:0} arg(0fd8e400) on /dev/pts/0
> > > 
> > > Does anybody know whether this is expected?
> > 
> > It's probably my fault, since I changed the compat ioctl handling for
> > block devices. Geert already reported the same, but I haven't had
> > a chance to reproduce it on my system to look into what went wrong.
> > Probably a trivial bug I introduced in block/compat_ioctl.c
> 
> I have to admit that ioctl numbers scare me :) Any idea what I should be
> looking for?

Fortunately there's nothing to really worry about, as it's purely cosmetic :-)

If you want to look into this, the question is just why these messages are
printed now, while they weren't printed before. I don't think any other
behavior got changed.

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
---584337861-507282801-1193319929=:3812--
