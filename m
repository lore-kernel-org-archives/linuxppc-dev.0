Message-ID: <3CF64E9C.60303@mvista.com>
Date: Thu, 30 May 2002 09:09:00 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
References: <20020529030838.GZ16537@zax>	<3CF4E842.3070207@embeddededge.com> <15605.24191.948013.249297@argo.ozlabs.ibm.com> <3CF581BE.8020207@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> Paul Mackerras wrote:
>
>
>> I suspect we are all confusing two things here: (1) having pinned TLB
>> entries and (2) using large-page TLB entries for the kernel.
>
>
> I wasn't confusing them :-).  I know that large page sizes are
> beneficial.
> Someday I hope to finish the code that allows large page sizes in the
> Linux page tables, so we can just load them.
>
>> We could have (2) without pinning any TLB entries but it would take
>> more code in the TLB miss handler to do that.
>
>
> Only on the 4xx.  I have code for the 8xx that loads them using the
> standard lookup.  Unfortunately, I have found something that isn't quite
> stable with the large page sizes, but I don't know what it is.
>
>
>> ....  It is an interesting
>> question whether the benefit of having the 64th TLB slot available for
>> applications would outweigh the cost of the slightly slower TLB
>> misses.
>
>
> Removing the entry will increase the TLB miss rate by 1/64 * 100 percent,
> or a little over 1.5%, right?  Any application that is thrashing the TLB
> cache by removing one entry is running on luck anyway, so we can't
> consider
> those.  When you have applications using lots of CPU in user space (which
> is usually a good thing :-), increased TLB misses will add up.
>
>> .... My feeling is that it would be a close-run thing either way.
>
>
> So, if you have a product that runs better one way or the other, just
> select the option that suits your needs.  If the 4xx didn't require the
> extra code in the miss handler to fangle the PTE, large pages without
> pinning would clearly be the way to go (that's why it's an easy decision
> on 8xx and I'm using it for testing).
>
>> Were you using any large-page TLB entries at all?
>
>
> Yes, but the problem was taking the tlb hit to get the first couple of
> pages loaded and hitting the hardware register in time.  It was a hack
> from the first line of code :-)  If you are going to pin a kernel entry,
> you may as well map the whole space.  I don't think it would even work
> if we were loading large pages out of the PTE tables.
>
>> .... Tom Rini mentioned the other day that some 8xx processors
>> only have 8 (I assume he meant 8 data + 8 instruction).
>
>
> Yes, there are a number of variants now that have everything from 8 to
> 64 I believe.  It was just easier to pick out the 860 (which always has
> lots of entries) for testing purposes.
>
> The 8xx also has hardware support for pinning entries that basically
> emulates BATs.  It doesn't require any software changes except for
> the initial programming of the MMU control and loading of the pinned
> entries.
>
>> .... David's suggestion was purely in the context of the 405
>> processor, which has 64.
>
>
> There is an option to enable it, so just enable it by default.  What
> do you gain by removing the option, except the possibility to prevent
> someone from using it when it may be to their benefit?  It certainly
> isn't a proven modification, as there may be some latent bugs associated
> with dual mapping pages that may be covered by the large page and
> some other mapping (I think this is the problem I see on the 8xx).


btw, there are bugs with it.  Starting several processes with init or
even telnetd will expose the bug.

>
>
>> ....  (actually, why is there the "860
>> only" comment in there?)
>
>
> Because the MMU control registers are slightly different among the 8xx
> processor variants, and I only wrote the code to work with the 860 :-)
>
> Thanks.
>
>
>     -- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
