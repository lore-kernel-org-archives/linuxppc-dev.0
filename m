Return-Path: <hollisb@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 892DC67A79
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 07:49:24 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4PLaGGI002206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 17:36:16 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4PLa48R016010
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 17:36:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4PLa4gW129814
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 17:36:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4PLa3M5002771
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 17:36:04 -0400
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17516.64514.854281.64425@cargo.ozlabs.ibm.com>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
	<17516.64514.854281.64425@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 16:36:53 -0500
Message-Id: <1148593014.15517.32.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-19 at 08:58 +1000, Paul Mackerras wrote:
> Care to redo the patch?

After some offline discussion, I think we're in agreement that these
properties are fine, since Linux's device tree code can't handle
multiple ranges. Right Segher?

-- 
Hollis Blanchard
IBM Linux Technology Center

Due to a firmware device tree bug, RTC and NVRAM accesses (including
halt/reboot) on Maple have been broken since January, when an untested
build fix went in. This code patches the device tree in Linux.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

diff -r 5158eb8d85b7 arch/powerpc/kernel/prom_init.c
--- a/arch/powerpc/kernel/prom_init.c	Thu May 18 11:32:22 2006 +0700
+++ b/arch/powerpc/kernel/prom_init.c	Thu May 25 16:30:10 2006 -0500
@@ -2057,10 +2057,45 @@ static void __init flatten_device_tree(v
 
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
+		== PROM_ERROR)
+		return;
+
+	if (isa_ranges[0] != 0x1 ||
+		isa_ranges[1] != 0xf4000000 ||
+		isa_ranges[2] != 0x00010000)
+		return;
+
+	prom_printf("fixing up bogus ISA range on Maple...\n");
+
+	isa_ranges[0] = 0x1;
+	isa_ranges[1] = 0x0;
+	isa_ranges[2] = 0x01002000; /* IO space; PCI device = 4 */
+	isa_ranges[3] = 0x0;
+	isa_ranges[4] = 0x0;
+	isa_ranges[5] = 0x00010000;
+	prom_setprop(isa, "/ht@0/isa@4", "ranges",
+			isa_ranges, sizeof(isa_ranges));
+}
+#else
+#define fixup_device_tree_maple()
+#endif
+
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
+static void __init fixup_device_tree_pmac(void)
+{
 	phandle u3, i2c, mpic;
 	u32 u3_rev;
 	u32 interrupts[2];
@@ -2097,9 +2132,16 @@ static void __init fixup_device_tree(voi
 	parent = (u32)mpic;
 	prom_setprop(i2c, "/u3@0,f8000000/i2c@f8001000", "interrupt-parent",
 		     &parent, sizeof(parent));
-#endif
-}
-
+}
+#else
+#define fixup_device_tree_pmac()
+#endif
+
+static void __init fixup_device_tree(void)
+{
+	fixup_device_tree_maple();
+	fixup_device_tree_pmac();
+}
 
 static void __init prom_find_boot_cpu(void)
 {
