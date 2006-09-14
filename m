Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 46434679FD
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 01:20:54 +1000 (EST)
Message-ID: <45097273.8070103@am.sony.com>
Date: Thu, 14 Sep 2006 08:17:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] powerpc: minor fix of numa message
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a very minor fix that effects no current system.  The NUMA startup
message values for 'Top of RAM' and 'Memory hole size' were reported
incorrectly if more than one lmb region was added.

A comment in the lmb code states that lmb_analyze() must be called before
lmb_phys_mem_size().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: cell--common--4/arch/powerpc/mm/numa.c
===================================================================
--- cell--common--4.orig/arch/powerpc/mm/numa.c
+++ cell--common--4/arch/powerpc/mm/numa.c
@@ -483,10 +483,14 @@
 
 static void __init setup_nonnuma(void)
 {
-	unsigned long top_of_ram = lmb_end_of_DRAM();
-	unsigned long total_ram = lmb_phys_mem_size();
+	unsigned long top_of_ram;
+	unsigned long total_ram;
 	unsigned int i;
 
+	lmb_analyze();
+	top_of_ram = lmb_end_of_DRAM();
+	total_ram = lmb_phys_mem_size();
+
 	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
