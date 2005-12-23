Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2A209679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 18:38:35 +1100 (EST)
Message-ID: <43ABA972.4080701@varma-el.com>
Date: Fri, 23 Dec 2005 10:38:26 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: pantelis.antoniou@gmail.com
References: <43A98F90.9010001@varma-el.com> <yq0d5jpuoqe.fsf@jaguar.mkp.net>
	<43AAEE12.5030009@varma-el.com>
	<200512222033.40156.pantelis.antoniou@gmail.com>
In-Reply-To: <200512222033.40156.pantelis.antoniou@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Pantelis Antoniou wrote:
> On Thursday 22 December 2005 20:18, Andrey Volkov wrote:
> 
>>Hi Jes,
>>
>>Jes Sorensen wrote:
>>
>>>>>>>>"Andrey" == Andrey Volkov <avolkov@varma-el.com> writes:
>>>
>>>
>>>Andrey> Hello Jes and all I try to use your allocator (gen_pool_xxx),
>>>Andrey> idea of which is a cute nice thing. But current implementation
>>>Andrey> of it is inappropriate for a _device_ (aka onchip, like
>>>Andrey> framebuffer) memory allocation, by next reasons:
>>>
>>>Andrey,
>>>
>>>Keep in mind that genalloc was meant to be simple for basic memory
>>>allocations. It was never meant to be an over complex super high
>>>performance allocation mechanism.
>>>
>>>Andrey>  1) Device memory is expensive resource by access time and/or
>>>Andrey> size cost.  So we couldn't use (usually) this memory for the
>>>Andrey> free blocks lists.
>>>
>>>This really is irrelevant, the space is only used within the object
>>>when it's on the free list. Ie. if all memory is handed out there's
>>>no space used for this purpose.
>>
>>I point out 2 reasons: ACCESS TIME was first :), let take very
>>widespread case: PCI device with some onboard memory and any
>>N GHz proc. - result may be terrible: each access to device mem (which
>>usually uncached) will slowed down this super fast proc to 33 MHZ, i.e
>>same as we made busy-wait with disabled interrupts after each read/write...
>>
>>I possible awry when use 'control structures' in 2), I've in view
>>allocator's control structures (size/next etc), not device specific
>>control structs.
>>
>>
>>>Andrey> 3) Obvious (IMHO) workflow of mem. allocator
>>>Andrey> look like: - at startup time, driver allocate some big
>>>Andrey> (almost) static mem. chunk(s) for a control/data structures.
>>>Andrey> - during work of the device, driver allocate many small
>>>Andrey> mem. blocks with almost identical size.  such behavior lead to
>>>Andrey> degeneration of buddy method and transform it to the
>>>Andrey> first/best fit method (with long seek by the free node list).
>>>
>>>This is only really valid for network devices, and even then it's not
>>>quite so. For things like uncached allocations your observation is
>>>completely off.
>>
>>Could you give me some examples? Possible I overlooked something
>>significant.
>>
>>
>>>For the case of more traditional devices, the control structures will
>>>be allocated from one end of the block, the rest will be used for
>>>packet descriptors which will be going in and out of the memory pool
>>>on a regular basis. 
>>
>>This was main reason why I try to modify genalloc: I needed  in
>>generic allocator for both short-live strictly aligned blocks and
>>long-live blocks with restriction by size.
>>
>>
>>>In most normal cases these will all be of the same
>>>size and it doesn't matter where in the memory space they were
>>>allocated.
>>
>>And thats also why I consider that 'buddy' is not appropriate to be
>>'generic' (most cases == generic, isn't is :)?): when you're allocate
>>mainly same sized blocks, 'buddy' degraded to the first-fit.
>>
>>Possible solution I see in mixed first-fit with lazy coalescent for
>>short lived blocks and first-fit with immediately coalescent for
>>long-lived blocks. But, again, I may overlook something significant.
>>And, certainly, I could overlooked someone else allocator implementation
>>in some driver.
>>
>>
>>>Andrey> 4) The simple binary buddy method is far away from perfect for
>>>Andrey> a device due to a big internal fragmentation. Especially for a
>>>Andrey> network/mfd devices, for which, size of allocated data very
>>>Andrey> often is not a power of 2.
>>>
>>
>>snip
>>
>>>Andrey> I start to modify your code to satisfy above demands, but
>>>Andrey> firstly I wish to know your, or somebody else, opinion.
>>>
>>>I honestly don't think the majority of your demands are valid.
>>>genalloc was meant to be simple, not an ultra fast at any random
>>>block size allocator. So far I don't see any reason for changing to
>>>the allocation algorithm into anything much more complex - doesn't
>>>mean there couldn't be a reason for doing so, but I don't think you
>>>have described any so far.
>>
>>I disagree here, generic couldn't be very simple and slow, because in
>>this case simply no one will be use it, and hence we'll get today's
>>picture: reimplemented allocators in many drivers.
>>
>>
>>>You mentioned frame buffers, but what is the kernel supposed to do
>>>with those allocation wise? If you have a frame buffer console, the
>>>memory is allocated once and handed to the frame buffer driver.
>>>Ie. you don't need a ton of on demand allocations for that and for
>>>X, the memory management is handled in the X server, not by the
>>>kernel.
>>
>>For video-only device this is true, but if device is a multifunctional,
>>which is frequent case in embedded systems, then kernel must control of
>>device memory allocation. Currently, however, even video cards for
>>desktops become more and more multifunctional (VIVO/audio etc.).
>>
>>
>>>The only thing I think would make sense to implement is to allow it to
>>>use indirect descriptor blocks for the memory it manages. This is not
>>>because it's wrong to use the memory for the free list, as it will
>>>only be used for this when the chunk is not in use, but because access
>>>to certain types of memory isn't always valid through normal direct
>>>access. Ie. if one used descriptor blocks residing in normal
>>>GFP_KERNEL memory, it would be possible to use the allocator to manage
>>>memory sitting on the other side of a PCI bus.
>>
>>I describe above, why we couldn't/wouldn't use onboard memory for
>>allocator specific data.
>>
>>Pantelis, Am I answered to your question (...what are you trying to
>>do...) too?
>>
> 
> 
> Yes. rheap seems to cover your cases...
>  
Agree, I couldn't see nothing better for a basement of generic dev. alloc.

So, it will be much better if it will be moved to lib/.

Anyone have some more comments about subj. ?

-- 
Regards
Andrey Volkov
