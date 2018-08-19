Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tqgl6SlzzF2FQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 07:24:03 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 19 Aug 2018 21:23:57 +0100 (BST)
Message-ID: <4c6da0b4b44.4b608222@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT v2 3/4] powerpc/pasemi: Add Nemo board device init code.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c124c60de690c6.9f"
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

----=_BOUNDARY.6c124c60de690c6.9f
Content-Type: text/plain

Add routines for Nemo specific devices to init at boot time, these
being board level power-off and SB600's rtc.
    
Also add a run time variable to prevent these being activated
if we boot on a reference board.
    
Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

Changes made:

v2: Merged some #ifdef blocks
----=_BOUNDARY.6c124c60de690c6.9f
Content-Type: text/plain;
	name="devs.patch"
Content-Disposition: attachment;
	filename="devs.patch";
	size=1088

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index fad5280..98bf2f7 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -73,6 +73,40 @@ static void __noreturn pas_restart(char *cmd)
 		out_le32(reset_reg, 0x6000000);
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+void pas_shutdown(void)
+{
+	/* Set the PLD bit that makes the SB600 think the power button is being pressed */
+	void __iomem *pld_map = ioremap(0xf5000000,4096);
+	while (1)
+		out_8(pld_map+7,0x01);
+}
+
+/* RTC platform device structure as is not in device tree */
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
+
+static inline void nemo_init_rtc(void)
+{
+	platform_device_register_simple("rtc_cmos", -1, rtc_resource, 2);
+}
+
+#else
+
+static inline void nemo_init_rtc(void)
+{
+}
+#endif
+
 #ifdef CONFIG_SMP
 static arch_spinlock_t timebase_lock;
 static unsigned long timebase;

----=_BOUNDARY.6c124c60de690c6.9f--
