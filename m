Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB83EDDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 14:05:52 +1100 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C0DBE18@zch01exm26.fsl.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE18@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CFFA5AB3-1C2A-4928-AE40-5BA24694AB09@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Wed, 7 Mar 2007 21:04:42 -0600
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 8:09 PM, Zhang Wei-r63237 wrote:

> Hi, Kumar,
>
>>>  	/* Alloc mpic structure and per isu has 16 INT entries. */
>>>  	mpic1 = mpic_alloc(np, res.start,
>>>  			MPIC_PRIMARY | MPIC_WANTS_RESET |
>> MPIC_BIG_ENDIAN,
>>> -			16, NR_IRQS - 4,
>>> +			16, NR_IRQS - 10,
>>>  			" MPIC     ");
>>
>> Why is the number of interrupts reduced by 10?
>
> There's IRQs reserved for mpic using in mpic.c around line 962:
>
> 	mpic->timer_vecs[0] = intvec_top - 8;
> 	mpic->timer_vecs[1] = intvec_top - 7;
> 	mpic->timer_vecs[2] = intvec_top - 6;
> 	mpic->timer_vecs[3] = intvec_top - 5;
> 	mpic->ipi_vecs[0]   = intvec_top - 4;
> 	mpic->ipi_vecs[1]   = intvec_top - 3;
> 	mpic->ipi_vecs[2]   = intvec_top - 2;
> 	mpic->ipi_vecs[3]   = intvec_top - 1;
> 	mpic->spurious_vec  = intvec_top;
>
> So I reduces it by 10 for IRQs reserved (leave 1 more space for
> further).

Why don't we set the number to 64 instead of NR_IRQS - 10.  This  
covers all the internal and external interrupts.

- k
