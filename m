Return-Path: <schandra@in.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1450BDDE05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 01:22:22 +1000 (EST)
Subject: ML507 EDK 10.1 SP2
From: somshekar c kadam <schandra@in.mvista.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <20080602143551.54964C80052@mail135-wa4.bigfish.com>
References: <1212445128.3187.20.camel@localhost.localdomain>
	<20080602143551.54964C80052@mail135-wa4.bigfish.com>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 07:56:00 +0530
Message-Id: <1217384760.22420.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: skaushik@in.mvista.com, nbhat@in.mvista.com, pnarasim@in.mvista.com,
	linuxppc-embedded@ozlabs.org
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

We are using ML507 EDK 10.1 with latest SP2.
We have took your help in getting up the Xilinx git kernel up on ML507
using bsb image donwload.bit from xilinx website and dts file part of
the kernel. The kernel boots successfully. thanks for all your support.

Well we now want to modify bsb image by creating new download.bit using
EDK 10.1 SP2 and generate dts file for it.

Problem now we are facing is we follow the steps mentioned XIlinx ML507
pdf to create donwload.bit and generate dts file for it. using the same
xilinx kernel but the board doesn't boot.

Can you throw some light on any specific steps we are missing apart from
the pdf mentioned to create bsb image download.bit and corresponding dts
file. 

Just we need to use uartlite instead of 16650 uart.
Also we are trying on ML403 we are not able to create a sample
donwload.bit which boots. 
Please mention any steps we are missing or any pointers will help as we
are stuck in this problem from long.

For ml403 we even tried older edk 9.1 sp2 , 8.1 sp2 and 7.1 sp2 neither
works .

Waiting for your inputs 
Thanks In advance 
Regards
Neelu






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
