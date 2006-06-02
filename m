Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 216EC67B27
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 16:25:51 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id 9D4032BDB60F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 02:20:15 -0400 (EDT)
Date: Fri, 2 Jun 2006 01:19:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pSeries_mach_cpu_die() question
Message-ID: <20060602061929.GM8934@localdomain>
References: <1149225392.16202.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149225392.16202.52.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> While doing some autumn cleaning of the irq stuff in general and xics
> specifically, I found out that
> the low level pSeriesLP_cppr_info() is exported because
> pSeries_mach_cpu_die() calls it:
> 
> static void pSeries_mach_cpu_die(void)
> {
> 	local_irq_disable();
> 	idle_task_exit();
> 	/* Some hardware requires clearing the CPPR, while other hardware does
> not
> 	 * it is safe either way
> 	 */
> 	pSeriesLP_cppr_info(0, 0);
> 	rtas_stop_self();
> 	/* Should never get here... */
> 	BUG();
> 	for(;;);
> }
> 
> This leads to a few questions:
> 
>  - We always pass "0" as the CPU. Is that right ? I seems not, but maybe
> pHyp doesn't care and always assume the calling CPU ...

The cpu parameter is actually unused by in the lpar case:

void pSeriesLP_cppr_info(int n_cpu, u8 value)
{
	unsigned long lpar_rc;

	lpar_rc = plpar_cppr(value);
	if (lpar_rc != H_SUCCESS)
		panic("bad return code cppr - rc = %lx\n", lpar_rc);
}


>  - xics has a xics_teardown_cpu() now, used by kexec, that does
> something very similar except that it passes the proper CPU number, and
> for secondary CPUs also does an EOI of any pending IPI (just in case). I
> think that could be used instead of the direct call to the low level
> pSeriesLP_* funciton (which I itend to unexport and rename anyway as
> part of my rework). Can whoever knows that code confirm ?

Sounds okay to me.


>  - There is a comment about "some hardware....", what does it mean ? Is
> it ok to do it unconditionally ? I suppose so but heh...

The comment should be changed or removed really.  We got away without
doing plpar_cppr() on the Power4 hypervisor but we found out it was
necessary when testing Power5.  I think it's required by the
architecture regardless, and yes, it's safe on both platforms.
