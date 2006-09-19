Return-Path: <acmay@acmay.homeip.net>
Received: from fed1rmmtai01.cox.net (fed1rmmtai01.cox.net [68.230.241.58])
	by ozlabs.org (Postfix) with ESMTP id 8B2DC679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 04:22:54 +1000 (EST)
Date: Tue, 19 Sep 2006 11:06:01 -0700
From: Andrew <acmay@acmay.homeip.net>
To: "John Bonesio" <john.bonesio@xilinx.com>
Message-ID: <20060919110601.5ba728ea@localhost.localdomain>
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2006 09:40:53 -0700
"John Bonesio" <john.bonesio@xilinx.com> wrote:

> I am in the group that has control over how this is done. What would
> you propose be done different? Keep in mind that we are trying to
> support a process where someone builds a hardware design and the
> later changes it with new peripherals or perhaps makes minor tweaks.
> We want to make the updating of the Linux kernel to reflect these
> hardware changes easy for people.
> 
> Having the ability to make rapid hardware changes, I think, is a bit
> different from what most folks are used to.

I am coming into this a bit late and it has been awhile since I worked
Virtex parts. But it doesn't look like things have changed much.

Since Linux is from a PC base, hardware changes are as rapid as
powering off and plugging a new device in the machine. Rebuilding the
kernel for this is not usually something people consider for this.
So to say Linux people aren't use to rapid hardware changes, seems
pretty backwards to me.

The static configuration of the hardware is the thing that is very
unusual for the software. And having that static hardware setup
compiled into the kernel is a real source of problems.
Typically things get probed, discovered/learned at boot time. Either by
the boot loader, pin strapping, dip switches, user config etc.

I worked on a board with 2 Virtex chips. They had some set of common IP
cores with minor differences between the two. There was no way I wanted
to build 2 sets of kernels and drivers to deal with things.
The first small difference of one chip having 2 serial ports and the
other side only having 1 serial port, rippled the entire IRQ mapping in
both xparameters.h file. There were all kinds of little changes between
the mem mapping and everything else as well.
Depending on how things were used from xparemeters.h I could change the
static numbers to function calls to get values, but most of the time I
easist to hack up the drivers to pick one of two values depending on
the chip.

At first I just used a kernel boot param saved in u-boot flash to tell
the SW which chip it was running on. Then I got our HW people to put
in a single bit in another register for SW to tell which chip was
running. That saved us setup step in production of setting up flash
with different items.

There are trade offs on how much it is worth being determined at run
time compared to compiled into the kernel, but with the current
xparemters.h you are stuck with things compiled in. Getting to a point
where anything can be learned at run time, or just pulled from flash
would be a big step forward. But at that point it should still be easy
to compile things into the kernel if someone has major sw space
constraints.

I also keep hearing about doing partial re-configuration bit streams.
Were the FPGA can change at run time as well. (ie switch from an
CAT5 ethernet IP core over to an 802.11 ethernet depending on if the
user plugs in a cable or an antenna)

How would you even plan to do that with the xparemters.h file and the
drivers as it is now?
