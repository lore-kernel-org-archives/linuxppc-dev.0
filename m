Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id F3553DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 00:20:05 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <46730D8A.9090309@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <951969d2021fe6e78917ef8bdb47cf6f@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
Date: Mon, 18 Jun 2007 09:20:10 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jun 16 08:07:06 EST 2007, Geoff Levand wrote:
> zImage.ps3 is a wrapped image that contains a flat device tree, an lv1
> compatible entry point, a wrapper program with a standard entry point,
> and an optional initrd.  otheros.bld is the gzip compresed rom image 
> built
> from zImage.ps3.  otheros.bld is suitable for programming into the PS3 
> boot
> flash memory.
>
> Also remove the now unneeded lmb calls in the platform code.
>
> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
> ---
>  arch/powerpc/boot/Makefile         |   21 ++--
>  arch/powerpc/boot/ps3-head.S       |   84 ++++++++++++++++
>  arch/powerpc/boot/ps3-hvcall.S     |  184 
> +++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/ps3.c            |  158 
> +++++++++++++++++++++++++++++++
>  arch/powerpc/boot/wrapper          |   55 +++++++++++
>  arch/powerpc/boot/zImage.ps3.lds.S |   50 ++++++++++
>  arch/powerpc/platforms/ps3/mm.c    |    2
>  7 files changed, 543 insertions(+), 11 deletions(-)
>
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -41,11 +41,13 @@ zliblinuxheader := zlib.h zconf.h zutil.
>  $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
>         $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix 
> $(obj)/,$(zlibheader))
>
> +src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
> +
>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c 
> flatdevtree_misc.c \
>                 ns16550.c serial.c simple_alloc.c div64.S util.S \
>                 gunzip_util.c elf_util.c $(zlib) devtree.c \
>                 44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c
> -src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
> +src-plat := $(src-plat-y) of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>                 cuboot-ebony.c treeboot-ebony.c prpmc2800.c
>  src-boot := $(src-wlib) $(src-plat) empty.c

The policy so far has been code for all platforms is compiled for all 
invocations of make in the boot directory.  Therefore just add your 
files directly to src-plat.  If needed, add a flags override to set the 
cpu type.

>
> @@ -75,11 +77,11 @@ $(addprefix $(obj)/,$(zliblinuxheader)):
>  $(obj)/empty.c:
>         @touch $@
>
> -$(obj)/zImage.lds $(obj)/zImage.coff.lds: $(obj)/%: 
> $(srctree)/$(src)/%.S
> +$(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds: 
> $(obj)/%: $(srctree)/$(src)/%.S
>         @cp $< $@
>
>  clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
> -               empty.c zImage.coff.lds zImage.lds
> +               empty.c zImage zImage.coff.lds zImage.ps3.lds 
> zImage.lds
>
>  quiet_cmd_bootcc = BOOTCC  $@
>        cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c 
> -o $@ $<
> @@ -102,7 +104,7 @@ hostprogs-y := addnote addRamDisk hack-c
>
>  targets                += $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
>  extra-y                := $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o 
> \
> -                  $(obj)/zImage.lds $(obj)/zImage.coff.lds
> +                  $(obj)/zImage.lds $(obj)/zImage.coff.lds 
> $(obj)/zImage.ps3.lds
>
>  wrapper                :=$(srctree)/$(src)/wrapper
>  wrapperbits    := $(extra-y) $(addprefix $(obj)/,addnote hack-coff 
> mktree) \
> @@ -187,11 +189,12 @@ $(obj)/zImage.%: vmlinux $(wrapperbits)
>  $(obj)/zImage.iseries: vmlinux
>         $(STRIP) -s -R .comment $< -o $@
>
> -$(obj)/zImage.ps3: vmlinux
> -       $(STRIP) -s -R .comment $< -o $@
> +$(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) 
> $(srctree)/$(src)/dts/ps3.dts
> +       $(STRIP) -s -R .comment $< -o vmlinux.strip
> +       $(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
>
> -$(obj)/zImage.initrd.ps3: vmlinux
> -       @echo "  WARNING zImage.initrd.ps3 not supported (yet)"
> +$(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits) 
> $(srctree)/$(src)/dts/ps3.dts $(obj)/ramdisk.image.gz
> +       $(call 
> cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)

The separate rule here is to pick up ps3.dts, correct?

After Marc's 3 patch series this would be handled by the config file.

>
>  $(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
>         $(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
> @@ -230,7 +233,7 @@ install: $(CONFIGURE) $(addprefix $(obj)
>
>  # anything not in $(targets)
>  clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* \
> -       treeImage.* zImage.dts zImage.dts_initrd
> +       treeImage.* zImage.dts zImage.dts_initrd otheros.bld
>
>  # clean up files cached by wrapper
>  clean-kernel := vmlinux.strip vmlinux.bin
> --- /dev/null
> +++ b/arch/powerpc/boot/ps3-head.S
> @@ -0,0 +1,84 @@
> +/*
> + *  PS3 bootwrapper entry.
> + *
> + *  Copyright (C) 2007 Sony Computer Entertainment Inc.
> + *  Copyright 2007 Sony Corp.
> + *
> + *  This program is free software; you can redistribute it and/or 
> modify
> + *  it under the terms of the GNU General Public License as published 
> by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
> 02111-1307  USA
> + */
> +
> +#include "ppc_asm.h"
> +
> +       .text
> +
> +/*
> + * __system_reset_overlay - The PS3 first stage entry.
> + *
> + * The bootwraper build script copies the 0x100 bytes at symbol
> + * __system_reset_overlay to offset 0x100 of the rom image.
> + */
> +
> +       .globl __system_reset_overlay
> +__system_reset_overlay:
> +
> +       /* Switch to 32-bit mode. */
> +
> +       mfmsr   r9
> +       clrldi  r9,r9,1
> +       mtmsrd  r9
> +       nop
> +
> +       /* Get thread number in r3 and branch. */
> +
> +       mfspr   r3, 0x88
> +       cntlzw. r3, r3
> +       li      r4, 0
> +       li      r5, 0
> +       beq     1f
> +
> +       /* Secondary goes to __secondary_hold in kernel. */
> +
> +       li      r4, 0x60
> +       mtctr   r4
> +       bctr
> +
> +       /* Primary waits for __secondary_hold_acknowledge. */
> +1:
> +       li      r5, 0x10 /* __secondary_hold_acknowledge */
> +       or      28, 28, 28 /* db8cyc */
> +
> +       ld      r4, 0(r5)
> +       cmpdi   r4, 0
> +       beq     1b

(1) The address of __secondary_hold_acknowledge is not stable.  It has 
changed in the past and may change in the future.  (2) This works 
because you always have exactly 2 cpus, and your secondary cpu is not 
id 0.

Because this is part of the kernel source tree, I'm not opposed to this 
usage, but I think some checking would be in order.   A comment that 
this only works for two cpus with the slave id not being 0, and some 
check that nm on the kernel image results in the expected symbol and 
value.

Since I'm here, I'll mention that the li to r5 doesn't need to be in 
the loop.  In fact, the load to r4 could be expressed as 0x10(0) or 
better create a symbol and use secondary_ack@l(0) eliminating the need 
for r5 and easing the above check.

> +
> +       /* Primary goes to _zimage_start in wrapper. */
> +
> +       lis     r4, _zimage_start at ha
> +       addi    r4, r4, _zimage_start at l
> +       mtctr   r4
> +       bctr
> +
> +/*
> + * __system_reset_kernel - Place holder for the kernel reset vector.
> + *
> + * The bootwrapper build script copies 0x100 bytes from offset 0x100
> + * of the rom image to the symbol __system_reset_kernel.  At runtime
> + * the bootwrapper program copies the 0x100 bytes at 
> __system_reset_kernel
> + * to ram address 0x100.  This symbol must occupy 0x100 bytes.
> + */
> +
> +       .globl __system_reset_kernel
> +__system_reset_kernel:
> +
> +       . = __system_reset_kernel + 0x100

Not bad.   Since this code doesn't have to be at any particular 
location when it is built (you have no .org or similar, its all PIC), I 
don't see anything that couldn't be done from an asm block in the 
platform .c file, like the entry point in prpmc2800.c file; that would 
save a file in the boot directory.  In that case __system_reset_kernel 
would be an array of 256 bytes.

[removed ps3-hvcall.S and lmb hack removal from followup]
> --- /dev/null
> +++ b/arch/powerpc/boot/ps3.c
> @@ -0,0 +1,158 @@
> +/*
> + *  PS3 bootwrapper support.
> + *
> + *  Copyright (C) 2007 Sony Computer Entertainment Inc.
> + *  Copyright 2007 Sony Corp.
> + *
> + *  This program is free software; you can redistribute it and/or 
> modify
> + *  it under the terms of the GNU General Public License as published 
> by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
> 02111-1307  USA
> + */
> +
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include "types.h"
> +#include "elf.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "page.h"
> +#include "ops.h"
> +
> +extern s64 lv1_panic(u64 in_1);
> +extern s64 lv1_get_logical_partition_id(u64 *out_1);
> +extern s64 lv1_get_logical_ppe_id(u64 *out_1);
> +extern s64 lv1_get_repository_node_value(u64 in_1, u64 in_2, u64 in_3,
> +       u64 in_4, u64 in_5, u64 *out_1, u64 *out_2);
> +
> +#ifdef DEBUG
> +#define DBG(fmt...) printf(fmt)
> +#else
> +static inline int __attribute__ ((format (printf, 1, 2))) DBG(
> +       const char *fmt, ...) {return 0;}
> +#endif

This should be in stdio.h for all.  Maybe ops, but that is a bit of a 
catch-all and printf is not there.

> +
> +BSS_STACK(4096);
> +
> +/* A buffer that may be edited by tools operating on a zImage binary 
> so as to
> + * edit the command line passed to vmlinux (by setting 
> /chosen/bootargs).
> + * The buffer is put in it's own section so that tools may locate it 
> easier.
> + */
> +static char cmdline[COMMAND_LINE_SIZE]
> +       __attribute__((__section__("__builtin_cmdline")));
> +
> +static void prep_cmdline(void *chosen)
> +{
> +       if (cmdline[0] == '\0')
> +               getprop(chosen, "bootargs", cmdline, 
> COMMAND_LINE_SIZE-1);
> +       else
> +               setprop_str(chosen, "bootargs", cmdline);
> +
> +       printf("cmdline: '%s'\n", cmdline);
> +}
> +
> +static void ps3_console_write(const char *buf, int len)
> +{
> +}

I'm guessing your testing was done with some non-empty function that 
you are not prepared to release.  Otherwise you would not have added 
all the printf code.   I'm not complaining, just noting for my 
observations below.

> +
> +static void ps3_exit(void)
> +{
> +       printf("ps3_exit\n");
> +       lv1_panic(0); /* zero = no reboot */
> +       while (1);
> +}

Does the hypervisor give some kind of indication that the code paniced? 
  A comment telling us users what to expect might be nice.

> +
> +static int ps3_repository_read_rm_size(u64 *rm_size)
> +{
> +       s64 result;
> +       u64 lpar_id;
> +       u64 ppe_id;
> +       u64 v2;
> +
> +       result = lv1_get_logical_partition_id(&lpar_id);
> +
> +       if (result)
> +               return -1;
> +
> +       result = lv1_get_logical_ppe_id(&ppe_id);
> +
> +       if (result)
> +               return -1;
> +
> +       /*
> +        * n1: 0000000062690000 : ....bi..
> +        * n2: 7075000000000000 : pu......
> +        * n3: 0000000000000001 : ........
> +        * n4: 726d5f73697a6500 : rm_size.
> +       */
> +
> +       result = lv1_get_repository_node_value(lpar_id, 
> 0x0000000062690000ULL,
> +               0x7075000000000000ULL, ppe_id, 0x726d5f73697a6500ULL, 
> rm_size,
> +               &v2);
> +
> +       printf("%s:%d: ppe_id  %lu \n", __func__, __LINE__,
> +               (unsigned long)ppe_id);
> +       printf("%s:%d: lpar_id %lu \n", __func__, __LINE__,
> +               (unsigned long)lpar_id);
> +       printf("%s:%d: rm_size %llxh \n", __func__, __LINE__, 
> *rm_size);
> +
> +       return result ? -1 : 0;
> +}
> +
> +void ps3_copy_vectors(void)
> +{
> +       extern char __system_reset_kernel[];
> +
> +       memcpy((void *)0x100, __system_reset_kernel, 0x100);
> +       flush_cache((void *)0x100, 0x100);
> +}
> +
> +void platform_init(void)
> +{
> +       extern char _end[];
> +       extern char _dtb_start[];
> +       extern char _initrd_start[];
> +       extern char _initrd_end[];
> +       const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */

Ok your heap is from (wrapper) _end to 16MiB.

> +       void *chosen;
> +       unsigned long ft_addr;
> +       u64 rm_size;
> +
> +       console_ops.write = ps3_console_write;
> +       platform_ops.exit = ps3_exit;
> +
> +       printf("\n-- PS3 bootwrapper --\n");
> +
> +       simple_alloc_init(_end, heapsize, 32, 64);
> +       ft_init(_dtb_start, 0, 4);

Ok this is the end of platform_init for most platforms.

> +
> +       chosen = finddevice("/chosen");
> +
> +       ps3_repository_read_rm_size(&rm_size);
> +       dt_fixup_memory(0, rm_size);

this is dt_fixups.

> +
> +       if (_initrd_end > _initrd_start) {
> +               setprop_val(chosen, "linux,initrd-start", 
> (u32)(_initrd_start));
> +               setprop_val(chosen, "linux,initrd-end", 
> (u32)(_initrd_end));
> +       }

This is part of prep_initrd.

> +
> +       prep_cmdline(chosen);
> +
> +       ft_addr = dt_ops.finalize();
> +
> +       ps3_copy_vectors();
> +
> +       printf(" flat tree at 0x%lx\n\r", ft_addr);
> +
> +       ((kernel_entry_t)0)(ft_addr, 0, NULL);
> +
> +       ps3_exit();
> +}

Based on past comments, I belive that you are not calling the normal 
_start() specifically to avoid dragging in zlib.  Oh, but you call 
prep_cmdline, which means you still get main.c and it drags zlib.  I 
guess we should move prep_initrd and prep_cmdline.  Were you just 
skipping prep_kernel?

This code and the concept in your .lds file looks like it could be used 
by other platforms in a generic way
(except for the call to ps3_exit which should be exit, and the call to 
ps3_copy_vectors, which can be moved earlier.  While its likely similar 
functionality would be needed, the details of what to patch and copy 
may vary).

> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -144,6 +144,15 @@ miboot|uboot)
>  cuboot*)
>      gzip=
>      ;;
> +ps3)
> +    platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
> +    lds=$object/zImage.ps3.lds
> +    gzip=
> +    ext=bin
> +    objflags="-O binary"
> +    ksection=.kernel:vmlinux.bin
> +    isection=.kernel:initrd
> +    ;;
>  esac
>
>  vmz="$tmpdir/`basename \"$kernel\"`.$ext"
> @@ -239,4 +248,50 @@ treeboot*)
>      fi
>      exit 0
>      ;;
> +ps3)
> +    # The ps3's loader supports loading gzipped binary images from 
> flash
> +    # rom to addr zero. The loader enters the image at addr 0x100.  A
> +    # bootwrapper overlay is use to arrange for the kernel to be 
> loaded
> +    # to addr zero and to have a suitable bootwrapper entry at 0x100.
> +    # To construct the rom image, 0x100 bytes from offset 0x100 in the
> +    # kernel is copied to the bootwrapper symbol 
> __system_reset_kernel.
> +    # The 0x100 bytes at the bootwrapper symbol 
> __system_reset_overlay is
> +    # then copied to offset 0x100.  At runtime the bootwrapper program
> +    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
> +
> +    system_reset_overlay=0x`${CROSS}nm "$ofile" \
> +        | grep ' __system_reset_overlay$'       \
> +        | cut -d' ' -f1`
> +    system_reset_overlay=`printf "%d" $system_reset_overlay`
> +    system_reset_kernel=0x`${CROSS}nm "$ofile" \
> +        | grep ' __system_reset_kernel$'       \
> +        | cut -d' ' -f1`
> +    system_reset_kernel=`printf "%d" $system_reset_kernel`
> +    overlay_dest="256"
> +    overlay_size="256"
> +
> +    rm -f "$object/otheros.bld"
> +
> +    ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
> +
> +    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
> +        skip=$overlay_dest seek=$system_reset_kernel      \
> +        count=$overlay_size bs=1 2>&1)
> +
> +    if [ $? -ne "0" ]; then
> +       echo $msg
> +       exit 1
> +    fi
> +
> +    msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
> +        skip=$system_reset_overlay seek=$overlay_dest     \
> +        count=$overlay_size bs=1 2>&1)
> +
> +    if [ $? -ne "0" ]; then
> +       echo $msg
> +       exit 2
> +    fi
> +
> +    gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
> +    ;;
>  esac
> --- /dev/null
> +++ b/arch/powerpc/boot/zImage.ps3.lds.S
> @@ -0,0 +1,50 @@
> +OUTPUT_ARCH(powerpc:common)
> +ENTRY(_zimage_start)
> +EXTERN(_zimage_start)
> +SECTIONS
> +{
> +  _vmlinux_start =  .;
> +  .kernel:vmlinux.bin : { *(.kernel:vmlinux.bin) }
> +  _vmlinux_end =  .;
> +
> +  . = ALIGN(8);
> +  _dtb_start = .;
> +  .kernel:dtb : { *(.kernel:dtb) }
> +  _dtb_end = .;
> +
> +  . = ALIGN(4096);
> +  _initrd_start =  .;
> +  .kernel:initrd : { *(.kernel:initrd) }
> +  _initrd_end =  .;
> +
> +  _start = .;
> +  .text      :
> +  {
> +    *(.text)
> +    *(.fixup)
> +  }
> +  _etext = .;
> +  . = ALIGN(4096);
> +  .data    :
> +  {
> +    *(.rodata*)
> +    *(.data*)
> +    *(.sdata*)
> +    __got2_start = .;
> +    *(.got2)
> +    __got2_end = .;
> +  }
> +
> +  . = ALIGN(4096);
> +  _edata  =  .;
> +
> +  . = ALIGN(4096);
> +  __bss_start = .;
> +  .bss       :
> +  {
> +   *(.sbss)
> +   *(.bss)
> +  }
> +  . = ALIGN(4096);
> +  _end = . ;
> +}

You don't seem to relocate the initrd.  Your lds file has the initrd on 
the 4k page boundary after the dtb, which is after the kernel as copied 
by objcopy -O binary.  As far as I know, objcopy only copies the load 
sections; it doesn't create space in the output binary image for alloc 
only sections.  What prevents the initrd from being in the kernel bss, 
which it clears before even looking at the device tree?  For that 
matter, what prevents the device tree from being allocated in this bss 
range?

I'm guessing that you tested with some additional code to display the 
console output, which made _end be above the kernel _end, or close 
enough that the finalized bss was above the kernel _end?  Did you test 
an initrd?  I guess an attached initrd would also solve the problem of 
the final dtb being overwritten, but not the start of the initrd.


I think your approach to the image layout has promise but still needs 
some refinement.  To solve the problem of where is the kernel end, I 
would create a section to hold the kernel elf header and use the 
elf_parse routines that are now conveniently in a separate file.  The 
wrapper script would dd off the header and then it would be linked into 
the wrapper like the other sections.  At that point the initrd could be 
moved before creating the malloc pool above it.

This approach can be used whenever there is something capable of 
installing an image at address 0 in ram before starting its execution, 
and is useful when the time to install that image is less than the time 
to decompress the kernel (and copy either it or the zImage, for the 
case where the entry point is fixed in low memory).  I can think of 
other platforms where this holds true.  In your case, this is true 
because the hypervisor decompresses the image.

What should this type of image be called?  Its not really a zImage, 
since there is nothing compressed (well, maybe the initrd/initramfs).  
uImage is already taken (u would have stood for uncompressed).  
Something like wrapped image?  flat image?  combined image?  We'd still 
do make zImage to invoke make for it.

One more point.  You indicated that this image had a standard entry 
point.  Were you thinking it will be used for kexec?  Or were you just 
trying to state you used the library _zimage_start?  While the current 
kexec-tools for 64-bit assumes the entry point to be image offset 0, 
the same address is used for both the boot cpu entry point and the 
address of the slave code to copy to address 0.  If you want the master 
to execute the wrapper code, you will need to patch the branch at 
address 0 in the kernel image to go to _zimage_start in the wrapper, 
and then from the wrapper patch it back before starting the kernel.  Or 
perhaps you don't plan to run the wrapper on the kexec path?  In that 
case the system reset handler would retained the patched handler and 
the initrd ignored would be ignored.  While you usage may not care, 
other platforms use the system reset vector.  In either case, 
_zimage_start doesn't have the necessary slave code, and therefore 
shouldn't be the entry point for the final image when we fix that bug 
in kexec-tools.


milton
