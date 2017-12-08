Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytVtz2npWzDwYv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 22:46:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [resend-without-rfc] powernv/kdump: Fix cases where the kdump
 kernel can get HMI's
In-Reply-To: <20171208145300.3d7e3003@roar.ozlabs.ibm.com>
References: <20171208033533.8014-1-bsingharora@gmail.com>
 <20171208145300.3d7e3003@roar.ozlabs.ibm.com>
Date: Fri, 08 Dec 2017 22:46:49 +1100
Message-ID: <87lgidh26u.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri,  8 Dec 2017 14:35:33 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> Certain HMI's such as malfunction error propagate through
>> all threads/core on the system. If a thread was offline
>> prior to us crashing the system and jumping to the kdump
>> kernel, bad things happen when it wakes up due to an HMI
>> in the kdump kernel.
>> 
>> There are several possible ways to solve this problem
>> 
>> 1. Put the offline cores in a state such that they are
>> not woken up for machine check and HMI errors. This
>> does not work, since we might need to wake up offline
>> threads occasionally to handle TB errors
>> 2. Ignore HMI errors, setup HMEER to mask HMI errors,
>> but this still leads the window open for any MCEs
>> and masking them for the duration of the dump might
>> be a concern
>> 3. Wake up offline CPUs, as in send them to crash_ipi_callback
>> (not wake them up as in mark them online as seen by
>> the scheduler). kexec does a wake_online_cpus() call,
>> this patch does something similar, but instead sends
>> an IPI and forces them to crash_ipi_callback
>> 
>> Care is taken to enable this only for powenv platforms
>> via crash_wake_offline (a global value set at setup
>> time). The crash code sends out IPI's to all CPU's
>> which then move to crash_ipi_callback and kexec_smp_wait().
>> We don't grab the pt_regs for offline CPU's.
>> 
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>> 
>> Nick reviewed the patches and asked if
>> 
>> 1. We need to do anything on the otherside of the kernel?
>> The answer is not clear at this point, but I don't want
>> to block this patch as it fixes a critical problem with
>> kdump in SMT=2/1 mode
>> 2. We should do this for other platforms
>> The answer is same as above, other platforms require testing
>> and I can selectively enable them as needed as I test them
>
> Yeah I didn't intend those as a nack for the patch... It's
> a bit annoying to have these selections between online cpus
> and present cpus depending on kdump.
>
> We don't want to do a full CPU online in the kdump path of
> course, but what if the crash code has a call that can IPI
> offline CPUs to get them into the crash callback, rather than
> put it in the general NMI IPI code?

Yeah. I reworked it with Balbir and I think that's pretty much what we
came up with. The crash code does the normal NMI callback and then goes
through any offline CPUs and sends them a do-nothing NMI.

>> @@ -187,6 +188,14 @@ static void pnv_smp_cpu_kill_self(void)
>>  		WARN_ON(lazy_irq_pending());
>>  
>>  		/*
>> +		 * For kdump kernels, we process the ipi and jump to
>> +		 * crash_ipi_callback. For more details see the description
>> +		 * at crash_wake_offline
>> +		 */
>> +		if (kdump_in_progress())
>> +			crash_ipi_callback(NULL);
>> +
>> +		/*
>>  		 * If the SRR1 value indicates that we woke up due to
>>  		 * an external interrupt, then clear the interrupt.
>>  		 * We clear the interrupt before checking for the
>
> I think you need to do this _after_ clearing the interrupt,
> otherwise you get a lost wakeup window, don't you?

Yeah I originally thought that, but it depends how you actually do the
wake up I think.

On P9 bare metal we will do OPAL_SIGNAL_SYS_RESET. I don't think that
actually sends an interrupt does it? But that's just from me skimming
the opal code you wrote :)

For the non-NMI case where it's a doorbell or xics/xive IPI yes as
currently written it will leave the interrupt uncleared.

On P9 if we don't have the NMI for some reason we should be using
doorbells, which is nice because it's just the msgclr, ie. we don't have
to call xive and run all that code.

On P8 it'll be a doorbell for threads with the same core, and for other
threads we'll call icp_native_flush_interrupt() which is also nice and
small and unlikely to break during kdump.

cheers
