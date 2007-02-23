Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.246.247.9])
	by ozlabs.org (Postfix) with ESMTP id 3EC0CDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 09:23:53 +1100 (EST)
Subject: Re: debugging custom Xilinx boot loader with abatron and
	Montavista devrocket
From: Jeff Angielski <jeff@theptrgroup.com>
To: Wade Maxfield <wmaxfield@gmail.com>
In-Reply-To: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
References: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 16:53:11 -0500
Message-Id: <1172267591.13040.30.camel@jaalaptop>
Mime-Version: 1.0
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-23 at 10:11 -0600, Wade Maxfield wrote:
> 
>   I want to debug a ppc custom boot loader with Montavista (since we
> spent the money on it) under the Xilinx fx60.

Writing custom bootloaders is nontrivial.  Are you sure you really want
to do that?

And what does MV have to do with the bootloader?
> 
>   I've been able to get the kernel to debug under MontaVista.
> However, since the hardware engineers have given up on DDR ram (they
> could not get it to work reliably and will be dropping it from the
> next release), I don't think I can use Linux for now.   Unfortunately,
> this decision is not changeable.  When a hardware engineer is
> embarrassed, the results are not good for software engineers. 
> 
> I don't think I've got enough static ram to host a PPC linux kernel
> and applications (we only have 8 meg).  We will have 16 meg on the
> next release, I expect.  Is that enough for simple apps and linux
> under PPC???  I need some guidance here, as I don't have enough PPC
> experience. 

You can get Linux up and running with 16MB, and probably with the 8MB,
although as your RAM decreases the software development time will
increase exponentially.  You are going to be required to use Busybox and
uclibc on the user space side.  And you are most likely going to need to
significantly customize the Linux kernel to use memory sparingly.  It is
not really worth the effort unless you area talking about very large
numbers of units.

You never talked about how much flash you have and what kind it is.  You
will need to compress the binaries and/or run XIP.  You will need to use
a compressed filesystem.

Most of this is Embedded Linux 101, the *easy* stuff which you can find
in a bunch of books that are out there...

>   Fortunately, we got the ppc running and can manage the hardware
> using Xilkernel and Xilnet (lwIP maybe later).
> 
>   I've done numerous Google searches, and searches on MontaVista
> support page.  They are specific to Linux. 

That is because MV is a Linux vendor...  :)

>   Has anyone debugged a custom boot loader with MontaVista and
> Abatron?

What does MV have to do with *debugging* the custom bootloader?  Do you
mean the cross compiler that comes with MV?  Or just DevRocket?

You can use the Abatron to debug the bootloader code you are writing.
It is done everyday.

>   How do you set up the project under  eclipse (which is devrocket)?

Why even use eclipse?   You mentioned gdb/ddd later in the email.

>   Nothing I see seems to match, as I need the boot vector code, and I
> don't know how to tell eclipse to compile for that option.  Can I just
> bring over the elf (compiled with debug under Xilinx) and the source
> files and start debugging?  If so, what kind of project would I pick
> under devrocket?  The more I look, the more confused I get.

Sounds like you are looking for information on how to connect Eclipse to
the GDB backend of the Abatron.  This has nothing to do with the custom
bootloader per se.

Keep in mind, however, that there is a lot of code development that
needs to take place before you get to the point where you can single
step through C source code using a nice interface.
> 
>    I could possibly bring up linux on an ML403 board and use gdb/ddd
> on that.  if so, how would I cause the boot code to be located at the
> right address?  Any howto's to read that aren't simply hand waves
> would be very useful. I understand once I do it is easy, but getting
> it done the first time is my problem right now. 

Again, I would point you to uboot.  It works on many PPC variants and
contains more features than you could ever want.
> 
>    I've got to pull some serious asses from the fire, so I'm under a
> lot of pressure.  I also know who will be blamed if I don't pull this
> off.

Custom bootloader and custom hardware do not mix well with pressure and
schedules.  Especially for you since you seem to be very new to writing
bootloaders and using the embedded tools.

>   Any help is greatly appreciated!

Update the resume?  ;)  JK

Uboot is your friend.  Get it.  Learn it. Use it.

Busybox and uclibc are your friends when it comes time to write the
userspace code.

Compression will be required.  The time and place will be dependent on
your final hardware resources.


-- 
Jeff Angielski
The PTR Group
