Date: Thu, 11 Dec 2003 10:45:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
Message-ID: <20031211104505.C26110@home.com>
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch> <20031210090327.A18009@home.com> <3FD83398.3020000@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FD83398.3020000@bluewin.ch>; from wolfgang.grandegger@bluewin.ch on Thu, Dec 11, 2003 at 10:06:32AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 11, 2003 at 10:06:32AM +0100, Wolfgang Grandegger wrote:
>
> On 12/10/2003 05:03 PM Matt Porter wrote:
> > David Gibson and Paul M. implemented large TLB kernel lowmem
> > support in 2.5/2.6 for 405.  It allows for large TLB entries
> > to be loaded on kernel lowmem TLB misses.  This is better than
> > the CONFIG_PIN_TLB since it works for all of your kernel lowmem
> > system memory rather than the fixed amount of memory that
> > CONFIG_PIN_TLB covers.
>
> Ah, I will have a look to 2.5/2.6. Is there a backport for 2.4?

No.

> > I've been thinking about enabling a variant of Andi Kleen's patch
> > to allow modules to be loaded into kernel lowmem space instead of
> > vmalloc space (to avoid the performance penalty of modular drivers).
> > This takes advantage of the large kernel lowmem 405 support above
> > and on 440 all kernel lowmem is in a pinned tlb for architectural
> > reasons.
>
> Is this patch available somewhere? It would be interesting to measure
> the improvement for our application.

Google is your friend.
http://seclists.org/lists/linux-kernel/2002/Oct/6522.html
IIRC, there's a later version with some minor differences.

> > I've also been thinking about dynamically using large TLB/PTE mappings
> > for ioremap on 405/440.
>
> OK, I expect not so much benefit from this measure but it depends on the
> application, of course.

Yes, I've seen a lot of apps with huge shared memory areas across PCI
that can benefit from this...they used BATs on classic PPCs.

> > In 2.6, there is hugetlb userspace infrastructure that could be enabled
> > for the large page sizes on 4xx.
>
> But this sounds more promising. Same questing as above. Is there a
> backport for 2.4?

No.

> > Allowing a compile time choice of default page size would also be useful.
>
> Increasing the page size from 4 to 8 kB should, in theory, halve the
> page misses (if no large TLB pages are used). Unfortunately, increasing
> the page size seem not straight forward as it's statically used in
> various places and maybe the GLIBC needs to be rebuild as well.

Possibly, as Dan mentions, there are other arches already doing this
type of thing.  I know ia64 does and sounds like MIPS is another.

> > Basically, all of these cases can provide a performance advantage
> > depending on your embedded application...it all depends on what your
> > application is doing.
>
> Of course, and tweaking the kernel for a dedicated application might not
> been worth the effort. Anyhow, I have now a better idea what else can be
> done.

When I used to do apps work we were very performance sensitive (depends
on you project, of course) and we were very willing to make kernel
tweaks (proprietary RTOS) to me our requirements.  It all depends on
your requirements, constraints, budget, etc. :)

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
