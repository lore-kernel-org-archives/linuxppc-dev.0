Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E894DDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 22:29:30 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4EApnaU024658
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 03:51:49 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4EAplDY023296
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 05:51:48 -0500 (CDT)
Message-ID: <46483FAC.60503@freescale.com>
Date: Mon, 14 May 2007 18:53:32 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Linus <torvalds@linux-foundation.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following "Section mismatch" warnings when
build powerpc platforms.

-------------
WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to .init.text:early_get_page from .text between 'pte_alloc_one_kernel' (at offset 0xc68) and 'pte_alloc_one'
WARNING: mm/built-in.o - Section mismatch: reference to .init.text:set_up_list3s from .text between 'kmem_cache_create' (at offset 0x20300) and 'cache_reap'
-------------

Massive warnings represented by:
-------------
WARNING: arch/powerpc/kernel/built-in.o - Section mismatch: reference to .init.data:.got2 from prom_entry (offset 0x0)
WARNING: arch/powerpc/platforms/built-in.o - Section mismatch: reference to .init.text:mpc8313_rdb_probe from .machine.desc after 'mach_mpc8313_rdb' (at offset 0x4)
-------------

Signed-off-by: Li Yang <leoli@freescale.com>
---
 scripts/mod/modpost.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c89cb71..aa3a881 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -649,9 +649,10 @@ static int strrcmp(const char *s, const char *sub)
  *  tosec    = .init.text
  *
  * Pattern 10:
- *  ia64 has machvec table for each platform. It is mixture of function
- *  pointer of .init.text and .text.
- *  fromsec  = .machvec
+ *  ia64 has machvec table and powerpc has machine desc table for each
+ *  platform. It is mixture of function pointer of .init.text and .text.
+ *  fromsec  = .machvec | .machine.desc
+ *
  **/
 static int secref_whitelist(const char *modname, const char *tosec,
 			    const char *fromsec, const char *atsym,
@@ -681,6 +682,8 @@ static int secref_whitelist(const char *modname, const char *tosec,
 	const char *pat4sym[] = {
 		"sparse_index_alloc",
 		"zone_wait_table_init",
+		"pte_alloc_one_kernel",
+		"kmem_cache_create",
 		NULL
 	};
 
@@ -750,7 +753,8 @@ static int secref_whitelist(const char *modname, const char *tosec,
 				return 1;
 
 	/* Check for pattern 10 */
-	if (strcmp(fromsec, ".machvec") == 0)
+	if ((strcmp(fromsec, ".machvec") == 0) ||
+	    (strcmp(fromsec, ".machine.desc") == 0))
 		return 1;
 
 	return 0;
@@ -883,6 +887,10 @@ static void warn_sec_mismatch(const char *modname, const char *fromsec,
 	    secref_whitelist(modname, secname, fromsec,
 			     elf->strtab + before->st_name, refsymname))
 		return;
+	/* fromsec whitelist - without a valid 'before' */
+	/* powerpc has a GOT table in .got2 section */
+	if (strcmp(fromsec, ".got2") == 0)
+		return;
 
 	if (before && after) {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
