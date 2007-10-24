Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7F629DDF36
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 02:26:34 +1000 (EST)
Date: Wed, 24 Oct 2007 18:26:32 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-2.6.git: cannot build PS3 image
In-Reply-To: <47162BC4.2090907@freescale.com>
Message-ID: <Pine.LNX.4.62.0710241820010.17958@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710171523120.19421@pademelon.sonytel.be>
	<47162BC4.2090907@freescale.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2054510590-1193243192=:17958"
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

---584337861-2054510590-1193243192=:17958
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 17 Oct 2007, Scott Wood wrote:
> Geert Uytterhoeven wrote:
> >> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> >> index 39b27e5..795f988 100755
> >> --- a/arch/powerpc/boot/wrapper
> >> +++ b/arch/powerpc/boot/wrapper
> >> @@ -232,7 +232,7 @@ base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
> >>  entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
> >>  
> >>  if [ -n "$binary" ]; then
> >> -    mv "$ofile" "$ofile".elf
> >> +    cp "$ofile" "$ofile".elf
> >>      ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
> >>  fi
> > 
> > No comments?
> 
> That'd work in this case, though it'd probably be better to make the 
> $ofile be the end result that will boot on the ps3, and leave a suffix 
> on the intermediate files.

The $ofile is the end result to boot using kboot (2nd stage kernel).
otheros.bld is the end result to write to FLASH ROM (1st stage kernel).

The funny thing is that we pass `-o arch/powerpc/boot/zImage.ps3' to the
wrapper script (which indicates the _output_ file, i.e. $ofile, as per the
documentation at the top of the wrapper script), while this output file is
no longer created by the wrapper script!
Instead it creates arch/powerpc/boot/zImage.ps3.elf.

So I do think your change broke the expected and obvious behavior.

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
---584337861-2054510590-1193243192=:17958--
