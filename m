Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8E46167B88
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 09:48:50 +1000 (EST)
Date: Tue, 5 Sep 2006 18:47:26 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, anton@samba.org
Subject: [patch 1/5] [v2] powerpc: Reduce default cacheline size to 64 bytes
Message-ID: <20060905184726.4a563644@localhost.localdomain>
In-Reply-To: <20060905184316.4c1a460b@localhost.localdomain>
References: <20060905184316.4c1a460b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reduce default cacheline size on 64-bit powerpc from 128 bytes to 64.
This is the architected minimum. In most cases we'll still end up using
cache line information from the device tree, but defaults are used during
early boot and doing a few dcbst/icbi's too many there won't do any harm.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- merge.orig/arch/powerpc/kernel/setup_64.c
+++ merge/arch/powerpc/kernel/setup_64.c
@@ -78,10 +78,10 @@ u64 ppc64_pft_size;
  * before we've read this from the device tree.
  */
 struct ppc64_caches ppc64_caches = {
-	.dline_size = 0x80,
-	.log_dline_size = 7,
-	.iline_size = 0x80,
-	.log_iline_size = 7
+	.dline_size = 0x40,
+	.log_dline_size = 6,
+	.iline_size = 0x40,
+	.log_iline_size = 6
 };
 EXPORT_SYMBOL_GPL(ppc64_caches);
 
Index: merge/arch/powerpc/kernel/head_64.S
===================================================================
--- merge.orig/arch/powerpc/kernel/head_64.S
+++ merge/arch/powerpc/kernel/head_64.S
@@ -1748,7 +1748,7 @@ _STATIC(__after_prom_start)
 _GLOBAL(copy_and_flush)
 	addi	r5,r5,-8
 	addi	r6,r6,-8
-4:	li	r0,16			/* Use the least common		*/
+4:	li	r0,8			/* Use the smallest common	*/
 					/* denominator cache line	*/
 					/* size.  This results in	*/
 					/* extra cache line flushes	*/
