Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 3 Dec 2003 11:28:03 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031203182803.GA10936@zenos.farnsworth.org>
References: <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> <20031116203318.21D9CC5F59@atlas.denx.de> <20031117185018.GG30251@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031117185018.GG30251@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 06:50:18PM +0000, Tom Rini wrote:
> Okay.  I've populated the following tree with what Dale had.  Since
> there's a number of things which need to be cleaned up / tweaked (fear
> not, I will follow up with my questions and conerns), I recommend that
> you get this tree by doing the following:
> 1) Start with a clean copy of 'linux-2.4'.  You can get this from
> bk://linux.bkbits.net/linux-2.4.
> 2) Copy linux-2.4 to linux-2.4-mpc5xxx (or whatever) and then do:
> 2a) cd linux-2.4-mpc5xxx
> 2b) bk parent bk://ppc.bkbits.net/linux-2.4-mpc5xxx
> 2c) bk pull -q

Thanks Tom.  I finally got some time to try this out.  Here's a patch
with what I needed to change to get it to boot on my icecube.

-Dale

===== arch/ppc/5xxx_io/bestcomm/Makefile 1.1 vs edited =====
10c10
< EXTRA_CFLAGS = -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/include -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/capi -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/capi/task_api -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/code_dma/image_rtos1
---
> EXTRA_CFLAGS = -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/include -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/capi -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/capi/task_api -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/code_dma/image_rtos1
===== arch/ppc/boot/simple/Makefile 1.12 vs edited =====
138,139c138,139
< obj-$(CONFIG_GLACIER)		:= mpc7xxx_tty.o
< obj-$(CONFIG_ICECUBE)		:= mpc5xxx_tty.o
---
> obj-$(CONFIG_GLACIER)		+= mpc5xxx_tty.o
> obj-$(CONFIG_ICECUBE)		+= mpc5xxx_tty.o
===== arch/ppc/configs/icecube_defconfig 1.1 vs edited =====
36,37c36,37
< CONFIG_GLACIER=y
< # CONFIG_ICECUBE is not set
---
> # CONFIG_GLACIER is not set
> CONFIG_ICECUBE=y
51,52c51,52
< CONFIG_PPC_5xxx_PSC_CONSOLE_PORT=2
< CONFIG_PPC_5xxx_PROCFREQ=231000000
---
> CONFIG_PPC_5xxx_PSC_CONSOLE_PORT=0
> CONFIG_PPC_5xxx_PROCFREQ=396000000
53a54,55
> CONFIG_PPC_5xxx_FLASH_ADDR=ff800000
> CONFIG_PPC_5xxx_FLASH_SIZE=800000
95c97,163
< # CONFIG_MTD is not set
---
> CONFIG_MTD=y
> # CONFIG_MTD_DEBUG is not set
> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_CONCAT is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
>
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_CHAR=y
> CONFIG_MTD_BLOCK=y
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
>
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> # CONFIG_MTD_CFI_INTELEXT is not set
> CONFIG_MTD_CFI_AMDSTD=y
> # CONFIG_MTD_CFI_STAA is not set
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> # CONFIG_MTD_OBSOLETE_CHIPS is not set
> # CONFIG_MTD_AMDSTD is not set
> # CONFIG_MTD_SHARP is not set
> # CONFIG_MTD_JEDEC is not set
>
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_TQM8XXL is not set
> # CONFIG_MTD_RPXLITE is not set
> # CONFIG_MTD_MBX860 is not set
> # CONFIG_MTD_DBOX2 is not set
> # CONFIG_MTD_CFI_FLAGADM is not set
> # CONFIG_MTD_REDWOOD is not set
> CONFIG_MTD_ICECUBE=y
> # CONFIG_MTD_PCI is not set
> # CONFIG_MTD_PCMCIA is not set
>
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLKMTD is not set
>
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOC1000 is not set
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOCPROBE is not set
>
> #
> # NAND Flash Device Drivers
> #
> # CONFIG_MTD_NAND is not set
529c597
< # CONFIG_USE_MDIO is not set
---
> CONFIG_USE_MDIO=y
531c599
< # CONFIG_FEC_LXT971 is not set
---
> CONFIG_FEC_LXT971=y
559c627
< # CONFIG_CRC32 is not set
---
> CONFIG_CRC32=y
574a643
> # CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/platforms/icecube.h 1.1 vs edited =====
61c61
< 	.iomem_base = (void *)MPC5xxx_PSC##num##,	\
---
> 	.iomem_base = (void *)MPC5xxx_PSC##num,		\

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
