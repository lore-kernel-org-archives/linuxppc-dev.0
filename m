Return-Path: <clg@kaod.org>
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [87.98.165.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtc0q2RctzDqjf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:36:42 +1000 (AEST)
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 22BA79822A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:30:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 2/2] powerpc/xive: add XIVE exploitation mode to CAS
Date: Thu, 22 Jun 2017 11:29:17 +0200
Message-Id: <1498123757-18427-3-git-send-email-clg@kaod.org>
In-Reply-To: <1498123757-18427-1-git-send-email-clg@kaod.org>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9, the Client Architecture Support (CAS) negotiation process
determines whether the guest operates in XIVE Legacy compatibility or
in XIVE exploitation mode.

Now that we have initial guest support for the XIVE interrupt
controller, let's inform the hypervisor what we can do.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kernel/prom_init.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index dd8a04f3053a..d7065d801f94 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -174,6 +174,7 @@ struct platform_support {
 	bool hash_mmu;
 	bool radix_mmu;
 	bool radix_gtse;
+	bool xive;
 };
 
 /* Platforms codes are now obsolete in the kernel. Now only used within this
@@ -1051,6 +1052,12 @@ static void __init prom_parse_platform_support(u8 index, u8 val,
 			support->radix_gtse = true;
 		}
 		break;
+	case OV5_INDX(OV5_XIVE_EXPLOIT): /* XIVE Exploitation mode */
+		if (val & OV5_FEAT(OV5_XIVE_EXPLOIT)) {
+			prom_debug("XIVE - exploitation mode\n");
+			support->xive = true;
+		}
+		break;
 	}
 }
 
@@ -1059,7 +1066,8 @@ static void __init prom_check_platform_support(void)
 	struct platform_support supported = {
 		.hash_mmu = false,
 		.radix_mmu = false,
-		.radix_gtse = false
+		.radix_gtse = false,
+		.xive = false
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
@@ -1092,6 +1100,11 @@ static void __init prom_check_platform_support(void)
 		/* We're probably on a legacy hypervisor */
 		prom_debug("Assuming legacy hash support\n");
 	}
+
+	if (supported.xive) {
+		prom_debug("Asking for XIVE\n");
+		ibm_architecture_vec.vec5.intarch = OV5_FEAT(OV5_XIVE_EXPLOIT);
+	}
 }
 
 static void __init prom_send_capabilities(void)
-- 
2.7.5
