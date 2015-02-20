Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E17C61A13D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 02:10:54 +1100 (AEDT)
Received: by mail-wi0-f176.google.com with SMTP id h11so3591267wiw.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 07:10:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <54E74E77.2070503@redhat.com>
Date: Fri, 20 Feb 2015 16:10:47 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de> <54E74B58.90706@redhat.com>
 <54E74D5E.1050209@linutronix.de>
In-Reply-To: <54E74D5E.1050209@linutronix.de>
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



On 20/02/2015 16:06, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 03:57 PM, Paolo Bonzini wrote:

>> Yes, but large latencies just mean the code has to be rewritten (x86
>> doesn't anymore do event injection in an atomic regions for example).
>> Until it is, using raw_spin_lock is correct.
> 
> It does not sound like it. It sounds more like disabling interrupts to
> get things run faster and then limit it on a different corner to not
> blow up everything.

"This patchset enables running KVM SMP guests with external interrupts
on an underlying RT-enabled Linux. Previous to this patch, a guest with
in-kernel MPIC emulation could easily panic the kernel due to preemption
when delivering IPIs and external interrupts, because of the openpic
spinlock becoming a sleeping mutex on PREEMPT_RT_FULL Linux".

> Max latencies was decreased "Max latency (us)  70        62" and that
> is why this is done? For 8 us and possible DoS in case there are too
> many cpus?

My understanding is that:

1) netperf can get you a BUG KVM, and raw_spinlock fixes that

2) cyclictest did not trigger the BUG, and you can also get reduced
latency from using raw_spinlock.

I think we agree that (2) is not a factor in accepting the patch.

Paolo

>> Paolo
>>
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
