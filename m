Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id A7F002C0335
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 03:27:06 +1100 (EST)
Message-ID: <525D6CD4.5090403@c-s.fr>
Date: Tue, 15 Oct 2013 18:27:00 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] powerpc 8xx: Fixing memory init issue with CONFIG_PIN_TLB
References: <201310111256.r9BCuepM006243@localhost.localdomain>
 <OFF3401910.4A8AA6D0-ONC1257C01.0052FC82-C1257C01.00539C55@transmode.se>
In-Reply-To: <OFF3401910.4A8AA6D0-ONC1257C01.0052FC82-C1257C01.00539C55@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 11/10/2013 17:13, Joakim Tjernlund a écrit :
> "Linuxppc-dev"
> <linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org>
> wrote on 2013/10/11 14:56:40:
>> Activating CONFIG_PIN_TLB allows access to the 24 first Mbytes of memory
> at
>> bootup instead of 8. It is needed for "big" kernels for instance when
> activating
>> CONFIG_LOCKDEP_SUPPORT. This needs to be taken into account in init_32
> too,
>> otherwise memory allocation soon fails after startup.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S
> linux-3.11/arch/powerpc/kernel/head_8xx.S
>> --- linux-3.11.org/arch/powerpc/mm/init_32.c   2013-09-02
> 22:46:10.000000000 +0200
>> +++ linux-3.11/arch/powerpc/mm/init_32.c   2013-09-09 11:28:54.000000000
> +0200
>> @@ -213,7 +213,12 @@
>>       */
>>      BUG_ON(first_memblock_base != 0);
>>
>> +#ifdef CONFIG_PIN_TLB
>> +   /* 8xx can only access 24MB at the moment */
>> +   memblock_set_current_limit(min_t(u64, first_memblock_size,
> 0x01800000));
>> +#else
>>      /* 8xx can only access 8MB at the moment */
>>      memblock_set_current_limit(min_t(u64, first_memblock_size,
> 0x00800000));
>> +#endif
>>   }
>>   #endif /* CONFIG_8xx */
> hmm, I think you should always map 24 MB (or less if RAM < 24 MB) and do
> the same
> in head_8xx.S.
>
> Or to keep it simple, just always map at least 16 MB here and in
> head_8xx.S, assuming
> that 16 MB is min RAM for any 8xx system running 3.x kernels.
Yes we could do a more elaborated modification in the future. However it 
also has an impact on the boot loader, so I'm not sure we should make it 
the default without thinking twice.

In the meantime, my patch does take into account the existing situation 
where you have 8Mb by default and 24Mb when you activate CONFIG_PIN_TLB.
I see it as a bug fix and I believe we should include it at least in 
order to allow including in the stable releases.

Do you see any issue with this approach ?

>
> Much of the need for pinning would go away if you adopted my 8MB pages
> from 2.4 to 3.x
>
>     Jocke
>
Christophe
