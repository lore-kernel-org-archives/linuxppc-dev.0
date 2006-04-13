Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 39A50679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 07:45:18 +1000 (EST)
In-Reply-To: <1144961737.4935.28.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<1144961737.4935.28.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7A11372-61BF-4EF7-9869-62B0FD5D8F44@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Date: Thu, 13 Apr 2006 16:46:25 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2006, at 3:55 PM, Benjamin Herrenschmidt wrote:

>
>>
>> The above code should really look like this:
>>
>>          mfmsr   r7
>>          ori     r7,r7,MSR_EE
>>          oris    r7,r7,MSR_POW@h
>>          sync
>>          isync
>>          mtmsr   r7
>>          isync
>> label:
>>          b label
>> 	blr
>
> Ohhh ... we always assumed mtmsr with MSR_POW was
> immediate/synchronous ! That explains a lot. The problem with the  
> above
> though is that we'll never get out unless we also hack the exception
> path to change the return address once an exception happens. It's not
> that difficult especially since we already have a special case to  
> handle
> returning from NAP there, on ppc32 at least. ppc64 will need a bit  
> more
> investigation.
>

Agreed, this is yuck :(

> Do you see another way to loop until NAP has gone ? Maybe reading  
> msr in
> a loop until POW gets cleared would do the trick ?

So, it makes sense to me that this would work, but I suspect there  
may be hardware wierdness - the user manual is very specific about  
the code sequence that should be used (although I've given you a  
slightly different sequence in my last mail that is also known to  
work and is cleaner, IMHO).  Let me check with one of our HW  
designers to see if this is OK.  It might be tomorrow before I have  
an answer - it's after 4:30 here and some of them are early birds,  
and might have already left for the day.

FYI, the user's manual recommends this sequence:
loop:
       sync
       mtmsr POW
       isync
       b     loop

>
>> Hope this helps - I don't have hardware to test this on, so I can't
>> be sure, but it seems to explain the behavior you're seeing if I'm
>> understanding the problem correctly.
>
> It definitely does ! Thanks a lot.
>

NP.

Cheers!
-B
