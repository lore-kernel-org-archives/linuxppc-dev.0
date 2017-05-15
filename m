Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRFWP476pzDqMV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 19:23:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Breno Leitao <brenohl@br.ibm.com>,
 Gustavo Bueno Romero <gromero@br.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/tm: Fix FP and VMX register corruption
In-Reply-To: <1494602774.21781.3.camel@gmail.com>
References: <20170508071627.21851-1-mikey@neuling.org>
 <1494602774.21781.3.camel@gmail.com>
Date: Mon, 15 May 2017 19:23:44 +1000
Message-ID: <874lwmbhi7.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:

> On Mon, 2017-05-08 at 17:16 +1000, Michael Neuling wrote:
>> In this commit:
>>   commit dc3106690b20305c3df06b42456fe386dd632ac9
>>   Author: Cyril Bur <cyrilbur@gmail.com>
>>   powerpc: tm: Always use fp_state and vr_state to store live registers
>> 
>> A section of code was removed that copied the current state to
>> checkpointed state.  This should not have been removed.
>> 
>
> -[space]
>
>> When an FP unavailable is taken inside a transaction, we need to abort
>> the transaction. This is because at the time of the tbegin, the FP
>> state is bogus so the state stored in the checkpointed registers is
>> incorrect. To fix this, we treclaim (to get the checkpointed GPRs) and
>> then copy the thread_struct FP live state into the checkpointed
>> state. We then trecheckpoint so that the FP state is correctly
>> restored into the CPU.
>> 
>> The coping of the FP registers from live to checkpointed is what was
          ^
Missed the actual spelling error.

8D

cheers
