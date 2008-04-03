Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86534DDF24
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 08:51:12 +1100 (EST)
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20080403190943.GA16446@ru.mvista.com>
References: <20080403190943.GA16446@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 08:50:36 +1100
Message-Id: <1207259436.10388.337.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-03 at 23:09 +0400, Valentine Barshak wrote:
> We really need to ack interrupts at mpic_teardown, since
> not all platforms reset mpic at kernel start-up. For example,
> kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---

Would be interesting to find out why it hangs tho... it shouldn't .

Ben.

>  arch/powerpc/sysdev/mpic.c |    6 +-----
>  1 files changed, 1 insertion(+), 5 deletions(-)
> 
> --- powerpc/arch/powerpc/sysdev/mpic.c	2008-02-26 15:56:57.000000000 +0300
> +++ linux-2.6.new/arch/powerpc/sysdev/mpic.c	2008-04-03 23:00:45.000000000 +0400
> @@ -1410,11 +1410,6 @@ void mpic_cpu_set_priority(int prio)
>  	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
>  }
>  
> -/*
> - * XXX: someone who knows mpic should check this.
> - * do we need to eoi the ipi including for kexec cpu here (see xics comments)?
> - * or can we reset the mpic in the new kernel?
> - */
>  void mpic_teardown_this_cpu(int secondary)
>  {
>  	struct mpic *mpic = mpic_primary;
> @@ -1434,6 +1429,7 @@ void mpic_teardown_this_cpu(int secondar
>  
>  	/* Set current processor priority to max */
>  	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
> +	mpic_eoi(mpic);
>  
>  	spin_unlock_irqrestore(&mpic_lock, flags);
>  }
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
