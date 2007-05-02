Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17976.28170.695715.416339@cargo.ozlabs.ibm.com>
Date: Wed, 2 May 2007 20:55:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
In-Reply-To: <1178086872.13233.27.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with the decrementer frequency set
> to minimum. To wake them up again we kick them just like when bringing
> them up. To stop those CPUs from messing with any global state we stop
> them from entering the timer interrupt.

Ultimately we want to put the disabled cpus in sleep mode, but that
will require a suitable cache flush routine.

For now, the patch mostly looks OK, except that I would prefer that
you make power4_idle_irqs_softdisabled a separate function from
power4_idle (and choose a better name while you're there :).  There
are enough differences between power4_idle and your new routine that
it would be clearer if they're separate.  For one thing your new
routine wouldn't need to set _TLF_NAPPING, for another, it wouldn't
need the conditional branch at the end.  Also you could do the test
for the nap capability in the caller.

Paul.
