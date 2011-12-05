Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6573C1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 03:41:12 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: galak@kernel.crashing.org
Subject: [PATCH] sbc834x: put full compat string in board match check
Date: Mon,  5 Dec 2011 11:41:07 -0500
Message-Id: <1323103267-22786-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 883c2cfc8bcc0fd00c5d9f596fb8870f481b5bda:

 "fix of_flat_dt_is_compatible() to match the full compatible string"

causes silent boot death on the sbc8349 board because it was
just looking for 8349 and not 8349E -- as originally there
were non-E (no SEC/encryption) chips available.  Just add the
E to the board detection string since all boards I've seen
were manufactured with the E versions.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index af41d8c..f5a783a 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -102,11 +102,11 @@ static int __init sbc834x_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "SBC834x");
+	return of_flat_dt_is_compatible(root, "SBC834xE");
 }
 
 define_machine(sbc834x) {
-	.name			= "SBC834x",
+	.name			= "SBC834xE",
 	.probe			= sbc834x_probe,
 	.setup_arch		= sbc834x_setup_arch,
 	.init_IRQ		= sbc834x_init_IRQ,
-- 
1.7.7
