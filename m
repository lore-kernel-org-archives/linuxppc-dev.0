Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A72BBDDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 19:47:23 +1000 (EST)
Date: Thu, 23 Aug 2007 11:47:20 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
In-Reply-To: <F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0708231146200.29327@pademelon.sonytel.be>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
	<20070823033318.GJ7042@localhost.localdomain>
	<F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-796519161-1187862440=:29327"
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
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

---584337861-796519161-1187862440=:29327
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 22 Aug 2007, Kumar Gala wrote:
> On Aug 22, 2007, at 10:33 PM, David Gibson wrote:
> > On Wed, Aug 22, 2007 at 10:33:55PM -0500, Kumar Gala wrote:
> >> On Aug 22, 2007, at 10:19 AM, Kumar Gala wrote:
> >>> I was wondering if I could get your help with looking at the
> >>> following lists and determining if we have an issue or not related
> >>> the following files:
> >>>
> >>> Getting some classification on these would be good.  Possibly
> >>> classifications, doesn't build in ARCH=powerpc, remove include, real
> >>> issue, etc.
> >>>
> >> My analysis of <asm/bootinfo.h> usage:
> >>
> >> ./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>	 remove
> >> ./drivers/char/vme_scc.c:#include <asm/bootinfo.h>		68k only
> >> ./drivers/char/serial167.c:#include <asm/bootinfo.h>		68k only
> >> ./drivers/serial/dz.c:#include <asm/bootinfo.h>		 decstation
> >> ./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>	decstation
> >> ./drivers/net/macsonic.c:#include <asm/bootinfo.h>		68k
> >> ./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/maxinefb.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/logo/logo.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/macfb.c:#include <asm/bootinfo.h>		68k
> >> ./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>		68k
> >
> > Uh.. I'm pretty sure valkyriefb.c is for (old) PowerMacs, not 68k.
> 
> It appears to be both.  If you look at the include its protected by a  
> #ifdef CONFIG_MAC which we is only defined on m68k.

Indeed, drivers/video/Kconfig says it depends on MAC || (PPC_PMAC && PPC32)

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
---584337861-796519161-1187862440=:29327--
