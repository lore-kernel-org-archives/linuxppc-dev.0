Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DC6B689FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 22:47:59 +1100 (EST)
Message-ID: <43DF4D6F.6090402@dlasys.net>
Date: Tue, 31 Jan 2006 06:43:43 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: David Summers <embeddedxilinx@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Getting started with Xilinx V4 PPC?
References: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
In-Reply-To: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


David;

I just completed a port of 2.6 to the Pico E-12 which is a Xilinx
Virtex-4 with very little hardware.

I had the advantage of a system that already had a elf loader (not
U-Boot), but not a Linux loader.
If I could load Linux as an elf file then I did not need another loader.
In the end I had to make some very trivial modifications to Pico's
loader to pass a board information structure. But otherwise the decision
to use the existing loader saved me having to port u-boot.

I also chose to boot into a ramdisk. Using the existing loader precluded
having the ramdisk as a separate file.
the intramfs feature of 2.6 allowed me to wrap the ramdisk into the same
file as the kernel. Documentation on initramfs is spartan, and somewhat
opaque. The good news was that despite the documentation initramfs
proved trivially easy to use.

After that I took the 2.6 kernel source, and litterally went through
looking for all references to the xilinx ml300.
Wherever there was an ml300 specific file I created an new one for the
pico_e12. Wherever there was an ml300 configuration option I created a
PICO_E12 one.

The E-12 had substatnitially less hardware than the ml300 (or the ml403)
so mostly I just ended up ripping code out of my private version of the
ml300 code that was transmuting into the pico_e12 code.

The next obstacle I bumped into was that the e-12 had two devices
suitable for a console - a highspeed fifo interface to a host
development system called the keyhole port, and the xilinx uartlite
serial port. Neither are supported in 2.6. I looked at the Xilinx
Uartlite 2.4 driver and it was coded substantially different from other
serial drivers. I decided not to try to port it to 2.6. I started from
scratch using the 8250 code as a base. I picked the 8250 because:
It must be the most heavily used linux serial driver and therefore I
hoped the most uptodate and well debugged.
The 8250 had boot through console IO support. Most other serial devices
require getting fairly far into the boot process before you get any output.

The really early IO proved fairly simple. Implimenting xxxx_dbg.c and
xxxx_tty.c for both the uartlite and the keyhole was fairly trivial.

Additionally the keyhole port had a "debug" feature where if you output
a single 32 bit word to one of the fifo ports it would be displayed in
hex on the host. As this could be done in an assembler macro that proved
indispensiable early on.

I was stalled for about 3 weeks trying to get the sucker into virtual
mode. In the end I had to disable Machine Check exceptions to make the
transition to virtual mode. Pico claims there is not a hardware problem,
but if I do nto disable machine checks on the e-12 it will never make
the tansition to virtual mode.

The full serial driver for the Uartlite (and Keyhole) proved more
daunting than anything else. In some ways the 8250 proved a bad choice
as a template there as there are more permutations, busses, etc
associated with the 8250 than anything else. I ended up stripping out
huge hunks of code. Eventually, I used the m32r_sio as a simpler
template. The driver was much simpler, and it had the critical features
I needed - both interupt driven and polled IO support - some
implimentations of the E12 do not include a PIC. The serial drivers took
much longer than the whole rest of the port combined - including the
machine check detour.

Just as I was finishing up the E12 port, Grant posted a set of patches
for the ml403. There were some fundimental differences at a fairly low
level between Grant's approach and mine. And I think Grant's Virtex-4
code appears to reflect more of the direction things are going, so I am
in the process of remodeling my port for the E12 on his for the ml403.
But I have not completed that.

Absent the machine check issue and having to write serial drivers thus
was atmost 2 weeks work.


BTW while you appear to be a hardware guy with alot of software
experience, I am a software guy with alot of hardware experience.


The E-12 has flash, but it uses a proprietary flash file system, and
using it would have required writing a filesystem driver - which I would
be happy to do if I got paid for it. Write performance on flash can be
extremely slow. If you are recording a significant amount of data in
realtime, you may want to skip the flash and just use a ramdisk. However
the ramdisk will not survive the system loosing power - which might be
an issue in a rocket.

If you are going to start with the 2.6 Kernel, I would get git. use it
to DL Linus's current 2.6 git repository, adn apply all of Grant's ml403
patches from the mailing list to it.
Then I would start an approach somewhat similar to what I described
above - except using Grant's ml403 as the base to create your own board
spec from instead of the ml300 that I used.
How tightly constrained are you for gates in the FPGA ?
If you are not tight, use the Xilinx 16550 serial IP and then you can
use standard Kernel 8250 dirvers (making Grant's patches work with
Uartlite is one of the things I am having trouble with) It would be my
guess that if you use the 16550 serial IP, you may be able to use
Grant's ml403 stuff asis.





David Summers wrote:

>I am starting a new project where I need to have a flash file system
>and an ethenet interface (HTTP and FTP).  The project is a solar
>physics experiment that will be launched on a sub-orbital rocket
>flight this fall.  The idea is that the experiment will write data
>files to the flash file system while in flight, and then I can
>download the data using ethernet after the experiment returns to
>earth.
>
>I think that Linux is the way to go for this project because of the
>JFFS2 filesystem and the strong networking support.  The only problem
>is that I am totally new to embedded linux.
>
>I am prototyping my system on an Avnet FX12 development board ( Specs
>here: http://tinyurl.com/4gfdv ) which is pretty similar to the Xilinx
>ML403 board except with less memory and no SystemACE slot.
>
>I will eventually build my own custom board with the same Xilinx
>Virtex 4 FX12 FPGA and additional flash memory and some custom
>interface hardware. My background is primarily as a hardware designer,
>and I am very confortable with the FPGA part of this project.   I am
>comfortable as a Linux user, and I am a pretty good C coder (for a
>hardware guy anyway :).  I have never built a linux system (embedded
>or desktop) before, and I need some help getting started with embedded
>linux.
>
>I have already found the following websites which have been a big help so far:
>
>http://www.klingauf.de/v2p/index.phtml
>http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm
>http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc1
>
>I have a few questions that I hope someone can help me with:
>
>1. What is the best linux distribution to start out with?  I am
>currently working with the 2.4 kernel code from
>ppc.bkbits.net/linuxppc_2_4_devel, but I'm not sure that this version
>be being updated.  (MontaVista also seems to be making it rather
>difficult to download their free Linux Preview Kit, so I wouldn't mind
>finding another distribution)    Does the DENX distribution have good
>PPC support?  Are there any others that I should look at, or should I
>just download the kernel source directly from kernel.org?
>
>
>2. kernel 2.4 or 2.6?
>
>It is my understanding that the latest version of MTD and JFFS2 have
>dropped support for kernel 2.4.  I would like to use JFFS2 on a NAND
>flash device, so it seems like I should use 2.6.  (Can I use JFFS2 on
>a NAND device with kernel v 2.4?)
>
>Being a complete newbie, am I biting off more that I can handle by
>trying to use 2.6?
>
>I have been lurking on the mailing list for a while, and I know that
>there are several people working on 2.6.x patches for the Xilinx
>virtex 4 parts.  Could someone point me to a list of the patches that
>I need to get me started?  I think that the ML403 patches should work
>with my board, but I don't know which ones I need to download.
>
>
>Thank you for your help,
>
>David Summers
>University of Colorado
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>

-- 
Dave Lynch 						DLA Systems
Software Development:  				     Embedded Linux
717.627.3770 	dhlii@dlasys.net 	 http://www.dlasys.net:8888
