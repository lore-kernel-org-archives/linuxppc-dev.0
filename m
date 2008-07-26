Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 630F0DDF33
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 11:45:09 +1000 (EST)
Date: Fri, 25 Jul 2008 21:45:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Cleanup for i2c driver changes.
Message-ID: <20080725214510.400c6ce8@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the i2c code which is now obsolete due to the new
ibm iic driver walking the device tree for child nodes.

There are two other small cleanups that came indirectly from the ad7414
code review. Make sure Tlow is correct and handle the case where
i2c_smbus_read_word_data fails.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 9565995..960edf8 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -30,18 +30,6 @@ static __initdata struct of_device_id warp_of_bus[] = {
 	{},
 };
 
-static __initdata struct i2c_board_info warp_i2c_info[] = {
-	{ I2C_BOARD_INFO("ad7414", 0x4a) }
-};
-
-static int __init warp_arch_init(void)
-{
-	/* This should go away once support is moved to the dts. */
-	i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
-	return 0;
-}
-machine_arch_initcall(warp, warp_arch_init);
-
 static int __init warp_device_probe(void)
 {
 	of_platform_bus_probe(NULL, warp_of_bus, NULL);
@@ -223,7 +211,7 @@ static void pika_setup_critical_temp(struct i2c_client *client)
 
 	/* These registers are in 1 degree increments. */
 	i2c_smbus_write_byte_data(client, 2, 65); /* Thigh */
-	i2c_smbus_write_byte_data(client, 3, 55); /* Tlow */
+	i2c_smbus_write_byte_data(client, 3,  0); /* Tlow */
 
 	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
 	if (np == NULL) {
@@ -289,8 +277,15 @@ found_it:
 	printk(KERN_INFO "PIKA DTM thread running.\n");
 
 	while (!kthread_should_stop()) {
-		u16 temp = swab16(i2c_smbus_read_word_data(client, 0));
-		out_be32(fpga + 0x20, temp);
+		int val;
+
+		val = i2c_smbus_read_word_data(client, 0);
+		if (val < 0)
+			dev_dbg(&client->dev, "DTM read temp failed.\n");
+		else {
+			s16 temp = swab16(val);
+			out_be32(fpga + 0x20, temp);
+		}
 
 		pika_dtm_check_fan(fpga);
 
