Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 60291DDE2E
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 17:49:38 +1000 (EST)
Message-ID: <46F76C0D.5090006@grandegger.com>
Date: Mon, 24 Sep 2007 09:49:33 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 6/6] Walnut zImage wrapper
References: <20070831200449.598781000@linux.vnet.ibm.com>	<20070831200643.675381000@linux.vnet.ibm.com>	<20070903011352.GF31499@localhost.localdomain>	<1188741519.3772.3.camel@localhost.localdomain>
	<20070905113604.746ee01c@weaponx.rchland.ibm.com>
In-Reply-To: <20070905113604.746ee01c@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> Updated patch below
> 
> Add zImage wrapper for walnut board
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/boot/Makefile          |    3 
>  arch/powerpc/boot/dcr.h             |    5 +
>  arch/powerpc/boot/treeboot-walnut.c |  131 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6/arch/powerpc/boot/Makefile
> @@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main
>  src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>  		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
>  		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
> -		cuboot-pq2.c cuboot-bamboo.c
> +		cuboot-pq2.c cuboot-bamboo.c treeboot-walnut.c
[deletions]

The addition of treeboot-walnut.c breaks compilation of Linux-2.6 for 
the lite5200 using the ppc_6xx toolchain of the ELDK 4.1:

   MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x14): Section mismatch: reference to 
.init.text:prom_init (between '__start' and '__after_mmu_off')
WARNING: vmlinux.o(.text+0x28): Section mismatch: reference to 
.init.text:early_init (between '__start' and '__after_mmu_off')
WARNING: vmlinux.o(.text+0x340c): Section mismatch: reference to 
.init.text:machine_init (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x3414): Section mismatch: reference to 
.init.text:MMU_init (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x343e): Section mismatch: reference to 
.init.text:start_kernel (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x3442): Section mismatch: reference to 
.init.text:start_kernel (between 'start_here' and 'set_context')
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      vmlinux
   SYSMAP  System.map
   BOOTAS  arch/powerpc/boot/string.o
   BOOTAS  arch/powerpc/boot/crt0.o
   BOOTCC  arch/powerpc/boot/stdio.o
   BOOTCC  arch/powerpc/boot/main.o
   BOOTCC  arch/powerpc/boot/flatdevtree.o
   BOOTCC  arch/powerpc/boot/flatdevtree_misc.o
   BOOTCC  arch/powerpc/boot/ns16550.o
   BOOTCC  arch/powerpc/boot/serial.o
   BOOTCC  arch/powerpc/boot/simple_alloc.o
   BOOTAS  arch/powerpc/boot/div64.o
   BOOTAS  arch/powerpc/boot/util.o
   BOOTCC  arch/powerpc/boot/gunzip_util.o
   BOOTCC  arch/powerpc/boot/elf_util.o
   BOOTCC  arch/powerpc/boot/inffast.o
   BOOTCC  arch/powerpc/boot/inflate.o
   BOOTCC  arch/powerpc/boot/inftrees.o
   BOOTCC  arch/powerpc/boot/devtree.o
   BOOTCC  arch/powerpc/boot/oflib.o
   BOOTCC  arch/powerpc/boot/ofconsole.o
   BOOTCC  arch/powerpc/boot/4xx.o
   BOOTCC  arch/powerpc/boot/ebony.o
   BOOTCC  arch/powerpc/boot/mv64x60.o
   BOOTCC  arch/powerpc/boot/mpsc.o
   BOOTCC  arch/powerpc/boot/mv64x60_i2c.o
   BOOTCC  arch/powerpc/boot/cuboot.o
   BOOTCC  arch/powerpc/boot/bamboo.o
   BOOTAR  arch/powerpc/boot/wrapper.a
   BOOTCC  arch/powerpc/boot/of.o
   BOOTCC  arch/powerpc/boot/cuboot-83xx.o
   BOOTCC  arch/powerpc/boot/cuboot-85xx.o
   BOOTCC  arch/powerpc/boot/holly.o
   BOOTCC  arch/powerpc/boot/cuboot-ebony.o
   BOOTCC  arch/powerpc/boot/treeboot-ebony.o
   BOOTCC  arch/powerpc/boot/prpmc2800.o
   BOOTAS  arch/powerpc/boot/ps3-head.o
   BOOTAS  arch/powerpc/boot/ps3-hvcall.o
   BOOTCC  arch/powerpc/boot/ps3.o
   BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
   BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
{standard input}: Assembler messages:
{standard input}:184: Error: Unrecognized opcode: `mfdcr'
{standard input}:185: Error: Unrecognized opcode: `mfdcr'
{standard input}:186: Error: Unrecognized opcode: `mfdcr'
{standard input}:217: Error: Unrecognized opcode: `mtdcr'
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
make: *** [uImage] Error 2

It looks like the ppc_6xx toolchain does not know the opcode above. I 
wonder why files for other PowerPC sub-archs like 4xx are compiled with 
the wrong compiler. Have I missed something?

And the WARNING above on "Section mismatch" looks strange as well (still 
present in 2.6.23-rc7).

Thanks for help.

Wolfgang.
