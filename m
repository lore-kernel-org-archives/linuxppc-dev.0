Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 2E264DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 15:30:11 +1000 (EST)
In-Reply-To: <20070907005803.GJ26079@localhost.localdomain>
References: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>,
	<20070907005803.GJ26079@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d16e868937a1f77cbf080754f5742ad9@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Date: Sun, 9 Sep 2007 18:29:11 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Sep 7 10:58:03 EST 2007, David Gibson wrote:
>> On Wed, Sep 05, 2007 at 02:21:16PM -0500, Scott Wood wrote:
>> This target produces a flat binary rather than an ELF file,
>> fixes the entry point at the beginning of the image, and takes
>> a complete device tree with no fixups needed.
>>
>> The device tree must have labels on /#address-cells, the timebase
>> frequency, and the memory size.
>
> Hrm... the actual contents of this patch are less about producing an
> unheadered binary image than they are about introducing the "raw"
> platform.  I don't mind the idea of a "raw" platform (although I'm not
> sure I like that name for it), but the patch comment needs work.

Plus, its not quite as generic as you think.

>> Signed-off-by: Scott Wood <scottwood at freescale.com>
>> ---
>>  arch/powerpc/Kconfig             |   12 +++++++++++
>>  arch/powerpc/boot/Makefile       |    4 ++-
>>  arch/powerpc/boot/fixed-head.S   |    4 +++
>>  arch/powerpc/boot/io.h           |    7 ++++++
>>  arch/powerpc/boot/raw-platform.c |   41 
>> ++++++++++++++++++++++++++++++++++++++
>>  arch/powerpc/boot/wrapper        |   21 ++++++++++++++----
>>  6 files changed, 83 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/powerpc/boot/fixed-head.S
>>  create mode 100644 arch/powerpc/boot/raw-platform.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 00099ef..251d0c3 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -358,6 +358,18 @@ config WANT_DEVICE_TREE
>>         bool
>>         default n
>>
>> +config BUILD_RAW_IMAGE
>> +       bool "Build firmware-independent image"
>> +       select WANT_DEVICE_TREE
>> +       help
>> +         If this is enabled, a firmware independent "raw" image will 
>> be
>> +         built, as zImage.raw.  This requires a completely filled-in
>> +         device tree, with the following labels:
>> +
>> +         mem_size_cells: on /#address-cells
>> +         memsize: on the size portion of /memory/reg
>> +         timebase: on the boot CPU's timebase property
>>

You need these labels on (in) the data not on the property struct ... 
(one can label either today, but only properties in the not to distant 
past).

>> +
>>  config DEVICE_TREE
>>         string "Static device tree source file"
>>         depends on WANT_DEVICE_TREE
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index 02f0fe0..2a6a4c6 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -48,7 +48,8 @@ src-wlib := string.S crt0.S stdio.c main.c 
>> flatdevtree.c flatdevtree_misc.c \
>>                 cpm-serial.c stdlib.c planetcore.c
>>  src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>>                 cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
>> -               ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c 
>> cuboot-8xx.c cuboot-pq2.c
>> +               ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
>> +               cuboot-8xx.c cuboot-pq2.c fixed-head.S raw-platform.c
>>  src-boot := $(src-wlib) $(src-plat) empty.c
>>
>>  src-boot := $(addprefix $(obj)/, $(src-boot))
>> @@ -146,6 +147,7 @@ image-$(CONFIG_PPC_83xx)            += 
>> cuImage.83xx
>>  image-$(CONFIG_PPC_85xx)               += cuImage.85xx
>>  image-$(CONFIG_EBONY)                  += treeImage.ebony 
>> cuImage.ebony
>>  image-$(CONFIG_BAMBOO)                 += treeImage.bamboo
>> +image-$(CONFIG_BUILD_RAW_IMAGE)                += zImage.raw
>>  endif
>>
>>  # For 32-bit powermacs, build the COFF and miboot images
>> diff --git a/arch/powerpc/boot/fixed-head.S 
>> b/arch/powerpc/boot/fixed-head.S
>> new file mode 100644
>> index 0000000..8e14cd9
>> --- /dev/null
>> +++ b/arch/powerpc/boot/fixed-head.S
>> @@ -0,0 +1,4 @@
>> +       .text
>> +       .global _zimage_start
>> +_zimage_start:
>> +       b       _zimage_start_lib
>> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
>> index ccaedae..ec57ec9 100644
>> --- a/arch/powerpc/boot/io.h
>> +++ b/arch/powerpc/boot/io.h
>> @@ -99,4 +99,11 @@ static inline void barrier(void)
>>         asm volatile("" : : : "memory");
>>  }
>>
>> +static inline void disable_irq(void)
>> +{
>> +       int dummy;
>> +       asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" 
>> :
>> +                    "=r" (dummy) : : "memory");
>> +}

This will fail (mtmsr illegal instruction) on 64 bit processors that do 
not implement the bridge facility (POWER4, 5, 6, PPC970, ...)

>> +
>>  #endif /* _IO_H */
>> diff --git a/arch/powerpc/boot/raw-platform.c 
>> b/arch/powerpc/boot/raw-platform.c
>> new file mode 100644
>> index 0000000..b9caeee
>> --- /dev/null
>> +++ b/arch/powerpc/boot/raw-platform.c
>> @@ -0,0 +1,41 @@
>> +/*
>> + * The "raw" platform -- for booting from a complete dtb without
>> + * any fixups.
>> + *
>> + * Author: Scott Wood <scottwood at freescale.com>
>> + *
>> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify it
>> + * under the terms of the GNU General Public License version 2 as 
>> published
>> + * by the Free Software Foundation.
>> + */
>> +
>> +#include "ops.h"
>> +#include "types.h"
>> +#include "io.h"
>> +
>> +BSS_STACK(4096);
>> +
>> +/* These are labels in the device tree. */
>> +extern u32 memsize[2], timebase, mem_size_cells;
>> +
>> +void platform_init(unsigned long r3, unsigned long r4, unsigned long 
>> r5,
>> +                   unsigned long r6, unsigned long r7)
>> +{
>> +       u64 memsize64 = memsize[0];
>> +
>> +       if (mem_size_cells == 2) {
>> +               memsize64 <<= 32;
>> +               memsize64 |= memsize[1];
>> +       }
>> +
>> +       if (sizeof(void *) == 4 && memsize64 >= 0x100000000ULL)
>> +               memsize64 = 0xffffffff;
>> +
>> +       disable_irq();

see above, only works on some processors.

>> +       timebase_period_ns = 1000000000 / timebase;
>> +       simple_alloc_init(_end, memsize64 - (unsigned long)_end, 32, 
>> 64);
>> +       ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
>>

only 64 malloc slots?

So the labels are linked against to find the memory size to allocate 
all above the load address to malloc ...

We can eliminate the need for the labels by calling simple_alloc_init 
twice: the first time on a small bss region, read the properties, then 
call it again with the full memory, and then call ft_init again.  That 
is the trick I used in the kexec series.  When dtlib merges, we can 
read the tree without malloc and avoid the extra dance.

>> +       serial_console_init();

I'm not sure I consider serial_console firemware independent: our 
wrapper IO macros simply do normal loads and stores, and rely on 
firmware to setup either tlbs, virtural mappings, or other to make the 
IO cache inhibited ...
yea, i realize it doesn't have to find a console, and it all works 
without it.  But this is why I pulled the call from my kexec patches.

>> +}

Just to clarify: this should go in the Kconfig help:
This platform requires
(1) device tree fully filled out, including memory size and timebase 
frequency
(2) (currently) labels
(3) firmware that jumps to start of image (this is like old kernels)
(4) after its in ram (we must have writable data/bss)
(5) space below load to decompress vmlinux (no vmlinux_alloc to 
fallback to malloc)
(6) all space above load address available to hold malloc region
(7) for console output (or input) from wrapper, on most cpus, some 
magic setup

Except for this supplying the dt instead of looking for one passed in 
r3, it is very similar to my kexec platform.  That platform has a few 
more features, however
(1) support for SMP with 64 bit kernel (6xx would require small patch)
(2) support for finding available space above or below, via memregions
(3) support for avoiding memroy blocks (rtas, etc)

I think that code could be tweaked to be used by both.

>> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
>> index 65f6854..a6501e9 100755
>> --- a/arch/powerpc/boot/wrapper
>> +++ b/arch/powerpc/boot/wrapper
>> @@ -30,6 +30,7 @@ dtb=
>>  dts=
>>  cacheit=
>>  gzip=.gz
>> +binary=
>>
>>  # cross-compilation prefix
>>  CROSS=
>> @@ -107,10 +108,11 @@ while [ "$#" -gt 0 ]; do
>>  done
>>
>>  if [ -n "$dts" ]; then
>> -    if [ -z "$dtb" ]; then
>> -       dtb="$platform.dtb"
>> -    fi
>> -    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
>> +    dtasm="$object/$platform.dtb.S"
>> +    dto="$object/$platform.dtb.o"
>> +    echo '.section .kernel:dtb,"a"' > "$dtasm"
>> +    dtc -O asm  -b 0 -V 16 "$dts" >> "$dtasm" || exit 1
>> +    ${CROSS}gcc "$dtasm" -c -o "$dto"
>>  fi

If we are going to start calling gcc from the wrapper (even if it is on 
a .S) ...
and synthesizing the input file from pieces ...
and not checking if you need -m32 or if its disallowed ...
not sanitizing preprocessor include environment ...

and if one passes dts and dtb you changed behavior ...

If we need the asm label, I'd rather add the call to dtc->asm and 
asm->.o in the makefile and link it into the platform, maybe using a 
raw-* rule like cuboot and treeboot, or just hardcode the output to be 
dtb.o (since we only have one dts).  If we want it to show up in the 
.dtb instead of .text then we can use objcopy to rename the section or 
do your cat of echo and dtc in a gen_ rule).

... but I think minimal alloc/peek at tree/full alloc is the way to go 
for now.

>>
>>  if [ -z "$kernel" ]; then
>> @@ -153,6 +155,10 @@ ps3)
>>      ksection=.kernel:vmlinux.bin
>>      isection=.kernel:initrd
>>      ;;
>> +raw)
>> +    platformo="$object/fixed-head.o $object/raw-platform.o"
>> +    binary=y
>> +    ;;
>>  esac
>>
>>  vmz="$tmpdir/`basename \"$kernel\"`.$ext"
>> @@ -216,7 +222,7 @@ fi
>>
>>  if [ "$platform" != "miboot" ]; then
>>      ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
>> -       $platformo $tmp $object/wrapper.a
>> +       $platformo $tmp $dto $object/wrapper.a
>>      rm $tmp
>>  fi
>>
>> @@ -295,3 +301,8 @@ ps3)
>>      gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
>>      ;;
>>  esac
>> +
>> +if [ -n "$binary" ]; then
>> +    mv "$ofile" "$ofile".elf
>> +    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
>> +fi

I'm not sure how putting a binary flag test here will help other 
platforms.  Even those that want a .elf left behind, if they need ohter 
processing they will done the move already.  I'd say just make this 
part of the platform case just above, although I could accept it being 
moved ahead of that case.

Actually, looking at the current case, treeboot, cuboot, and ps3 all 
(could) start with this rename and objcopy, so lets put it above the 
final platform fixup case, and update those platforms to use this 
feature (adjusting the calls to nm, dd, gzip, etc accordingly).


Bottom line: This looks like a very simple platform, but it has hidden 
assumptions in its environment (mtmsr, laod in the middle of memory, 
others?) and takes the wrapper script in directions i'd rather it not 
go.  I'd like you to look at my kexec platform series, and see if 
reusing some of that code would give us a more robust "raw" image.  
(even if you don't need the detached kernel, initramfs parsing, and 
detached initrd; I was thinking more like memranges and the 
vmlinuz_alloc.  The policy about not using memory to end can be 
relaxed, and find_end_of_ram made to search memory).  It's on my short 
list to rediff and repost those anyways.

milton
