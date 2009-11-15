Return-Path: <alonz@discretix.com>
Received: from mail.discretix.com (mail.discretix.com [192.116.217.178])
	by ozlabs.org (Postfix) with SMTP id 73C15B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 Nov 2009 20:45:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
Date: Sun, 15 Nov 2009 11:34:26 +0200
Message-ID: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com>
From: "Alon Ziv" <alonz@discretix.com>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am using locally the attached (hackish) patch; could someone propose a
way to make it acceptable to mainline (or should I just keep this
quiet)?

diff --git a/arch/powerpc/platforms/44x/virtex.c
b/arch/powerpc/platforms/44x/virtex.c
index cf96cca..749a330 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -51,6 +51,16 @@ static int __init virtex_probe(void)
 	return 1;
 }
=20
+void (*board_reset_system)(char *);
+EXPORT_SYMBOL(board_reset_system);
+
+static void virtex_reset_system(char *cmd)
+{
+	if (board_reset_system)
+		board_reset_system(cmd);
+	ppc4xx_reset_system(cmd);
+}
+
 define_machine(virtex) {
 	.name			=3D "Xilinx Virtex440",
 	.probe			=3D virtex_probe,
@@ -58,5 +68,5 @@ define_machine(virtex) {
 	.init_IRQ		=3D xilinx_intc_init_tree,
 	.get_irq		=3D xilinx_intc_get_irq,
 	.calibrate_decr		=3D generic_calibrate_decr,
-	.restart		=3D ppc4xx_reset_system,
+	.restart		=3D virtex_reset_system,
 };
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index b20abe1..f3b4ab9 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -950,6 +950,19 @@ static struct block_device_operations ace_fops =3D {
 	.getgeo =3D ace_getgeo,
 };
=20
+extern void (*board_reset_system)(char *);
+static struct ace_device *the_ace_device;
+
+/* --------------------------------------------------------------------
+ * Board reset using ACE (forced FPGA reconfigure)
+ */
+static void ace_reset_system(char *cmd)
+{
+	printk(KERN_EMERG "ace_reset_system: attempting suicide\n");
+	ace_out(the_ace_device, ACE_CTRL, ACE_CTRL_FORCECFGMODE |
+		ACE_CTRL_CFGMODE | ACE_CTRL_CFGSTART | ACE_CTRL_CFGSEL);
+}
+
 /* --------------------------------------------------------------------
  * SystemACE device setup/teardown code
  */
@@ -1040,6 +1053,9 @@ static int __devinit ace_setup(struct ace_device
*ace)
 	val |=3D ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
 	ace_out(ace, ACE_CTRL, val);
=20
+	board_reset_system =3D ace_reset_system;
+	the_ace_device =3D ace;
+
 	/* Print the identification */
 	dev_info(ace->dev, "Xilinx SystemACE revision %i.%i.%i\n",
 		 (version >> 12) & 0xf, (version >> 8) & 0x0f, version &
0xff);
*************************************************************************=
*********************
IMPORTANT: The contents of this email and any attachments are confidentia=
l. They are intended for the=20
named recipient(s) only.
If you have received this email in error, please notify the system manage=
r or the sender immediately and do=20
not disclose the contents to anyone or make copies thereof.
