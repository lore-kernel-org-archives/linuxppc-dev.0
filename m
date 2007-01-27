Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1FEEDE629
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:18 +1100 (EST)
Message-ID: <45BAC21C.7000104@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:12 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/16] ps3: add interrupt alloc for outlets
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
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

Got rid of the redundent symbols ps3_connect_irq & ps3_disconnect_irq
as requested by Ben and Geert.

 arch/powerpc/platforms/ps3/interrupt.c |   24 ++++++++++++++----------
 include/asm-powerpc/ps3.h              |    3 +++
 2 files changed, 17 insertions(+), 10 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -85,7 +85,7 @@ struct ps3_private {
 
 static DEFINE_PER_CPU(struct ps3_private, ps3_private);
 
-static int ps3_connect_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
+int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
 	unsigned int *virq)
 {
 	int result;
@@ -138,8 +138,9 @@ fail_connect:
 fail_create:
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_alloc_irq);
 
-static void ps3_disconnect_irq(unsigned int virq)
+int ps3_free_irq(unsigned int virq)
 {
 	int result;
 	const struct ps3_private *pd = get_irq_chip_data(virq);
@@ -155,7 +156,9 @@ static void ps3_disconnect_irq(unsigned 
 
 	set_irq_chip_data(virq, NULL);
 	irq_dispose_mapping(virq);
+	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_free_irq);
 
 /**
  * ps3_alloc_io_irq - Assign a virq to a system bus device.
@@ -182,7 +185,7 @@ int ps3_alloc_io_irq(enum ps3_cpu_bindin
 		return result;
 	}
 
-	result = ps3_connect_irq(cpu, outlet, virq);
+	result = ps3_alloc_irq(cpu, outlet, virq);
 	BUG_ON(result);
 
 	return result;
@@ -198,7 +201,7 @@ int ps3_free_io_irq(unsigned int virq)
 		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	ps3_disconnect_irq(virq);
+	ps3_free_irq(virq);
 
 	return result;
 }
@@ -228,7 +231,7 @@ int ps3_alloc_event_irq(enum ps3_cpu_bin
 		return result;
 	}
 
-	result = ps3_connect_irq(cpu, outlet, virq);
+	result = ps3_alloc_irq(cpu, outlet, virq);
 	BUG_ON(result);
 
 	return result;
@@ -246,7 +249,7 @@ int ps3_free_event_irq(unsigned int virq
 		pr_debug("%s:%d: lv1_destruct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	ps3_disconnect_irq(virq);
+	ps3_free_irq(virq);
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return result;
@@ -350,7 +353,7 @@ int ps3_alloc_vuart_irq(enum ps3_cpu_bin
 		return result;
 	}
 
-	result = ps3_connect_irq(cpu, outlet, virq);
+	result = ps3_alloc_irq(cpu, outlet, virq);
 	BUG_ON(result);
 
 	return result;
@@ -368,7 +371,7 @@ int ps3_free_vuart_irq(unsigned int virq
 		return result;
 	}
 
-	ps3_disconnect_irq(virq);
+	ps3_free_irq(virq);
 
 	return result;
 }
@@ -399,7 +402,7 @@ int ps3_alloc_spe_irq(enum ps3_cpu_bindi
 		return result;
 	}
 
-	result = ps3_connect_irq(cpu, outlet, virq);
+	result = ps3_alloc_irq(cpu, outlet, virq);
 	BUG_ON(result);
 
 	return result;
@@ -407,10 +410,11 @@ int ps3_alloc_spe_irq(enum ps3_cpu_bindi
 
 int ps3_free_spe_irq(unsigned int virq)
 {
-	ps3_disconnect_irq(virq);
+	ps3_free_irq(virq);
 	return 0;
 }
 
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
 
