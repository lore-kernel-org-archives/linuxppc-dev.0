Return-Path: <jchapman@katalix.com>
Received: from s36.avahost.net (unknown [74.53.95.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 434BADDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 00:57:45 +1000 (EST)
Message-ID: <46D4376E.3000900@katalix.com>
Date: Tue, 28 Aug 2007 15:55:42 +0100
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
References: <46D2F301.7050105@katalix.com>
	<20070827.145600.102570576.davem@davemloft.net>
	<46D3E971.4010909@katalix.com>
	<200708281348.21302.ossthema@de.ibm.com>
In-Reply-To: <200708281348.21302.ossthema@de.ibm.com>
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
> On Tuesday 28 August 2007 11:22, James Chapman wrote:
>>> So in this scheme what runs ->poll() to process incoming packets?
>>> The hrtimer?
>> No, the regular NAPI networking core calls ->poll() as usual; no timers 
>> are involved. This scheme simply delays the napi_complete() from the 
>> driver so the device stays in the poll list longer. It means that its 
>> ->poll() will be called when there is no work to do for 1-2 jiffies, 
>> hence the optimization at the top of ->poll() to efficiently handle that 
>> case. The device's ->poll() is called by the NAPI core until it has 
>> continuously done no work for 1-2 jiffies, at which point it finally 
>> does the netif_rx_complete() and re-enables its interrupts.
>>
> I'm not sure if I understand your approach correctly.
> This approach may reduce the number of interrupts, but it does so
> by blocking the CPU for up to 1 jiffy (that can be quite some time
> on some platforms). So no other application / tasklet / softIRQ type
> can do anything in between.

I think I've misread the reworked NAPI net_rx_action code. I thought 
that it ran each device ->poll() just once, rescheduling the NET_RX 
softirq again if a device stayed in polled mode. I can see now that it 
loops while one or more devices stays in the poll list for up to a 
jiffy, just like it always has. So by keeping the device in the poll 
list and not consuming quota, net_rx_action() spins until the next jiffy 
tick unless another device consumes quota, like you say.

I can only assume that the encouraging results that I get with this 
scheme are specific to my test setups (measuring packet forwarding 
rates). I agree that it isn't desirable to tie up the CPU for up to a 
jiffy in net_rx_action() in order to do this. I need to go away and 
rework my ideas. Perhaps it is possible to get the behavior I'm looking 
for by somehow special-casing the zero return from ->poll() in 
net_rx_action(), but I'm not sure.

Thanks for asking questions.

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development
