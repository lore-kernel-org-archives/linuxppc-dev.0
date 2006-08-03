Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id CF346679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 00:35:00 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so239800ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Aug 2006 07:34:58 -0700 (PDT)
Message-ID: <528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
Date: Thu, 3 Aug 2006 08:34:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: Booting Linux Kernel without bootloader
In-Reply-To: <311545913012eb141f24.1102520059.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <311545913012eb141f24.1102520059.miltonm@bga.com>
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

On 8/3/06, Milton Miller <miltonm@bga.com> wrote:
> On Tue Aug  1 2006 11:17:41 PM CDT,  Grant Likely  wrote:
> > On 7/25/06, Clint Thomas <cthomas@soneticom.com> wrote:
> > >
> > > Basically, the system I want linux running on does not require the
> > > initialization of hardware that U-boot provides, or at least it does not
> > > need it to boot the linux kernel. I want to load an uncompressed linux
> > > kernel into memory and start the execution of the kernel, without using any
> > > kind of bootloader. Is this possible? Or does linux need some kind of
> > > firmware or other software to tell it to start executing? Thanks for any
> > > info you might have.
> >
> > Loading a kernel into memory and starting execution *is* a boot loader.  :)
>
> If it's running on the cpu, then I agreee.   But he didn't say how he was loading
> the image into memory, and if it is via an external agent then I would not
> necessarly call that a boot loader, altough it is performing those tasks.
> Actually, that may be too broad.  Is kexec a boot loader?

I would say it is.  :)

IMHO, even the basic tasks of correctly setting up the initial
conditions can be considered a bootloader.

> > You could use the bootwrapper that is in the kernel source tree
> > (zImage).  If a zImage's entry point is at the execution entry point,
> > then it will start the Linux kernel correctly.  However, it is still a
> > compressed image.
> >
>
> The boot wrapper is a reference implementation, not a required piece of the
> boot sequence.  As I stated in my previous post, the kernel entry conditions
> are documted and loading the vmlinux raw is reasonable, asssuming that
> the other conditions can be met (registers and device  treee, and maybe
> initrd).

I agree.  However, the original post sounded to me like he was looking
for a canned solution.  I know zImage isn't exactly what he asked for
because it is a compressed image, but it does achieve the *effect* he
asked for.

I am curious as to the source of his requirements.  ie. what is
loading the kernel into ram?  Where is it coming from?

I've got a similar situation on my Virtex-4 platform.  The FPGA takes
care of all device initialization.  However, the kernel is loaded of a
CF card via a *slow* JTAG interface.  Loading an uncompressed image is
more time consuming than loading a compressed image and uncompressing
it in software.

>
> > If you *really* need an uncompressed image, I would start with the
> > bootwrapper and hack it to work with an non-gzipped kernel image.
> > However, why do you want to do it this way?  You probably won't gain
> > much in boot time and it will be more difficult to maintain.
>
> Actually, the code is aready there to just copy anything inthe kernel
> section that is without the gzip header.

Perfect!

cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
