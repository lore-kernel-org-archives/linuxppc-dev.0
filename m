Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 946BCB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 05:33:46 +1000 (EST)
Date: Thu, 9 Sep 2010 12:33:42 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, peterz@infradead.org,
	mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909193341.GC3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <20100909184446.GB3496@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2010 at 11:44:46AM -0700, Ira W. Snyder wrote:

[ snip a bunch of info: summary below ]

> 
> I've also found that setting a breakpoint at 0x0 stops right when the
> Linux kernel starts, at symbol _start. AFAIK, the MMU is not yet
> enabled, so I have to subtract 0xc0000000 from all addresses.
> 
> Single stepping through the initial assembly portion of kernel startup
> shows that the FDT gets clobbered during the function early_init(). This
> trace is reproduced below.
> 
> For whatever reason, even when single stepping, the debugger absolutely
> refuses to enter the early_init function.
> 
> Misc Information:
> 1) 0xd00dfeed is an FDT magic number
> 2) 0x7f8000 is the physical address of the FDT in memory
> 

I have gotten the debugger to enter early_init(). I had to remove the
__init annotation on the function. I guess the debugger doesn't cope
with the extra sections that Linux uses.

(gdb) target remote bdi2k:2001
Remote debugging using bdi2k:2001
0xfc0034e8 in ?? ()
(gdb) info break
Num Type           Disp Enb Address    What
1   hw breakpoint  keep y   0x00000000 /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:72
        breakpoint already hit 1 time
(gdb) continue 
Continuing.

Breakpoint 1, _stext () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:72
72              nop     /* used by __secondary_hold on prep (mtx) and chrp smp */
Current language:  auto; currently asm
(gdb) s
73              nop     /* used by __secondary_hold on prep (mtx) and chrp smp */
(gdb) s
74              nop
(gdb) s
__start () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:113
113             cmpwi   0,r5,0
(gdb) s
114             beq     1f
(gdb) s
142     1:      mr      r31,r3                  /* save parameters */
(gdb) s
143             mr      r30,r4
(gdb) s
144             li      r24,0                   /* cpu # */
(gdb) s
151             bl      early_init
(gdb) s
early_init (dt_ptr=8355840) at /home/iws/devel/linux-2.6/arch/powerpc/kernel/setup_32.c:82
82      {
Current language:  auto; currently c
(gdb) s
88              memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
(gdb) print /x *0x7f8000
$22 = 0xd00dfeed
(gdb) n
82      {
(gdb) n
88              memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
(gdb) print __bss_start
$23 = 0xc0369000 <Address 0xc0369000 out of bounds>
(gdb) print __bss_stop
$25 = 0xc08a0c48 <Address 0xc08a0c48 out of bounds>
(gdb) print /x *0x7f8000
$26 = 0xd00dfeed
(gdb) n
83              unsigned long offset = reloc_offset();
(gdb) print /x *0x7f8000
$27 = 0xd00dfeed
(gdb) n
88              memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
(gdb) print /x *0x7f8000
$28 = 0xd00dfeed
(gdb) n
55      DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
(gdb) print /x *0x7f8000
$29 = 0xd00dfeed
(gdb) n
95              spec = identify_cpu(offset, mfspr(SPRN_PVR));
(gdb) print /x *0x7f8000
$30 = 0x0

This shows that the memset_io() in early_init() is zeroing the FDT. It
appears that CONFIG_PROVE_LOCKING increases the BSS size significantly,
and that's what is causing the true error. It isn't a lockdep problem,
it is a "the BSS is too big" problem.

Unfortunately, I'm now at a loss on how to fix this. Why does the
bootloader put the FDT so close to the kernel? Is this a bootloader
problem? Is it a configuration problem on my part?

I'm booting with a FIT image. The source file is inlined below. By
U-Boot bootm command is trivial:

dhcp 2000000 carma.itb ; bootm 2000000

Thanks,
Ira

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="carma.its"

/*
 * U-boot uImage source file with CARMA kernel, ramdisk, and FDT blob
 *
 * Compile with:
 * $ mkimage -f carma.its carma.itb
 */

/dts-v1/;

/ {
	description = "CARMA kernel, ramdisk, and FDT blob";
	#address-cells = <1>;

	images {
		kernel@1 {
			description = "Linux 2.6.36rc3";
			data = /incbin/("./vmlinux.bin.gz");
			type = "kernel";
			arch = "ppc";
			os = "linux";
			compression = "gzip";
			load = <0x0>;
			entry = <0x0>;
			hash@1 {
				algo = "md5";
			};
			hash@2 {
				algo = "sha1";
			};
		};

		ramdisk@1 {
			description = "CARMA PPC Generic Ramdisk";
			data = /incbin/("./initramfs-generic-ppc.cpio.gz");
			type = "ramdisk";
			arch = "ppc";
			os = "linux";
			compression = "gzip";
			load = <0x0>;
			hash@1 {
				algo = "sha1";
			};
		};

		fdt@1 {
			description = "CARMA FDT";
			data = /incbin/("./carma.dtb");
			type = "flat_dt";
			arch = "ppc";
			compression = "none";
			hash@1 {
				algo = "crc32";
			};
		};

	};

	configurations {
		default = "config@1";

		config@1 {
			description = "CARMA 2.6.36rc3 configuration";
			kernel = "kernel@1";
			ramdisk = "ramdisk@1";
			fdt = "fdt@1";
		};
	};

};

--cWoXeonUoKmBZSoM--
