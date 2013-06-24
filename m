Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E83642C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:36:01 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 00:33:14 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9BCED2BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:35:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OEL0tJ35061766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:21:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OEZvxQ029157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:35:57 +1000
Message-ID: <51C8594B.1080701@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 09:35:55 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Correct build warnings with CONFIG_TRANSPARENT_HUGEPAGE
 disabled
Content-Type: text/plain; charset=windows-1252
Cc: aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Building with CONFIG_TRANSPARENT_HUGEPAGE disabled causes the following
build wearnings;

powerpc/arch/powerpc/include/asm/mmu-hash64.h: In function ‘__hash_page_thp’:
powerpc/arch/powerpc/include/asm/mmu-hash64.h:354: warning: no return statement in function returning non-void

This patch adds a return -1 to the static inline for __hash_page_thp()
to correct the warnings.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |    1 +
 1 file changed, 1 insertion(+)

Index: powerpc/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/mmu-hash64.h	2013-06-24 07:54:08.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/mmu-hash64.h	2013-06-24 08:07:56.000000000 -0500
@@ -351,6 +351,7 @@
 				  int ssize, unsigned int psize)
 {
 	BUG();
+	return -1;
 }
 #endif
 extern void hash_failure_debug(unsigned long ea, unsigned long access,
