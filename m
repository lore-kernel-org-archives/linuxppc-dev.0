Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5xnk4Z8qzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 22:36:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>,
 Don Zickus <dzickus@redhat.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure()
 two stage
In-Reply-To: <alpine.DEB.2.20.1710030848210.2281@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
Date: Tue, 03 Oct 2017 22:36:41 +1100
Message-ID: <87o9pocvjq.fsf@concordia.ellerman.id.au>
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

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 3 Oct 2017, Michael Ellerman wrote:
>> Hi Thomas,
>> Unfortunately this is hitting the WARN_ON in start_wd_cpu() on powerpc
>> because we're calling it multiple times for the boot CPU.
>> 
>> The first call is via:
>> 
>>   start_wd_on_cpu+0x80/0x2f0
>>   watchdog_nmi_reconfigure+0x124/0x170
>>   softlockup_reconfigure_threads+0x110/0x130
>>   lockup_detector_init+0xbc/0xe0
>>   kernel_init_freeable+0x18c/0x37c
>>   kernel_init+0x2c/0x160
>>   ret_from_kernel_thread+0x5c/0xbc
>> 
>> And then again via the CPU hotplug registration:
>> 
>>   start_wd_on_cpu+0x80/0x2f0
>>   cpuhp_invoke_callback+0x194/0x620
>>   cpuhp_thread_fun+0x7c/0x1b0
>>   smpboot_thread_fn+0x290/0x2a0
>>   kthread+0x168/0x1b0
>>   ret_from_kernel_thread+0x5c/0xbc
>> 
>> 
>> The first call is new because previously watchdog_nmi_reconfigure()
>> wasn't called from softlockup_reconfigure_threads().
>
> Hmm, don't you have the same problem with CPU hotplug or do you just get
> lucky because the hotplug callback in your code is ordered vs. the
> softlockup thread hotplug callback in a way that this does not hit?

I don't see it with CPU hotplug.

AFAICS that's because softlockup_reconfigure_threads() isn't called for
CPU hotplug. Unless there's a path I'm missing?

>> I'm not sure what the easiest fix is. One option would be to just drop
>> the WARN_ON, it's just there for paranoia AFAICS.
>
> The straight forward way is to make use of the new probe function. Patch
> below.

Thanks.

Hmm, I tried that patch, it makes the warning go away. But then I
triggered a deliberate hard lockup and got nothing.

Then I went back to the existing code (in linux-next), and I still get
no warning from a deliberate hard lockup.

So seems there may be some more gremlins. Will test more in the morning.

cheers
