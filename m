Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400YS4501kzF0VN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:03:16 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CMwkqe048119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:13 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gnxgv9dax-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:13 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 17:03:12 -0600
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v2 3/4] rfi-flush: Allow pseries to force init of fallback
 flush area
Date: Mon, 12 Mar 2018 20:02:57 -0300
In-Reply-To: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1520895778-17586-4-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This ensures the fallback flush area is always allocated at boot time
on the pseries platform, so PowerVM migration to an unpatched system
can rely on the fallback flush method.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/setup.h       | 2 +-
 arch/powerpc/kernel/setup_64.c         | 5 +++--
 arch/powerpc/platforms/powernv/setup.c | 3 ++-
 arch/powerpc/platforms/pseries/setup.c | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index bbcdf929..efdaf10 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -49,7 +49,7 @@ enum l1d_flush_type {
 	L1D_FLUSH_MTTRIG	= 0x8,
 };
 
-void setup_rfi_flush(enum l1d_flush_type, bool enable);
+void setup_rfi_flush(enum l1d_flush_type, bool enable, bool force_init_fallback);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d60e2f7..cb886a8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -881,12 +881,13 @@ static void init_fallback_flush(void)
 	}
 }
 
-void setup_rfi_flush(enum l1d_flush_type types, bool enable)
+void setup_rfi_flush(enum l1d_flush_type types, bool enable, bool force_init_fallback)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
 		pr_info("rfi-flush: Using fallback displacement flush\n");
 		init_fallback_flush();
-	}
+	} else if (force_init_fallback)
+		init_fallback_flush();
 
 	if (types & L1D_FLUSH_ORI)
 		pr_info("rfi-flush: Using ori type flush\n");
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 092715b..a4ab8f6 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -46,6 +46,7 @@ static void pnv_setup_rfi_flush(void)
 	struct device_node *np, *fw_features;
 	enum l1d_flush_type type;
 	int enable;
+	bool force_init_fallback = false;
 
 	/* Default to fallback in case fw-features are not available */
 	type = L1D_FLUSH_FALLBACK;
@@ -88,7 +89,7 @@ static void pnv_setup_rfi_flush(void)
 		of_node_put(fw_features);
 	}
 
-	setup_rfi_flush(type, enable > 0);
+	setup_rfi_flush(type, enable > 0, force_init_fallback);
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1a52762..2f82bbb 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -463,7 +463,7 @@ static void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
 	enum l1d_flush_type types;
-	bool enable;
+	bool enable, force_init_fallback = true;
 	long rc;
 
 	/* Enable by default */
@@ -490,7 +490,7 @@ static void pseries_setup_rfi_flush(void)
 		types = L1D_FLUSH_FALLBACK;
 	}
 
-	setup_rfi_flush(types, enable);
+	setup_rfi_flush(types, enable, force_init_fallback);
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.7.4
