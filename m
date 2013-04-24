Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7B7E2C010F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 01:55:18 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 11:55:16 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7E80638C8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:55:13 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OFtDhZ258934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:55:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OFtD49026318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:55:13 -0400
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OFtBiF026171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:55:12 -0400
Message-ID: <5178005C.1070204@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 10:55:08 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/13] Use ARRAY_SIZE to iterate over firmware_features_table
 array
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When iterating over the entries in firmware_features_table we only need
to go over the actual number of entries in the array instead of declaring
it to be bigger and checking to make sure there is a valid entry in every
slot.

This patch removes the FIRMWARE_MAX_FEATURES #define and replaces the
array looping with the use of ARRAY_SIZE().

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    1 -
 arch/powerpc/platforms/pseries/firmware.c |    8 +++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

Index: powerpc/arch/powerpc/include/asm/firmware.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/firmware.h	2013-04-23 14:17:16.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/firmware.h	2013-04-23 14:19:54.000000000 -0500
@@ -18,7 +18,6 @@
 #include <asm/feature-fixups.h>
 
 /* firmware feature bitmask values */
-#define FIRMWARE_MAX_FEATURES 63
 
 #define FW_FEATURE_PFT		ASM_CONST(0x0000000000000001)
 #define FW_FEATURE_TCE		ASM_CONST(0x0000000000000002)
Index: powerpc/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/firmware.c	2013-04-23 14:17:16.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/firmware.c	2013-04-23 14:46:10.000000000 -0500
@@ -39,7 +39,7 @@
  * string must match.
  */
 static __initdata firmware_feature_t
-firmware_features_table[FIRMWARE_MAX_FEATURES] = {
+firmware_features_table[] = {
 	{FW_FEATURE_PFT,		"hcall-pft"},
 	{FW_FEATURE_TCE,		"hcall-tce"},
 	{FW_FEATURE_SPRG0,		"hcall-sprg0"},
@@ -77,12 +77,10 @@
 	pr_debug(" -> fw_feature_init()\n");
 
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
-		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
+		for (i = 0; i < ARRAY_SIZE(firmware_features_table); i++) {
 			const char *name = firmware_features_table[i].name;
 			size_t size;
-			/* check value against table of strings */
-			if (!name)
-				continue;
+
 			/*
 			 * If there is a '*' at the end of name, only check
 			 * upto there
