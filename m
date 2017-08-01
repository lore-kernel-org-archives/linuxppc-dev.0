Return-Path: <axboe@kernel.dk>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMKsd1xh9zDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 01:26:13 +1000 (AEST)
Received: by mail-io0-x231.google.com with SMTP id c74so9551195iod.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 08:26:13 -0700 (PDT)
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Michael Ellerman <mpe@ellerman.id.au>,
 Bart Van Assche <Bart.VanAssche@wdc.com>, Brian J King <bjking1@us.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
 <877eynu69j.fsf@concordia.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4fb0293-d0cb-ebff-cddf-a4e301826fbc@kernel.dk>
Date: Tue, 1 Aug 2017 09:26:09 -0600
MIME-Version: 1.0
In-Reply-To: <877eynu69j.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2017 12:55 AM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> ...
>>
>> Can you try the below fix? Should be more palatable than the previous
>> one. Brian, maybe you can take a look at the IRQ issue mentioned above?
> 
> Given the patch from Brian fixed the lockdep warning, do you still want
> me to try and test this one?

Nope, we don't have to do that. I'd much rather just add a WARN_ON()
or similar to make sure we catch buggy users earlier. scsi_run_queue()
needs a

WARN_ON(in_interrupt());

but it might be better to put that in __blk_mq_run_hw_queue().

-- 
Jens Axboe
