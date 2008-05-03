Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 049D3DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 10:01:07 +1000 (EST)
Message-Id: <C7C06232-EB2F-40F5-8742-E95592B084CA@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <481B5F59.8020201@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2.6.26] powerpc: Fix a bunch of sparse warnings in the
	qe_lib
Date: Fri, 2 May 2008 19:00:59 -0500
References: <1209751415-25612-1-git-send-email-afleming@freescale.com>
	<481B5F59.8020201@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 13:37, Timur Tabi wrote:

> Andy Fleming wrote:
>
>> int ucc_fast_init(struct ucc_fast_info * uf_info, struct  
>> ucc_fast_private ** uccf_ret)
>> {
>> 	struct ucc_fast_private *uccf;
>> -	struct ucc_fast *uf_regs;
>> +	struct ucc_fast __iomem *uf_regs;
>> 	u32 gumr;
>> 	int ret;
>>
>> @@ -216,10 +216,10 @@ int ucc_fast_init(struct ucc_fast_info *  
>> uf_info, struct ucc_fast_private ** ucc
>> 	uccf->stopped_tx = 0;
>> 	uccf->stopped_rx = 0;
>> 	uf_regs = uccf->uf_regs;
>> -	uccf->p_ucce = (u32 *) & (uf_regs->ucce);
>> -	uccf->p_uccm = (u32 *) & (uf_regs->uccm);
>> +	uccf->p_ucce = (u32 __iomem *) & (uf_regs->ucce);
>> +	uccf->p_uccm = (u32 __iomem *) & (uf_regs->uccm);
>
> Since you've already made uf_regs into an __iomem pointer, do you  
> really need to
> cast it?

Ah, yes.  That's probably leftover from when uf_regs wasn't __iomem.


>
> And please remember to CC: me on any QE library patches.

Can do.

Andy
