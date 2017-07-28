Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJdwn14LzzDrMS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:19:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
 Brian J King  <bjking1@us.ibm.com>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
In-Reply-To: <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
Date: Fri, 28 Jul 2017 16:19:36 +1000
Message-ID: <87lgn9dqx3.fsf@concordia.ellerman.id.au>
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

Jens Axboe <axboe@kernel.dk> writes:
> On 07/27/2017 08:47 AM, Bart Van Assche wrote:
>> On Thu, 2017-07-27 at 08:02 -0600, Jens Axboe wrote:
>>> The bug looks like SCSI running the queue inline from IRQ
>>> context, that's not a good idea.
...
>> 
>> scsi_run_queue() works fine if no scheduler is configured. Additionally, that
>> code predates the introduction of blk-mq I/O schedulers. I think it is
>> nontrivial for block driver authors to figure out that a queue has to be run
>> from process context if a scheduler has been configured that does not support
>> to be run from interrupt context.
>
> No it doesn't, you could never run the queue from interrupt context with
> async == false. So I don't think that's confusing at all, you should
> always be aware of the context.
>
>> How about adding WARN_ON_ONCE(in_interrupt()) to
>> blk_mq_start_hw_queue() or replacing the above patch by the following:
>
> No, I hate having dependencies like that, because they always just catch
> one of them. Looks like the IPR path that hits this should just offload
> to a workqueue or similar, you don't have to make any scsi_run_queue()
> async.

OK, so the resolution is "fix it in IPR" ?

cheers
