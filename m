Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EED2F67B26
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 15:51:26 +1000 (EST)
Subject: pSeries_mach_cpu_die() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 15:16:32 +1000
Message-Id: <1149225392.16202.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While doing some autumn cleaning of the irq stuff in general and xics
specifically, I found out that
the low level pSeriesLP_cppr_info() is exported because
pSeries_mach_cpu_die() calls it:

static void pSeries_mach_cpu_die(void)
{
	local_irq_disable();
	idle_task_exit();
	/* Some hardware requires clearing the CPPR, while other hardware does
not
	 * it is safe either way
	 */
	pSeriesLP_cppr_info(0, 0);
	rtas_stop_self();
	/* Should never get here... */
	BUG();
	for(;;);
}

This leads to a few questions:

 - We always pass "0" as the CPU. Is that right ? I seems not, but maybe
pHyp doesn't care and always assume the calling CPU ...

 - xics has a xics_teardown_cpu() now, used by kexec, that does
something very similar except that it passes the proper CPU number, and
for secondary CPUs also does an EOI of any pending IPI (just in case). I
think that could be used instead of the direct call to the low level
pSeriesLP_* funciton (which I itend to unexport and rename anyway as
part of my rework). Can whoever knows that code confirm ?

 - There is a comment about "some hardware....", what does it mean ? Is
it ok to do it unconditionally ? I suppose so but heh...

Cheers,
Ben.
