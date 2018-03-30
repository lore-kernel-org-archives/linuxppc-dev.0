Return-Path: <prvs=06277935a1=aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CL5F1vcfzF1qF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 23:09:20 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2UC7pms010590
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 08:09:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h1md8hd49-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 08:09:18 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 30 Mar 2018 08:09:17 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/radix: Update command line parsing for
 disable_radix
Date: Fri, 30 Mar 2018 17:39:02 +0530
In-Reply-To: <20180330120902.28798-1-aneesh.kumar@linux.ibm.com>
References: <20180330120902.28798-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180330120902.28798-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel parameter disable_radix takes different options
disable_radix=yes|no|1|0  or just disable_radix.

prom_init parsing is not supporting these options.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kernel/prom_init.c        | 16 +++++++++++++---
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 0323e073341d..c85333c244e8 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -171,7 +171,7 @@ static unsigned long __initdata prom_tce_alloc_start;
 static unsigned long __initdata prom_tce_alloc_end;
 #endif
 
-static bool __initdata prom_radix_disable;
+static bool prom_radix_disable __initdata = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
 
 struct platform_support {
 	bool hash_mmu;
@@ -641,9 +641,19 @@ static void __init early_cmdline_parse(void)
 
 	opt = strstr(prom_cmd_line, "disable_radix");
 	if (opt) {
-		prom_debug("Radix disabled from cmdline\n");
-		prom_radix_disable = true;
+		opt += 13;
+		if (*opt && *opt == '=') {
+			bool val;
+
+			if (kstrtobool(++opt, &val))
+				prom_radix_disable = false;
+			else
+				prom_radix_disable = val;
+		} else
+			prom_radix_disable = true;
 	}
+	if (prom_radix_disable)
+		prom_debug("Radix disabled from cmdline\n");
 }
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 12640f7e726b..acb6b9226352 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -19,7 +19,7 @@
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
-strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
+strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
 
-- 
2.14.3
