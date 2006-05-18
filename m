Return-Path: <hollisb@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C6AC67A44
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 08:00:04 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4ILXGY7029638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:33:16 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4ILXAwK031447
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:33:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4ILXBkO214878
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:33:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4ILXAQE012916
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:33:10 -0400
Subject: [patch] fix RTC/NVRAM accesses on Maple
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 18 May 2006 16:34:00 -0500
Message-Id: <1147988040.2692.40.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like RTC and NVRAM accesses (including halt/reboot) on Maple
have been broken since January, when an untested build fix went in
("[PATCH] powerpc: Fix Maple build").

PIBS (the firmware on Maple) has a bad "ranges" property for the ISA
bus, which means of_address_to_resource() fails for ISA devices, and
that breaks maple_find_nvram_base() and maple_get_boot_time().

This patch adds ifdefs mid-file, but some were already present anyways,
and I don't see a better way.

Please apply.

-- 
Hollis Blanchard
IBM Linux Technology Center

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff -r 5158eb8d85b7 arch/powerpc/kernel/prom_init.c
--- a/arch/powerpc/kernel/prom_init.c	Thu May 18 11:32:22 2006 +0700
+++ b/arch/powerpc/kernel/prom_init.c	Thu May 18 16:23:40 2006 -0500
@@ -2057,10 +2057,44 @@ static void __init flatten_device_tree(v
 
 }
 
-
-static void __init fixup_device_tree(void)
-{
+#ifdef CONFIG_PPC_MAPLE
+/* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges property.
+ * The values are bad, and it doesn't even have the right number of cells. */
+static void __init fixup_device_tree_maple(void)
+{
+	phandle isa;
+	u32 isa_ranges[6];
+
+	isa = call_prom("finddevice", 1, 1, ADDR("/ht@0/isa@4"));
+	if (!PHANDLE_VALID(isa))
+		return;
+
+	if (prom_getprop(isa, "ranges", isa_ranges, sizeof(isa_ranges))
+	    == PROM_ERROR)
+		return;
+
+	if (isa_ranges[0] != 0x1 ||
+	    isa_ranges[1] != 0xf4000000 ||
+	    isa_ranges[2] != 0x00010000)
+		return;
+
+	prom_printf("fixing up bogus ISA range on Maple...\n");
+
+	isa_ranges[0] = 0x1;
+	isa_ranges[1] = 0x0;
+	isa_ranges[2] = 0x0;
+	isa_ranges[3] = 0x0;
+	isa_ranges[4] = 0x0;
+	isa_ranges[5] = 0x00010000;
+	prom_setprop(isa, "/ht@0/isa@4", "ranges",
+		     isa_ranges, sizeof(isa_ranges));
+}
+#endif
+
+		
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
+static void __init fixup_device_tree_pmac(void)
+{
 	phandle u3, i2c, mpic;
 	u32 u3_rev;
 	u32 interrupts[2];
@@ -2097,9 +2131,18 @@ static void __init fixup_device_tree(voi
 	parent = (u32)mpic;
 	prom_setprop(i2c, "/u3@0,f8000000/i2c@f8001000", "interrupt-parent",
 		     &parent, sizeof(parent));
-#endif
-}
-
+}
+#endif
+
+static void __init fixup_device_tree(void)
+{
+#ifdef CONFIG_PPC_MAPLE
+	fixup_device_tree_maple();
+#endif
+#if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
+	fixup_device_tree_pmac();
+#endif
+}
 
 static void __init prom_find_boot_cpu(void)
 {
