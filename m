Return-Path: <schandra@in.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 47309DE051
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 19:25:42 +1000 (EST)
Subject: RE: ML507 EDK 10.1
From: somshekar c kadam <schandra@in.mvista.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <20080602143551.54964C80052@mail135-wa4.bigfish.com>
References: <1212445128.3187.20.camel@localhost.localdomain>
	<20080602143551.54964C80052@mail135-wa4.bigfish.com>
Content-Type: text/plain
Date: Wed, 04 Jun 2008 02:38:41 +0530
Message-Id: <1212527321.25185.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi John Linn, 
I tried using bit stream provided by linux_support.tar.gz,

It seems ace file still doesnt work, I created the ace file using bit
stream and zImage as you mentioned in the previuos mail. I dont know
wether there is something more for this to do. 
I dont have parallel cable to check using xmd. shall I use bdi and
conenct and see this, 

command i used to create ace file is shown below and put it on compact
flash at cfg6

Please suggest 


Thanks In Advance 
Neelu

xmd -tcl ../data/genace.tcl -hw ./ml507_ppc440_rtos.bit -elf ./zImage
-ace system.ace -board ml507


Xilinx Microprocessor Debug (XMD) Engine
Xilinx EDK 10.1 Build EDK_K.15
Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
Executing user script : ../data/genace.tcl

#######################################################################
XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
#######################################################################
Target Type not defined for Processor 1, Using default Target Type
ppc_hw
GenACE Options:
        Board      : ml507
        Jtag Devs  : xc5vfx70t
        FPGA pos   : 1
        JPROG      : false
        HW File    : ./ml507_ppc440_rtos.bit
        ACE File   : system.ace
        nCPUs      : 1

        Processor ppc_hw_1 Information
                Debug opt : -debugdevice devicenr 1 cpunr 1
                ELF files : ./zImage
                Start PC Address : 0x004007d8

############################################################
Converting Bitstream './ml507_ppc440_rtos.bit' to SVF file
'./ml507_ppc440_rtos.svf'
Executing 'impact -batch bit2svf.scr'

Copying ./ml507_ppc440_rtos.svf File to  system.svf File


JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
1       032c6093          10        xc5vfx70t

PowerPC440 Processor Configuration
-------------------------------------
Version.............................0x7ff21910
User ID.............................0x00f00000
No of PC Breakpoints................4
No of Read Addr/Data Watchpoints....1
No of Write Addr/Data Watchpoints...1
User Defined Address Map to access Special PowerPC Features using XMD:
        I-Cache (Data)........0x70000000 - 0x70007fff
        I-Cache (TAG).........0x70008000 - 0x7000ffff
        D-Cache (Data)........0x78000000 - 0x78007fff
        D-Cache (TAG).........0x78008000 - 0x7800ffff
        DCR...................0x78020000 - 0x78020fff
        TLB...................0x70020000 - 0x70023fff


############################################################
Converting ELF file './zImage' to SVF file './zImage.svf'

JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
1       032c6093          10        xc5vfx70t

PowerPC440 Processor Configuration
-------------------------------------
Version.............................0x7ff21910
User ID.............................0x00f00000
No of PC Breakpoints................4
No of Read Addr/Data Watchpoints....1
No of Write Addr/Data Watchpoints...1
User Defined Address Map to access Special PowerPC Features using XMD:
        I-Cache (Data)........0x70000000 - 0x70007fff
        I-Cache (TAG).........0x70008000 - 0x7000ffff
        D-Cache (Data)........0x78000000 - 0x78007fff
        D-Cache (TAG).........0x78008000 - 0x7800ffff
        DCR...................0x78020000 - 0x78020fff
        TLB...................0x70020000 - 0x70023fff


Copying ./zImage.svf File to  system.svf File


############################################################
Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'

JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
1       032c6093          10        xc5vfx70t

PowerPC440 Processor Configuration
-------------------------------------
Version.............................0x7ff21910
User ID.............................0x00f00000
No of PC Breakpoints................4
No of Read Addr/Data Watchpoints....1
No of Write Addr/Data Watchpoints...1
User Defined Address Map to access Special PowerPC Features using XMD:
        I-Cache (Data)........0x70000000 - 0x70007fff
        I-Cache (TAG).........0x70008000 - 0x7000ffff
        D-Cache (Data)........0x78000000 - 0x78007fff
        D-Cache (TAG).........0x78008000 - 0x7800ffff
        DCR...................0x78020000 - 0x78020fff
        TLB...................0x70020000 - 0x70023fff

Info:Processor started. Type "stop" to stop processor

RUNNING> 
############################################################
Converting SVF file 'system.svf' to SystemACE file 'system.ace'
Executing 'impact -batch svf2ace.scr'

SystemACE file 'system.ace' created successfully


On Mon, 2008-06-02 at 08:35 -0600, John Linn wrote:
> Hi Neelu,
> 
> The easiest way to get a good baseline with the board and the kernel is
> to use the bitstream for the board that we provide in the file,
> linux_support.tar.gz, on http://git.xilinx.com.
> 
> In the PPC440 directory of the support file, there's a bit stream for
> the board. If you don't use a Xilinx probe to download to the board, you
> will need to create an ACE file from that bit stream, but it sounds like
> you know how to do that.
> 
> I know the state of the Xilinx Git tree, but I don't know the state of
> Grant's for sure. We have baselined our Git tree such that you should be
> able to make it work quick and easy (that's our goal).
> 
> To build arch/powerpc, the following commands should create zImage in
> the arch/powerpc/boot directory that can be used with the bitstream from
> the linux_support.tar.gz file.  I am currently using the ELDK 4.1 tools
> to build the kernel.
> 
> > make ARCH=powerpc ml507_defconfig
> > make ARCH=powerpc zImage
> 
> We also provide a ramdisk image in the support file, you can build it
> also after copying the ramdisk images into the arch/powerpc/boot
> directory.  The default command line of the kernel, in the ml507.dts
> file in the arch/powerpc/boot/dts directory, is setup to use the
> ramdisk.
> 
> > make ARCH=powerpc zImage.initrd
> 
> Hope that helps,
> John Linn
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] On
> Behalf Of somshekar c kadam
> Sent: Monday, June 02, 2008 4:19 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: ML507 EDK 10.1
> 
> Hi All,
> 
> Currently I am working with ML507 Base Reference design. I  have
> installed Eval 10.1 edk I am bale to create ace file using xmd with base
> download.bit. and able to boot the board. Now I want to boot the board
> with Xilinx Linux kernel from Xilinx git tree. I am facing compilation
> problem with zImage.dts for ml507_defconfig.
> 
>   
> 
> 
> now I need to create ace file for Linux for ML507.
> I tried creating zImage.dts its failing. Kernel error see below
> 
> Please help or give some pointers wherein I can compile zImge.dts. this
> is from latest git tree. Seems for me arch/powerpc wrapper code is
> broken. Please suggest.
> currently I have no bdi I need to stick to Ace compact Flash booting.
> Also bit confused where we have two git tree one is Xilinx git tree one
> more from Grant Likely which should I use ?
> 
> Thanks In Advance
> 
> Neelu
> 
> ---------------------------------------------------
> WRAP    arch/powerpc/boot/zImage.dts
> DTC: dts->dtb  on file
> "/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/bo
> ot/dts/ml507.dts"
> objcopy: Unable to recognise the format of the input file `vmlinux'
> make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
> make: *** [zImage.dts] Error 2
> 
> 
> 
> 
> WIth Verbose =1 
> 
> 
>  /bin/sh
> /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
> t/wrapper -c -o arch/powerpc/boot/zImage.dts -p dts   -s
> /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
> t/dts/ml507.dts vmlinux
> + kernel=
> + ofile=zImage
> + platform=of
> + initrd=
> + dtb=
> + dts=
> + cacheit=
> + binary=
> + gzip=.gz
> + CROSS=
> + object=arch/powerpc/boot
> + objbin=arch/powerpc/boot
> + tmpdir=.
> + '[' 8 -gt 0 ']'
> + case "$1" in
> + cacheit=y
> + shift
> + '[' 7 -gt 0 ']'
> + case "$1" in
> + shift
> + '[' 6 -gt 0 ']'
> + ofile=arch/powerpc/boot/zImage.dts
> + shift
> + '[' 5 -gt 0 ']'
> + case "$1" in
> + shift
> + '[' 4 -gt 0 ']'
> + platform=dts
> + shift
> + '[' 3 -gt 0 ']'
> + case "$1" in
> + shift
> + '[' 2 -gt 0 ']'
> +
> dts=/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc
> /boot/dts/ml507.dts
> + shift
> + '[' 1 -gt 0 ']'
> + case "$1" in
> + '[' -z '' ']'
> + kernel=vmlinux
> + shift
> + '[' 0 -gt 0 ']'
> + '['
> -n
> /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
> t/dts/ml507.dts ']'
> + '[' '!'
> -r
> /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
> t/dts/ml507.dts -a -r
> arch/powerpc/boot/dts//home/neelu/xilinx/xilinx_gittree/test44/linux-2.6
> -xlnx/arch/powerpc/boot/dts/ml507.dts ']'
> + '[' -z '' ']'
> + dtb=dts.dtb
> + arch/powerpc/boot/dtc -O dtb -o dts.dtb -b
> 0
> /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
> t/dts/ml507.dts
> DTC: dts->dtb  on file
> "/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/bo
> ot/dts/ml507.dts"
> + '[' -z vmlinux ']'
> + platformo=arch/powerpc/boot/dts.o
> + lds=arch/powerpc/boot/zImage.lds
> + ext=strip
> + objflags=-S
> + tmp=./zImage.24209.o
> + ksection=.kernel:vmlinux.strip
> + isection=.kernel:initrd
> + case "$platform" in
> ++ basename vmlinux
> + vmz=./vmlinux.strip
> + '[' -z y -o '!' -f ./vmlinux.strip.gz -o ./vmlinux.strip.gz -ot
> vmlinux ']'
> + objcopy -S vmlinux ./vmlinux.strip.24209
> objcopy: Unable to recognise the format of the input file `vmlinux'
> make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
> make: *** [zImage.dts] Error 2
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> ------------------
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
