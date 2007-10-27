Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BECDDDEED
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 00:22:21 +1000 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IlmYJ-0001I4-Pd
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 16:22:15 +0200
Message-ID: <47234995.7020500@tiscali.nl>
Date: Sat, 27 Oct 2007 16:22:13 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] allocation fix in ppc/platforms/4xx/luan.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't allocate hose2 when when hose1 can't be allocated and free hose1 when
hose2 can't be allocated.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
index 4b16961..b79ebb8 100644
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -230,9 +230,14 @@ luan_setup_hoses(void)
 
 	/* Allocate hoses for PCIX1 and PCIX2 */
 	hose1 = pcibios_alloc_controller();
+	if (!hose1)
+		return;
+
 	hose2 = pcibios_alloc_controller();
-	if (!hose1 || !hose2)
+	if (!hose2) {
+		pcibios_free_controller(hose1);
 		return;
+	}
 
 	/* Setup PCIX1 */
 	hose1->first_busno = 0;
