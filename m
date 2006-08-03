Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 94F6967C1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 19:46:12 +1000 (EST)
Date: Thu, 3 Aug 2006 02:48:21 -0500
From: Milton Miller <miltonm@bga.com>
To: grant.likely@secretlab.ca, cthomas@soneticom.com,
Subject: Re: Booting Linux Kernel without bootloader
Message-Id: <311545913012eb141f24.1102520059.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue Aug  1 2006 11:17:41 PM CDT,  Grant Likely  wrote:
> On 7/25/06, Clint Thomas <cthomas@soneticom.com> wrote:
> >
> > Basically, the system I want linux running on does not require the
> > initialization of hardware that U-boot provides, or at least it does not
> > need it to boot the linux kernel. I want to load an uncompressed linux
> > kernel into memory and start the execution of the kernel, without using any
> > kind of bootloader. Is this possible? Or does linux need some kind of
> > firmware or other software to tell it to start executing? Thanks for any
> > info you might have.
> 
> Loading a kernel into memory and starting execution *is* a boot loader.  :)

If it's running on the cpu, then I agreee.   But he didn't say how he was loading
the image into memory, and if it is via an external agent then I would not
necessarly call that a boot loader, altough it is performing those tasks. 
Actually, that may be too broad.  Is kexec a boot loader?

> 
> You could use the bootwrapper that is in the kernel source tree
> (zImage).  If a zImage's entry point is at the execution entry point,
> then it will start the Linux kernel correctly.  However, it is still a
> compressed image.
> 

The boot wrapper is a reference implementation, not a required piece of the
boot sequence.  As I stated in my previous post, the kernel entry conditions
are documted and loading the vmlinux raw is reasonable, asssuming that
the other conditions can be met (registers and device  treee, and maybe
initrd).

> If you *really* need an uncompressed image, I would start with the
> bootwrapper and hack it to work with an non-gzipped kernel image.
> However, why do you want to do it this way?  You probably won't gain
> much in boot time and it will be more difficult to maintain.

Actually, the code is aready there to just copy anything inthe kernel
section that is without the gzip header.

milton
