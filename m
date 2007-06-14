Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4671390D.1060606@ru.mvista.com>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
	<4671390D.1060606@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f5cc841be768a8d34e7278a8d221b97@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 14 Jun 2007 15:18:05 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> So, what you're suggesting is a subnode for each described partition?
>
>> I'm saying this is a reasonable way to describe the regions
>> of flash the firmware itself cares about.
>
>> This isn't anything new; it is done like this on some
>> Apple systems, for example.
>
>    First you're saying that nodes should correspont to *real* devices, 
> then it turns out that there have been precedents for the nodes 
> corresponding to completely virtual entities? ;-)

Every physical device should have its own node (there
_can_ be exceptions, but if you can help it at all...)

There can be virtual devices as well, although you don't
often need or want them.  There are a few pseudo-nodes
too, not representing _any_ device, physical or virtual.

>>> Seems an awfully verbose way of going about it,
>
>> Not verbose, but flexible, and in line with everything
>
>    Yes, I'd agree about more flexibility...

Good to hear :-)

>> else about the device tree.
>
>    How about your earlier arguments against the representation of 
> flashes?

What arguments, exactly?  Perhaps you're not understanding
exactly what I meant, or perhaps I changed my mind -- that
happens sometimes, after long discussions.  That is what
those discussions are for, even -- only after looking at
every detail, and discussing all those details with other
people, including non-experts on OF who can bring in valuable
concerns about use cases etc.; only then can a good device
binding be defined.  Sometimes also it should be concluded
there is not enough experience yet on how to do a certain
device binding; in such a case, the best course of action is
usually to _not_ define such a binding yet.

>>> and I don't see what
>>> it buys us over the partitions/partition-names pair of properties.
>
>> It is extensible.  It makes parsing trivial.  It
>
>    Excellent -- previously my arguments about more simplicity for 
> representing  flash itself were sent to /dev/null.

Do you like my proposed CFI binding?  I need a bit more
input on how to do a JEDEC flash binding still.  After
I've written it all up properly, I plan to send this to
the OF working group to turn it into a standard binding.

>> represents a flash partition in a way similar to how
>> a "whole" flash device is represented.
>
>    Except it's not a device. :-)

Yes, but in many aspects it can be treated as one.  And
it cannot be mistaken for one, either.


Segher
