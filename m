Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 44975DEA83
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:41:11 +1100 (EST)
Message-ID: <45B8188E.7020602@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:14 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 9/14] ps3: add interrupt alloc for outlets
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3 interrupt core update:
  - Add ps3_alloc_irq() and ps3_free_irq(), to allocate a virtual interrupt
    number for an interrupt outlet, which is needed by the PS3 GPU frame
    buffer device and audio drivers

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |   12 ++++++++++++
 include/asm-powerpc/ps3.h              |    3 +++
 2 files changed, 15 insertions(+)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -412,6 +412,18 @@ int ps3_free_spe_irq(unsigned int virq)
 	return 0;
 }
 
+int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
+	unsigned int *virq)
+{
+	return ps3_connect_irq(cpu, outlet, virq);
+}
+
+int ps3_free_irq(unsigned int virq)
+{
+	ps3_disconnect_irq(virq);
+	return 0;
+}
+
 #define PS3_INVALID_OUTLET ((irq_hw_number_t)-1)
 #define PS3_PLUG_MAX 63
 
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -163,6 +163,9 @@ int ps3_free_vuart_irq(unsigned int virq
 int ps3_alloc_spe_irq(enum ps3_cpu_binding cpu, unsigned long spe_id,
 	unsigned int class, unsigned int *virq);
 int ps3_free_spe_irq(unsigned int virq);
+int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
+	unsigned int *virq);
+int ps3_free_irq(unsigned int virq);
 
 /* lv1 result codes */
 
