Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE003.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 5EA47DDFF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 00:35:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: ML507 EDK 10.1
Date: Mon, 2 Jun 2008 08:35:45 -0600
In-Reply-To: <1212445128.3187.20.camel@localhost.localdomain>
References: <1212445128.3187.20.camel@localhost.localdomain>
From: John Linn <John.Linn@xilinx.com>
To: "somshekar c kadam" <schandra@in.mvista.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080602143551.54964C80052@mail135-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Neelu,

The easiest way to get a good baseline with the board and the kernel is
to use the bitstream for the board that we provide in the file,
linux_support.tar.gz, on http://git.xilinx.com.

In the PPC440 directory of the support file, there's a bit stream for
the board. If you don't use a Xilinx probe to download to the board, you
will need to create an ACE file from that bit stream, but it sounds like
you know how to do that.

I know the state of the Xilinx Git tree, but I don't know the state of
Grant's for sure. We have baselined our Git tree such that you should be
able to make it work quick and easy (that's our goal).

To build arch/powerpc, the following commands should create zImage in
the arch/powerpc/boot directory that can be used with the bitstream from
the linux_support.tar.gz file.  I am currently using the ELDK 4.1 tools
to build the kernel.

> make ARCH=3Dpowerpc ml507_defconfig
> make ARCH=3Dpowerpc zImage

We also provide a ramdisk image in the support file, you can build it
also after copying the ramdisk images into the arch/powerpc/boot
directory.  The default command line of the kernel, in the ml507.dts
file in the arch/powerpc/boot/dts directory, is setup to use the
ramdisk.

> make ARCH=3Dpowerpc zImage.initrd

Hope that helps,
John Linn

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of somshekar c kadam
Sent: Monday, June 02, 2008 4:19 PM
To: linuxppc-embedded@ozlabs.org
Subject: ML507 EDK 10.1

Hi All,

Currently I am working with ML507 Base Reference design. I  have
installed Eval 10.1 edk I am bale to create ace file using xmd with base
download.bit. and able to boot the board. Now I want to boot the board
with Xilinx Linux kernel from Xilinx git tree. I am facing compilation
problem with zImage.dts for ml507_defconfig.

  =



now I need to create ace file for Linux for ML507.
I tried creating zImage.dts its failing. Kernel error see below

Please help or give some pointers wherein I can compile zImge.dts. this
is from latest git tree. Seems for me arch/powerpc wrapper code is
broken. Please suggest.
currently I have no bdi I need to stick to Ace compact Flash booting.
Also bit confused where we have two git tree one is Xilinx git tree one
more from Grant Likely which should I use ?

Thanks In Advance

Neelu

---------------------------------------------------
WRAP    arch/powerpc/boot/zImage.dts
DTC: dts->dtb  on file
"/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/bo
ot/dts/ml507.dts"
objcopy: Unable to recognise the format of the input file `vmlinux'
make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
make: *** [zImage.dts] Error 2




WIth Verbose =3D1 =



 /bin/sh
/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
t/wrapper -c -o arch/powerpc/boot/zImage.dts -p dts   -s
/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
t/dts/ml507.dts vmlinux
+ kernel=3D
+ ofile=3DzImage
+ platform=3Dof
+ initrd=3D
+ dtb=3D
+ dts=3D
+ cacheit=3D
+ binary=3D
+ gzip=3D.gz
+ CROSS=3D
+ object=3Darch/powerpc/boot
+ objbin=3Darch/powerpc/boot
+ tmpdir=3D.
+ '[' 8 -gt 0 ']'
+ case "$1" in
+ cacheit=3Dy
+ shift
+ '[' 7 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 6 -gt 0 ']'
+ ofile=3Darch/powerpc/boot/zImage.dts
+ shift
+ '[' 5 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 4 -gt 0 ']'
+ platform=3Ddts
+ shift
+ '[' 3 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 2 -gt 0 ']'
+
dts=3D/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc
/boot/dts/ml507.dts
+ shift
+ '[' 1 -gt 0 ']'
+ case "$1" in
+ '[' -z '' ']'
+ kernel=3Dvmlinux
+ shift
+ '[' 0 -gt 0 ']'
+ '['
-n
/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
t/dts/ml507.dts ']'
+ '[' '!'
-r
/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
t/dts/ml507.dts -a -r
arch/powerpc/boot/dts//home/neelu/xilinx/xilinx_gittree/test44/linux-2.6
-xlnx/arch/powerpc/boot/dts/ml507.dts ']'
+ '[' -z '' ']'
+ dtb=3Ddts.dtb
+ arch/powerpc/boot/dtc -O dtb -o dts.dtb -b
0
/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boo
t/dts/ml507.dts
DTC: dts->dtb  on file
"/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/bo
ot/dts/ml507.dts"
+ '[' -z vmlinux ']'
+ platformo=3Darch/powerpc/boot/dts.o
+ lds=3Darch/powerpc/boot/zImage.lds
+ ext=3Dstrip
+ objflags=3D-S
+ tmp=3D./zImage.24209.o
+ ksection=3D.kernel:vmlinux.strip
+ isection=3D.kernel:initrd
+ case "$platform" in
++ basename vmlinux
+ vmz=3D./vmlinux.strip
+ '[' -z y -o '!' -f ./vmlinux.strip.gz -o ./vmlinux.strip.gz -ot
vmlinux ']'
+ objcopy -S vmlinux ./vmlinux.strip.24209
objcopy: Unable to recognise the format of the input file `vmlinux'
make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
make: *** [zImage.dts] Error 2





------------------------------------------------------------------------
------------------




_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
