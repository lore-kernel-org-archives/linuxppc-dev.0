Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s30.bay0.hotmail.com (bay0-omc2-s30.bay0.hotmail.com
	[65.54.246.166]) by ozlabs.org (Postfix) with ESMTP id 8D862DE3B0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 00:53:46 +1000 (EST)
Message-ID: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: linux powerpc and device trees
Date: Fri, 23 May 2008 14:53:44 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

I am busy with a platform move from the arch/ppc to arch/powerpc tree of th=
e linux kernel. Being relatively new to device trees, I'm trying to ensure =
I have all the steps covered. The platform is very similar to the AMCC Sequ=
ioa (440EPx) and that board has been used as reference for the code changes=
 required. Kernel version is 2.6.25, using u-boot 1.2.0 (CONFIG_OF_xxx enab=
led, debug output on).

My understanding of the whole powerpc branch boot process is as follows:

1. Add platform to arch/powerpc/platforms/4xx
2. Create a .dts in arch/powerpc/boot/dts
3. Setup .config and compile uImage
4. Compile device tree blob using dtc
5. As test, tftp uImage, RootFS, and deviceblob to system memory
6. Use u-boot's bootm command to boot kernel

Every seems OK, until you get to the boot part. The boot hangs:

Verifying Checksum ... OK
Booting using flat device tree at 0x3000000
## initrd at 0x02000040 ... 0x027FEDF7 (len=3D8383928=3D0x7FEDB8)
Loading Ramdisk to 0f332000, end 0fb30db8 ... OK
## Transferring control to Linux (at address 00000000) ...


Using various diagnostics like BDI, ft_dump_blob etc I can see that u-boot =
does what I expect it to do, and the device tree blob looks valid. Tracing =
into the kernel init all looks fine until you hit MMU_init - at this point =
it looks like the total memory is calculated as 0. Evaluating the .dts file=
 the following lines are immediately suspect:

memory {
device_type =3D "memory";
reg =3D ; /* Filled in by zImage */
};

This is where I am unclear as to how to prepare the device tree. Is step (4=
) correct since I'm using uImage? Where is the memory information suppose t=
o come from? Previously U-boot passes this kind of data to the kernel via b=
d_t - how does it work now using device trees?

Cheers
Jan


_________________________________________________________________

http://clk.atdmt.com/UKM/go/msnnkmgl0010000007ukm/direct/01/=
