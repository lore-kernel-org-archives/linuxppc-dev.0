Return-Path: <clg@kaod.org>
Received: from 1.mo68.mail-out.ovh.net (1.mo68.mail-out.ovh.net
 [46.105.41.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjGTx2pXmzDqXl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:56:21 +1000 (AEST)
Received: from player776.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id C91407B73E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:47:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 7/8] powerpc/xive: add XIVE Exploitation Mode to CAS
Date: Wed, 30 Aug 2017 21:46:16 +0200
Message-Id: <20170830194617.26621-8-clg@kaod.org>
In-Reply-To: <20170830194617.26621-1-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
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
in XIVE exploitation mode. Now that we have initial guest support for
the XIVE interrupt controller, let's inform the hypervisor what we can
do.

The platform advertises the XIVE Exploitation Mode support using the
property "ibm,arch-vec-5-platform-support-vec-5", byte 23 bits 0-1 :

 - 0b00 XIVE legacy mode Only
 - 0b01 XIVE exploitation mode Only
 - 0b10 XIVE legacy or exploitation mode

The OS asks for XIVE Exploitation Mode support using the property
"ibm,architecture-vec-5", byte 23 bits 0-1:

 - 0b00 XIVE legacy mode Only
 - 0b01 XIVE exploitation mode Only

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - fixed XIVE mode parsing 
 - integrated the prom.h definitions
 - introduced extra bits definition : OV5_XIVE_LEGACY and OV5_XIVE_EITHER
 
 arch/powerpc/include/asm/prom.h |  5 ++++-
 arch/powerpc/kernel/prom_init.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 35c00d7a0cf8..825bd5998701 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -159,7 +159,10 @@ struct of_drconf_cell {
 #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
-#define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation supported */
+#define OV5_XIVE_SUPPORT	0x17C0	/* XIVE Exploitation Support Mask */
+#define OV5_XIVE_LEGACY		0x1700	/* XIVE legacy mode Only */
+#define OV5_XIVE_EXPLOIT	0x1740	/* XIVE exploitation mode Only */
+#define OV5_XIVE_EITHER		0x1780	/* XIVE legacy or exploitation mode */
 /* MMU Base Architecture */
 #define OV5_MMU_SUPPORT		0x18C0	/* MMU Mode Support Mask */
 #define OV5_MMU_HASH		0x1800	/* Hash MMU Only */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 613f79f03877..02190e90c7ae 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -177,6 +177,7 @@ struct platform_support {
 	bool hash_mmu;
 	bool radix_mmu;
 	bool radix_gtse;
+	bool xive;
 };
 
 /* Platforms codes are now obsolete in the kernel. Now only used within this
@@ -1041,6 +1042,27 @@ static void __init prom_parse_mmu_model(u8 val,
 	}
 }
 
+static void __init prom_parse_xive_model(u8 val,
+					 struct platform_support *support)
+{
+	switch (val) {
+	case OV5_FEAT(OV5_XIVE_EITHER): /* Either Available */
+		prom_debug("XIVE - either mode supported\n");
+		support->xive = true;
+		break;
+	case OV5_FEAT(OV5_XIVE_EXPLOIT): /* Only Exploitation mode */
+		prom_debug("XIVE - exploitation mode supported\n");
+		support->xive = true;
+		break;
+	case OV5_FEAT(OV5_XIVE_LEGACY): /* Only Legacy mode */
+		prom_debug("XIVE - legacy mode supported\n");
+		break;
+	default:
+		prom_debug("Unknown xive support option: 0x%x\n", val);
+		break;
+	}
+}
+
 static void __init prom_parse_platform_support(u8 index, u8 val,
 					       struct platform_support *support)
 {
@@ -1054,6 +1076,10 @@ static void __init prom_parse_platform_support(u8 index, u8 val,
 			support->radix_gtse = true;
 		}
 		break;
+	case OV5_INDX(OV5_XIVE_SUPPORT): /* Interrupt mode */
+		prom_parse_xive_model(val & OV5_FEAT(OV5_XIVE_SUPPORT),
+				      support);
+		break;
 	}
 }
 
@@ -1062,7 +1088,8 @@ static void __init prom_check_platform_support(void)
 	struct platform_support supported = {
 		.hash_mmu = false,
 		.radix_mmu = false,
-		.radix_gtse = false
+		.radix_gtse = false,
+		.xive = false
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
@@ -1095,6 +1122,11 @@ static void __init prom_check_platform_support(void)
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
2.13.5
