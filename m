From: "Georg Klug" <gklug@giga-stream.de>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: Possible problem in asm/bitops.h
Date: Tue, 17 Dec 2002 10:10:09 +0100
Message-ID: <FFECLICFNBJAHONLGAKMAEFOCHAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021212152851.GE19456@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tom,

> On Wed, Dec 11, 2002 at 04:31:14PM +0100, Georg Klug wrote:
>
> > Q: Is the ffz() function desgined to work in a user space
> application, too? If
> >    yes, the file asm-ppc/bitops.h would need a change.
> > Q: Does it make any sense to define one single macro (PPC405_ERR77()) in
> > different
> >    ways in different include files?
>
> The problem here is that userland programs are _not_ allowed to use
> kernel headers, iirc, even programs which are tied to the kernel in some
> way. They _must_ make a local copy of the include file which they
> actually need.

Oops, I thought, that the directories /usr/include/linux as well as
/usr/include/asm should come directly from the kernel (either as a copy
or symbolically linked). In that case those include files should always
be prepared to be included in a userland application. Am I right with this?

I also thought, that the asm-ppc/bitops.h should provide the same
functionality as its pendant in asm-i386/ which lets userland applications
use some static inline functions like set_bit() clear_bit() and change_bit().
I actually don't know whether those functions are needed outside the kernel,
so I cannot tell whether it is correct or not. But IMO it should be done
the same way on all plattforms. Would you agree?

> I suspect the actual problem is that iproute2 only needs
> a very small amount of what is in include/linux/inetdev.h

That might be true. But would the solution be to copy the linux/inetdev.h
to a local directory and change that file until it doesn't need the file
asm/bitops.h anymore?

Sorry for asking a little bit pedantic, but I want to set-up a complete
environment for building a kernel as well as all the needed userland
applications for our custom ppc_405 (walnut based) boards.

Thanks in advance for answering my questions,
Georg Klug


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
