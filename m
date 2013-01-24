Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D1B5E2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 14:47:22 +1100 (EST)
Message-ID: <1358999231.29726.9.camel@pasglop>
Subject: Re: [PATCH powerpc ] Avoid debug_smp_processor_id() check in
 arch_spin_unlock_wait()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Thu, 24 Jan 2013 14:47:11 +1100
In-Reply-To: <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
 <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
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

On Thu, 2013-01-10 at 17:00 +0800, Li Zhong wrote:
> Use local_paca directly in arch_spin_unlock_wait(), as all processors have the
> same value for the field shared_proc, so we don't need care racy here.

Of course that won't build if CONFIG_PPC_SPLPAR isn't defined...

Maybe you could change the definition of the SHARED_PROCESSOR
macro itself. The only possible "risk" would be a stale lppaca
if we preempt & hot unplug the CPU at the wrong time (provided
we no longer stop_machine either), I suppose if that's a real
concern we could delay freeing of lppaca's via RCU or such.

Ben.

> Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/locks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index bb7cfec..850bea6 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -72,7 +72,7 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
>  {
>  	while (lock->slock) {
>  		HMT_low();
> -		if (SHARED_PROCESSOR)
> +		if (local_paca->lppaca_ptr->shared_proc)
>  			__spin_yield(lock);
>  	}
>  	HMT_medium();
