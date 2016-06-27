Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdWN95z7CzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:22:01 +1000 (AEST)
Date: Mon, 27 Jun 2016 16:21:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, Waiman.Long@hpe.com,
 boqun.feng@gmail.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 3/3] locking/osq: Drop the overload of osq_lock()
Message-ID: <20160627142155.GP30921@twins.programming.kicks-ass.net>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467049290-32359-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2016 at 01:41:30PM -0400, Pan Xinhui wrote:
> @@ -118,8 +123,17 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>  	while (!READ_ONCE(node->locked)) {
>  		/*
>  		 * If we need to reschedule bail... so we can block.
> +		 * An over-committed guest with more vCPUs than pCPUs
> +		 * might fall in this loop and cause a huge overload.
> +		 * This is because vCPU A(prev) hold the osq lock and yield out
> +		 * vCPU B(node) wait ->locked to be set, IOW, it wait utill
> +		 * vCPU A run and unlock the osq lock. Such spin is meaningless
> +		 * use vcpu_is_preempted to detech such case. IF arch does not
> +		 * support vcpu preempted check, vcpu_is_preempted is a macro
> +		 * defined by false.

Or you could mention lock holder preemption and everybody will know what
you're talking about.

>  		 */
> -		if (need_resched())
> +		if (need_resched() ||
> +			vcpu_is_preempted(node_cpu(node->prev)))

Did you really need that linebreak?

>  			goto unqueue;
>  
>  		cpu_relax_lowlatency();
> -- 
> 2.4.11
> 
