Message-ID: <3FD83398.3020000@bluewin.ch>
Date: Thu, 11 Dec 2003 10:06:32 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch> <20031210090327.A18009@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 12/10/2003 05:03 PM Matt Porter wrote:
> On Wed, Dec 10, 2003 at 03:43:41PM +0100, Wolfgang Grandegger wrote:
>>
>> Hello,
>>
>> we are suffering from TLB misses on a 405GP processor, eating up to
>> 10% of the CPU power when running our (rather big) application. We
>> can regain a few percent by using the kernel option CONFIG_PIN_TLB
>> but we are thinking about further kernel modifications to reduce
>> TLB misses. What comes into my mind is:
>>
>>  - using a kernel PAGE_SIZE of 8KB (instead of 4KB).
>>  - using large-page TLB entries.
>>
>> Has anybody already investigated the effort or benefit of such
>> changes or knows about other (simple) measures (apart from
>> replacing the hardware)?
>
> David Gibson and Paul M. implemented large TLB kernel lowmem
> support in 2.5/2.6 for 405.  It allows for large TLB entries
> to be loaded on kernel lowmem TLB misses.  This is better than
> the CONFIG_PIN_TLB since it works for all of your kernel lowmem
> system memory rather than the fixed amount of memory that
> CONFIG_PIN_TLB covers.

Ah, I will have a look to 2.5/2.6. Is there a backport for 2.4?

> I've been thinking about enabling a variant of Andi Kleen's patch
> to allow modules to be loaded into kernel lowmem space instead of
> vmalloc space (to avoid the performance penalty of modular drivers).
> This takes advantage of the large kernel lowmem 405 support above
> and on 440 all kernel lowmem is in a pinned tlb for architectural
> reasons.

Is this patch available somewhere? It would be interesting to measure
the improvement for our application.

> I've also been thinking about dynamically using large TLB/PTE mappings
> for ioremap on 405/440.

OK, I expect not so much benefit from this measure but it depends on the
application, of course.

> In 2.6, there is hugetlb userspace infrastructure that could be enabled
> for the large page sizes on 4xx.

But this sounds more promising. Same questing as above. Is there a
backport for 2.4?

> Allowing a compile time choice of default page size would also be useful.

Increasing the page size from 4 to 8 kB should, in theory, halve the
page misses (if no large TLB pages are used). Unfortunately, increasing
the page size seem not straight forward as it's statically used in
various places and maybe the GLIBC needs to be rebuild as well.

> Basically, all of these cases can provide a performance advantage
> depending on your embedded application...it all depends on what your
> application is doing.

Of course, and tweaking the kernel for a dedicated application might not
been worth the effort. Anyhow, I have now a better idea what else can be
done.

Thanks.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
