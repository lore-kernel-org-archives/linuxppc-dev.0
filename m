Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJgNJ5vbtzDvkx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 21:24:16 +1100 (AEDT)
Date: Wed, 16 Nov 2016 11:23:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com,
 rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
 vcpu preempted check
Message-ID: <20161116102355.GP3142@twins.programming.kicks-ass.net>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161115154706.GF11311@worktop.programming.kicks-ass.net>
 <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2016 at 12:19:09PM +0800, Pan Xinhui wrote:
> Hi, Peter.
> 	I think we can avoid a function call in a simpler way. How about below
> 
> static inline bool vcpu_is_preempted(int cpu)
> {
> 	/* only set in pv case*/
> 	if (pv_lock_ops.vcpu_is_preempted)
> 		return pv_lock_ops.vcpu_is_preempted(cpu);
> 	return false;
> }

That is still more expensive. It needs to do an actual load and makes it
hard to predict the branch, you'd have to actually wait for the load to
complete etc.

Also, it generates more code.

Paravirt muck should strive to be as cheap as possible when ran on
native hardware.
