Date: Wed, 10 Dec 2003 09:03:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
Message-ID: <20031210090327.A18009@home.com>
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>; from wolfgang.grandegger@bluewin.ch on Wed, Dec 10, 2003 at 03:43:41PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 10, 2003 at 03:43:41PM +0100, Wolfgang Grandegger wrote:
>
> Hello,
>
> we are suffering from TLB misses on a 405GP processor, eating up to
> 10% of the CPU power when running our (rather big) application. We
> can regain a few percent by using the kernel option CONFIG_PIN_TLB
> but we are thinking about further kernel modifications to reduce
> TLB misses. What comes into my mind is:
>
>  - using a kernel PAGE_SIZE of 8KB (instead of 4KB).
>  - using large-page TLB entries.
>
> Has anybody already investigated the effort or benefit of such
> changes or knows about other (simple) measures (apart from
> replacing the hardware)?

David Gibson and Paul M. implemented large TLB kernel lowmem
support in 2.5/2.6 for 405.  It allows for large TLB entries
to be loaded on kernel lowmem TLB misses.  This is better than
the CONFIG_PIN_TLB since it works for all of your kernel lowmem
system memory rather than the fixed amount of memory that
CONFIG_PIN_TLB covers.

I've been thinking about enabling a variant of Andi Kleen's patch
to allow modules to be loaded into kernel lowmem space instead of
vmalloc space (to avoid the performance penalty of modular drivers).
This takes advantage of the large kernel lowmem 405 support above
and on 440 all kernel lowmem is in a pinned tlb for architectural
reasons.

I've also been thinking about dynamically using large TLB/PTE mappings
for ioremap on 405/440.

In 2.6, there is hugetlb userspace infrastructure that could be enabled
for the large page sizes on 4xx.

Allowing a compile time choice of default page size would also be useful.

Basically, all of these cases can provide a performance advantage
depending on your embedded application...it all depends on what your
application is doing.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
