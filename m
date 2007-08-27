Return-Path: <jchapman@katalix.com>
Received: from s36.avahost.net (s36.avahost.net [74.53.95.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29B5BDDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 03:05:58 +1000 (EST)
Message-ID: <46D3046A.5090607@katalix.com>
Date: Mon, 27 Aug 2007 18:05:46 +0100
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
References: <46CF127D.1090609@katalix.com>
	<20070826.185815.93042514.davem@davemloft.net>
	<46D2F301.7050105@katalix.com>
	<200708271802.48691.ossthema@de.ibm.com>
In-Reply-To: <200708271802.48691.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, akepner@sgi.com,
	meder@de.ibm.com, shemminger@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> On Monday 27 August 2007 17:51, James Chapman wrote:
> 
>> In the second half of my previous reply (which seems to have been 
>> deleted), I suggest a way to avoid this problem without using hardware 
>> interrupt mitigation / coalescing. Original text is quoted below.
>>
>>  >> I've seen the same and I'm suggesting that the NAPI driver keeps
>>  >> itself in polled mode for N polls or M jiffies after it sees
>>  >> workdone=0. This has always worked for me in packet forwarding
>>  >> scenarios to maximize packets/sec and minimize latency.
>>
>> To implement this, there's no need for timers, hrtimers or generic NAPI 
>> support that others have suggested. A driver's poll() would set an 
>> internal flag and record the current jiffies value when finding 
>> workdone=0 rather than doing an immediate napi_complete(). Early in 
>> poll() it would test this flag and if set, do a low-cost test to see if 
>> it had any work to do. If no work, it would check the saved jiffies 
>> value and do the napi_complete() only if no work has been done for a 
>> configurable number of jiffies. This keeps interrupts disabled longer at 
>> the expense of many more calls to poll() where no work is done. So 
>> critical to this scheme is modifying the driver's poll() to fastpath the 
>> case of having no work to do while waiting for its local jiffy count to 
>> expire.
>>
> 
> The problem I see with this approach is that the time that passes between
> two jiffies might be too long for 10G ethernet adapters. 

Why would staying in polled mode for 2 jiffies be too long in the 10G 
case? I don't see why 10G makes any difference. Your poll() would be 
called as fast as your CPU allows during those 2 jiffies (it would 
actually be between 1 and 2 jiffies in practice). It is therefore 
critical that the driver's poll() implementation is as efficient as 
possible for the "no work" case to minimize the overhead of the extra 
poll() calls. Your poll might be called thousands of times in 1-2 
jiffies with nothing to do...

> (I tried to implement
> a timer based approach with usual timers and the result was a disaster).
> HW interrupts / or HP timer avoid the jiffy problem as they activate softIRQs
> as soon as you call netif_rx_schedule. 

My scheme doesn't use timers to do netif_rx_schedule() because the 
device stays in polled mode for 1-2 jiffies _after_ it detects it has no 
more work. So the device remains scheduled, processing packets as usual. 
The device deschedules itself and re-enables its interrupts only when it 
has a period of 1-2 jiffies of doing no work.

BTW, I chose 2 jiffies in the example patch just to keep the patch 
simple. It might be more for systems with large HZ or those that want to 
be even more aggressive at staying in polled mode. I envisage it being 
another parameter that can be tweaked using ethtool if people see a 
benefit of this scheme.

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development
