Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A666B7251
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 15:44:09 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id AC34CDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 15:44:04 +1000 (EST)
Date: Sat, 20 Jun 2009 01:43:59 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, ben-linux@fluff.org, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: warp platform fix for i2c change
Message-ID: <20090620014359.6fee339a@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A change to the i2c subsystem breaks the warp platform code. The patch
is cleaner anyway, the old way was a bit crufty.

For those with keen eyes, the gratuitous change in the string from
PIKA to Warp is just so the logs look a bit nicer. The following two
lines tend to be printed one after another.

  Warp POST OK
  Warp DTM thread running.

Yeah, this will be the third patch to warp.c submitted in this
release....

Cheers,
   Sean

The i2c_client struct changed, breaking the code that looked for the ad7414
chip. Use the new of_find_i2c_device_by_node function added in 2.6.29.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 42e09a9..0362c88 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
+#include <linux/of_i2c.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -65,7 +66,6 @@ define_machine(warp) {
 
 static u32 post_info;
 
-/* I am not sure this is the best place for this... */
 static int __init warp_post_info(void)
 {
 	struct device_node *np;
@@ -194,9 +194,9 @@ static int pika_setup_leds(void)
 	return 0;
 }
 
-static void pika_setup_critical_temp(struct i2c_client *client)
+static void pika_setup_critical_temp(struct device_node *np,
+				     struct i2c_client *client)
 {
-	struct device_node *np;
 	int irq, rc;
 
 	/* Do this before enabling critical temp interrupt since we
@@ -208,14 +208,7 @@ static void pika_setup_critical_temp(struct i2c_client *client)
 	i2c_smbus_write_byte_data(client, 2, 65); /* Thigh */
 	i2c_smbus_write_byte_data(client, 3,  0); /* Tlow */
 
-	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
-	if (np == NULL) {
-		printk(KERN_ERR __FILE__ ": Unable to find ad7414\n");
-		return;
-	}
-
 	irq = irq_of_parse_and_map(np, 0);
-	of_node_put(np);
 	if (irq  == NO_IRQ) {
 		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
 		return;
@@ -244,32 +237,24 @@ static inline void pika_dtm_check_fan(void __iomem *fpga)
 
 static int pika_dtm_thread(void __iomem *fpga)
 {
-	struct i2c_adapter *adap;
+	struct device_node *np;
 	struct i2c_client *client;
 
-	/* We loop in case either driver was compiled as a module and
-	 * has not been insmoded yet.
-	 */
-	while (!(adap = i2c_get_adapter(0))) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
-	}
-
-	while (1) {
-		list_for_each_entry(client, &adap->clients, list)
-			if (client->addr == 0x4a)
-				goto found_it;
+	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
+	if (np == NULL)
+		return -ENOENT;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
+	client = of_find_i2c_device_by_node(np);
+	if (client == NULL) {
+		of_node_put(np);
+		return -ENOENT;
 	}
 
-found_it:
-	pika_setup_critical_temp(client);
+	pika_setup_critical_temp(np, client);
 
-	i2c_put_adapter(adap);
+	of_node_put(np);
 
-	printk(KERN_INFO "PIKA DTM thread running.\n");
+	printk(KERN_INFO "Warp DTM thread running.\n");
 
 	while (!kthread_should_stop()) {
 		int val;
@@ -291,7 +276,6 @@ found_it:
 	return 0;
 }
 
-
 static int __init pika_dtm_start(void)
 {
 	struct task_struct *dtm_thread;
