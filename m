Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl9q06s3gzDsj8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 20:31:40 +1000 (AEST)
Date: Thu, 29 Sep 2016 12:31:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org,
 kvm@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Message-ID: <20160929103133.GW5016@twins.programming.kicks-ass.net>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2016 at 12:23:19PM +0200, Christian Borntraeger wrote:
> On 09/29/2016 12:10 PM, Peter Zijlstra wrote:
> > On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
> >> change from v2:
> >> 	no code change, fix typos, update some comments
> >>
> >> change from v1:
> >> 	a simplier definition of default vcpu_is_preempted
> >> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
> >> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
> >> 	add more comments
> >> 	thanks boqun and Peter's suggestion.
> >>
> >> This patch set aims to fix lock holder preemption issues.
> > 
> > So I really like the concept, but I would also really like to see
> > support for more hypervisors included before we can move forward with
> > this.
> > 
> > Please consider s390 and (x86/arm) KVM. Once we have a few, more can
> > follow later, but I think its important to not only have PPC support for
> > this.
> 
> Actually the s390 preemted check via sigp sense running  is available for
> all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can no
> longer buy s390 systems without LPAR.
> 
> As Heiko already pointed out we could simply use a small inline function
> that calls cpu_is_preempted from arch/s390/lib/spinlock (or smp_vcpu_scheduled from smp.c)

Sure, and I had vague memories of Heiko's email. This patch set however
completely fails to do that trivial hooking up.
