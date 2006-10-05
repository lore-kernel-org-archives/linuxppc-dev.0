Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B71F467C7E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 14:18:53 +1000 (EST)
Subject: [PATCH] powerpc: Fix zImage decompress location
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 14:18:46 +1000
Message-Id: <1160021926.22232.6.camel@localhost.localdomain>
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

The zImage wrapper has a "hack" that force the decompression to happen
above 20Mb for 64 bits kernels, to work around issues with some
firmwares on the field. However, the new wrapper has a bug which makes
that hack not work properly. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/boot/of.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/of.c	2006-10-03 12:41:02.000000000 +1000
+++ linux-work/arch/powerpc/boot/of.c	2006-10-05 13:52:29.000000000 +1000
@@ -176,12 +176,9 @@ static void *claim(unsigned long virt, u
 static void *of_try_claim(u32 size)
 {
 	unsigned long addr = 0;
-	static u8 first_time = 1;
 
-	if (first_time) {
+	if (claim_base == 0)
 		claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
-		first_time = 0;
-	}
 
 	for(; claim_base < RAM_END; claim_base += ONE_MB) {
 #ifdef DEBUG
