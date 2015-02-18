Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24A091A0A40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 21:09:47 +1100 (AEDT)
Message-ID: <54E45D31.3020302@linutronix.de>
Date: Wed, 18 Feb 2015 10:36:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
 agraf@suse.de, pbonzini@redhat.com
Subject: Re: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on
 RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset=windows-1252
Cc: scottwood@freescale.com, mihai.caraman@freescale.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2015 10:32 AM, Bogdan Purcareata wrote:
> Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
> high number of VCPUs may induce great latencies on the underlying RT Linux
> system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
> This can be further aggravated by sending a lot of external interrupts to the
> guest.
> 
> A malicious app can abuse this scenario, causing a DoS of the host Linux.
> Until the KVM openpic code is refactored to use finer lock granularity, impose
> a limitation on the number of VCPUs a guest can have when running on a
> PREEMPT_RT_FULL system with KVM_MPIC emulation.

How is this possible? You take the raw lock, write a register, release
the raw lock. How can the guest lockup the host? Is this write blocking
in guest?

Sebastian
