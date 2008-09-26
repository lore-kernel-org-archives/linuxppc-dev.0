Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B5ECDDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 09:44:30 +1000 (EST)
Message-ID: <48DD73B8.7020201@emcraft.com>
Date: Sat, 27 Sep 2008 03:43:52 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>	
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>	
	<20080912034814.GE22288@yookeroo.seuss>
	<1221328010.7675.21.camel@pasglop>
In-Reply-To: <1221328010.7675.21.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Benjamin,

Benjamin Herrenschmidt wrote:
>> [snip]
>>     
>>> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
>>> index fce2df9..4f802df 100644
>>> --- a/arch/powerpc/kernel/head_booke.h
>>> +++ b/arch/powerpc/kernel/head_booke.h
>>> @@ -20,7 +20,9 @@
>>>  	beq	1f;							     \
>>>  	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
>>>  	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
>>> -	addi	r1,r1,THREAD_SIZE;					     \
>>> +	lis	r11,THREAD_SIZE@h;					     \
>>> +	ori	r11,r11,THREAD_SIZE@l;					     \
>>> +	add	r1,r1,r11;
>>> \
>>>       
>> It would be nice if we could avoid the extra instruction here when the
>> page sizes isn't big enough to require it.
>>     
>
> As a matter of fact, I don't see why THREAD_SIZE should ever need that,
> there is no reason to change the kernel stack size.
>   

Well, this was introduced because of that:

kernel/fork.c [179]:

 max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);

With THREAD_SIZE=8K we will get mempages divided by zero if PAGE_SIZE is 
bigger than 64K. (Well, another reason not to use >64K pages). Not sure 
this is the right way to fix it.

Regards, Ilya.
