Message-Id: <200012211548.eBLFmJ727210@denx.local.net>
To: Kyle Harris <kharris@nexus-tech.net>
cc: Jerry Van Baren <vanbaren_gerald@si.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation error 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Dec 2000 08:28:28 EST."
             <3A42057C.6449819F@nexus-tech.net>
Date: Thu, 21 Dec 2000 16:48:19 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kyle,

in message <3A42057C.6449819F@nexus-tech.net> you wrote:
>
> Sorry, I guess more detailed info would be helpful. I'm running a 2.2.13
> kernel on a TQM823 board. I have seen this error when using dd to write
> to flash. But it's not consistent (sometimes dd works, sometimes it
> doesn't). Then I wrote a program using the times() function and it
> always fails. I went back and tried this with the original kernel and it
> works! I recompiled with and without MATH_EMULATION, but essentially get

Be careful what your running where - if you use  the  old  glibc-1.99
based  tools  which  assume to have a FPU, you MUST run a kernel with
MATH_EMULATION. If you use the CDK to  compile  you  own  stuff  with
glibc-2.x  you  MUST  use  -msoft-float  (in  fact  that's enabled by
default in the CDK).

I have seen similar problem with the old glibc-1.99  tools;  they  go
away when you use a "clean" soft-float-only environment.

> the same error. I've tried rebuilding the kernel to what I think are
> default settings, but still no luck. What other kernel configs are
> relevant?

It's not the kernel, it's the application / library (except that  the
FP emulation code in 2.2.13 had several problems of it's own).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
