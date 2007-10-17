Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id BE406DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:23:44 +1000 (EST)
Date: Wed, 17 Oct 2007 15:23:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Re: linux-2.6.git: cannot build PS3 image
In-Reply-To: <Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0710171523120.19421@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2092211940-1192627423=:19421"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
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

---584337861-2092211940-1192627423=:19421
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 12 Oct 2007, Geert Uytterhoeven wrote:
> On Fri, 12 Oct 2007, Geert Uytterhoeven wrote:
> > On current linux-2.6.git (782e3b3b3804c38d5130c7f21d7ec7bf6709023f), I get:
> > 
> > |   WRAP    arch/powerpc/boot/zImage.ps3
> > | DTC: dts->dtb  on file "/usr/people/geert.nba/ps3/ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
> > | ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory
> > 
> > `make V=1' gives:
> > 
> > |   /bin/sh ps3-linux-2.6/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/zImage.ps3 -p ps3 -C "ppu-"  -s ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts vmlinux
> > | DTC: dts->dtb  on file "ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
> > | ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory
> > 
> > I don't see a change to arch/powerpc/boot/Makefile that could explain this.
> 
> After bisecting between 2.6.23 and current, I found the culprit:
> 
> > commit 11c146cc19df337f4af42dade9e4fca33c5a54ee
> > Author: Scott Wood <scottwood@freescale.com>
> > Date:   Fri Sep 14 14:58:25 2007 -0500
> > 
> >     [POWERPC] 8xx/wrapper: Embedded Planet EP88xC support

> Below is a quick and dirty temporary fix:
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 39b27e5..795f988 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -232,7 +232,7 @@ base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
>  entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
>  
>  if [ -n "$binary" ]; then
> -    mv "$ofile" "$ofile".elf
> +    cp "$ofile" "$ofile".elf
>      ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
>  fi

No comments?

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
---584337861-2092211940-1192627423=:19421--
