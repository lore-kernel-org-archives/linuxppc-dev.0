Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhQ160QmZzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 20:31:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] powerpc/64s: idle POWER9 can execute stop without
 a sync sequence
In-Reply-To: <20170829001110.GD12629@fergus.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-3-npiggin@gmail.com>
 <20170829001110.GD12629@fergus.ozlabs.ibm.com>
Date: Tue, 29 Aug 2017 20:30:37 +1000
Message-ID: <87mv6i1x9u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:
> On Fri, Aug 25, 2017 at 02:30:34PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
>> index 4924647d964d..14e97f442167 100644
>> --- a/arch/powerpc/kernel/idle_book3s.S
>> +++ b/arch/powerpc/kernel/idle_book3s.S
>> @@ -205,6 +205,19 @@ pnv_powersave_common:
>>  	mtmsrd	r7,0
>>  	bctr
>>  
>> +/*
>> + * This is the sequence required to execute idle instructions, as
>> + * specified in ISA v2.07. MSR[IR] and MSR[DR] must be 0.
>> + */
>> +#define ARCH207_IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)		\
>
> We had to do this sequence on POWER7 also, which is architecture
> v2.06.  Thus the comments and the naming (ARCH207_*) are a bit
> misleading here.  The actual code change looks OK.

I'll just drop the name change, I don't think it's crucial. That makes
P9 the special case.

We can come up with a better name or something in future.

Unless Nick objects?

cheers
