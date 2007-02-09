Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9CA9ADDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 01:31:13 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 447BD9B116
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 15:10:39 +0100 (CET)
Received: from mail.dmz.schenk (host-82-135-47-202.customer.m-online.net
	[82.135.47.202])
	by mail.mnet-online.de (Postfix) with ESMTP id 1E1F1BB93C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 15:10:38 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by mail.dmz.schenk (Postfix) with ESMTP id D33CED5DB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 15:10:38 +0100 (CET)
Received: from pcimr.rt.schenk (pcimr.rt.schenk [172.22.10.20])
	by gwhaus.rt.schenk (Postfix) with ESMTP id A69721F483
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 15:10:38 +0100 (CET)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] PPC: Fix compile error with e500 core
Date: Fri, 9 Feb 2007 15:10:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702091510.38246.imr@rtschenk.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this patch fixes a compile error with linux 2.6.20
configured for the mpc8548.

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>

---

diff -ur linux-2.6.20-orig/arch/ppc/kernel/ppc_ksyms.c 
linux-2.6.20/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.6.20-orig/arch/ppc/kernel/ppc_ksyms.c	2007-02-04 
19:44:54.000000000 +0100
+++ linux-2.6.20/arch/ppc/kernel/ppc_ksyms.c	2007-02-09 14:44:15.000000000 
+0100
@@ -270,7 +270,7 @@
 extern long *intercept_table;
 EXPORT_SYMBOL(intercept_table);
 #endif /* CONFIG_PPC_STD_MMU */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_DCR_NATIVE
 EXPORT_SYMBOL(__mtdcr);
 EXPORT_SYMBOL(__mfdcr);
 #endif
