Date: Thu, 12 Dec 2002 08:28:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Georg Klug <gklug@giga-stream.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Possible problem in asm/bitops.h
Message-ID: <20021212152851.GE19456@opus.bloom.county>
References: <FFECLICFNBJAHONLGAKMMEEJCHAA.gklug@giga-stream.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FFECLICFNBJAHONLGAKMMEEJCHAA.gklug@giga-stream.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 11, 2002 at 04:31:14PM +0100, Georg Klug wrote:

> Q: Is the ffz() function desgined to work in a user space application, too? If
>    yes, the file asm-ppc/bitops.h would need a change.
> Q: Does it make any sense to define one single macro (PPC405_ERR77()) in
> different
>    ways in different include files?

The problem here is that userland programs are _not_ allowed to use
kernel headers, iirc, even programs which are tied to the kernel in some
way.  They _must_ make a local copy of the include file which they
actually need.  I suspect the actual problem is that iproute2 only needs
a very small amount of what is in include/linux/inetdev.h

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
