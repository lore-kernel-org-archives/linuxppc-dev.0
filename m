Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 487FFDDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 19:40:00 +1100 (EST)
Received: from [192.168.1.37] (66-81-70-236.bayarea.dialup.o1.com
	[66.81.70.236]) (authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mAH8cjqp039387
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 00:39:50 -0800 (PST)
Message-ID: <49212D61.3080305@hypersurf.com>
Date: Mon, 17 Nov 2008 00:37:53 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: pmac_zilog debugging ...
References: <4914B549.9010805@hypersurf.com>	
	<1226096603.13603.74.camel@pasglop>
	<491C11B2.1060909@hypersurf.com>	
	<1226612654.7178.84.camel@pasglop> <491CAA32.20307@hypersurf.com>
	<1226624429.7178.105.camel@pasglop>
In-Reply-To: <1226624429.7178.105.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-11-13 at 14:29 -0800, Kevin Diggs wrote:
> 
>>Benjamin Herrenschmidt wrote:
>>
>>>On Thu, 2008-11-13 at 03:38 -0800, Kevin Diggs wrote:
>>>
>>>
>>>
>>>>12,206 PowerMac Zilog interrupts
>>>>
>>>>Interrupt load is higher without the DMA support.
>>>>
>>>>Is it possible that this hardware was not meant to be used without the
>>>>DMA (i.e. it does not work quite right?)?
>>>
>>>
>>>Well, the HW Rx buffer is only 3 bytes so if you have high interrupt
>>>latencies you are more likely to loose data...
>>>
>>
>>These are not real 8530s any more, right? How certain are we of this?
>>Is it possible that there is a larger buffer when used with the DMA
>>capability ... somehow?
> 
> 
> Well, the main thing is that when using DMA, it doesn't need to wait for
> the kernel to come fetch the bytes, and thus the only latency that
> matters if the DMA list is appropriately provisioned is the bus latency,
> which is much less likely to be an issue even with a small buffer.
> 
"... if the DMA list is appropriately provisioned ..." ???

> It's definitely not a "basic" 8530, it's an ESCC but I don't think the
> base rx buffer in polled mode is any bigger (I may be wrong).
> 
Any idea how we might find out?
> 
>>I tried to put some debug statements where the flow lines are managed. I
>>could have goofed it up. They never produce any output. The latest
>>attempt used nortscts which should have disabled flow control. That
>>coupled with the fact that a 250 MHz 750GX is talking to a 486dx4 at
>>1200 - 9600 baud I would have thought would reduce the chance the PowerMac
>>would fall behind?
> 
> 
> Have you disabled flow control both with the old macserial -and-
> pmac_zilog and still experiencing the same problems ? (ie one works and
> the other one doesn't ?)
> 
I reinstalled the disk with 2.4.31 and reran the tests. With "nortscts" added to
the pppd options macserial still works fine. Even at 115,200 it seemed fine (I
expected to see some type of packet errors via pppstats or ifconfig). I did not,
however, verify that pppd actually does something with this option.

I can't get pmac_zilog to work even at 1200 baud. That is pretty slow.
> 
>>You would need to explain to me the advantage of doing DMA in this case???
> 
> 
> Well, if I setup for example 128 DMA descriptors for 1 byte each, then
> the chip will be able to DMA up to 128 bytes without CPU intervention,
> thus is a -lot- less likely to overflow it's fifo. It's essentially a
> way to have the DMA engine operate as an external FIFO. As the CPU
> fetches the bytes, it can recycle the descriptors at the end of the list
> effectively acting as some kind of ring buffer.
> 
> We can more easily do DMA for Tx but while this can improve performances
> and lower interrupt usage, it is not a correctness issue in the sense
> that Tx isn't -losing- data today, it's Rx that is a potential problem.
> 
Ah! I think I get it. I was thinking that cpu intervention would be required after
each byte. But the descriptors are more like linked commands for the DMA
hardware. So, I'm on board with this approach. Since I don't really know what I am
doing, how do you recommend I proceed?

Would it be correct to say that DMA would also free the cpu from doing io accesses
which are MUCH slower than normal memory acdcesses?

> Cheers,
> Ben.
> 
> 
> 
