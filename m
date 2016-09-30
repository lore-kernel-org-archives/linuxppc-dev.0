Return-Path: <pbonzini@redhat.com>
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com [209.132.183.25])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slj3w2Z4MzDskR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 16:59:40 +1000 (AEST)
Date: Fri, 30 Sep 2016 02:58:58 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 will deacon <will.deacon@arm.com>, kernellwp@gmail.com,
 jgross@suse.com, bsingharora@gmail.com,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
In-Reply-To: <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
 <20160929103133.GW5016@twins.programming.kicks-ass.net>
 <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > > Please consider s390 and (x86/arm) KVM. Once we have a few, more can
> > > > follow later, but I think its important to not only have PPC support for
> > > > this.
> > >
> > > Actually the s390 preemted check via sigp sense running  is available for
> > > all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can
> > > no longer buy s390 systems without LPAR.
> > >
> > > As Heiko already pointed out we could simply use a small inline function
> > > that calls cpu_is_preempted from arch/s390/lib/spinlock (or
> > > smp_vcpu_scheduled from smp.c)
> >
> > Sure, and I had vague memories of Heiko's email. This patch set however
> > completely fails to do that trivial hooking up.
> 
> sorry for that.
> I will try to work it out on x86.

x86 has no hypervisor support, and I'd like to understand the desired
semantics first, so I don't think it should block this series.  In
particular, there are at least the following choices:

1) exit to userspace (5-10.000 clock cycles best case) counts as
lock holder preemption

2) any time the vCPU thread not running counts as lock holder
preemption

To implement the latter you'd need a hypercall or MSR (at least as
a slow path), because the KVM preempt notifier is only active
during the KVM_RUN ioctl.

Paolo
