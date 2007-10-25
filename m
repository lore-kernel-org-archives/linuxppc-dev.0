Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 0867EDDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 19:27:28 +1000 (EST)
Date: Thu, 25 Oct 2007 11:27:26 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-2.6.git: cannot build PS3 image
In-Reply-To: <Pine.LNX.4.62.0710241820010.17958@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0710251113000.335@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710171523120.19421@pademelon.sonytel.be>
	<47162BC4.2090907@freescale.com>
	<Pine.LNX.4.62.0710241820010.17958@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1752422522-1193303593=:335"
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

---584337861-1752422522-1193303593=:335
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0710251113161.335@pademelon.sonytel.be>

On Wed, 24 Oct 2007, Geert Uytterhoeven wrote:
> On Wed, 17 Oct 2007, Scott Wood wrote:
> > Geert Uytterhoeven wrote:
> > >> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> > >> index 39b27e5..795f988 100755
> > >> --- a/arch/powerpc/boot/wrapper
> > >> +++ b/arch/powerpc/boot/wrapper
> > >> @@ -232,7 +232,7 @@ base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
> > >>  entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
> > >>  
> > >>  if [ -n "$binary" ]; then
> > >> -    mv "$ofile" "$ofile".elf
> > >> +    cp "$ofile" "$ofile".elf
> > >>      ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
> > >>  fi
> > > 
> > > No comments?
> > 
> > That'd work in this case, though it'd probably be better to make the 
> > $ofile be the end result that will boot on the ps3, and leave a suffix 
> > on the intermediate files.
> 
> The $ofile is the end result to boot using kboot (2nd stage kernel).
> otheros.bld is the end result to write to FLASH ROM (1st stage kernel).

Bummer, ignore the first sentence. For a 2nd stage kernel, we do not boot
$ofile (= arch/powerpc/boot/zImage.ps3), but the plain vmlinux or
vmlinux.strip.

Hence zImage.ps3 is an intermediate file only and we don't need zImage at all.

Nevertheless, your other patch fixed the problem, thanks! ;-)

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
---584337861-1752422522-1193303593=:335--
