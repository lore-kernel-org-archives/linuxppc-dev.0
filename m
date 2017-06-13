Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5300kyczDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:04:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: svaidy@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
In-Reply-To: <20170612171138.GB4340@drishya.in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-14-npiggin@gmail.com>
 <20170612171138.GB4340@drishya.in.ibm.com>
Date: Tue, 13 Jun 2017 20:04:27 +1000
Message-ID: <87zidcgq50.fsf@concordia.ellerman.id.au>
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

Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> * Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:34]:
>
>> The CTRL register is read-only except bit 63 which is the run latch
>> control. This means it can be updated with a mtspr rather than
>> mfspr/mtspr.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index baae104b16c7..a44ea034c226 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -1973,13 +1969,9 @@ void notrace __ppc64_runlatch_on(void)
>>  void notrace __ppc64_runlatch_off(void)
>>  {
>>  	struct thread_info *ti = current_thread_info();
>> -	unsigned long ctrl;
>> 
>>  	ti->local_flags &= ~_TLF_RUNLATCH;
>> -
>> -	ctrl = mfspr(SPRN_CTRLF);
>> -	ctrl &= ~CTRL_RUNLATCH;
>> -	mtspr(SPRN_CTRLT, ctrl);
>> +	mtspr(SPRN_CTRLT, 0);
>
> Good idea.  Writing to CTRL register can change only the RUN field.
> Was this any different in older generations?

No AFAICS back to 2.02.

> Anton and Ben kept the mfspr/mtspr part in earlier updates to this
> routine.

Doing the read/modify write is forward compatible vs a new writable
field, whereas writing the whole register with a known value is not.

cheers
