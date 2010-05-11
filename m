Return-Path: <anton@ozlabs.org>
Date: Tue, 11 May 2010 12:27:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mikey@neuling.org, miltonm@bga.com,
	michael@ellerman.id.au, paulus@samba.org
Subject: [PATCH 3/3] powerpc: kdump: Use chip->shutdown to disable IRQs
Message-ID: <20100511022738.GG12203@kryten>
References: <20100511022329.GE12203@kryten>
 <20100511022551.GF12203@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100511022551.GF12203@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I saw this in a kdump kernel:

IOMMU table initialized, virtual merging enabled
Interrupt 155954 (real) is invalid, disabling it.
Interrupt 155953 (real) is invalid, disabling it.

ie we took some spurious interrupts. default_machine_crash_shutdown tries
to disable all interrupt sources but uses chip->disable which maps to
the default action of:

static void default_disable(unsigned int irq)
{
}

If we use chip->shutdown, then we actually mask the IRQ:

static void default_shutdown(unsigned int irq)
{
        struct irq_desc *desc = irq_to_desc(irq);

        desc->chip->mask(irq);
        desc->status |= IRQ_MASKED;
}

Not sure why we don't implement a ->disable action for xics.c, or why
default_disable doesn't mask the interrupt.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/crash.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/crash.c	2010-05-10 23:43:10.445953883 +1000
+++ linux-2.6/arch/powerpc/kernel/crash.c	2010-05-10 23:43:21.223454012 +1000
@@ -315,7 +315,7 @@ void default_machine_crash_shutdown(stru
 			desc->chip->eoi(i);
 
 		if (!(desc->status & IRQ_DISABLED))
-			desc->chip->disable(i);
+			desc->chip->shutdown(i);
 	}
 
 	/*
