Return-Path: <dave@stgolabs.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5mrr6mFQzDvT1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 03:52:42 +1100 (AEDT)
Date: Sat, 29 Oct 2016 09:52:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v6 02/11] locking/osq: Drop the overload of osq_lock()
Message-ID: <20161029165216.GA17451@linux-80c1.suse>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 28 Oct 2016, Pan Xinhui wrote:
> 		/*
> 		 * If we need to reschedule bail... so we can block.
>+		 * Use vcpu_is_preempted to detech lock holder preemption issue
                                            ^^ detect
>+		 * and break. 

Could you please remove the rest of this comment? Its just noise to point out
that vcpu_is_preempted is a macro defined by arch/false. This is standard protocol
in the kernel.

Same goes for all locks you change with this.

Thanks,
Davidlohr

>                * vcpu_is_preempted is a macro defined by false if
>+		 * arch does not support vcpu preempted check,
> 		 */
>-		if (need_resched())
>+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> 			goto unqueue;
>
> 		cpu_relax_lowlatency();
>-- 
>2.4.11
>
