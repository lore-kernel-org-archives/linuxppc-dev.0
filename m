Message-Id: <4.3.2.20010307072619.00bcc700@falcon.si.com>
Date: Wed, 07 Mar 2001 07:53:15 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: how to use fp unit in kernel
In-Reply-To: <3AA60D9F.FEABC67A@dspace.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort answered the "how".  The "why" is for speed: since nobody in the
kernel uses floating point, it don't have to save and restore the fp
unit on every task switch.  This is quite expensive as there are quite
a few large registers involved.  There also could be a floating point
instruction in progress that takes a relatively a long time to complete
(fdiv appears to be the slowest in the 603e core) which would stall the
register save until it completed.

If at all possible, don't do fp in the kernel (modules are effectively
kernel extensions).  If you _have_ to use floating point, Cort's answer
is the way to go, especially if you only occasionally use the fp unit:
there is no point saving and restoring the fp unit on a simple time
tick that doesn't cause any fp operations.

I don't know the proper answer to your __xxxx floating point support
symbols problem, but it _is_not_ to compile your kernel with
-msoft-float.  Soft float is incompatible with hardware floating point
support (calling conventions and register usage).

You could solve the __xxxx fp support symbol problem by adding the fp
support library to the kernel and then exporting all the symbols so
that modules could use it, but that also is the wrong solution: it is
too much work for minimal benefit and all the kernel people will
ostracize you for doing something that they will consider really stupid
(remember, nobody in the kernel uses fp).  You will then have to redo
all that work every time you upgrade your kernel.

My guess is that the proper solution is to enable the fp unit (per
Cort), find and statically link the necessary fp support objects into
your module (remember, you are the only one in the kernel using fp so
there is no benefit to sharing).  One way to selectively statically
link your fp support routines is to use ar (archive) to extract
required .o files from an archive (ar -t /usr/lib/libc.a | less) and
then add those files to your link command line.

gvb


At 11:29 AM 3/7/01 +0100, Andreas Schreckenberg wrote:

>hello,
>
>i got a floating point unavialable exception, if i use
>floating point instructions within a module
>in the kernel. why ?
>(kernel 2.4.0 on a PPC750 board)
>
>the kernel is compiled with -msoft-float, and my
>kernel module whithout this option.
>
>If i compile the kernel without -msoft-float,
>i cannot insert my module because some __xxxx
>symbols cannot be resolved by the module linker.
>(i linked my module static
>again the math library libm.a, so sin(x) should
>be available)
>
>the kernel receives a trap 0x800 (fp unavailable)
>prints a message:
>floating point used in kernel (task=%p, pc=%x)\n
>turns on the fp in the msr and exit.
>
>what must i do ?
>best thing whould be: everything in kernelmode
>should use the fp unit ?
>is that the best or not (performance) ?
>
>What do the enable_kernel_fp() function ?
>at which moment must this be invoked.
>
>i would thank you for any help
>Andreas
>--
>           Life's not fair. But the root password helps ! :-)
>                    http://schrecky.home.pages.de
>                Open minds. Open sources. Open future.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
