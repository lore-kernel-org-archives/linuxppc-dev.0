Return-Path: <SRS0=DNDs=5F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EEC4332B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 22:37:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CBC20722
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 22:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CBC20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kdvk3nf3zF0cL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2020 09:37:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kdt22mBkzF0Bm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2020 09:36:26 +1100 (AEDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jFQFI-0005GA-2c; Fri, 20 Mar 2020 23:36:04 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 7EC4C1039FC; Fri, 20 Mar 2020 23:36:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: paulmck@kernel.org
Subject: Re: [patch V2 08/15] Documentation: Add lock ordering and nesting
 documentation
In-Reply-To: <20200320210243.GT3199@paulmck-ThinkPad-P72>
References: <20200320160145.GN3199@paulmck-ThinkPad-P72>
 <87mu8apzxr.fsf@nanos.tec.linutronix.de>
 <20200320210243.GT3199@paulmck-ThinkPad-P72>
Date: Fri, 20 Mar 2020 23:36:03 +0100
Message-ID: <874kuipsbw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Oleg Nesterov <oleg@redhat.com>, Joel Fernandes <joel@joelfernandes.org>,
 Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Logan Gunthorpe <logang@deltatee.com>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Fri, Mar 20, 2020 at 08:51:44PM +0100, Thomas Gleixner wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >
>> >  - The soft interrupt related suffix (_bh()) still disables softirq
>> >    handlers.  However, unlike non-PREEMPT_RT kernels (which disable
>> >    preemption to get this effect), PREEMPT_RT kernels use a per-CPU
>> >    lock to exclude softirq handlers.
>> 
>> I've made that:
>> 
>>   - The soft interrupt related suffix (_bh()) still disables softirq
>>     handlers.
>> 
>>     Non-PREEMPT_RT kernels disable preemption to get this effect.
>> 
>>     PREEMPT_RT kernels use a per-CPU lock for serialization. The lock
>>     disables softirq handlers and prevents reentrancy by a preempting
>>     task.
>
> That works!  At the end, I would instead say "prevents reentrancy
> due to task preemption", but what you have works.

Yours is better.

>>    - Task state is preserved across spinlock acquisition, ensuring that the
>>      task-state rules apply to all kernel configurations.  Non-PREEMPT_RT
>>      kernels leave task state untouched.  However, PREEMPT_RT must change
>>      task state if the task blocks during acquisition.  Therefore, it
>>      saves the current task state before blocking and the corresponding
>>      lock wakeup restores it. A regular not lock related wakeup sets the
>>      task state to RUNNING. If this happens while the task is blocked on
>>      a spinlock then the saved task state is changed so that correct
>>      state is restored on lock wakeup.
>> 
>> Hmm?
>
> I of course cannot resist editing the last two sentences:
>
>    ... Other types of wakeups unconditionally set task state to RUNNING.
>    If this happens while a task is blocked while acquiring a spinlock,
>    then the task state is restored to its pre-acquisition value at
>    lock-wakeup time.

Errm no. That would mean

     state = UNINTERRUPTIBLE
     lock()
       block()
         real_state = state
         state = SLEEPONLOCK

                               non lock wakeup
                                 state = RUNNING    <--- FAIL #1

                               lock wakeup
                                 state = real_state <--- FAIL #2

How it works is:

     state = UNINTERRUPTIBLE
     lock()
       block()
         real_state = state
         state = SLEEPONLOCK

                               non lock wakeup
                                 real_state = RUNNING

                               lock wakeup
                                 state = real_state == RUNNING

If there is no 'non lock wakeup' before the lock wakeup:

     state = UNINTERRUPTIBLE
     lock()
       block()
         real_state = state
         state = SLEEPONLOCK

                               lock wakeup
                                 state = real_state == UNINTERRUPTIBLE

I agree that what I tried to express is hard to parse, but it's at least
halfways correct :)

Thanks,

        tglx
