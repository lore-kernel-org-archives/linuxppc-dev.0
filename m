Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D1FF1A0C04
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 01:54:12 +1100 (AEDT)
Message-ID: <54E74A8C.30802@linutronix.de>
Date: Fri, 20 Feb 2015 15:54:04 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org
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

On 02/20/2015 03:12 PM, Paolo Bonzini wrote:
>> Thomas, what is the usual approach for patches like this? Do you take
>> them into your rt tree or should they get integrated to upstream?
> 
> Patch 1 is definitely suitable for upstream, that's the reason why we
> have raw_spin_lock vs. raw_spin_unlock.

raw_spin_lock were introduced in c2f21ce2e31286a0a32 ("locking:
Implement new raw_spinlock). They are used in context which runs with
IRQs off - especially on -RT. This includes usually interrupt
controllers and related core-code pieces.

Usually you see "scheduling while atomic" on -RT and convert them to
raw locks if it is appropriate.

Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
not cause a DoS and large latencies in the host. I haven't seen an
answer to my why question. Because if the conversation leads to
large latencies in the host then it does not look right.

Each host PIC has a rawlock and does mostly just mask/unmask and the
raw lock makes sure the value written is not mixed up due to
preemption.
This hardly increase latencies because the "locked" path is very short.
If this conversation leads to higher latencies then the locked path is
too long and hardly suitable to become a rawlock.

> Paolo
> 

Sebastian
