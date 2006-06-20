Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4357567A6F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 10:39:44 +1000 (EST)
In-Reply-To: <40AABEB6-3467-4AFB-BC7B-08176EDD61E2@freescale.com>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
	<1150759075.23600.297.camel@localhost.localdomain>
	<40AABEB6-3467-4AFB-BC7B-08176EDD61E2@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D442541A-BD06-4641-A251-3D603E32FD4F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Interrupt mapping documentation
Date: Tue, 20 Jun 2006 02:39:27 +0200
To: Becky Bruce <Becky.Bruce@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I haven't specified that it _should_ be called interrupt- 
>> controller, but
>> it's generally called that way at least on chrp/pSeries and I think
>> there's an OF recommended practices RFC that says something around  
>> those
>> lines, so I changed the examples to reflect that.
>
> If there's precedence for it, it's fine with me.  I was just  
> curious about why it changed.  Personally, I'd rather see it as  
> "pic", because that's more specific, and it's the actual device  
> name, but it's not keeping me up at night.....

I'll just say that _I_ care :-)

>> In addition,
>> the default-to-parent thing is something I'll remove from the spec  
>> and
>> write that the absence of the property is undefined I think. We'll  
>> keep
>> the current behaviour in linux for now though.
>
> That also works for me.  I'd rather have to specify more stuff in  
> the tree and have it be crystal clear how it's interpreted and  
> used.  So, is this true for just #address-cells, or does it affect  
> #size-cells as well?

#size-cells defaults to 1, it isn't inherited either.  So same story.

>>>> The additions in the patch specify new requirements that don't seem
>>>> to match up with the statement above.  In the new patch, #address-
>>>> cells is listed as a required node for interrupt-controller nodes,
>>>> there's no mention of inheritance from a parent,
>>>
>>> Inheritance from the parent does not exist, in real OF.  Absence of
>>> #address-cells means "default to 2".  This needs to be fixed in DTC.
>>
>> Yes. Except that I will probably not do the "default to 2". The  
>> kernel
>> doesn't do it and there might still be things relying on the old
>> (broken) linux behaviour. Thus I'll probably spec it as undefined.
>
> Sounds good.  The dtc should probably throw an error (or at least a  
> warning) on this, so the trees get fixed.  I think I'd prefer to  
> see an error - that will keep this problem from propagating any  
> further.

Error please...  If the new DTC spec will require it, it should
be an error.

>>> Just *require* #address-cells for everything with addressable sub- 
>>> nodes,
>>> at least in DTC.  Doesn't cost much, and no confusion anymore.
>>
>> Yes. We should do that.
>
> I agree 100%.

No dissenters anywhere?  Please?  Can't we have a fight?

>> In the case of interrupt controllers/nexus, #address-cells is not for
>> addressable sub-nodes though but for defining the format of unit
>> interrupt specifiers for interrupt-childs which aren't necessary sub
>> nodes... confusing heh ?
>
> Um, yeah :)  I think with a little clarification it will be fine,  
> though.

As long as your interrupt tree is a) completely independent of your bus
tree (and then, only in most cases), or b) completely follows the bus  
tree.

Sigh.

On almost all platforms, this shouldn't cause any real problems, though.


Segher
