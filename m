Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BB5E1A0550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 18:50:41 +1100 (AEDT)
Message-ID: <54EADBB6.4020005@freescale.com>
Date: Mon, 23 Feb 2015 09:50:14 +0200
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
 <54E74D5E.1050209@linutronix.de>
In-Reply-To: <54E74D5E.1050209@linutronix.de>
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

On 20.02.2015 17:06, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 03:57 PM, Paolo Bonzini wrote:
>>
>>
>> On 20/02/2015 15:54, Sebastian Andrzej Siewior wrote:
>>> Usually you see "scheduling while atomic" on -RT and convert them to
>>> raw locks if it is appropriate.
>>>
>>> Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
>>> not cause a DoS and large latencies in the host. I haven't seen an
>>> answer to my why question. Because if the conversation leads to
>>> large latencies in the host then it does not look right.
>>>
>>> Each host PIC has a rawlock and does mostly just mask/unmask and the
>>> raw lock makes sure the value written is not mixed up due to
>>> preemption.
>>> This hardly increase latencies because the "locked" path is very short.
>>> If this conversation leads to higher latencies then the locked path is
>>> too long and hardly suitable to become a rawlock.
>>
>> Yes, but large latencies just mean the code has to be rewritten (x86
>> doesn't anymore do event injection in an atomic regions for example).
>> Until it is, using raw_spin_lock is correct.
>
> It does not sound like it. It sounds more like disabling interrupts to
> get things run faster and then limit it on a different corner to not
> blow up everything.
> Max latencies was decreased "Max latency (us)  70        62" and that
> is why this is done? For 8 us and possible DoS in case there are too
> many cpus?

The main reason for this patch was to enable KVM guests to run on RT 
hosts in certain scenarios, such as delivering external interrupts to 
the guest and the guest being SMP. The cyclictest measurements were just 
a "sanity check" to make sure the latencies don't get messed up too bad, 
albeit in a light scenario (guest with 1 VCPU), for a use case when the 
guest is not SMP and doesn't have any external interrupts delivered. 
This latter scenario works even without the kvm openpic being a 
raw_spinlock.

Previous to this patch, KVM was indeed blowing up on guest_enter [1], 
and making the openpic lock a raw_spinlock fixes that, without causing 
too much cyclictest damage when the guest doesn't have many VCPUs. I had 
a discussion with Scott Wood a while ago regarding delivering external 
interrupts to the guest, and he mentioned that the correct solution was 
to rework the entire interrupt delivery mechanism into multiple lock 
domains, minimize the code on the EPR path and the locking involved. 
Until that can be achieved, converting the openpic lock to a 
raw_spinlock would be acceptable, as long as we keep the number of guest 
VCPUs small, so as to not cause big host latencies.

[1] http://lxr.free-electrons.com/source/include/linux/kvm_host.h#L762

Best regards,
Bogdan P.

>> Paolo
>>
>
> Sebastian
>
