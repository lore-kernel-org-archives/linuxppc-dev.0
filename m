Return-Path: <anton@ozlabs.org>
Date: Tue, 11 May 2010 12:23:29 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mikey@neuling.org, michael@ellerman.id.au,
	miltonm@bga.com
Subject: [PATCH 1/3] powerpc: kdump: Fix NULL pointer dereference in irq
	disable code
Message-ID: <20100511022329.GE12203@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


With sparse irqs we have to check if we have a descriptor before dereferencing
it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 6f4613d..5182439 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -375,6 +375,9 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	for_each_irq(i) {
 		struct irq_desc *desc = irq_to_desc(i);
 
+		if (!desc)
+			continue;
+
 		if (desc->status & IRQ_INPROGRESS)
 			desc->chip->eoi(i);
 
