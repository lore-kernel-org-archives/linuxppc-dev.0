Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (unknown [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id C582B679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Feb 2006 05:12:47 +1100 (EST)
Date: Fri, 17 Feb 2006 11:12:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: scatter/gather DMA and cache coherency
Message-ID: <20060217181237.GG16247@mag.az.mvista.com>
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
	<20060216174655.GC16848@mag.az.mvista.com>
	<kwaccqbwyw.fsf@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kwaccqbwyw.fsf@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Phil,

On Fri, Feb 17, 2006 at 11:52:31AM +1030, Phil Nitschke wrote:
> >>>>> "MAG" == Mark A Greer <mgreer@mvista.com> writes:

<snip>

>   MAG> It would have been useful if you had given the actual hardware
>   MAG> you're using.
> 
> Processor: http://www.artesyncp.com/products/PmPPC7448.html

Okay but since its a ppmc module, the motherboard its installed on would
be useful info too.  Don't worry about it now, more for future reference.

>   MAG> For the record, don't assume that this is Artesyn's fault.
>   MAG> Artesyn says that the erratum workaround is impractical and they
>   MAG> may be right.  I don't know, I just write software...
> 
> I don't know either.  I don't have a problem with Artesyn; they've
> always been nice to me ;-)  Here's what one of their engineers had to
> say on the topic:
> 
>   Artesyn> I stated in a previous email that our boards must have the
>   Artesyn> CONFIG_NOT_COHERENT_CACHE option turned on.  This is because
>   Artesyn> or our history with the Discovery family of bridges.
>   Artesyn> Initially it was reported that the hardware cache coherency
>   Artesyn> (snooping) was known to be not functional.  Then at a later
>   Artesyn> date when it was supposed to be fixed, we found that it was
>   Artesyn> not completely dependable so Artesyn has taken a stance to
>   Artesyn> not trust snooping on the Discovery chips and to always use
>   Artesyn> software cache coherency methods.

Yep.  I didn't mean to implicate Artesyn.  Marvell bridges [so far] have
all had problems with coherency so I definitely believe what's written
above.

>   >> So if I understand my situation correctly, the device driver must
>   >> use software-enforced coherency to avoid data corruption.  Is this
>   >> correct?
> 
>   MAG> It looks like Eugene is guiding you on this.  Listen to him.  I
>   MAG> will add that you should align your buffers on cacheline
>   MAG> boundaries and make the allocation sizes multiples of the
>   MAG> cacheline size otherwise you could have other data sharing the
>   MAG> first and/or last cacheline of your buffers and mess up your
>   MAG> software cache mgmt.
> 
> It might well be that the third party driver isn't enforcing the
> cacheline boundary alignment.

If it isn't, then you have a bug and it will bite you.

> Artesyn tell me that "it is stated in the
> MV64460 Users Manual that when interfacing cache coherent DRAM or
> integrated SRAM, the maximum write burst size must be set to 32 bytes".

Yes, but you [should] have coherency off so this isn't an issue for you.

> So I guess this is that cacheline size?

Correct, the cacheline size of the 7448 is 32 bytes.

> Anyway, we don't see any
> corruption when the DMA buffer size is 32 bytes, but we do see it for 24
> bytes, 36 bytes, etc.

This sounds like what I was referring to.  Do you see the problem?

If you have some other data in the same cacheline as your buffers
(or buffer descriptors) then whenever that other data is read/written
you have the potential for it to screw up the manual cache mgmt you
*thought* you did for your buffers/buf desc's.

Mark
