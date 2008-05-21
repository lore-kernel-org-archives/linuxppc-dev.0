Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D848DE08B
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:39:02 +1000 (EST)
Message-Id: <F5D33911-1265-4D4F-9D37-D2965120DB77@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Jin Zhengxiong" <Jason.Jin@freescale.com>
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A91586D@zch01exm27.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
Date: Tue, 20 May 2008 22:38:32 -0500
References: <1211270856-26579-1-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
	<177599B6-6236-4292-A69B-CA13617A6576@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A91586D@zch01exm27.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 10:29 PM, Jin Zhengxiong wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, May 20, 2008 9:24 PM
>> To: Jin Zhengxiong
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
>>
>>> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/
>>> powerpc/platforms/86xx/mpc8610_hpcd.c
>>> index dea1320..290d717 100644
>>> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
>>> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
>>> @@ -71,9 +71,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
>>> 	/* Alloc mpic structure and per isu has 16 INT entries. */
>>> 	mpic1 = mpic_alloc(np, res.start,
>>> 			MPIC_PRIMARY | MPIC_WANTS_RESET |
>> MPIC_BIG_ENDIAN,
>>> -			0, 256, " MPIC     ");
>>> +			64, 256, " MPIC     ");
>>> 	BUG_ON(mpic1 == NULL);
>>>
>>> +	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
>>> +	mpic_assign_isu(mpic1, 1, res.start + 0x10800);
>>> +	mpic_assign_isu(mpic1, 2, res.start + 0x11600);
>>> +
>>
>> I don't understand why you are breaking the interrupts up like this.
>>
>> If you leave as it was, the MSIs would start at hw irq 176
>
> If the ISU size is 0, mpic will only initialize the interrupt source  
> num
> reading from
> Feature Reporting Register(FRR), For 8610 it's 104, for 8572 it is  
> 108,
> As the address
> space of the interrupt source configuration register is not
> continuous(between 0xa00-0x1600),
> with ISU=0, actually only the 16 externel interrupts and 64 internal
> interrupts were initialized.
> the Messaging interrupts and MSI interrupts were not intialized.
>
> With the original code. the Messaging interrupts would start at hwirq
> 176 and the MSIs would
> start at hwirq 224.
> By setting the ISU=64, the Messaging interrupts would start at 128 and
> the MSIs start at 176.
> And all the interrupt sources will be initialized.

Yeah, I remember this now.  What about something like:

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8619f2a..90de869 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1251,6 +1251,8 @@ void __init mpic_init(struct mpic *mpic)
         if (mpic->irq_count == 0)
                 mpic->irq_count = mpic->num_sources;

+       mpic->num_sources = max(mpic->num_sources, mpic->irq_count);
+
         /* Do the HT PIC fixups on U3 broken mpic */
         DBG("MPIC flags: %x\n", mpic->flags);
         if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags &  
MPIC_PRIMARY)) {


- k
