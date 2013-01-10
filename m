Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 270FB2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:02:16 +1100 (EST)
Message-ID: <1357797726.4838.89.camel@pasglop>
Subject: Re: [RFC PATCH powerpc ] Protect smp_processor_id() in
 arch_spin_unlock_wait()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2013 17:02:06 +1100
In-Reply-To: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-19 at 14:16 +0800, Li Zhong wrote:
> This patch tries to disable preemption for using smp_processor_id() in arch_spin_unlock_wait(), 
> to avoid following report:

 .../...

> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index bb7cfec..7a7c31b 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -72,8 +72,10 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
>  {
>  	while (lock->slock) {
>  		HMT_low();
> +		preempt_disable();
>  		if (SHARED_PROCESSOR)
>  			__spin_yield(lock);
> +		preempt_enable();
>  	}

I assume what you are protecting is the PACA access in SHARED_PROCESSOR
or is there more ?

In that case I'd say just make it use local_paca-> directly or something
like that. It doesn't matter if the access is racy, all processors will
have the same value for that field as far as I can tell.

Cheers,
Ben.
