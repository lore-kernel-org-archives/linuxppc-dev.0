Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 58644DDF6A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:51 +1000 (EST)
Message-Id: <20070705170241.356893000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:02 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 29/35] Work around errata 4910
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't allow unguarded mappings in PCI-express space. This is resolves
problems with frame buffers having garbage on them due to failing
write merges.


Index: 2.6.21/arch/powerpc/mm/hash_native_64.c
===================================================================
--- 2.6.21.orig/arch/powerpc/mm/hash_native_64.c
+++ 2.6.21/arch/powerpc/mm/hash_native_64.c
@@ -152,6 +152,10 @@ static long native_hpte_insert(unsigned 
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
+	/* Workaround for bug 4910: No non-guarded access over IOB */
+	if (pa >= 0x80000000 && pa < 0x100000000)
+		rflags |= _PAGE_GUARDED;
+
 	hpte_v = hpte_encode_v(va, psize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 

--
