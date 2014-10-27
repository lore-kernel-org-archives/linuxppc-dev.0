Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 860351A19C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 17:41:20 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 02:41:17 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTPS id 53E84C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:29:57 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R6fDo158851558
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 06:41:13 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R6fDs6027071
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:41:13 -0400
Message-ID: <544DE8F9.5070100@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 12:10:57 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 09/11] powerpc: kvm: handle time base on secondary hwthread
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-10-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-10-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
> (This is a place holder patch.)
> We need to store the time base for host on secondary hwthread.
> Later when switching back, we need to reprogram it with elapse
> time.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 89ea16c..a817ba6 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -371,6 +371,8 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
>  
>  	/* fixme: store other register such as msr */
>  
> +	/* fixme: store the tb, and set it as MAX, so we cease the tick on secondary */

This can lead to serious consequences. First of all, even if we set the
decrementer(not tb) to MAX, it is bound to fire after 4s. That is the
maximum time till which you can keep off the decrementer from firing.

In the hotplug path, the offline cpus nap and their decrementers are
programmed to fire at MAX too. But the difference is that we clear the
LPCR_PECE1 wakeup bit which prevents cpus from waking up on a
decrementer interrupt.

We cannot afford to do this here though because there are other tasks on
the secondary threads' runqueue. They need to be scheduled in.
There are also timers besides the tick_sched one, which can be queued on
these secondary threads. These patches have not taken care to migrate
timers or tasks before entering guest as far as I observed. Hence we
cannot just turn off time base like this and expect to handle the above
mentioned events the next time the primary thread decides to exit to the
host.

Regards
Preeti U Murthy
> +
>  	/* prevent us to enter kernel */
>  	li	r0, 1
>  	stb	r0, HSTATE_HWTHREAD_REQ(r13)
> @@ -382,6 +384,10 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
>  
>  /* enter with vmode */
>  kvmppc_secondary_stopper_exit:
> +	/* fixme: restore the tb, with the orig val plus time elapse
> +         * so we can fire the hrtimer as soon as possible
> +         */
> +
>  	/* fixme, restore the stack which we store on lpaca */
>  
>  	ld	r0, 112+PPC_LR_STKOFF(r1)
> 
