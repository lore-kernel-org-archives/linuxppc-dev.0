Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1116987700.6395.64.camel@gaston>
References: <1116987700.6395.64.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <362472e35e6672011614c2710183e778@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 24 May 2005 21:30:32 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 24, 2005, at 9:21 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2005-05-24 at 21:17 -0500, Kumar Gala wrote:
>> On May 24, 2005, at 8:30 PM, Benjamin Herrenschmidt wrote:
>>
>>> As the subject says ... it's the source of endless headaches, is
> used
>>> in
>>> a way that often prevents moving TASK_SIZE freely, etc etc etc...
>>>
>>> What are the good and unavoidable uses of it currently that cannot
> be
>>> replaced by some sort of ioremap ?
>>
>> Do you propose to fixup ioremap to allocate large page resources (BATs
>
>> and CAMs) going forward?
>
> Do we really ever need them for anything but RAM mapping ?

The only case I could thing of are embedded frame buffers across some 
bus like PCI.  An example would be a image buffer that a printing 
application may use.

>>> (Note that if the answer to the above is: page tables exist too
> late, I
>>> already have a reply: our initialisations happen too early, let's
> move
>>> things around so that ioremap is useable... pretty much everything
>>> needed to setup kernel page tables & have working ioremap can be
> done
>>> without any HW device access so ...)
>>
>> Do you have any proposed solution for early console access?  I'm
>> guessing that most of the need for early access is for some sort of
>> console (serial) for early debug output.
>
> How do we implement io_block_mapping() on CPUs without a hash table ? 
> We
> need page tables for these so we can have ioremap working. On CPUs with
> a hash, we could just shove entries in the hash... though we may need a
> mecanism to bolt them or convert those mappings to page tables once
> those are available.

I know what I've done in the past is either steal a BAT (83xx) or CAM 
(85xx) entry and then free it up when a proper ioremap can be done 
later.

>> Also does this mean we would drop ppc_md.setup_io_mappings() complete?
>
> Does it really make sense ? I always disliked it.

No, as far as a can tell doing a quick glance if we drop 
io_block_mapping than we can drop setup_io_mappings().

- kumar
