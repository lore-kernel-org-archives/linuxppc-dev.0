Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 286B867D25
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 09:40:40 +1100 (EST)
Message-ID: <45510B5E.9000104@ru.mvista.com>
Date: Wed, 08 Nov 2006 01:40:30 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree: respin
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>	
	<4550A5E6.50409@ru.mvista.com> <1162934221.2680.2.camel@barja>	
	<4550F9B8.40901@ru.mvista.com> <1162935862.2680.7.camel@barja>	
	<45510013.8010509@ru.mvista.com> <1162937920.2680.10.camel@barja>
In-Reply-To: <1162937920.2680.10.camel@barja>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Vitaly Wool wrote:
>>    We don't have any actual registers (at least "physmap" doesn't know about 
>>them anyway) I think, just a memory range. What registers are you talking about?

> We do have registers there, in query mode. The CFI registers.

    Aren't they accessed thru the range we're giving to the mapping layer? 
What else do you need? Who cares about the exact offsets at the mapping level 
(or at the level of the bus)?

>>>Okay, probably we can go you way naming of_device by what it's
>>>compatible with. So that "physmap" compatible would be called
>>>"physmap-flash", "nand"-compatible would be called "nand-flash" etc.

>>    Actually, Generic Names spec tells to use the most generic user-parsable 
>>names, just like I used initally ("flash")...

>>>Does that work for you?

>>    No. Getting rid of "physmap" completely and using of_find_node_by_type() 
>>does. :-)

> That's effectively what I'm talking about. Find the device by type and
> register it with the name which depends on what it's compatible with.

    I stand enlightened. It have finally occured to me that this of_device 
stuff wasn't worth the effort of using it and moving the code into 
drivers/mtd/. This move doesn't buy you much -- you still have to walk the 
device tree stupidly in search for the "known" devices... unless you're making 
up the names for of_platform bus like this. And what for? Those names aren't 
used to select the correct driver anyway... Crap. :-(
    We could also try using "device_type" or "name" properties to name the 
of_device -- this name doesn't matter much anyway...

> Vitaly

WBR, Sergei
