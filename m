Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEA5DDE002
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 00:44:49 +1000 (EST)
Message-Id: <2FCBCE91-8B77-4E78-A7F9-D4128980814F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ron Madrid <ron_madrid@sbcglobal.net>
In-Reply-To: <470944.9117.qm@web83514.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Using DMA interrupt on MPC8313
Date: Mon, 16 Jun 2008 09:44:43 -0500
References: <470944.9117.qm@web83514.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What does your code actually look like.  In your driver how are you  
getting the IRQ value that you pass to request_irq?

- k

On Jun 13, 2008, at 6:52 PM, Ron Madrid wrote:

> I don't know why request_irq is succeeding when the fsldma and  
> dmaengine drivers are installed.
> I'm using the same dts in both cases.
>
> Ron
> --- Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> That's a bit odd.  How is your driver getting the IRQ its requesting?
>> Are you using the same .dts in both cases?
>>
>> - k
>>
>> On Jun 13, 2008, at 2:02 PM, Ron Madrid wrote:
>>
>>> So after I've built the kernel to include the dmaengine and fsldma
>>> drivers, my driver is allowed
>>> to register its ISR via request_irq.  However, if these drivers are
>>> not installed then request_irq
>>> fails in my driver.  So it seems that there is some other
>>> initialization happening before
>>> request_irq is being called in fsldma and subsequently my driver.
>>> Does anyone know what this is?
>>>
>>> Ron
>>> --- Kumar Gala <galak@kernel.crashing.org> wrote:
>>>
>>>> The dmaengine provides a generic set of APIs w/a FSL dma  
>>>> backend.  It
>>>> might be the case that your need of dma doesnt fit into the current
>>>> set of APIs.
>>>>
>>>> - k
>>>>
>>>> On Jun 12, 2008, at 3:04 PM, Ron Madrid wrote:
>>>>
>>>>> Well in that case wouldn't I need to use the fsldma driver?  Or is
>>>>> dmaengine a generic dma driver?
>>>>>
>>>>> Ron
>>>>> --- Kumar Gala <galak@kernel.crashing.org> wrote:
>>>>>
>>>>>>
>>>>>> On Jun 12, 2008, at 2:35 PM, Ron Madrid wrote:
>>>>>>
>>>>>>> I'm trying to write a driver that would make use of the DMA on  
>>>>>>> the
>>>>>>> MPC8313.  I'm attempting to
>>>>>>> register the interrupt with request_irq but it is not  
>>>>>>> passing.  Is
>>>>>>> there something that I need to
>>>>>>> do before I call request_irq, maybe in the dts or somewhere  
>>>>>>> else?
>>>>>>
>>>>>>
>>>>>> any reason you aren't using the dmaengine driver?
>>>>>>
>>>>>> - k
>>>>>>
>>>>
>>>>
>>
>>
