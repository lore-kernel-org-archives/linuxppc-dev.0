Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by lists.ozlabs.org (Postfix) with ESMTP id 66A051A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:07:07 +1000 (AEST)
Date: Thu, 14 May 2015 13:06:56 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: G5 Xserve rackmeter broken?
Message-ID: <20150514100656.GC609@fuloong-minipc.musicnaut.iki.fi>
References: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
 <1431296015.13039.12.camel@kernel.crashing.org>
 <20150512175555.GB609@fuloong-minipc.musicnaut.iki.fi>
 <1431463180.20218.57.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431463180.20218.57.camel@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, May 13, 2015 at 06:39:40AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2015-05-12 at 20:55 +0300, Aaro Koskinen wrote:
> > I'm running with HZ=100 so the values are still probably within
> > jiffy resolution, so perhaps the calculation should first do
> > idle = min(idle, total)?
> 
> Does it gives you a reasonable output if you do that ?

The below change fixes the idle system blinking behaviour.

I'm also able to reproduce the leds going off during full CPU load case.
It seems there is some DMA error. Normally, reading rm->dma_regs->status
in the IRQ handler gives 0x8400. In the failure cases I've seen values
0x8880 and 0x8980 - the IRQ will stop after this and it will need
paused -> started cycle before it gets going again (but sometimes fails
again soon after).

A.

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 048901a..3381fa59 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -227,6 +227,7 @@ static void rackmeter_do_timer(struct work_struct *work)
 
 	total_idle_ticks = get_cpu_idle_time(cpu);
 	idle_ticks = (unsigned int) (total_idle_ticks - rcpu->prev_idle);
+	idle_ticks = min(idle_ticks, total_ticks);
 	rcpu->prev_idle = total_idle_ticks;
 
 	/* We do a very dumb calculation to update the LEDs for now,
