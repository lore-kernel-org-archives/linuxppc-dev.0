Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E0F2B7BB2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 01:59:24 +1000 (EST)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225]) by ozlabs.org (Postfix) with ESMTP id BDFFEDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 01:59:22 +1000 (EST)
Received: by ewy25 with SMTP id 25so1803389ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 08:59:19 -0700 (PDT)
Message-ID: <4A71C40A.2060606@gmail.com>
Date: Thu, 30 Jul 2009 18:02:18 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc: missing tests after ioremap()?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Missing tests after ioremap()

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Shouldn't we test whether ioremaps fail?

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index e6c0040..3a4ebd3 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2589,9 +2589,16 @@ static void __init probe_uninorth(void)
 	if (address == 0)
 		return;
 	uninorth_base = ioremap(address, 0x40000);
+	if (uninorth_base == NULL)
+		return;
 	uninorth_rev = in_be32(UN_REG(UNI_N_VERSION));
-	if (uninorth_maj == 3 || uninorth_maj == 4)
+	if (uninorth_maj == 3 || uninorth_maj == 4) {
 		u3_ht_base = ioremap(address + U3_HT_CONFIG_BASE, 0x1000);
+		if (u3_ht_base == NULL) {
+			iounmap(uninorth_base);
+			return;
+		}
+	}
 
 	printk(KERN_INFO "Found %s memory controller & host bridge"
 	       " @ 0x%08x revision: 0x%02x\n", uninorth_maj == 3 ? "U3" :
