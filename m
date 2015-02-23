Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9228C1A0C26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 19:13:07 +1100 (AEDT)
Message-ID: <54EAE0FA.3090402@freescale.com>
Date: Mon, 23 Feb 2015 10:12:42 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Bogdan Purcareata
 <bogdan.purcareata@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de> <54E74B58.90706@redhat.com>
 <54E74D5E.1050209@linutronix.de> <54E74E77.2070503@redhat.com>
 <54E74FED.2090203@linutronix.de>
In-Reply-To: <54E74FED.2090203@linutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: scottwood@freescale.com, mihai.caraman@freescale.com,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20.02.2015 17:17, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 04:10 PM, Paolo Bonzini wrote:
>> On 20/02/2015 16:06, Sebastian Andrzej Siewior wrote:
>>> On 02/20/2015 03:57 PM, Paolo Bonzini wrote:
>>
>>>> Yes, but large latencies just mean the code has to be rewritten (x86
>>>> doesn't anymore do event injection in an atomic regions for example).
>>>> Until it is, using raw_spin_lock is correct.
>>>
>>> It does not sound like it. It sounds more like disabling interrupts to
>>> get things run faster and then limit it on a different corner to not
>>> blow up everything.
>>
>> "This patchset enables running KVM SMP guests with external interrupts
>> on an underlying RT-enabled Linux. Previous to this patch, a guest with
>> in-kernel MPIC emulation could easily panic the kernel due to preemption
>> when delivering IPIs and external interrupts, because of the openpic
>> spinlock becoming a sleeping mutex on PREEMPT_RT_FULL Linux".
>>
>>> Max latencies was decreased "Max latency (us)  70        62" and that
>>> is why this is done? For 8 us and possible DoS in case there are too
>>> many cpus?
>>
>> My understanding is that:
>>
>> 1) netperf can get you a BUG KVM, and raw_spinlock fixes that

Actually, it's not just netperf. The bug triggers in the following 
scenarios:
- running CPU intensive task (while true; do date; done) in SMP guest 
(even with 2 VCPUs)
- running netperf in guest
- running cyclictest in SMP guest

> May I please see a backtrace with context tracking which states where
> the interrupts / preemption gets disabled and where the lock was taken?

Will do, I will get back to you as soon as I have it available. I will 
try and capture it using function trace.

> I'm not totally against this patch I just want to make sure this is not
> a blind raw conversation to shup up the warning the kernel throws.
>
>> 2) cyclictest did not trigger the BUG, and you can also get reduced
>> latency from using raw_spinlock.
>>
>> I think we agree that (2) is not a factor in accepting the patch.
> good :)
>
>>
>> Paolo
>>
> Sebastian
>
