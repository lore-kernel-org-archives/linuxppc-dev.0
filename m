Message-ID: <4111231E.5040201@mvista.com>
Date: Wed, 04 Aug 2004 10:55:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Brian Waite <linwoes@gmail.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Workaround for 745x data corruption bug
References: <1091291276.987.57.camel@localhost> <410E85EE.8050707@mvista.com> <36b714c804080306175c5dc3f6@mail.gmail.com> <411009D9.7090802@mvista.com> <36b714c8040804073721d8d856@mail.gmail.com>
In-Reply-To: <36b714c8040804073721d8d856@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian Waite wrote:

>Mark,
>      Pardon the poor descriptions. Lame excuses follow.
>

No biggie.  I made a mistake in my description too.  More on that below.

>Thanks
>Brian
>
>On Tue, 03 Aug 2004 14:55:37 -0700, Mark A. Greer <mgreer@mvista.com> wrote:
>
>
>>Brian,
>>
>>One of us must be seriously misunderstanding that erratum.  Below is my
>>thinking.
>>
>>--
>>Brian Waite wrote:
>>
>>
>>
>>>Mark,
>>>
>>>Looking at this errata, I don't think poeple using Marvell chips will
>>>be affected by this errata.
>>>I don't see this as impacting the IO subsystem only the internal MPX system.
>>>
>>>
>>>
>>Please define exactly what you mean by "MPX system".
>>
>>
>Poor nomencalture. I was referring to M affecting the behaviour of
>multi-CPU interfaces.
>

Okay.

>
>
>>>IE
>>>using a 2 74xx system and not using the M bit.
>>>
>>>
>>>
>>Doubtful.  Assuming you mean a dual *SMP* 745x system, you'll almost
>>certainly want "coherency required" (i.e., M=1) so the erratum doesn't
>>apply.
>>
>>
>It was bantered around my office that to improve the memory bus
>bandwidth of a dual CPU system that we place horrendus restrictions on
>user apps being locked to a single processor, not share data/code and
>eliminate the memory coherence between them. We measured about a 30%
>bandwidth reduction due to the M bit so the first reaction was to
>eliminate it. Thankfully I was able to kill that quickly. I should not
>have even brought the dual proc, non-coherent case up here.  Sorry.
>

No problem.

>
>
>
>>>This race can also
>>>occur on a single processor system with the M disabled,
>>>
>>>
>>>
>>Yep.
>>
>>
>>
>>>as it is in
>>>Linux, but it has nothing to do with the memory controller mapping its
>>>PCI<->mem windows as non cacheable.
>>>
>>>
>>>
>>This statement is wrong.  Firstly (nit pick), its not the memory
>>controller part of the chip that does that mapping, its the "PCI bridge"
>>part of that chip that does.
>>
>>
>Nit pick accepted. I should have been more descriptive here.
>
>
>>Secondly, you can't define a pci mem->system mem window as "non
>>cacheable"; you can only specify what type of snooping you want (none,
>>WB or WT).  Caches are assumed to exist and be turned on.  If they
>>aren't, you can just specify "none" for your snooping option.
>>
>>
>
>I agree. What I really meant was non-coherent. Ie Snoop option of "none".
>

I figured you meant that but wasn't sure.  This one was a nit pick too.

>
>
>
>>Thirdly, it has everything to do with pci mem->system mem windows
>>because that mapping points to normal old system memory that PCI devices
>>are going to DMA into and out of.  If CONFIG_NOT_COHERENT_CACHE is NOT
>>defined, the the processor will set M=1 for data mappings so the
>>processor will assume that when a PCI device DMAs into memory, the
>>bridge will follow whatever coherency protocol they've agreed upon
>>(i.e., all that MEI, MESI, MERSI stuff) so the processor can
>>flush/invalidate cachelines as necessary.  Everyone has to follow the
>>protocol or you will end up with stale cachelines and seemingly broken
>>I/O sooner or later.
>>
>>So, if CONFIG_NOT_COHERENT_CACHE is not defined, we must set up the
>>snoop windows on the bridge to either WB or WT.  If we don't set the
>>snoop windows correctly, coherency will be broken.  Also remember that
>>when CONFIG_NOT_COHERENT_CACHE is not defined the pci_/dma_ calls that
>>drivers use are essentially null (i.e., no manual cache management).
>>
>>
>>
>Agreed.
>
>
>
>>If CONFIG_NOT_COHERENT_CACHE is defined, then M=0 and now we set the
>>snoop windows on the bridge to "none".  The pci_/dma_ calls used by
>>drivers manage the caches and, assuming the driver is correctly written,
>>I/O works.
>>
>>
>Here is where I get lost. I am searching for the point where we modify
>the M bit reletive to CONFIG_NOT_COHERENT_CACHE and I can't find it.
>Under 2.6 I see us using the CPU_FTR_NEED_COHERENT to determine the M
>bit setting in mm/hashtable.S and mm/ppc_mmu.c but I can only find us
>setting CPU_FTR_NEED_COHERENT in kernel cputable.c: #if
>defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
>
>Under 2.4, I see it only set depending on CONFIG_SMP
>
>Looking at Programing Environments for 32 bit processors section
>5.2.1.3 about the Memory Coherence Attribute I see the following
>description:
>"When the M attribute is set, and the access is performed to memory,
>there is a hardware indication to the rest of the system that the
>access is global. Other processors affected by the access must then
>respond to this global access signal." Example then follows.
>The M bit allows 2 processors to communicate address acess with each
>other. I don't see where it has anything to do with PCI->memory
>access.
>
>M bit affects the processor asserting Global
>I hope I am missing something here.
>

You're right.  Randy Vinson pointed out to me that what I said about the
M bit was wrong.  Part of it was that I was not understanding what you
were saying.  I was assuming that you were talking about turning cache
coherency on in the cpu but leaving it off on the bridge.  I then went
off into the weeds.  I now understand that you were talking specifically
about the M bit.  So you're right, the erratum shouldn't affect whether
we turn coherency on or off.  Good point.

What I should have said is that if CONFIG_NOT_COHERENT_CACHE is not
defined, we need to set the snoop windows to WB or WT (depending on what
the cpu is set to).  If it is defined, we set it to none (or just
disable the snoop window(s)).  Forget what I said about the M bit, I
agree that should only be an issue in an SMP system.

>
>
>>The point is, the bridge snoop window setting have to match the M bit
>>the processor uses.
>>
>>
>I disagree here. In fact I know that this is not the case. M=1 on SMP
>and M=0 on UP the bridge snoop settings will stay the same. But WB vs
>WT settings must be the same between bridge and CPUs otherwise the
>protocol will be broken.
>

I agree.

>
>
>>>You should be able to boost the IO
>>>throughput using non coherency without this errata impacting you any
>>>more than it already is.
>>>
>>>
>>>
>Long story short I don't think the M bit will affect anything in the
>behaviour a PCI DMA.
>The snoop registers in the bridge certainly will affect behaviour but
>not the other way around.
>
>If I am wrong please let me know :)
>

No, you're right.  What I thought you were saying was that even when you
wanted coherency, we didn't have to enable the snoop windows in the
bridge.  That was what I was taking issue with.  I just wasn't
understanding what you were saying.

I think we're on the same page after all.  Just to make sure, here's a
summary:

1) M=1 is only necessary in an SMP environment (or for the 745x erratum).
2) If CONFIG_NOT_COHERENT_CACHE is not set, we enable snoop windows on
the bridge.
3) If CONFIG_NOT_COHERENT_CACHE is set, we disable snoop windows (or set
to none) on the bridge.

Back to your original comment, I think you're right, we should be able
to turn off the snooping windows and still have M=1 with no problem.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
