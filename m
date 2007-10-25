Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 2F3E9DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 21:08:37 +1000 (EST)
Date: Thu, 25 Oct 2007 13:08:35 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] wrapper: Revert ps3 binary flag usage, and remove .bin
	suffix.
In-Reply-To: <20071024165628.GA13863@loki.buserror.net>
Message-ID: <Pine.LNX.4.62.0710251308290.3812@pademelon.sonytel.be>
References: <20071024165628.GA13863@loki.buserror.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1474231594-1193310515=:3812"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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

---584337861-1474231594-1193310515=:3812
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 24 Oct 2007, Scott Wood wrote:
> The ps3 target produces two images, and the binary one is not the
> "primary" image that corresponds to the -o flag; thus, it no longer
> uses the generic binary flag.
> 
> On platforms which do use the binary flag, it no longer produces a
> .bin suffix, so that the output file matches what was passed to the -o flag.
> 
> This should fix the zImage ln problems for the ps3 target.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/boot/wrapper |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 39b27e5..ece6f49 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -149,7 +149,6 @@ cuboot*)
>  ps3)
>      platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
>      lds=$object/zImage.ps3.lds
> -    binary=y
>      gzip=
>      ext=bin
>      objflags="-O binary --set-section-flags=.bss=contents,alloc,load,data"
> @@ -233,7 +232,7 @@ entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
>  
>  if [ -n "$binary" ]; then
>      mv "$ofile" "$ofile".elf
> -    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
> +    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
>  fi
>  
>  # post-processing needed for some platforms
> @@ -246,9 +245,9 @@ coff)
>      $object/hack-coff "$ofile"
>      ;;
>  cuboot*)
> -    gzip -f -9 "$ofile".bin
> +    gzip -f -9 "$ofile"
>      mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
> -            $uboot_version -d "$ofile".bin.gz "$ofile"
> +            $uboot_version -d "$ofile".gz "$ofile"
>      ;;
>  treeboot*)
>      mv "$ofile" "$ofile.elf"
> @@ -269,11 +268,11 @@ ps3)
>      # then copied to offset 0x100.  At runtime the bootwrapper program
>      # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
>  
> -    system_reset_overlay=0x`${CROSS}nm "$ofile".elf \
> +    system_reset_overlay=0x`${CROSS}nm "$ofile" \
>          | grep ' __system_reset_overlay$'       \
>          | cut -d' ' -f1`
>      system_reset_overlay=`printf "%d" $system_reset_overlay`
> -    system_reset_kernel=0x`${CROSS}nm "$ofile".elf \
> +    system_reset_kernel=0x`${CROSS}nm "$ofile" \
>          | grep ' __system_reset_kernel$'       \
>          | cut -d' ' -f1`
>      system_reset_kernel=`printf "%d" $system_reset_kernel`
> @@ -282,6 +281,8 @@ ps3)
>  
>      rm -f "$object/otheros.bld"
>  
> +    ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
> +
>      msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
>          skip=$overlay_dest seek=$system_reset_kernel      \
>          count=$overlay_size bs=1 2>&1)
> -- 
> 1.5.3.4
> 

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
---584337861-1474231594-1193310515=:3812--
