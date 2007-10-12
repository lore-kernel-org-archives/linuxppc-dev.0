Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 75FB0DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:50:33 +1000 (EST)
Date: Fri, 12 Oct 2007 15:50:31 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Re: linux-2.6.git: cannot build PS3 image
In-Reply-To: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-188223201-1192197031=:757"
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

---584337861-188223201-1192197031=:757
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 12 Oct 2007, Geert Uytterhoeven wrote:
> On current linux-2.6.git (782e3b3b3804c38d5130c7f21d7ec7bf6709023f), I get:
> 
> |   WRAP    arch/powerpc/boot/zImage.ps3
> | DTC: dts->dtb  on file "/usr/people/geert.nba/ps3/ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
> | ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory
> 
> `make V=1' gives:
> 
> |   /bin/sh ps3-linux-2.6/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/zImage.ps3 -p ps3 -C "ppu-"  -s ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts vmlinux
> | DTC: dts->dtb  on file "ps3-linux-2.6/arch/powerpc/boot/dts/ps3.dts"
> | ln: accessing `arch/powerpc/boot/zImage.ps3': No such file or directory
> 
> I don't see a change to arch/powerpc/boot/Makefile that could explain this.

After bisecting between 2.6.23 and current, I found the culprit:

> commit 11c146cc19df337f4af42dade9e4fca33c5a54ee
> Author: Scott Wood <scottwood@freescale.com>
> Date:   Fri Sep 14 14:58:25 2007 -0500
> 
>     [POWERPC] 8xx/wrapper: Embedded Planet EP88xC support
>     
>     This board is also resold by Freescale under the names
>     "QUICCStart MPC885 Evaluation System" and "CWH-PPC-885XN-VE".
>     
>     Signed-off-by: Scott Wood <scottwood@freescale.com>
>     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -142,17 +143,23 @@ miboot|uboot)
>      isection=initrd
>      ;;
>  cuboot*)
> +    binary=y
>      gzip=
>      ;;
>  ps3)
>      platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
>      lds=$object/zImage.ps3.lds
> +    binary=y
       ^^^^^^^^
>      gzip=
>      ext=bin
>      objflags="-O binary --set-section-flags=.bss=contents,alloc,load,data"
>      ksection=.kernel:vmlinux.bin
>      isection=.kernel:initrd
>      ;;
> +ep88xc)
> +    platformo="$object/fixed-head.o $object/$platform.o"
> +    binary=y
> +    ;;
>  esac
>  
>  vmz="$tmpdir/`basename \"$kernel\"`.$ext"
> @@ -224,6 +231,11 @@ fi
>  base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
>  entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
>  
> +if [ -n "$binary" ]; then
> +    mv "$ofile" "$ofile".elf
       ^^^^^^^^^^^^^^^^^^^^^^^^
Hence $ofile no longer exists after running `wrapper'...

> +    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
> +fi
> +
>  # post-processing needed for some platforms
>  case "$platform" in
>  pseries|chrp)
> @@ -234,8 +246,6 @@ coff)
>      $object/hack-coff "$ofile"
>      ;;
>  cuboot*)
> -    mv "$ofile" "$ofile".elf
> -    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
>      gzip -f -9 "$ofile".bin
>      mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
>              $uboot_version -d "$ofile".bin.gz "$ofile"
> @@ -259,11 +269,11 @@ ps3)
>      # then copied to offset 0x100.  At runtime the bootwrapper program
>      # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
>  
> -    system_reset_overlay=0x`${CROSS}nm "$ofile" \
> +    system_reset_overlay=0x`${CROSS}nm "$ofile".elf \
>          | grep ' __system_reset_overlay$'       \
>          | cut -d' ' -f1`
>      system_reset_overlay=`printf "%d" $system_reset_overlay`
> -    system_reset_kernel=0x`${CROSS}nm "$ofile" \
> +    system_reset_kernel=0x`${CROSS}nm "$ofile".elf \
>          | grep ' __system_reset_kernel$'       \
>          | cut -d' ' -f1`
>      system_reset_kernel=`printf "%d" $system_reset_kernel`
> @@ -272,8 +282,6 @@ ps3)
>  
>      rm -f "$object/otheros.bld"
>  
> -    ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
> -
>      msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
>          skip=$overlay_dest seek=$system_reset_kernel      \
>          count=$overlay_size bs=1 2>&1)

... and when the following rules in arch/powerpc/boot/Makefile

| $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
| 	@rm -f $@; ln $< $@
| $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
| 	@rm -f $@; ln $< $@

are executed, they fail, because the source file of the `ln' command no longer
exists.

Below is a quick and dirty temporary fix:

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 39b27e5..795f988 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -232,7 +232,7 @@ base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
 entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
 
 if [ -n "$binary" ]; then
-    mv "$ofile" "$ofile".elf
+    cp "$ofile" "$ofile".elf
     ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
 fi
 
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
---584337861-188223201-1192197031=:757--
