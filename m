Return-Path: <kevcorry@us.ibm.com>
From: Kevin Corry <kevcorry@us.ibm.com>
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 0/2] Oprofile-on-Cell prereqs
Date: Thu, 9 Nov 2006 08:58:11 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611090858.11590.kevcorry@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are two patches that provide some prerequisites for the upcoming 
Oprofile-on-Cell patches, which Maynard Johnson will be posting.

These patches are against the 2.6.18-arnd5 tree.

1. cbe_pmu_interrupts.diff
Add routines for managing the Cell PMU interrupts.

The following routines are added to arch/powerpc/platforms/cell/pmu.c:
 cbe_clear_pm_interrupts()
 cbe_enable_pm_interrupts()
 cbe_disable_pm_interrupts()
 cbe_query_pm_interrupts()
 pm_init_IRQ()

This also adds two routines to arch/powerpc/platforms/cell/interrupt.c
to manipulate the IIC_IS and IIC_IR registers:
 iic_clear_pmi_interrupt()
 iic_set_interrupt_routing()

We are still working on how to clean up cbe_clear_pm_interrupts() and
cbe_enable_pm_interrupts() so we hopefully won't need to call the
iic_ routines (and also not need the additions to interrupt.c).

2. export_hrtimer_forward.diff
Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
be built as a module.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
