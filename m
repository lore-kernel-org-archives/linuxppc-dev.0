Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5691DDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:37:18 +1100 (EST)
In-Reply-To: <17834.47158.581922.62728@cargo.ozlabs.ibm.com>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <37cdcd37b9252ee18fa458b22e8bdd60@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Date: Mon, 15 Jan 2007 00:32:18 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Please apply for 2.6.20.  If an atomic counter is explicitly set to a
>> negative value the atomic_dec_if_positive function will decrement and
>> store the next smallest value in the atomic counter contrary to it's
>> intended operation.
>
> [snip]
>
>>  	__asm__ __volatile__(
>>  	LWSYNC_ON_SMP
>>  "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
>> +	extsw	%0,%0\n\
>>  	addic.	%0,%0,-1\n\
>>  	blt-	2f\n"
>>  	PPC405_ERR77(0,%1)
>
> NAK: Good fix for 64-bit, but it will break 32-bit.  I think a better
> fix would be to use a cmpwi after the lwarx, and use addi rather than
> addic..

Instead of the "extsw %0,%0" you could do "rlwinm %0,%0,0,0,31"
but I guess it's not worth it.

What is this function supposed to do if it gets 0x80000000 as
input btw?  The current code happily makes it 0x7fffffff as
far as I can see?  The "rlwinm" thing would fix that ;-)  (Or
unfix, if the current behaviour is intended).


Segher
