Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28C42DDE39
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 10:51:35 +1100 (EST)
In-Reply-To: <20071109231927.GA19415@lixom.net>
References: <11946460863124-git-send-email-becky.bruce@freescale.com>
	<20071109231927.GA19415@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <260A8045-7F86-46EC-9242-08BC2669890F@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Avoid unpaired stwcx. on some processors
Date: Fri, 9 Nov 2007 17:52:30 -0600
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 9, 2007, at 5:19 PM, Olof Johansson wrote:

> On Fri, Nov 09, 2007 at 04:08:06PM -0600, Becky Bruce wrote:
>> The context switch code in the kernel issues a dummy stwcx. to  
>> clear the
>> reservation, as recommended by the architecture. However, some  
>> processors
>> can have issues if this stwcx to address A occurs while the  
>> reservation
>> is already held to a different address B.  To avoid this problem,  
>> the dummy
>> stwcx. needs to be paired with a dummy lwarx to the same address.
>>
>> This patch adds the dummy lwarx, and creates a cpu feature bit to  
>> indicate
>> which cpus are affected. Tested on mpc8641_hpcn_defconfig in arch/ 
>> powerpc;
>> build tested in arch/ppc.
>
> You're still exposed even with this patch. The stwcx is there to  
> protect
> from the cases where process 1 does lwarx and get context switched
> out to process 2 that by pure random chance does a stwcx. to the same
> reservation granule and succeeds, in spite of not having done the  
> lwarx
> (on this side of the context switch).

> In exactly that case, process 2 will instead of doing a store to a
> reservation it didn't take on it's own, do a dangling stwcx, which is
> your erratum. Right?

I don't think so. It's not plain old dangling stwcx that's the  
problem.  It's dangling stwcx when the reservation is held to another  
address.  The lwarx that I've added prevents the normally dangling  
stwcx. in the context switch/syscall  path from meeting this  
condition.  Any process that gets swapped in and executes stwcx.  
first thing is fine, because the reservation was previously cleared  
by the stwcx. in the context switch path.

BTW, I think you're missing a key point here, which is this:  
Architecturally, there is a single reservation per core.  On e600 and  
other parts, the stwcx. does *not* take the address into account for  
success.  If you stwcx, and the reservation is held, it succeeds  
regardless of the address.   Fun, no?   That's one of the reasons  
it's so important that the kernel have the dummy stwcx. in place.

Does that make sense?
-B
