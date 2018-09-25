Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K7km0qhvzDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 14:43:59 +1000 (AEST)
Subject: Re: [PATCH] powerpc/traps: merge unrecoverable_exception() and
 nonrecoverable_exception()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
 <875zyu5pr6.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <af93f6f7-b7e7-64a0-b9df-4f1721a567bd@c-s.fr>
Date: Tue, 25 Sep 2018 06:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <875zyu5pr6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/09/2018 à 03:29, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 6ab66a88db14..4567eeb6524e 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -2090,8 +2082,9 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
>>    */
>>   void unrecoverable_exception(struct pt_regs *regs)
>>   {
>> -	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
>> -	       regs->trap, regs->nip);
>> +	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
>> +		 regs->trap, regs->nip, regs->msr);
>> +	debugger(regs);
>>   	die("Unrecoverable exception", regs, SIGABRT);
> 
> die() already calls debugger() if the trap is != 0x100.
> 
> I don't think we want to call it twice?

Oh, good spot. So nonrecoverable_exception() is calling it twice.

I'll fix the patch. Thanks.

Christophe
