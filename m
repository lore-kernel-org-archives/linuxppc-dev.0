Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id E9C9367F9A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 03:25:00 +1000 (EST)
Message-ID: <430372E9.7040700@ru.mvista.com>
Date: Wed, 17 Aug 2005 21:24:57 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------080109080001030000050307"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: ppc_sys SOC identification additions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080109080001030000050307
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Kumar,
this is proposed extension of ppc_sys identify functions.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------080109080001030000050307
Content-Type: text/x-patch;
 name="ppc_sys_add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_sys_add.patch"

diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -6,6 +6,7 @@
  * Maintainer: Kumar Gala <kumar.gala@freescale.com>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2005 MontaVista, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -35,10 +36,58 @@ void __init identify_ppc_sys_by_id(u32 i
 
 void __init identify_ppc_sys_by_name(char *name)
 {
-	/* TODO */
+	unsigned int i = 0;
+	while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {
+		if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
+			break;
+		i++;
+	}
+	cur_ppc_sys_spec = &ppc_sys_specs[i];
 	return;
 }
 
+static int __init count_sys_specs(void)
+{
+	int i = 0;
+	while (strcmp(ppc_sys_specs[i].ppc_sys_name, ""))
+		i++;
+	return i;
+}
+
+static int __init find_chip_by_name_and_id(char *name, u32 id)
+{
+	int ret = -1;
+	unsigned int i = 0;
+	unsigned int j = 0;
+	unsigned int dups = 0;
+
+	unsigned char matched[count_sys_specs()];
+
+	while (strcmp(ppc_sys_specs[i].ppc_sys_name, "")) {
+		if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
+			matched[j++] = i;
+		i++;
+	}
+	if (j != 0) {
+		for (i = 0; i < j; i++) {
+			if ((ppc_sys_specs[matched[i]].mask & id) ==
+			    ppc_sys_specs[matched[i]].value) {
+				ret = matched[i];
+				dups++;
+			}
+		}
+		ret = (dups == 1) ? ret : (-1 * dups);
+	}
+	return ret;
+}
+
+void __init identify_ppc_sys_by_name_and_id(char *name, u32 id)
+{
+	int i = find_chip_by_name_and_id(name, id);
+	BUG_ON(i < 0);
+	cur_ppc_sys_spec = &ppc_sys_specs[i];
+}
+
 /* Update all memory resources by paddr, call before platform_device_register */
 void __init
 ppc_sys_fixup_mem_resource(struct platform_device *pdev, phys_addr_t paddr)
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -51,7 +51,8 @@ extern struct ppc_sys_spec *cur_ppc_sys_
 
 /* determine which specific SOC we are */
 extern void identify_ppc_sys_by_id(u32 id) __init;
-extern void identify_ppc_sys_by_name(char *name) __init;
+extern void identify_ppc_sys_by_name(char* name) __init;
+extern void identify_ppc_sys_by_name_and_id(char *name, u32 id) __init;
 
 /* describes all devices that may exist in a given family of processors */
 extern struct platform_device ppc_sys_platform_devices[];

--------------080109080001030000050307--
