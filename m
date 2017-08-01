Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xM6Vx15bhzDrJ4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 16:54:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Brian J King <bjking1@us.ibm.com>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
In-Reply-To: <87379c6cfh.fsf@concordia.ellerman.id.au>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
 <OF186C0C54.7E077412-ON8625816B.0053C88E-8625816B.00540312@notes.na.collabserv.com>
 <5dcfe3ac-50c7-86a6-e571-fe5a1c1dc316@linux.vnet.ibm.com>
 <87379c6cfh.fsf@concordia.ellerman.id.au>
Date: Tue, 01 Aug 2017 16:54:16 +1000
Message-ID: <87a83ju6av.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Brian King <brking@linux.vnet.ibm.com> writes:
>
>> On 07/28/2017 10:17 AM, Brian J King wrote:
>>> Jens Axboe <axboe@kernel.dk> wrote on 07/28/2017 09:25:48 AM:
>>> 
>>>> Can you try the below fix? Should be more palatable than the previous
>>>> one. Brian, maybe you can take a look at the IRQ issue mentioned above?
>>
>> Michael,
>>
>> Does this address the issue you are seeing?
>
> Yes it seems to, thanks.
>
> I only see the trace on reboot, and not 100% of the time. But I've
> survived a couple of reboots now without seeing anything, so I think
> this is helping.
>
> I'll put the patch in my Jenkins over night and let you know how it
> survives that, which should be ~= 25 boots.

No lockdep warnings or other oddness over night, so that patch looks
good to me.

cheers
