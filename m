Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2655E1A0064
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 00:31:25 +1100 (AEDT)
Message-ID: <54EF2025.80404@linutronix.de>
Date: Thu, 26 Feb 2015 14:31:17 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>	
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>	
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>
 <54EF196E.4090805@redhat.com>
In-Reply-To: <54EF196E.4090805@redhat.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/26/2015 02:02 PM, Paolo Bonzini wrote:
> 
> 
> On 24/02/2015 00:27, Scott Wood wrote:
>> This isn't a host PIC driver.  It's guest PIC emulation, some of which
>> is indeed not suitable for a rawlock (in particular, openpic_update_irq
>> which loops on the number of vcpus, with a loop body that calls
>> IRQ_check() which loops over all pending IRQs).
> 
> The question is what behavior is wanted of code that isn't quite
> RT-ready.  What is preferred, bugs or bad latency?
> 
> If the answer is bad latency (which can be avoided simply by not running
> KVM on a RT kernel in production), patch 1 can be applied.  If the
can be applied *but* makes no difference if applied or not.

> answer is bugs, patch 1 is not upstream material.
> 
> I myself prefer to have bad latency; if something takes a spinlock in
> atomic context, that spinlock should be raw.  If it hurts (latency),
> don't do it (use the affected code).

The problem, that is fixed by this s/spin_lock/raw_spin_lock/, exists
only in -RT. There is no change upstream. In general we fix such things
in -RT first and forward the patches upstream if possible. This convert
thingy would be possible.
Bug fixing comes before latency no matter if RT or not. Converting
every lock into a rawlock is not always the answer.
Last thing I read from Scott is that he is not entirely sure if this is
the right approach or not and patch #1 was not acked-by him either.

So for now I wait for Scott's feedback and maybe a backtrace :)

> 
> Paolo

Sebastian
