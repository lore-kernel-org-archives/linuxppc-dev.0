Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85B2B1A0D2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 09:48:45 +1100 (AEDT)
Message-ID: <1424731710.4698.15.camel@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on
 RT Linux
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 23 Feb 2015 16:48:30 -0600
In-Reply-To: <54E73A64.5020608@suse.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A64.5020608@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, pbonzini@redhat.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-20 at 14:45 +0100, Alexander Graf wrote:
> 
> On 18.02.15 10:32, Bogdan Purcareata wrote:
> > Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
> > high number of VCPUs may induce great latencies on the underlying RT Linux
> > system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
> > This can be further aggravated by sending a lot of external interrupts to the
> > guest.
> > 
> > A malicious app can abuse this scenario, causing a DoS of the host Linux.
> > Until the KVM openpic code is refactored to use finer lock granularity, impose
> > a limitation on the number of VCPUs a guest can have when running on a
> > PREEMPT_RT_FULL system with KVM_MPIC emulation.
> > 
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> > Reviewed-by: Scott Wood <scottwood@freescale.com>
> 
> I don't think this patch is reasonable to take upstream.

I agree (or at least, I don't think the raw lock conversion should be
separated from the vcpu limitation that makes it clear that it's a
temporary hack), because it ought to be fixed properly.

>  If we have a
> latency issue, whoever spawned KVM VMs made a decision to spawn such big
> VMs.

I disagree.  The point of PREEMPT_RT is to prevent the majority of
kernel code from excessively impacting latency.  When you start using
raw locks you're stepping outside those bounds and need to ensure that
you don't hand things within those bounds (which includes userspace) the
ability to excessively impact latency.

-Scott
