Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3cLC1XNtzDqFk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:22:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Avoid taking a data miss on every userspace
 instruction miss
In-Reply-To: <09625197-3387-eeb6-5f80-5d14d1332b2d@c-s.fr>
References: <20170403064102.23245-1-anton@ozlabs.org>
 <20170403205548.Horde.yvekJnoFaOaIi2_bvtIsLA2@messagerie.c-s.fr>
 <20170404080001.2c03b043@kryten>
 <09625197-3387-eeb6-5f80-5d14d1332b2d@c-s.fr>
Date: Thu, 13 Apr 2017 20:22:40 +1000
Message-ID: <8737dca9ov.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hi Anton,
>
> Le 04/04/2017 =C3=A0 00:00, Anton Blanchard a =C3=A9crit :
>> Hi Christophe,
>>
>>>> -	if (user_mode(regs))
>>>> +	if (!is_exec && user_mode(regs))
>>>
>>> Shouldn't it also check 'is_write' ?
>>> If it is a store, is_write should be set, shouldn't it ?
>>
>> Thanks, Ben had the same suggestion. I'll add that further optimisation
>> in a subsequent patch.
>>
>
> For your information, I made some benchmark test using 'perf stat' with=20
> your app on MPC8321 and MPC885, and I got the following results:

 MPC8321:
 before        47386      faults=20
 after         35181      faults        -12205
 is_write      35181      faults        -12205=20

So that's good.

 MPC885:
 before:      176067      dTLB-load-misses=20
               52722      iTLB-load-misses=20
               25718      faults=20
 after:       152462      dTLB-load-misses    -23605
               52715      iTLB-load-misses        -7
               19611      faults               -6107

 is_write:    147162      dTLB-load-misses    -28905
               52716      iTLB-load-misses        -6
               19610      faults               -6108

Also good, and shows that is_write idea would be even better.

cheers
