Message-Id: <200106281624.f5SGOL810414@stimpy.networkrobots.com>
Date: Thu, 28 Jun 2001 09:28:28 -0700
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>,
	jtm@smoothsmoothie.com
From: Paul White <pwhite@networkrobots.com>
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Cc: linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Justin,

>From my recent experience, this does not work.   We have a device on our
PCI bus which is
DMAing to SDRAM, and so far I can't get anything to work without cache
coherency
support in the system controller.

If you find anything out, please let me know.  I may end up adding a new
memory queue
for non-cacheable memory, and just use another BAT entry for some
pre-defined amount
of memory for a non-cacheable pool.  A new flag to kmalloc() could then be
used to
get non-cacheable memory.  Does anyone know if anything like this already
exists, or
if theres a much easier way around this??  I should hopefully get cache
coherency
working, but we have been unable to so far.  If I end up doing the work,
I"ll post the patches
here.

Btw..  I attempted to disable cache, as well as simply set the RAM bat's to
PAGE_NO_CACHE,
however this does not work because the PowerPC will throw alignment
exceptions whenever a
cache instruction is called on either a non-cached memory region, or if
caching is disabled.
Just wanted to give you a heads up on this.

Paul W.


At 04:52 AM 6/28/2001 -0400, Justin (Gus) Hurwitz wrote:
>
>Did yo ever get a reply to this? That sounds like just what I want to do
>(well, it sounds just like what our vxworks code does to do what I want to
>do, which I guess is good enough).
>
>TIA,
>--Gus
>
>On Tue, 26 Jun 2001 jtm@smoothsmoothie.com wrote:
>
>>
>> I am looking for a solution to a similar problem. I am writing a
>> driver for an FCC on the 8260 in transparent mode, and need
>> to allocate buffer memory. The buffer memory will get filled
>> via DMA, and therefore must not be cached. Will the following work
>> correctly?
>>
>> 	vaddr = kmalloc(BUF_SIZE, GFP_DMA);
>> 	paddr = __pa(vaddr);
>>
>> Thanks.
>> --
>> Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
>> monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
>> 		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_
>
>
>
-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
