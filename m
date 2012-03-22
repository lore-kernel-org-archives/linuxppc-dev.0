Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:56:49 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/6] powerpc/pseries: Remove RTAS_POWERMGM_EVENTS
Message-ID: <20120322125649.434c6f5e@kryten>
In-Reply-To: <20120322125343.63d77e82@kryten>
References: <20120322124707.3cd3037f@kryten> <20120322125343.63d77e82@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


IBM bit 2 in the rtas event-scan and check-exception calls is
marked reserved in the PAPR, so remove it from our RAS code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/rtas.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/rtas.h	2012-03-22 12:41:38.079754144 +1100
+++ linux-build/arch/powerpc/include/asm/rtas.h	2012-03-22 12:43:56.574267101 +1100
@@ -74,7 +74,6 @@ struct rtas_suspend_me_data {
 /* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
-#define RTAS_POWERMGM_EVENTS		0x20000000 /* set bit 2 */
 #define RTAS_HOTPLUG_EVENTS		0x10000000 /* set bit 3 */
 #define RTAS_IO_EVENTS			0x08000000 /* set bit 4 */
 #define RTAS_EVENT_SCAN_ALL_EVENTS	0xffffffff
Index: linux-build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:43:50.842163086 +1100
+++ linux-build/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:43:56.574267101 +1100
@@ -223,7 +223,7 @@ static irqreturn_t ras_epow_interrupt(in
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
 			   RTAS_VECTOR_EXTERNAL_INTERRUPT,
 			   virq_to_hw(irq),
-			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
+			   RTAS_EPOW_WARNING,
 			   critical, __pa(&ras_log_buf),
 				rtas_get_error_log_max());
 
