Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w38DH6gyZzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 02:15:59 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Avoid taking a data miss on every userspace
 instruction miss
To: Anton Blanchard <anton@samba.org>
References: <20170403064102.23245-1-anton@ozlabs.org>
 <20170403205548.Horde.yvekJnoFaOaIi2_bvtIsLA2@messagerie.c-s.fr>
 <20170404080001.2c03b043@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <09625197-3387-eeb6-5f80-5d14d1332b2d@c-s.fr>
Date: Wed, 12 Apr 2017 18:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170404080001.2c03b043@kryten>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

Le 04/04/2017 à 00:00, Anton Blanchard a écrit :
> Hi Christophe,
>
>>> -	if (user_mode(regs))
>>> +	if (!is_exec && user_mode(regs))
>>
>> Shouldn't it also check 'is_write' ?
>> If it is a store, is_write should be set, shouldn't it ?
>
> Thanks, Ben had the same suggestion. I'll add that further optimisation
> in a subsequent patch.
>
> Anton
>

For your information, I made some benchmark test using 'perf stat' with 
your app on MPC8321 and MPC885, and I got the following results:

MPC8321 before the change:

  Performance counter stats for './fault 1000' (10 runs):

        4491.971466      cpu-clock (msec) 
               ( +-  0.03% )
              47386      faults 
               ( +-  0.02% )

        4.727864465 seconds time elapsed 
          ( +-  0.17% )


MPC8321 after your change:

  Performance counter stats for './fault 1000' (10 runs):

        4278.738845      cpu-clock (msec) 
               ( +-  0.02% )
              35181      faults 
               ( +-  0.02% )

        4.504443891 seconds time elapsed 
          ( +-  0.19% )


MPC8321 after changing !is_exec by is_write

  Performance counter stats for './fault 1000' (10 runs):

        4268.187261      cpu-clock (msec) 
               ( +-  0.03% )
              35181      faults 
               ( +-  0.01% )

        4.489207922 seconds time elapsed 
          ( +-  0.20% )





MPC885 before the change:

  Performance counter stats for './fault 500' (10 runs):

          726605854      cpu-cycles 
               ( +-  0.03% )
             176067      dTLB-load-misses 
               ( +-  0.08% )
              52722      iTLB-load-misses 
               ( +-  0.01% )
              25718      faults 
               ( +-  0.03% )

        5.795924654 seconds time elapsed 
          ( +-  0.14% )


MPC885 after your change:

  Performance counter stats for './fault 500' (10 runs):

          711233251      cpu-cycles 
               ( +-  0.04% )
             152462      dTLB-load-misses 
               ( +-  0.09% )
              52715      iTLB-load-misses 
               ( +-  0.01% )
              19611      faults 
               ( +-  0.02% )

        5.673784606 seconds time elapsed 
          ( +-  0.14% )


MPC885 after changing !is_exec by is_write

  Performance counter stats for './fault 500' (10 runs):

          710904083      cpu-cycles 
               ( +-  0.05% )
             147162      dTLB-load-misses 
               ( +-  0.06% )
              52716      iTLB-load-misses 
               ( +-  0.01% )
              19610      faults 
               ( +-  0.02% )

        5.672091139 seconds time elapsed 
          ( +-  0.15% )



Christophe
