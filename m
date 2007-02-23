Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 3BDE6DDE26
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 02:22:40 +1100 (EST)
Message-ID: <45DF0696.80301@smiths-aerospace.com>
Date: Fri, 23 Feb 2007 10:21:58 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt: a fix but still broken
References: <45DD9A41.7060900@smiths-aerospace.com>
	<20070223034734.GA18698@localhost.localdomain>
	<E1HKc1x-0001ze-0b@jdl.com>
In-Reply-To: <E1HKc1x-0001ze-0b@jdl.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
>> On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
>>> Hi Dave,
>>>
>>> I have good news and bad news. ;-)  The good news is that the 
>>> incompatibility between libfdt and jdl's dtc is that libfdt has the name 
>>> offset and the length of the name switched.  booting_without_of.txt says 
>>> the length comes first, so libfdt is in the wrong.
>> Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
>> came from: I was looking at flat_dt.h from dtc, which also gets this
>> wrong (but the declaration in question is unused).  Of course, I also
>> wrote flat_dt.h ...
>>
>>> The bad news is that, when I fix this, nearly all of the tests fail (but 
>>> they fail the same way for both tree.S and jdl's dtc).  I have not 
>>> started on that layer of the onion yet.
>> Found it, there was a direct use of the position of the length in
>> _fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
>> along with some other small fixes which I found while tracking this
>> one down.
>>
>> Oh, incidentally, I applied your patch by eye rather than with
>> patch(1), which was handy, because it appears to have been whitespace
>> damaged.
> 
> And amidst all of this, is there an actual DTC change needed?
> I've not detected one yet, but I'm watching... :-)
> 
> jdl

Hi Jon,

Your dtc is the "gold standard."  Gold doesn't tarnish.  ;-)

David's libfdt supports version 17 that dtc doesn't - I'm not sure where 
version 17 came from, David or elsewhere.  Version 17 adds one more size 
to the blob header structure and is suppose to be backward compatible 
with version 16. (A couple of the current libfdt tests fail when run 
against a dtc-generated version 16 blob - don't know where the fault 
lies yet.)

Best regards,
gvb
