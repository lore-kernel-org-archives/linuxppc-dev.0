To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling : problem linking 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 16:24:07 +0200."
             <1065104646.13376.8.camel@toni>
Date: Thu, 02 Oct 2003 17:01:44 +0200
Message-Id: <20031002150149.4E451C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1065104646.13376.8.camel@toni> you wrote:
>
> > Without more information (i. e. what sort of code this is and how you
> > intend it to run - stdandalone, in kernel or in user context)  nobody
> > can help you.
>
> Final goal is a kernel module, but now I'm writing a test program in
> user space (standalone, dynamic compiled).

These are two completely different issues.

> Code is quite simple (but I'm unsure about the correctness, due to the
> fact that my C knowledge has collapsed since I didn't use it anymore
> last 2 years):
>
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <asm/io.h>

You're including a kernel header file here. You must not do this. The
functions / macros you're looking for are not available in user space
(for example, outb is #defined only when __KERNEL__ is defined  which
is never the case for user space applications.)

> So somewhere, there is a linker problem.

No, it's a misunderstanding on your side. You cannot run kernel  code
in user space or vice versa.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have yet to add the ESP-driver to the kernel to read  the  mind  of
the user...                                       - Linus Torvalds in
      <Pine.LNX.3.91.960426110644.24860I-100000@linux.cs.Helsinki.FI>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
