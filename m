Return-Path: <fweisbec@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 765B72C019B
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Oct 2013 01:25:48 +1100 (EST)
Received: by mail-wg0-f52.google.com with SMTP id f12so897599wgh.19
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 07:25:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131023141948.GB3566@localhost.localdomain>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
Date: Wed, 23 Oct 2013 15:25:44 +0100
Message-ID: <CAFTL4hxGxSqWSaX0s7kSdXXY0sgSmM3intiKpM7H_4RhRP5DBg@mail.gmail.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Michael Neuling <mikey@neuling.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/10/23 Frederic Weisbecker <fweisbec@gmail.com>:
> On Wed, Oct 23, 2013 at 10:54:54AM +1100, Michael Neuling wrote:
>> Frederic,
>>
>> In the perf ring buffer code we have this in perf_output_get_handle():
>>
>>       if (!local_dec_and_test(&rb->nest))
>>               goto out;
>>
>>       /*
>>        * Publish the known good head. Rely on the full barrier implied
>>        * by atomic_dec_and_test() order the rb->head read and this
>>        * write.
>>        */
>>       rb->user_page->data_head = head;
>>
>> The comment says atomic_dec_and_test() but the code is
>> local_dec_and_test().
>>
>> On powerpc, local_dec_and_test() doesn't have a memory barrier but
>> atomic_dec_and_test() does.  Is the comment wrong, or is
>> local_dec_and_test() suppose to imply a memory barrier too and we have
>> it wrongly implemented in powerpc?
>>
>> My guess is that local_dec_and_test() is correct but we to add an
>> explicit memory barrier like below:
>>
>> (Kudos to Victor Kaplansky for finding this)
>>
>> Mikey
>>
>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> index cd55144..95768c6 100644
>> --- a/kernel/events/ring_buffer.c
>> +++ b/kernel/events/ring_buffer.c
>> @@ -87,10 +87,10 @@ again:
>>               goto out;
>>
>>       /*
>> -      * Publish the known good head. Rely on the full barrier implied
>> -      * by atomic_dec_and_test() order the rb->head read and this
>> -      * write.
>> +      * Publish the known good head. We need a memory barrier to order the
>> +      * order the rb->head read and this write.
>>        */
>> +     smp_mb ();
>>       rb->user_page->data_head = head;
>>
>>       /*
>
>
> I'm adding Peter in Cc since he wrote that code.
> I agree that local_dec_and_test() doesn't need to imply an smp barrier.
> All it has to provide as a guarantee is the atomicity against local concurrent
> operations (interrupts, preemption, ...).
>
> Now I'm a bit confused about this barrier.
>
> I think we want this ordering:
>
>     Kernel                             User
>
>    READ rb->user_page->data_tail       READ rb->user_page->data_head
>    smp_mb()                            smp_mb()
>    WRITE rb data                       READ rb  data
>    smp_mb()                            smp_mb()
>    rb->user_page->data_head            WRITE rb->user_page->data_tail
      ^^ I meant a write above for data_head.
