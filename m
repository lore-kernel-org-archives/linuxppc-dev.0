Message-ID: <393D6779.1EFD794A@embeddededge.com>
Date: Tue, 06 Jun 2000 17:04:57 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@wavemark.com>
CC: dan@netx4.com, tmontgom@miranda.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running from ROM
References: <200006052137.RAA29282@rome.wavemark.com> <393C23CC.3289DD1F@mvista.com> <00060516034300.24189@minotaur.mvista.com> <200006061339.JAA30741@rome.wavemark.com> <393D06BD.ADEDF247@miranda.com> <393D3D63.E3504DE9@embeddededge.com> <200006062011.QAA31478@rome.wavemark.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:

> As a preface, let me say that I don't know that it *is* better for us
> to run from ROM, only that I suspect it *might* be.  See if the
> following makes any sense.

Yes, it does.  Count bytes and make trade offs.  What "fudge factor"
do you use :-).

> .....  I am not talking about merely
> running the kernel out of ROM (though that seems the easy part),

I know a few people that would disagree with this statement, having
actually done the work.  There is this minor problem of branch targets
not able to cover 32 bits of address, and it is all uphill from there
when you are trying to span a 4 GByte space in code/data (plus fit
some user applications in the middle).


> Who says that development has to happen in flash ROM?

I didn't mean to imply all development happens there.  Execute from
ROM (in my experience) was an additional step for testing that
didn't always work the first time, and debugging in this environment
is more challenging.  For 8xx development, I typically use NFS root
disk filesystems, then just make these into a compressed ram disk.
In this case, you are done because the final product is still running
from RAM just like the original development.  Further, if you design
the product to use some (carefully) removeable media like compact flash,
your initial guess at the amount of flash rom doesn't have to be
accurate.  You may wish it was less, but it won't stop the shipment of
products and you can squeeze it or update the features over time.
It really sucks when you have soldered down the maximum amount and you
can't make the software fit....


> But how much application code can you fit in that 8-bit device?

Lots, until you fill it up :-).  Seriously, in products I have seen,
you can achieve at least 50% reduction in Flash requirement by
compressing the kernel and file system.  As you said, some things
compress better than others.

> So I am still wondering how we might do this as I worry about possibly
> having to muck in the deep innards of MMU manipulating code.

It's not only the MMU.  When you use the standard Linux file system
features like RAM disks, ROM file systems, and program loaders, your
software just works and your product is out the door.  People also forget
that the kernel is a small part in the product development.  Many of
these "features" affect the libraries, which are substantially more
code and more complex (to someone like me that doesn't really understand
dynamic loading).  It also affects the tools used to develop the
software. You have to also consider if saving that dollar or two of
flash or RAM is worth additional time of not shipping products.

OK, back to real work now......I must write some code.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
