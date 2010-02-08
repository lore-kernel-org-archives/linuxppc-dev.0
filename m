Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 16:26:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] powerpc: Only print clockevent settings once
Message-ID: <20100208052629.GM32246@kryten>
References: <20100207222801.GE32246@kryten>
	<20100208045319.GA1405@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208045319.GA1405@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Wolfram,

> What about printk_once from kernel.h?

Thanks for the suggestion!

Anton
--

The clockevent multiplier and shift is useful information, but we
only need to print it once.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/time.c	2010-02-08 11:45:12.933073040 +1100
+++ powerpc.git/arch/powerpc/kernel/time.c	2010-02-08 16:21:08.505571532 +1100
@@ -935,8 +935,8 @@ static void register_decrementer_clockev
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);
 
-	printk(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
-	       dec->name, dec->mult, dec->shift, cpu);
+	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
+		    dec->name, dec->mult, dec->shift, cpu);
 
 	clockevents_register_device(dec);
 }
