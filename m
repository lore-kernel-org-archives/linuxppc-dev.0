To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling glibc-2.3.2 (debian) on mpc8xx ;-) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Mar 2004 09:53:54 +0100."
             <200403090953.54598.david.jander@protonic.nl>
Date: Tue, 09 Mar 2004 10:45:21 +0100
Message-Id: <20040309094526.38303C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200403090953.54598.david.jander@protonic.nl> you wrote:
>
> So far, so good. I compiled a kernel with FPU-emulation just in case, and went
> through the installation of the base system using glibc-2.3.1 from ELDK
> binaries plugged on top of the version from debian, to avoid further
> incompatibilities.

You have just created a bunch of incompatibilities here.  You  cannot
use binaries and shared libraries that don't fit to each other.

> Question: What do I have to patch exactly before compiling? I want to leave
> floating-point stuff in there for now to stay compatible with

What do you mean by "leave floating-point stuff in"?

Since the MPC8xx does  not  have  a  FPU,  you  cannot  use  hardware
floating  point. Oh yes, there is the FP emulation in the kernel. But
this has never been working reliably.

> debian-binaries. AFAIK there is (was?) an issue with
> sysdeps/powerpc/powerpc32/memset.S and sysdeps/powerpc/powerpc32/dl-machine.c
> containing code that assumed a cache-line of different size than that of the
> MPC8xx. Is this still the case in glibc-2.3.2? Hasn't this been patched in
> the official sources?
> What else do I have to look out for? What other patches to apply? Where to get
> them from?

See the patches in the ELDK build environment.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The greatest threat towards future is indifference.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
