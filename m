Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVvt06G5zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:00:58 +1000 (AEST)
Date: Mon, 27 Jun 2016 16:00:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, Waiman.Long@hpe.com,
 boqun.feng@gmail.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
Message-ID: <20160627140043.GO30921@twins.programming.kicks-ass.net>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2016 at 01:41:28PM -0400, Pan Xinhui wrote:
> +++ b/include/linux/sched.h
> @@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
>  
>  #endif /* CONFIG_SMP */
>  
> +#ifdef arch_vcpu_is_preempted
> +static inline bool vcpu_is_preempted(int cpu)
> +{
> +	return arch_vcpu_is_preempted(cpu);
> +}
> +#else
> +#define vcpu_is_preempted(cpu)	false
> +#endif

#ifndef vcpu_is_preempted
#define vcpu_is_preempted(cpu)		(false)
#endif

Is so much simpler...

Also, please Cc the virt list so that other interested parties can
comment, and maybe also the s390 folks.
