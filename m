Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8B17DDEBD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 13:41:04 +1000 (EST)
In-Reply-To: <C75BA37F-82D2-4520-9898-D7BE9A0C4F9C@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.!
	! org> <11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
	<11852238411823-git-send-email-galak@kernel.crashing.org>
	<1185241693.5439.194.camel@localhost.localdomain>
	<C75BA37F-82D2-4520-9898-D7BE9A0C4F9C@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FCAC4384-F100-4C80-B8CC-70474178110A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 19/25] [POWERPC] 85xxCDS: Allow 8259 cascade to share an
	MPIC interrupt line.
Date: Mon, 23 Jul 2007 22:41:49 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 23, 2007, at 9:47 PM, Kumar Gala wrote:

>
> On Jul 23, 2007, at 8:48 PM, Benjamin Herrenschmidt wrote:
>
>> On Mon, 2007-07-23 at 15:50 -0500, Kumar Gala wrote:
>>> --- a/arch/powerpc/sysdev/mpic.c
>>> +++ b/arch/powerpc/sysdev/mpic.c
>>> @@ -836,6 +836,7 @@ static struct irq_chip mpic_irq_chip = {
>>>         .mask           = mpic_mask_irq,
>>>         .unmask         = mpic_unmask_irq,
>>>         .eoi            = mpic_end_irq,
>>> +       .end            = mpic_unmask_irq,
>>>         .set_type       = mpic_set_irq_type,
>>>  };
>>
>> Nope, that doesn't look correct and shouldn't be in this patch in the
>> first place.
>>
>> end() is flow control business, not chip business, so it's really
>> something that needs to be fixed in the fasteoi handler for -rt I
>> suppose.
>
> Ok, I dropped this one for now.

Just dropped the mpic.c change.

- k
