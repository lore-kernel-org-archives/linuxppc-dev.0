Return-Path: <benh@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7FF567BD4
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 15:09:03 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id kBBGAnRd4501570
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 15:10:49 -0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBB4C9pU104002
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 15:12:19 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBB48f91018540
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 15:08:41 +1100
Subject: [PATCH] powerpc: Remove old dcr.S
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 15:08:40 +1100
Message-Id: <1165810120.7260.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I renamed dcr.S to dcr_low.S (and added dcr.c) it looks like the
old dcr.S file didn't properly get removed. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/sysdev/dcr.S
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/dcr.S	2006-12-11 15:07:04.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,39 +0,0 @@
-/*
- * "Indirect" DCR access
- *
- * Copyright (c) 2004 Eugene Surovegin <ebs@ebshome.net>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under  the terms of  the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-
-#define DCR_ACCESS_PROLOG(table) \
-	rlwinm  r3,r3,4,18,27;   \
-	lis     r5,table@h;      \
-	ori     r5,r5,table@l;   \
-	add     r3,r3,r5;        \
-	mtctr   r3;              \
-	bctr
-
-_GLOBAL(__mfdcr)
-	DCR_ACCESS_PROLOG(__mfdcr_table)
-
-_GLOBAL(__mtdcr)
-	DCR_ACCESS_PROLOG(__mtdcr_table)
-
-__mfdcr_table:
-	mfdcr  r3,0; blr
-__mtdcr_table:
-	mtdcr  0,r4; blr
-
-dcr     = 1
-        .rept   1023
-	mfdcr   r3,dcr; blr
-	mtdcr   dcr,r4; blr
-	dcr     = dcr + 1
-	.endr
