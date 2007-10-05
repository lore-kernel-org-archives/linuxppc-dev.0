Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCB21DDE3F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:16:19 +1000 (EST)
Date: Fri, 5 Oct 2007 12:16:01 -0500 (CDT)
Message-Id: <200710051716.l95HG1cV019434@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: Patch: Fix regression. Make hot unlplug of CPU0 work again.
References: <20071005035241.GO9814@bakeyournoodle.com>,
	<20071005070519.GQ9814@bakeyournoodle.com>
In-Reply-To: <20071005070519.GQ9814@bakeyournoodle.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 05:05:21PM, Tony Breeds wrote:
>> On Fri, Oct 05, 2007 at 01:52:41PM +1000, Tony Breeds wrote:
>> Early in the 2.6.23 cycle we broke the ability to offline cpu0
>> (7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
>> ensuring that the (xics)  default irq server, will not be 0 when taking
>> cpu0 offline.
>> 
>> Also catches a use of irq, when virq should be used (I think that the
>> last one).
> 
> Hmm testing, this on a JS21 shows that it doesn't work.  I guess I'll go
> back to the drawing board.


Reviewing the first patch, xics_set_affinity no longer looks at the
cpu_mask arg, instead get_irq_server reads it from the irq descriptor.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
On top of tonys patch (13926)

I don't have a system to test hotplug, so this is only compile tested.

A more complete fix might be to pass the cpu_mask struct to get_irq_server,
but kernel/irq/manage.c currently sets the descriptor first.

Index: kernel/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- kernel.orig/arch/powerpc/platforms/pseries/xics.c	2007-10-05 11:37:01.000000000 -0500
+++ kernel/arch/powerpc/platforms/pseries/xics.c	2007-10-05 11:37:16.000000000 -0500
@@ -890,8 +890,8 @@ void xics_migrate_irqs_away(void)
 		       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		desc->chip->set_affinity(virq, CPU_MASK_ALL);
 		irq_desc[virq].affinity = CPU_MASK_ALL;
+		desc->chip->set_affinity(virq, CPU_MASK_ALL);
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
