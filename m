Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.245])
	by ozlabs.org (Postfix) with ESMTP id A89FCDDDF4
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 07:59:35 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so4286739agc.0
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 14:59:34 -0700 (PDT)
Message-ID: <fa686aa40806281459k45b8d60fwea16740a971fe519@mail.gmail.com>
Date: Sat, 28 Jun 2008 15:59:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: FW: [PATCH] powerpc: Xilinx: adding virtex5 powerpc 440 support
In-Reply-To: <20080628215615.GD10692@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080618210943.874627E8072@mail79-sin.bigfish.com>
	<20080628215615.GD10692@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John.

Oops, you had also posted this patch to the list later, so I'm also
forwarding my comments to the list.

Cheers,
g.

On Sat, Jun 28, 2008 at 3:56 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Sorry for the late reply on this one, I had gotten rather busy.
>
> On Wed, Jun 18, 2008 at 03:09:39PM -0600, John Linn wrote:
>> 1.    I'm not sure why we need to disable the interrupts in the
>> bootstrap loader?
>
> You don't.  That's old zImage.raw stuff that you don't need.
>
>> 2.    I see some SecetLab copyright in new files that might be just a
>> cut/paste type error?
>
> If it is mostly based on my code, then it is appropriate to preserve my
> copyright and add Xilinx's copyright above it.  If it is really heavily
> modified, then the Secret lab copyright can be dropped.
>
>> 3.    I don't see the cputable.c up to date with the 440?
>
>> Thanks,
>> John
>>
>> -----Original Message-----
>> From: John Linn [mailto:john.linn@xilinx.com]
>> Sent: Wednesday, June 18, 2008 2:58 PM
>> Cc: John Linn
>> Subject: [PATCH] powerpc: Xilinx: adding virtex5 powerpc 440 support
>>
>>
>>
>> The following files add support for Virtex5 with Powerpc 440.
>>
>>
>>
>> Device trees are currently handled differently than other embedded
>>
>> systems as there may not be a boot loader such that the device
>>
>> tree is compiled into the kernel or pulled from a BRAM.
>>
>>
>>
>> The UART 16550 has extra initialization in the bootstrap loader
>>
>> since a boot loader is not used many times.
>>
>
> Your mailer seems to have damaged the patch by wrapping lines and
> inserting extra blank lines.  You'll need to resend.  I've removed
> them below so I could make comments.
>
>>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>> ---
>>  arch/powerpc/Kconfig                     |   75 +++
>>  arch/powerpc/boot/Makefile               |   24 +-
>>  arch/powerpc/boot/dts/ml507.dts          |  254 ++++++++
>>  arch/powerpc/boot/io.h                   |    7 +
>>  arch/powerpc/boot/virtex.c               |  246 ++++++++
>>  arch/powerpc/configs/44x/ml507_defconfig | 1010 ++++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/44x/Kconfig       |   62 ++
>>  arch/powerpc/platforms/44x/Makefile      |    1 +
>>  arch/powerpc/platforms/44x/virtex.c      |   58 ++
>>  arch/powerpc/platforms/Kconfig           |    7 +
>>  10 files changed, 1739 insertions(+), 5 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/ml507.dts
>>  create mode 100644 arch/powerpc/boot/virtex.c
>>  create mode 100644 arch/powerpc/configs/44x/ml507_defconfig
>>  create mode 100644 arch/powerpc/platforms/44x/virtex.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 3934e26..94adfe1 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -483,6 +483,81 @@ config SECCOMP
>>
>>         If unsure, say Y. Only embedded should say N here.
>>
>> +config WANT_DEVICE_TREE
>> +     bool
>> +     default n
>
> This shouldn't be here.
>
>> +
>> +config BUILD_RAW_IMAGE
>> +     bool "Build firmware-independent image"
>> +     select WANT_DEVICE_TREE
>> +     help
>> +       If this is enabled, a firmware independent "raw" image will be
>> +       built, as zImage.raw.  This requires a completely filled-in
>> +       device tree, with the following labels:
>> +
>> +       mem_size_cells: on /#address-cells
>> +       memsize: on the size portion of /memory/reg
>> +       timebase: on the boot CPU's timebase property
>
> Obsolete stuff; replaced with simpleImage
>
>> +config DEVICE_TREE
>> +     string "Static device tree source file"
>> +     depends on WANT_DEVICE_TREE
>> +     help
>> +       This specifies the device tree source (.dts) file to be
>> +       compiled and included when building the bootwrapper.  If a
>> +       relative filename is given, then it will be relative to
>> +       arch/powerpc/boot/dts.  If you are not using the bootwrapper,
>> +       or do not need to build a dts into the bootwrapper, this
>> +       field is ignored.
>> +
>> +       For example, this is required when building a cuImage target
>> +       for an older U-Boot, which cannot pass a device tree itself.
>> +       Such a kernel will not work with a newer U-Boot that tries to
>> +       pass a device tree (unless you tell it not to).  If your U-Boot
>> +       does not mention a device tree in "help bootm", then use the
>> +       cuImage target and specify a device tree here.  Otherwise, use
>> +       the uImage target and leave this field blank.
>
> Obsolete
>
>> +config COMPRESSED_DEVICE_TREE
>> +     bool "Use compressed device tree"
>> +     depends on XILINX_VIRTEX
>> +     depends on WANT_DEVICE_TREE
>> +     help
>> +       In Xilinx FPGAs, the hardware can change quite dramatically
>> while
>> +       still running the same kernel.  In this case and other similar
>> +       ones, it is preferable to associate the device tree with a
>> +       particular build of the hardware design.  This configuration
>> +       option assumes that the device tree blob has been compressed and
>> +       stored in Block RAM in the FPGA design.  Typically, such a block
>> +       ram is available in order to provide a bootloop or other code
>> +       close to the reset vector at the top of the address space.  By
>> +       default, the parameter options associated with this configuration
>> +       assumes that exactly one block ram (2KB) of storage is available,
>> +       which should be sufficient for most designs.  If necessary in a
>> +       particular design, due to boot code requirement or a large number
>> +       of devices, this address (and the corresponding parameters in the
>> +       EDK design) must be modified.
>> +
>> +       Note that in some highly area constrained designs, no block rams
>> +       may be available in the design, and some other mechanism may be
>> +       used to hold the processor in reset while external memory is
>> +       initialized with processor code.  In such cases, that mechanism
>> +       should also be used to load the device tree at an appropriate
>> +       location, and the parameters associated with this configuration
>> +       option should be modified to point to that location in external
>> +       memory.
>
> This is a really interesting option and is probably useful for other
> platforms too.  I'd like to see this split out into a separate patch and
> slightly reworked so that it is usable by non-xilinx targets.
>
>> +config COMPRESSED_DTB_START
>> +     hex "Start of compressed device tree"
>> +     depends on COMPRESSED_DEVICE_TREE
>> +     default 0xfffff800
>> +
>> +config COMPRESSED_DTB_SIZE
>> +     hex "Size of compressed device tree"
>> +     depends on COMPRESSED_DEVICE_TREE
>> +     default 0x800
>
> These probably shouldn't be config values.  Either they should be
> provided in regsiters or memory at boot time, or a data file should be
> pulled in when linking the bootwrapper to determine where to look for the
> device tree compressed blob.  The goal of this is to allow multiple
> images to be built (with different dtb locations) for a single kernel
> compile.
>
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index 1cee2f9..9de59fb 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -66,7 +66,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c
>> cuboot-83xx.c cuboot-85xx.c holly.c
>>             fixed-head.S ep88xc.c ep405.c \
>>             cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
>>             cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c
>> simpleboot.c \
>> -           virtex405-head.S
>> +           virtex.c virtex405-head.S
>>  src-boot := $(src-wlib) $(src-plat) empty.c
>>
>>  src-boot := $(addprefix $(obj)/, $(src-boot))
>> @@ -197,6 +197,7 @@ image-$(CONFIG_PPC_HOLLY)         += zImage.holly
>>  image-$(CONFIG_PPC_PRPMC2800)            += dtbImage.prpmc2800
>>  image-$(CONFIG_PPC_ISERIES)        += zImage.iseries
>>  image-$(CONFIG_DEFAULT_UIMAGE)           += uImage
>> +image-$(CONFIG_XILINX_VIRTEX)            += zImage.virtex
>>
>>  #
>>  # Targets which embed a device tree blob
>> @@ -279,14 +280,24 @@ targets += $(image-y) $(initrd-y)
>>
>>  $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>>
>> +# If CONFIG_WANT_DEVICE_TREE is set and CONFIG_DEVICE_TREE isn't an
>> +# empty string, define 'dts' to be path to the dts
>> +# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
>> +ifeq ($(CONFIG_WANT_DEVICE_TREE),y)
>> +ifneq ($(CONFIG_DEVICE_TREE),"")
>> +dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
>> +     ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=%)
>> +endif
>> +endif
>> +
>
> Obsolete stuff
>
>>  # Don't put the ramdisk on the pattern rule; when its missing make will
>> try
>>  # the pattern rule with less dependencies that also matches (even with
>> the
>>  # hard dependency listed).
>> -$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
>> -     $(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
>> +$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
>> +     $(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
>
> Ditto
>
>>
>> -$(obj)/zImage.%: vmlinux $(wrapperbits)
>> -     $(call if_changed,wrap,$*)
>> +$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
>> +     $(call if_changed,wrap,$*,$(dts))
>
> Ditto
>
>>  # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
>>  $(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
>> @@ -325,6 +336,9 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb
>> $(wrapperbits)
>>  $(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
>>       $(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS)
>> $(dtstree)/$*.dts
>>
>> +$(obj)/zImage.raw: vmlinux $(dts) $(wrapperbits)
>> +     $(call if_changed,wrap,raw,$(dts))
>> +
>
> Ditto
>
>>  # If there isn't a platform selected then just strip the vmlinux.
>>  ifeq (,$(image-y))
>>  image-y := vmlinux.strip
>> diff --git a/arch/powerpc/boot/dts/ml507.dts
>> b/arch/powerpc/boot/dts/ml507.dts
>> new file mode 100644
>> index 0000000..43d8535
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/ml507.dts
>> @@ -0,0 +1,254 @@
>> +/*
>> + * (C) Copyright 2007-2008 Xilinx, Inc.
>> + * (C) Copyright 2007 Michal Simek
>> + *
>> + * Michal SIMEK <monstr@monstr.eu>
>
> I don't think it is appropriate to have Michal's name here; this is a
> generated file, not a file that he wrote.  (It is, of course, 100%
> appropriate for the tool that generated it to have his copyright)
>
> It *might* be appropriate for Xilinx to claim copyright on this file
> because it is the device tree for one of Xilinx's reference designs, but
> that ground isn't very stable.
>
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>> + * MA 02111-1307 USA
>
> These three paragraphs can be dropped; they are redundant.
>
>> + *
>> + * CAUTION: This file is automatically generated by libgen.
>> + * Version: Xilinx EDK 10.1.01 EDK_K_SP1.2
>
> This is a generated file and so it is debatable about whether or not it
> is appropriate for inclusion in the kernel.  Personally, I lean toward
> including it as long as it is well documented as to what it is.
> Specifically, the comment block should state exactly what version of the
> reference design is being described here.
>
> <snipping the entire dts file>
>
> BTW, the dts file and defconfig should be submitted in separate patch
> files.
>
>> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
>> index ccaedae..ec57ec9 100644
>> --- a/arch/powerpc/boot/io.h
>> +++ b/arch/powerpc/boot/io.h
>> @@ -99,4 +99,11 @@ static inline void barrier(void)
>>       asm volatile("" : : : "memory");
>>  }
>>
>> +static inline void disable_irq(void)
>> +{
>> +     int dummy;
>> +     asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
>> +                  "=r" (dummy) : : "memory");
>> +}
>> +
>
> Drop this; it was part of the old zImage.raw stuff.
>
>>  #endif /* _IO_H */
>> diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
>> new file mode 100644
>> index 0000000..5d807c6
>> --- /dev/null
>> +++ b/arch/powerpc/boot/virtex.c
>> @@ -0,0 +1,246 @@
>> +/*
>> + * Old U-boot compatibility for Walnut
>
> Not true!  :-)
>
>> + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> Probably not true either!
>
>> + *
>> + * Copyright 2007 IBM Corporation
>> + *   Based on cuboot-83xx.c, which is:
>> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
>
> You should probably add Xilinx to this list.
>
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation.
>
> This paragraph is redundant; remove.
>
>> + */
>> +
>> +#include <stddef.h>
>> +#include <stdio.h>
>> +#include "ops.h"
>> +#include "dcr.h"
>> +#include "4xx.h"
>> +#include "io.h"
>> +#include "reg.h"
>> +
>> +BSS_STACK(4096);
>> +
>> +#include "types.h"
>> +#include "gunzip_util.h"
>> +#include <libfdt.h>
>> +#include "../../../include/linux/autoconf.h"
>> +
>> +#define UART_DLL       0     /* Out: Divisor Latch Low */
>> +#define UART_DLM       1     /* Out: Divisor Latch High */
>> +#define UART_FCR       2     /* Out: FIFO Control Register */
>> +#define UART_FCR_CLEAR_RCVR 0x02 /* Clear the RCVR FIFO */
>> +#define UART_FCR_CLEAR_XMIT  0x04 /* Clear the XMIT FIFO */
>> +#define UART_LCR       3     /* Out: Line Control Register */
>> +#define UART_MCR       4     /* Out: Modem Control Register */
>> +#define UART_MCR_RTS         0x02 /* RTS complement */
>> +#define UART_MCR_DTR         0x01 /* DTR complement */
>> +#define UART_LCR_DLAB        0x80 /* Divisor latch access bit */
>> +#define UART_LCR_WLEN8       0x03 /* Wordlength: 8 bits */
>> +
>> +/* This function is only needed when there is no boot loader to
>> +   initialize the UART
>> +*/
>> +static int virtex_ns16550_console_init(void *devp)
>> +{
>> +     int n;
>> +     unsigned long reg_phys;
>> +     unsigned char *regbase;
>> +     u32 regshift, clk, spd;
>> +     u16 divisor;
>> +
>> +     n = getprop(devp, "virtual-reg", &regbase, sizeof(regbase));
>> +     if (n != sizeof(regbase)) {
>> +           if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
>> +                 return -1;
>> +
>> +           regbase = (void *)reg_phys + 3;
>> +     }
>> +     regshift = 2;
>> +
>> +     n = getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
>> +     if (n != sizeof(spd))
>> +           spd = 9600;
>> +
>> +     /* should there be a default clock rate?*/
>> +     n = getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
>> +     if (n != sizeof(clk))
>> +           return -1;
>> +
>> +     divisor = clk / (16 * spd);
>> +
>> +     /* Access baud rate */
>> +     out_8(regbase + (UART_LCR << regshift), UART_LCR_DLAB);
>> +
>> +     /* Baud rate based on input clock */
>> +     out_8(regbase + (UART_DLL << regshift), divisor & 0xFF);
>> +     out_8(regbase + (UART_DLM << regshift), divisor >> 8);
>> +
>> +     /* 8 data, 1 stop, no parity */
>> +     out_8(regbase + (UART_LCR << regshift), UART_LCR_WLEN8);
>> +
>> +     /* RTS/DTR */
>> +     out_8(regbase + (UART_MCR << regshift), UART_MCR_RTS | UART_MCR_DTR);
>> +
>> +     /* Clear transmitter and receiver */
>> +     out_8(regbase + (UART_FCR << regshift),
>> +                       UART_FCR_CLEAR_XMIT | UART_FCR_CLEAR_RCVR);
>> +     return 0;
>> +}
>> +
>> +/* For virtex, the kernel may be loaded without using a bootloader and if so
>> +   some UARTs need more setup than is provided in the normal console init
>> +*/
>> +static int virtex_serial_console_init(void)
>> +{
>> +     void *devp;
>> +     char devtype[MAX_PROP_LEN];
>> +     char path[MAX_PATH_LEN];
>> +
>> +     devp = finddevice("/chosen");
>> +     if (devp == NULL)
>> +           return -1;
>> +
>> +     if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0) {
>> +           devp = finddevice(path);
>> +           if (devp == NULL)
>> +                 return -1;
>> +
>> +           if ((getprop(devp, "device_type", devtype, sizeof(devtype)) > 0)
>> +                       && !strcmp(devtype, "serial")
>> +                       && (dt_is_compatible(devp, "ns16550")))
>> +                       virtex_ns16550_console_init(devp);
>> +     }
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +static struct gunzip_state gzstate;
>> +#endif
>
> #ifdefs are forbidden in bootwrapper code.  Use different zImage targets
> to enable/disable particular features.
>
>> +
>> +void platform_init(void)
>
> Wrong signature for platform_init().  Should be:
>
> void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>                   unsigned long r6, unsigned long r7)
>
>> +{
>> +     u32 memreg[4];
>> +     u64 start;
>> +     u64 size = 0x2000000;
>> +     int naddr, nsize, i;
>> +     void *root, *memory;
>> +     static const unsigned long line_size = 32;
>> +     static const unsigned long congruence_classes = 256;
>> +     unsigned long addr;
>> +     unsigned long dccr;
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +     void *dtbz_start;
>> +     u32 dtbz_size;
>> +     void *dtb_addr;
>> +     u32 dtb_size;
>> +     struct fdt_header dtb_header;
>> +     int len;
>> +#endif
>
> Ditto
>
>> +
>> +        if((mfpvr() & 0xfffff000) == 0x20011000) {
>> +            /* PPC errata 213: only for Virtex-4 FX */
>> +            __asm__("mfccr0  0\n\t"
>> +                    "oris    0,0,0x50000000@h\n\t"
>> +                    "mtccr0  0"
>> +                    : : : "0");
>> +        }
>> +
>> +     /*
>> +     * Invalidate the data cache if the data cache is turned off.
>> +     * - The 405 core does not invalidate the data cache on power-up
>> +     *   or reset but does turn off the data cache. We cannot assume
>> +     *   that the cache contents are valid.
>> +     * - If the data cache is turned on this must have been done by
>> +     *   a bootloader and we assume that the cache contents are
>> +     *   valid.
>> +     */
>> +     __asm__("mfdccr %0": "=r" (dccr));
>> +     if (dccr == 0) {
>> +           for (addr = 0;
>> +                addr < (congruence_classes * line_size);
>> +                addr += line_size) {
>> +                 __asm__("dccci 0,%0": :"b"(addr));
>> +           }
>> +     }
>
> Instead of duplicating this in C code, you should instead modify the
> wrapper script to also link in virtex405-head.o
>
>> +#if defined(CONFIG_XILINX_VIRTEX_5_FXT) && defined(CONFIG_MATH_EMULATION)
>> +     /* Make sure the APU is disabled when using soft FPU emulation */
>> +     mtdcr(5, 0);
>> +#endif
>
> Again; remove #ifdefs.  Do stuff like this in the equivalent of
> virtex405-head.S
>
>> +
>> +     disable_irq();
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +
>> +        /** FIXME: flatdevicetrees need the initializer allocated,
>> +            libfdt will fix this. */
>> +     dtbz_start = (void *)CONFIG_COMPRESSED_DTB_START;
>> +     dtbz_size = CONFIG_COMPRESSED_DTB_SIZE;
>> +     /** get the device tree */
>> +     gunzip_start(&gzstate, dtbz_start, dtbz_size);
>> +     gunzip_exactly(&gzstate, &dtb_header, sizeof(dtb_header));
>> +
>> +     dtb_size = dtb_header.totalsize;
>> +     // printf("Allocating 0x%lx bytes for dtb ...\n\r", dtb_size);
>
> remove c++ style comments
>
>> +
>> +     dtb_addr = _end; // Should be allocated?
>> +
>> +     gunzip_start(&gzstate, dtbz_start, dtbz_size);
>> +     len = gunzip_finish(&gzstate, dtb_addr, dtb_size);
>> +     if (len != dtb_size)
>> +           fatal("ran out of data!  only got 0x%x of 0x%lx bytes.\n\r",
>> +                       len, dtb_size);
>> +     printf("done 0x%x bytes\n\r", len);
>> +     simple_alloc_init(0x800000, size - (unsigned long)0x800000, 32, 64);
>> +     fdt_init(dtb_addr);
>
> Address shouldn't be hard coded.  Can you calculate the dtb_addr based on
> the _end addr and the size of the dtb?
>
>> +#else
>> +        /** FIXME: flatdevicetrees need the initializer allocated,
>> +            libfdt will fix this. */
>> +     simple_alloc_init(_end, size - (unsigned long)_end, 32, 64);
>> +     fdt_init(_dtb_start);
>> +#endif
>> +
>> +     root = finddevice("/");
>> +     if (getprop(root, "#address-cells", &naddr, sizeof(naddr)) < 0)
>> +           naddr = 2;
>> +     if (naddr < 1 || naddr > 2)
>> +           fatal("Can't cope with #address-cells == %d in /\n\r", naddr);
>> +
>> +     if (getprop(root, "#size-cells", &nsize, sizeof(nsize)) < 0)
>> +           nsize = 1;
>> +     if (nsize < 1 || nsize > 2)
>> +           fatal("Can't cope with #size-cells == %d in /\n\r", nsize);
>> +
>> +     memory = finddevice("/memory@0");
>> +     if (! memory) {
>> +           fatal("Need a memory@0 node!\n\r");
>> +     }
>> +     if (getprop(memory, "reg", memreg, sizeof(memreg)) < 0)
>> +           fatal("Need a memory@0 node!\n\r");
>> +
>> +     i = 0;
>> +     start = memreg[i++];
>> +     if(naddr == 2) {
>> +           start = (start << 32) | memreg[i++];
>> +     }
>> +     size = memreg[i++];
>> +     if (nsize == 2)
>> +           size = (size << 32) | memreg[i++];
>> +
>> +     // timebase_period_ns = 1000000000 / timebase;
>> +     virtex_serial_console_init();
>> +     serial_console_init();
>> +     if (console_ops.open)
>> +           console_ops.open();
>> +
>> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
>> +     printf("Using compressed device tree at 0x%x\n\r",
>> CONFIG_COMPRESSED_DTB_START);
>> +#else
>> +#endif
>> +        printf("booting virtex\n\r");
>> +        printf("memstart=0x%llx\n\r", start);
>> +        printf("memsize=0x%llx\n\r", size);
>> +}
>> diff --git a/arch/powerpc/platforms/44x/Kconfig
>> b/arch/powerpc/platforms/44x/Kconfig
>> index 6abe913..b90b33d 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -102,6 +102,58 @@ config YOSEMITE
>>  #    help
>>  #      This option enables support for the IBM PPC440GX evaluation board.
>>
>> +config XILINX_ML507
>> +     bool "Xilinx ML507 Reference System"
>> +     depends on 44x
>> +     default n
>> +     select XILINX_ML5XX
>> +     select WANT_DEVICE_TREE
>> +     help
>> +       This option enables support for the Xilinx ML507 board.
>
> I don't think this is necessary.  Follow the lead of virtex4 support and
> do something like config XILINX_VIRTEX_440_GENERIC_BOARD.
>
>> @@ -152,3 +204,13 @@ config 460EX
>>  # 44x errata/workaround config symbols, selected by the CPU models
>> above
>>  config IBM440EP_ERR42
>>       bool
>> +
>> +# Xilinx specific config options.
>> +config XILINX_ML5XX
>> +     bool
>> +     select XILINX_VIRTEX
>
> I think you should drop this.  Board specific stuff should be contained
> within the .dts files.
>
>> +config XILINX_VIRTEX_5_FXT
>> +     bool
>> +     depends on XILINX_ML507
>> +     default y
>
> Drop the above two lines and may the generic board config option select
> XILINX_VIRTEX_5_FXT
>
>> diff --git a/arch/powerpc/platforms/44x/Makefile
>> b/arch/powerpc/platforms/44x/Makefile
>> index 774165f..e3a9337 100644
>> --- a/arch/powerpc/platforms/44x/Makefile
>> +++ b/arch/powerpc/platforms/44x/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_TAISHAN)     += taishan.o
>>  obj-$(CONFIG_BAMBOO)   += bamboo.o
>>  obj-$(CONFIG_YOSEMITE) += bamboo.o
>>  obj-$(CONFIG_SEQUOIA)  += sequoia.o
>> +obj-$(CONFIG_XILINX_ML507)   += virtex.o
>>  obj-$(CONFIG_KATMAI)   += katmai.o
>>  obj-$(CONFIG_RAINIER)  += rainier.o
>>  obj-$(CONFIG_WARP)     += warp.o
>> diff --git a/arch/powerpc/platforms/44x/virtex.c
>> b/arch/powerpc/platforms/44x/virtex.c
>> new file mode 100644
>> index 0000000..42ca337
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/44x/virtex.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * Xilinx Virtex 5FXT based board support
>> + *
>> + * Copyright 2007 Secret Lab Technologies Ltd.
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> License
>> + * version 2. This program is licensed "as is" without any warranty of
>> any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/of_platform.h>
>> +#include <asm/machdep.h>
>> +#include <asm/prom.h>
>> +#include <asm/time.h>
>> +#include <asm/xilinx_intc.h>
>> +#include <asm/reg.h>
>> +#include <asm/ppc4xx.h>
>> +#include "44x.h"
>> +
>> +static struct of_device_id xilinx_of_bus_ids[] __initdata = {
>> +     { .compatible = "simple-bus", },
>> +     { .compatible = "xlnx,plb-v46-1.00.a", },
>> +     { .compatible = "xlnx,plb-v46-1.02.a", },
>> +     { .compatible = "xlnx,plb-v34-1.01.a", },
>> +     { .compatible = "xlnx,plb-v34-1.02.a", },
>> +     { .compatible = "xlnx,opb-v20-1.10.c", },
>> +     { .compatible = "xlnx,dcr-v29-1.00.a", },
>
> Do you need this whole list if the device tree generator is now claiming
> "simple-bus" compatibility?
>
>> +     { .compatible = "xlnx,compound", },
>> +     {}
>> +};
>> +
>> +static int __init virtex_device_probe(void)
>> +{
>> +     of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
>> +
>> +     return 0;
>> +}
>> +machine_device_initcall(virtex, virtex_device_probe);
>> +
>> +static int __init virtex_probe(void)
>> +{
>> +     unsigned long root = of_get_flat_dt_root();
>> +
>> +     if (!of_flat_dt_is_compatible(root, "xlnx,virtex"))
>> +           return 0;
>
> This is probably not good.  Granted, it is impossible to build a 405+440
> multiplatform image, but the device tree generator should probably be
> modified to claim something like "xlnx,virtex5fxt" so it isn't confused
> with an older virtex part.  (I realize that this is just following the
> lead from virtex2/4 support, but that should probably be changed too.)
>
>> +
>> +     return 1;
>> +}
>> +
>> +define_machine(virtex) {
>> +     .name             = "Xilinx Virtex",
>> +     .probe                  = virtex_probe,
>> +     .init_IRQ         = xilinx_intc_init_tree,
>> +     .get_irq          = xilinx_intc_get_irq,
>> +     .calibrate_decr         = generic_calibrate_decr,
>> +     .restart                = ppc4xx_reset_system,
>> +};
>> diff --git a/arch/powerpc/platforms/Kconfig
>> b/arch/powerpc/platforms/Kconfig
>> index 87454c5..523388b 100644
>> --- a/arch/powerpc/platforms/Kconfig
>> +++ b/arch/powerpc/platforms/Kconfig
>> @@ -313,6 +313,13 @@ config FSL_ULI1575
>>  config CPM
>>       bool
>>
>> +config XILINX_VIRTEX
>> +     bool
>> +     select PPC_DCR_MMIO
>> +     select PPC_DCR_NATIVE
>> +     help
>> +       Support for Xilinx Virtex platforms.
>> +
>
> config XILINX_VIRTEX is already defined in
> arch/powerpc/platforms/40x/Kconfig.  Moving it to this file should be
> done in a separate patch.
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
