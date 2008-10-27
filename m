Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 47311DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 06:11:03 +1100 (EST)
Message-ID: <4906123F.7020802@nortel.com>
Date: Mon, 27 Oct 2008 13:10:55 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
References: <4903A37A.50607@hypersurf.com>
	<20081025.210513.80339263.davem@davemloft.net>
	<4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
In-Reply-To: <20081027.112823.178324048.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: "Chris Friesen" <cfriesen@nortel.com>

>> What about something like the Cavium Octeon, where we have 16 cores but a
>> single core isn't powerful enough to keep up with a gigE device?
> 
> Hello, we either have hardware that does flow seperation and has multiple
> RX queues going to multiple MSI-X interrupts or we do flow seperation in
> software (work in progress patches were posted for that about a month ago,
> maybe something final will land in 2.6.29)

Are there any plans for a mechanism to allow the kernel to figure out (or be 
told) what packets cpu-affined tasks are interested in and route the 
interrupts appropriately?

> Just moving the interrupt around when not doing flow seperation is as 
> suboptimal as you can possibly get.  You'll get out of order packet 
> processing within the same flow, TCP will retransmit when the reordering
> gets deep enough, and then you're totally screwed performance wise.

Ideally I agree with you.  In this particular case however the hardware is 
capable of doing flow separation, but the vendor driver doesn't support it 
(and isn't in mainline).  Packet rates are high enough that a single core 
cannot keep up, but are low enough that they can be handled by multiple cores 
without reordering if interrupt mitigation is not used.

It's not an ideal situation, but we're sort of stuck unless we do custom 
driver work.

Chris
