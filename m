Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79FB31007D5
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jun 2010 04:02:31 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5II12fB032238
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 14:01:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5II2RKL055816
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 14:02:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5II2Qvs007644
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 14:02:27 -0400
Date: Fri, 18 Jun 2010 11:02:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Linux cannot run with 0 cores
Message-ID: <20100618180222.GH2365@linux.vnet.ibm.com>
References: <20100618003306.GA3463@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100618003306.GA3463@kryten>
Cc: linuxppc-dev@ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 18, 2010 at 10:33:06AM +1000, Anton Blanchard wrote:
> 
> If we configure with CONFIG_SMP=n or set NR_CPUS less than the number of
> SMT threads we will set the max cores property to 0 in the
> ibm,client-architecture-support structure. On new versions of firmware that
> understand this property it obliges and terminates our partition.
> 
> Use DIV_ROUND_UP so we handle not only the CONFIG_SMP=n case but also the
> case where NR_CPUS isn't a multiple of the number of SMT threads.

Thank you, Anton!!!

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

(Will test as soon as the system that hit this becomes available.)

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-2.6/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/prom_init.c	2010-06-17 09:08:20.000000000 +1000
> +++ linux-2.6/arch/powerpc/kernel/prom_init.c	2010-06-17 09:10:02.000000000 +1000
> @@ -872,7 +872,7 @@ static void __init prom_send_capabilitie
>  				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
>  				    *cores);
>  		} else {
> -			*cores = NR_CPUS / prom_count_smt_threads();
> +			*cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
>  			prom_printf("Max number of cores passed to firmware: 0x%x\n",
>  				    (unsigned long)*cores);
>  		}
