Message-ID: <3E006B47.8070906@intracom.gr>
Date: Wed, 18 Dec 2002 14:34:15 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmalloc and startup process
References: <3DFF1DF4.8010005@intracom.gr> <3DFF5466.3050606@embeddededge.com>
In-Reply-To: <3DFF5466.3050606@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Pantelis Antoniou wrote:
>
>
>> At what point in the startup process is it OK to call
>> kmalloc?
>
>
> Before you start hacking up things that are "broken", you
> should probably take a moment to understand why they are
> currently implemented the way they are.
>
> The CPM support functions are called _very_ early in the
> kernel to support such features as KGDB on the serial ports.
> Currently, the host memory allocator uses bootmem pages
> because they are only option for allocating memory that early.

Yes I'm perfectly aware of that. My solution is to use this
memory first, and then fallback to using dynamic memory
later. Since my routines don't impose any memory overhead
to the allocated space, anyone counting at the old behaviour
is unaffected.

>
>
> There are three host memory allocators that are used to
> support CPM functions.  One is the 'cpm_hostalloc()' space,
> which is available early and used for small objects like
> uart fifos.  Second is the consistent DMA functions which
> are used in the places like the Ethernet driver.  Third is
> the kernel kmalloc() function which must be futher managed
> with the cache coherency functions.  They all have advantages
> and features that meet various driver requirements.  You may
> need to use several layers of initialization to make this
> happen, just like any other Linux driver.  Some must be
> done at kernel initialization, others can be postponed until
> later.  When you think driver support functions are "broken"
> you may want to stop and consider that maybe your driver
> writing techniques are broken and investigate how these
> functions are working successfully for others.

What  I'm  dealing here is the requirement to use modules
for my proprietary hardware. I am perfectly willing to
contibute whatever changes I make to the kernel to the places
not dealing with my hardware. But I cannot open source my
hardware.

>
>
> I would strongly suggest that the only thing to "fix" is to
> add a trivial space manager to some statically configurable
> number of bootmem pages.  The old UNIX resouce map allocator
> would be a perfect algorithm to manage this space.

Well, patch follows.

>
>
> Thanks.
>
>
>     -- Dan
>
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
