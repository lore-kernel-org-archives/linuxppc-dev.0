Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id C0C90DEC51
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 01:06:10 +1000 (EST)
Message-ID: <4836DD88.3090407@coritel.it>
Date: Fri, 23 May 2008 17:06:48 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: linux powerpc and device trees
References: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
In-Reply-To: <BAY101-W39CE5CDB63DCE2DC056AAFBEC10@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

- Reyneke ha scritto:
> Hi All,
> 
> I am busy with a platform move from the arch/ppc to arch/powerpc tree of the linux kernel. Being relatively new to device trees, I'm trying to ensure I have all the steps covered. The platform is very similar to the AMCC Sequioa (440EPx) and that board has been used as reference for the code changes required. Kernel version is 2.6.25, using u-boot 1.2.0 (CONFIG_OF_xxx enabled, debug output on).
> 
> My understanding of the whole powerpc branch boot process is as follows:
> 
> 1. Add platform to arch/powerpc/platforms/4xx
> 2. Create a .dts in arch/powerpc/boot/dts
> 3. Setup .config and compile uImage
> 4. Compile device tree blob using dtc
> 5. As test, tftp uImage, RootFS, and deviceblob to system memory
> 6. Use u-boot's bootm command to boot kernel
> 
> Every seems OK, until you get to the boot part. The boot hangs:
> 
> Verifying Checksum ... OK
> Booting using flat device tree at 0x3000000
> ## initrd at 0x02000040 ... 0x027FEDF7 (len=8383928=0x7FEDB8)
> Loading Ramdisk to 0f332000, end 0fb30db8 ... OK
> ## Transferring control to Linux (at address 00000000) ...
> 
> 
> Using various diagnostics like BDI, ft_dump_blob etc I can see that u-boot does what I expect it to do, and the device tree blob looks valid. Tracing into the kernel init all looks fine until you hit MMU_init - at this point it looks like the total memory is calculated as 0. Evaluating the .dts file the following lines are immediately suspect:
> 
> memory {
> device_type = "memory";
> reg = ; /* Filled in by zImage */
> };
> 
> This is where I am unclear as to how to prepare the device tree. Is step (4) correct since I'm using uImage? Where is the memory information suppose to come from? Previously U-boot passes this kind of data to the kernel via bd_t - how does it work now using device trees?
> 
> Cheers
> Jan
> 
> 
> _________________________________________________________________
> 
> http://clk.atdmt.com/UKM/go/msnnkmgl0010000007ukm/direct/01/
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
Some information aren't statically filled in the dts but they are added 
dynamicly by U-Boot. This stuff has to be done in proper U-Boot 
functions. I suggest you to check these functions comparing them even 
with other boards.
