Return-Path: <dvhltc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E595CB7D2F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 00:39:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4KEc82x005301
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 08:38:08 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4KEdYiT065222
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 08:39:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4K7dStG023182
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 01:39:29 -0600
Message-ID: <4BF5499F.8050203@us.ibm.com>
Date: Thu, 20 May 2010 07:39:27 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
	<1274319248.22892.40.camel@concordia>
	<OF17F8F35C.B09E4797-ONC1257729.0028292D-C1257729.0029E9AC@de.ibm.com>
	<alpine.LFD.2.00.1005200950410.3368@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1005200950410.3368@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jan-Bernd Themann <THEMANN@de.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Doug Maxey <doug.maxey@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2010 01:14 AM, Thomas Gleixner wrote:
> On Thu, 20 May 2010, Jan-Bernd Themann wrote:
>>>> Thought more about that. The case at hand (ehea) is nasty:
>>>>
>>>> The driver does _NOT_ disable the rx interrupt in the card in the rx
>>>> interrupt handler - for whatever reason.
>>>
>>> Yeah I saw that, but I don't know why it's written that way. Perhaps
>>> Jan-Bernd or Doug will chime in and enlighten us? :)
>>
>>  From our perspective there is no need to disable interrupts for the
>> RX side as the chip does not fire further interrupts until we tell
>> the chip to do so for a particular queue. We have multiple receive
>
> The traces tell a different story though:
>
>      ehea_recv_irq_handler()
>        napi_reschedule()
>      eoi()
>      ehea_poll()
>        ...
>        ehea_recv_irq_handler()<---------------- ???
>          napi_reschedule()
>        ...
>        napi_complete()
>
> Can't tell whether you can see the same behaviour in mainline, but I
> don't see a reason why not.

I was going to suggest that because these are threaded handlers, perhaps 
they are rescheduled on a different CPU and then receive the interrupt 
for the other CPU/queue that Jan was mentioning.

But, the handlers are affined if I remember correctly, and we aren't 
running with multiple receive queues. So, we're back to the same 
question, why are we seeing another irq. It comes in before 
napi_complete() and therefor before the ehea_reset*() block of calls 
which do the equivalent of re-enabling interrupts.

--
Darren

>
>> queues with an own interrupt each so that the interrupts can arrive
>> on multiple CPUs in parallel.  Interrupts are enabled again when we
>> leave the NAPI Poll function for the corresponding receive queue.
>
> I can't see a piece of code which does that, but that's probably just
> lack of detailed hardware knowledge on my side.
>
> Thanks,
>
> 	tglx


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
