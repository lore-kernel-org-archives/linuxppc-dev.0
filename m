Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18742.21422.999737.179325@cargo.ozlabs.ibm.com>
Date: Wed, 3 Dec 2008 20:38:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] powerpc/pseries: fix idle sleep early exit state
In-Reply-To: <20081127155203.2a1d6af9@bull.net>
References: <20081127155203.2a1d6af9@bull.net>
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

Sebastien Dugue writes:

>   In pseries_dedicated_idle_sleep(), if we need to exit idle during the
> snooze period (i.e. need_resched or cpu has been offlined), then we should
> re-disable the interrupts and clear TIF_POLLING_NRFLAG before leaving.

Are you doing this because of a bug you actually observed, or did you
just find this by inspection?  I don't believe it's necessary to do
these things (disabling interrupts, clearing TIF_POLLING_NRFLAG)
because the code that calls it immediately reenables interrupts and
sets TIF_POLLING_NRFLAG again.  From arch/powerpc/kernel/idle.c (line
73):

				if (!need_resched() && !cpu_should_die())
					ppc_md.power_save();

				local_irq_enable();
				set_thread_flag(TIF_POLLING_NRFLAG);

Paul.
