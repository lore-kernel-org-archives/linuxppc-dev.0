Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D3D0DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 01:10:38 +1000 (EST)
Message-Id: <779A7F07-8988-47A2-85BF-B92FF33A8935@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1220390478.13010.163.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Date: Wed, 3 Sep 2008 10:10:28 -0500
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<1220246399.13010.25.camel@pasglop>
	<44677536-2308-40AF-8844-7192489664B9@freescale.com>
	<1220390478.13010.163.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 2, 2008, at 4:21 PM, Benjamin Herrenschmidt wrote:

>
>> The reason I did that was to distinguish between the size of a
>> software PTE entry, and the actual size of the hardware entry.  In  
>> the
>> case of 36b physical, the hardware PTE size is the same as it always
>> is; but we've grown the Linux PTE.  We can call it something else, or
>> I can change as you suggest; I was worried that the next person to
>> come along might get confused.  I suppose there aren't too many of us
>> that are crazy enough to muck around in this code, so maybe it's not
>> that big of a deal.
>
> We already called "PTE" the linux entry everywhere so hopefully there
> should be no confusion. We call "HPTE" the hash table ones.

Actually, PTE_SIZE is already defined in hash_low_32.S, and it's the  
size of the HPTE.  I'll rename that to HPTE_SIZE and use PTE_SIZE for  
the linux PTE.

-Becky
