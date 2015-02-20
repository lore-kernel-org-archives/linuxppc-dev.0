Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3058D1A0550
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 01:16:11 +1100 (AEDT)
Message-ID: <54E741A6.8000308@suse.de>
Date: Fri, 20 Feb 2015 15:16:06 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
 bigeasy@linutronix.de
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
In-Reply-To: <54E740E7.5090806@redhat.com>
Content-Type: text/plain; charset=windows-1252
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



On 20.02.15 15:12, Paolo Bonzini wrote:
> 
> 
> On 20/02/2015 14:45, Alexander Graf wrote:
>>
>>
>> On 18.02.15 10:32, Bogdan Purcareata wrote:
>>> This patchset enables running KVM SMP guests with external interrupts on an
>>> underlying RT-enabled Linux. Previous to this patch, a guest with in-kernel MPIC
>>> emulation could easily panic the kernel due to preemption when delivering IPIs
>>> and external interrupts, because of the openpic spinlock becoming a sleeping
>>> mutex on PREEMPT_RT_FULL Linux.
>>>
>>> 0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
>>> this behavior. While this change is targeted for a RT enabled Linux, it has no
>>> effect on upstream kvm-ppc, so send it upstream for better future maintenance.
>>>
>>> 0002: introduces a limit on the maximum VCPUs a guest can have, in order to
>>> prevent potential DoS attack due to large system latencies. This patch is
>>> targeted to RT (due to CONFIG_PREEMPT_RT_FULL), but it can also be applied on
>>> upstream Linux, with no effect. Not sure if it's best to send it upstream and
>>> have a hanging CONFIG_PREEMPT_RT_FULL check there, with no effect, or send it
>>> against linux-stable-rt. Please apply as you consider appropriate.
>>
>> Thomas, what is the usual approach for patches like this? Do you take
>> them into your rt tree or should they get integrated to upstream?
> 
> Patch 1 is definitely suitable for upstream, that's the reason why we
> have raw_spin_lock vs. raw_spin_unlock.

I see, perfect :).

Bogdan, please resend patch 1 with CC to kvm-ppc@vger so that I can pick
it up from patchworks.


Alex
