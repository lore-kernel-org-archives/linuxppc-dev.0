Message-ID: <39D18CAD.FDC505E0@mvista.com>
Date: Wed, 27 Sep 2000 01:59:09 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Julia Elbert <jelbert@enerdyne.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: switching linux kernels
References: <20000927004021.ABEB8BF@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
>

> Turning off copy-back has a global performance hit, so it's a pretty nasty
> workaround for cache coherency bugs in a single driver.

Yep, you should really fix the driver.....

> ....... does it use insx/outsx &
> friends from asm/io.h, or does it dereference pointers directly, forgetting
> the eieio's?

Please don't use in/out macros on PowerPC....especially on 8xx their
underlying address arithmetic will likely break more things that it
fixes.
Use memory mapped I/O (readb/writeb, etc.) and ioremap().....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
