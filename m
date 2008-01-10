Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1E53DDFF2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 17:03:01 +1100 (EST)
Message-Id: <354E8B44-78B4-49DF-8DCF-5E70BB982E86@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <478525E7.3060106@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Fix handling of memreserve if the range lands
	in highmem
Date: Thu, 10 Jan 2008 00:02:22 -0600
References: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
	<20080109185349.GC4337@loki.buserror.net>
	<3B831CF0-E978-42E7-BA26-7598BC27A5F6@kernel.crashing.org>
	<478520E4.1050204@freescale.com>
	<9536E0AC-E4D2-4E86-8DC6-F40A322FC817@kernel.crashing.org>
	<478525E7.3060106@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 1:52 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> I'm thinking I'll add something like:
>>                if (addr < total_lowmem)
>>                        reserve_bootmem(lmb.reserved.region[i].base,
>>                                         
>> lmb_size_bytes(&lmb.reserved, i));
>> +               else if (lmb.reserved.region[i].base >  
>> total_lowmem) {
>
> less than, surely?

damn, why didn't I see your email before a spent 20 minutes debugging  
this ;)

>> +                       unsigned long adjusted_size;
>> +//                     adjusted_size = xxx;
>> need to figure out the math here.
>
> Wouldn't it just be total_lowmem - lmb.reserved.region[i].base?

yep, but that required my brain to have enough time to think about this.

- k
