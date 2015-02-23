Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0135.outbound.protection.outlook.com [65.55.169.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD7391A0C23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 10:27:46 +1100 (AEDT)
Message-ID: <1424734051.4698.17.camel@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 23 Feb 2015 17:27:31 -0600
In-Reply-To: <54E74A8C.30802@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-20 at 15:54 +0100, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 03:12 PM, Paolo Bonzini wrote:
> >> Thomas, what is the usual approach for patches like this? Do you take
> >> them into your rt tree or should they get integrated to upstream?
> > 
> > Patch 1 is definitely suitable for upstream, that's the reason why we
> > have raw_spin_lock vs. raw_spin_unlock.
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
> 
> Each host PIC has a rawlock and does mostly just mask/unmask and the
> raw lock makes sure the value written is not mixed up due to
> preemption.
> This hardly increase latencies because the "locked" path is very short.
> If this conversation leads to higher latencies then the locked path is
> too long and hardly suitable to become a rawlock.

This isn't a host PIC driver.  It's guest PIC emulation, some of which
is indeed not suitable for a rawlock (in particular, openpic_update_irq
which loops on the number of vcpus, with a loop body that calls
IRQ_check() which loops over all pending IRQs).  The vcpu limits are a
temporary bandaid to avoid the worst latencies, but I'm still skeptical
about this being upstream material.

-Scott
