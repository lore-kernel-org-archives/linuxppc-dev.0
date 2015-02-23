Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0118.outbound.protection.outlook.com [65.55.169.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EBDE1A0C23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 18:29:32 +1100 (AEDT)
Message-ID: <54EAD6C2.3080601@freescale.com>
Date: Mon, 23 Feb 2015 09:29:06 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Bogdan Purcareata
 <bogdan.purcareata@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de>
In-Reply-To: <54E74A8C.30802@linutronix.de>
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

On 20.02.2015 16:54, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 03:12 PM, Paolo Bonzini wrote:
>>> Thomas, what is the usual approach for patches like this? Do you take
>>> them into your rt tree or should they get integrated to upstream?
>>
>> Patch 1 is definitely suitable for upstream, that's the reason why we
>> have raw_spin_lock vs. raw_spin_unlock.
>
> raw_spin_lock were introduced in c2f21ce2e31286a0a32 ("locking:
> Implement new raw_spinlock). They are used in context which runs with
> IRQs off - especially on -RT. This includes usually interrupt
> controllers and related core-code pieces.
>
> Usually you see "scheduling while atomic" on -RT and convert them to
> raw locks if it is appropriate.
>
> Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
> not cause a DoS and large latencies in the host. I haven't seen an
> answer to my why question. Because if the conversation leads to
> large latencies in the host then it does not look right.

What I did notice were bad cyclictest results, when run in a guest with 
24 VCPUs. There were 24 netperf flows running in the guest. The max 
cyclictest latencies got up to 15ms in the guest, however I haven't 
captured any host side information related to preemptirqs off statistics.

What I was planning to do in the past days was to rerun the test and 
come up with the host preemptirqs off disabled statistics (mainly the 
max latency), so I could have a more reliable argument. I haven't had 
the time nor the setup to do that yet, and will come back with this as 
soon as I have them available.

> Each host PIC has a rawlock and does mostly just mask/unmask and the
> raw lock makes sure the value written is not mixed up due to
> preemption.
> This hardly increase latencies because the "locked" path is very short.
> If this conversation leads to higher latencies then the locked path is
> too long and hardly suitable to become a rawlock.

 From my understanding, the kvm openpic emulation code does more than 
just that - it requires to be atomic with interrupt delivery. This might 
mean the bad cyclictest max latencies visible from the guest side 
(15ms), may also have a correspondent to how much time that raw spinlock 
is taken, leading to an unresponsive host.

Best regards,
Bogdan P.

>> Paolo
>>
>
> Sebastian
>
