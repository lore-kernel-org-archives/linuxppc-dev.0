Date: Tue, 3 Aug 2004 17:16:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Josh Boyer <jwboyer@charter.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large TLBs on 40x
Message-ID: <20040803171641.B5454@home.com>
References: <1091574342.2578.83.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091574342.2578.83.camel@c68.115.86.108.roc.mn.charter.com>; from jwboyer@charter.net on Tue, Aug 03, 2004 at 06:05:42PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 03, 2004 at 06:05:42PM -0500, Josh Boyer wrote:
>
> Howdy,
>
> In 2.6, the PPC mm code for 4xx platforms uses large TLB entries for
> most of RAM.  Specifically, I am looking at arch/ppc/mm/4xx_mmu.c at the
> mmu_mapin_ram function.  In there, the pmd pointers are setup with
> _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE.
>
> Doesn't this allow the text pages of the kernel to be written to?  So to

Yes.

> my understanding, a buggy driver that went off into the weeds could
> corrupt the text pages of the kernel.

Yes.

> I would think that you would want the kernel text pages to be
> non-writable so that if something like the above scenario happened you
> don't have possibly bad text pages.  Debugging wouldn't be much fun.

Ideally, that's true. However, the kernel lowmem large TLB mapping is
there for performance. There's no way to manage default page size
protection on the text pages. It's a tradeoff between performance
and the ease of debugging a misguided driver. With all the kernel
debugging tools these days, it sure seems like performance is the
clear winner.

> I think I am missing something here.  If so, please excuse my lack of
> knowledge on TLBs, but I am somewhat new to the low level stuff.  Anyone
> care to point out what I am missing?

Well, it should be noted that the Classic PPC mapin_ram does a similar
thing. When mapping with BATs, the ability to do per (default size) page
RO is not available.  For reasons of performance, this is the default
method to map kernel lowmem on Classic PPC cores.

The same situation is present on Book E parts (44x/85xx). Since they
map all of kernel lowmem staticly with large TLB entries, they also
lack the ability to cover kernel text with read-only entries.

Anyway, this isn't just 4xx, it's pretty much everywhere. It's
possible to make 4xx large TLB mapping optional, but it's not
clear that adding the option is really that useful (at least
to me, YMMV).

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
