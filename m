Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8vvK1vHqzDr29
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 09:22:04 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 31 Dec 2017 22:08:46 +0000 (GMT)
Message-ID: <4b3d20c0900.2ef0ae17@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT 3/4] powerpc/pasemi: Add Nemo board device init code.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c368940b380086.ba"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c368940b380086.ba
Content-Type: text/plain

    Add routines for Nemo specific devices to init at boot time, these
    being board level power-off and SB600's rtc.
    
    Also add a run time variable to prevent these being activated
    if we boot on a reference board.
    
    Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---
----=_BOUNDARY.6c368940b380086.ba
Content-Type: text/plain;
	name="devs.patch"
Content-Disposition: attachment;
	filename="devs.patch";
	size=1563

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index c583c17..8d3664f 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -73,6 +73,19 @@ static void __noreturn pas_restart(char *cmd)
 		out_le32(reset_reg, 0x6000000);
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+/* A flag to indicate we are running on Nemo */
+static bool nemo_board = false;
+
+void pas_shutdown(void)
+{
+	/* Set the PLD bit that makes the SB600 think the power button is being pressed */
+	void __iomem *pld_map = ioremap(0xf5000000,4096);
+	while (1)
+		out_8(pld_map+7,0x01);
+}
+#endif
+
 #ifdef CONFIG_SMP
 static arch_spinlock_t timebase_lock;
 static unsigned long timebase;
@@ -492,6 +505,20 @@ static inline void pasemi_pcmcia_init(void)
 	{},
 };
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static struct resource rtc_resource[] = {{
+	.name = "rtc",
+	.start = 0x70,
+	.end = 0x71,
+	.flags = IORESOURCE_IO,
+}, {
+	.name = "rtc",
+	.start = 8,
+	.end = 8,
+	.flags = IORESOURCE_IRQ,
+}};
+#endif
+
 static int __init pasemi_publish_devices(void)
 {
 	pasemi_pcmcia_init();
@@ -499,6 +526,14 @@ static int __init pasemi_publish_devices(void)
 	/* Publish OF platform devices for SDC and other non-PCI devices */
 	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	/*
+	 * Activate the SB600's rtc
+	 */
+	if (nemo_board)
+		platform_device_register_simple("rtc_cmos", -1, rtc_resource, 2);
+#endif
+
 	return 0;
 }
 machine_device_initcall(pasemi, pasemi_publish_devices);

----=_BOUNDARY.6c368940b380086.ba--
