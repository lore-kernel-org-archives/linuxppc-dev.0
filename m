Return-Path: <jschopp@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 505AC1007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 08:08:01 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBIL1CLi030486
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 14:01:12 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id nBIL7djO171848
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 14:07:40 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBIL7ZGn002921
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 14:07:35 -0700
Subject: [PATCH] powerpc: update ibm,client-architecture
From: Joel Schopp <jschopp@austin.ibm.com>
To: benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Dec 2009 15:07:32 -0600
Message-ID: <1261170452.8134.13.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to boot with more than 64 cores on machines that support the ibm,client-architecture RTAS call a 
new field has been added to the structure.  This patch updates that field and adds a few others in the
process.  It would be good if this could go in as a bugfix.  

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
@@ -654,6 +654,9 @@ static void __init early_cmdline_parse(v
 #define OV5_CMO			0x00
 #endif
 
+/* Option Vector 6: IBM PAPR hints */
+#define OV6_LINUX		0x02	/* Linux is our OS */
+
 /*
  * The architecture vector has an array of PVR mask/value pairs,
  * followed by # option vectors - 1, followed by the option vectors.
@@ -665,7 +668,7 @@ static unsigned char ibm_architecture_ve
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
-	5 - 1,				/* 5 option vectors */
+	6 - 1,				/* 6 option vectors */
 
 	/* option vector 1: processor architectures supported */
 	3 - 2,				/* length */
@@ -697,12 +700,26 @@ static unsigned char ibm_architecture_ve
 	0,				/* don't halt */
 
 	/* option vector 5: PAPR/OF options */
-	5 - 2,				/* length */
+	13 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
 	0,
 	OV5_CMO,
+	0,				/* reserved */
+	0,				/* reserved */
+	0,				/* reserved */
+	0,				/* reserved */
+	W(NR_CPUS/4),			/* max cores supported */
+
+	/* option vector 6: IBM PAPR hints */
+	4 - 2,
+	0,				/* reserved */
+	0,				/* 1 == no secondary pteg */
+	OV6_LINUX,
+
+	/* option vector 7: IBM PAPR OS identification */
+	/* a human readable ascii string will go here */
 };
 
 /* Old method - ELF header with PT_NOTE sections */
