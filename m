Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A15CDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 06:43:51 +1100 (EST)
Message-Id: <B6F01D86-7B36-40E8-9440-CA371B08B1C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081027.112823.178324048.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
Date: Mon, 27 Oct 2008 14:43:29 -0500
References: <4903A37A.50607@hypersurf.com>
	<20081025.210513.80339263.davem@davemloft.net>
	<4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
Cc: kevdig@hypersurf.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 1:28 PM, David Miller wrote:

> From: "Chris Friesen" <cfriesen@nortel.com>
> Date: Mon, 27 Oct 2008 11:36:21 -0600
>
>> David Miller wrote:
>>> From: Kevin Diggs <kevdig@hypersurf.com>
>>> Date: Sat, 25 Oct 2008 15:53:46 -0700
>>>
>>>> What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
>>>> thing supposed to be able to spread irq between its cpus?
>>> Networking interrupts should lock onto a single CPU,  
>>> unconditionally.
>>> That's the optimal way to handle networking interrupts, especially
>>> with multiqueue chips.
>>
>> What about something like the Cavium Octeon, where we have 16 cores  
>> but a single core isn't powerful enough to keep up with a gigE  
>> device?
>
> Hello, we either have hardware that does flow seperation and has  
> multiple RX queues
> going to multiple MSI-X interrupts or we do flow seperation in  
> software (work
> in progress patches were posted for that about a month ago, maybe  
> something final
> will land in 2.6.29)
>
> Just moving the interrupt around when not doing flow seperation is as
> suboptimal as you can possibly get.  You'll get out of order packet
> processing within the same flow, TCP will retransmit when the
> reordering gets deep enough, and then you're totally screwed
> performance wise.

I haven't been following the netdev patches, but what about HW that  
does flow separation w/o multiple interrupts?

We (Freescale) are working on such a device:

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?fastpreview=1&code=P4080

- k
