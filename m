Subject: Re: Question about PPC __put_user_asm/__get_user_asm
To: drow@false.org (Daniel Jacobowitz)
Date: Wed, 5 Apr 2000 10:33:16 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000404102915.A29825@drow.res.cmu.edu> from "Daniel Jacobowitz" at Apr 04, 2000 10:29:15 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000405003318.76C5B3C994@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

Daniel Jacobowitz writes:
> I can't tell you what those particular elements do, but I can tell you
> that -ffunction-sections will most likely NOT produce a bootable
> kernel.  It makes assumptions about the types of sections present - see
> for instance the __initfunc() macro and its custom section.

Thanks for the tip, but I think I've already solved this by renaming the
sections used in include/asm/init.h from ".text.init" to ".text_init" to avoid
the namespace clash which would happen if compiling a function named "init()".
I've also made the corresponding change in arch/ppc/vmlinux.lds, and added
*(.text.*) and (*.data.*) to the .text and .data output sections respectively.
That oughta do it, unless I've missed something...

Thanks,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
