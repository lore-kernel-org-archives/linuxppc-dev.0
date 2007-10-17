Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 1BFE3DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 18:49:07 +1000 (EST)
Date: Wed, 17 Oct 2007 10:49:04 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Joseph Fannin <jfannin@gmail.com>
Subject: Re: vga16fb doesn't build on powerpc (vgacon_remap_base)
In-Reply-To: <20071016191403.GA5962@nineveh.local>
Message-ID: <Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
References: <20071016191403.GA5962@nineveh.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-2973903-1192610944=:29856"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
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

---584337861-2973903-1192610944=:29856
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 16 Oct 2007, Joseph Fannin wrote:
> vga16fb is an available config option on powerpc, but it won't link
> with my .config:
> 
>     ERROR: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
> 
> 
> I'm guessing this is because include/asm-powerpc/vga.h declares
> vgacon_remap_base: 
> 
>     extern unsigned long vgacon_remap_base;
> 
> 
> ...but arch/powerpc/kernel/setup_32.c wraps the definition in an #ifdef:
> 
>     #ifdef CONFIG_VGA_CONSOLE
>     unsigned long vgacon_remap_base;
>     EXPORT_SYMBOL(vgacon_remap_base);
>     #endif
> 
> 
> So CONFIG_VGA_CONSOLE=n and CONFIG_FB_VGA16=[y|m] won't work.
> 
> I've also noticed that the only places in the tree that ever assign
> anything to config_remap_base are under arch/ppc.  And
> include/asm-powerpc/vga.h also does this:
> 
>     #ifdef __powerpc64__
>     #define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
>     #else
>     #define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
>     #endif
> 
> 
> So VGACON probably doesn't work either on 32bit.  I'm guessing arch/powerpc
> doesn't support PREP.

It's not only useful for PREP, but also for CHRP.

> How best could this be fixed up? Or should I just let the thing
> be?  This is obviously not a new thing, and I don't have any hardware
> that supports this stuff either.

I remember this problem was present when I still had a working LongTrail (which
is CHRP), long before arch/powerpc/ was created.

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
---584337861-2973903-1192610944=:29856--
