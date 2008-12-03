Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 066E6DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 21:07:14 +1100 (EST)
Date: Wed, 3 Dec 2008 11:07:10 +0100
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/pseries: fix idle sleep early exit state
Message-ID: <20081203110710.2be536e8@bull.net>
In-Reply-To: <18742.21422.999737.179325@cargo.ozlabs.ibm.com>
References: <20081127155203.2a1d6af9@bull.net>
	<18742.21422.999737.179325@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008 20:38:54 +1100 Paul Mackerras <paulus@samba.org> wrote:

> Sebastien Dugue writes:
> 
> >   In pseries_dedicated_idle_sleep(), if we need to exit idle during the
> > snooze period (i.e. need_resched or cpu has been offlined), then we should
> > re-disable the interrupts and clear TIF_POLLING_NRFLAG before leaving.
> 
> Are you doing this because of a bug you actually observed, or did you
> just find this by inspection?

  By inspection, and just to be consistent with the other way out. But
you're right, it's not really necessary here.

>  I don't believe it's necessary to do
> these things (disabling interrupts, clearing TIF_POLLING_NRFLAG)
> because the code that calls it immediately reenables interrupts and
> sets TIF_POLLING_NRFLAG again.  From arch/powerpc/kernel/idle.c (line
> 73):
> 
> 				if (!need_resched() && !cpu_should_die())
> 					ppc_md.power_save();
> 
> 				local_irq_enable();
> 				set_thread_flag(TIF_POLLING_NRFLAG);
> 
> Paul.
> 

  Thanks,

  Sebastien.
