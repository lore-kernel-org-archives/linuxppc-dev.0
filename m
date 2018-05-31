Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3s2yQszDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:33 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 09/11] powerpc/prom_init: Move a few remaining statics to
 appropriate sections
Date: Thu, 31 May 2018 14:33:47 +1000
Message-Id: <20180531043349.24783-10-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 67df2758a4e2..f54177a84dbc 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -174,7 +174,7 @@ static unsigned long __prombss prom_tce_alloc_end;
 #endif
 
 #ifdef CONFIG_PPC_PSERIES
-static bool prom_radix_disable __prombss;
+static bool __prombss prom_radix_disable;
 #endif
 
 struct platform_support {
@@ -211,7 +211,7 @@ static int __prombss mem_reserve_cnt;
 
 static cell_t __prombss regbuf[1024];
 
-static bool rtas_has_query_cpu_stopped;
+static bool  __prombss rtas_has_query_cpu_stopped;
 
 
 /*
@@ -500,8 +500,8 @@ static void add_string(char **str, const char *q)
 
 static char *tohex(unsigned int x)
 {
-	static char digits[] = "0123456789abcdef";
-	static char result[9];
+	static const char digits[] __initconst = "0123456789abcdef";
+	static char result[9] __prombss;
 	int i;
 
 	result[8] = 0;
@@ -2295,7 +2295,7 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 	char *namep, *prev_name, *sstart, *p, *ep, *lp, *path;
 	unsigned long soff;
 	unsigned char *valp;
-	static char pname[MAX_PROPERTY_NAME];
+	static char pname[MAX_PROPERTY_NAME] __prombss;
 	int l, room;
 
 	dt_push_token(OF_DT_BEGIN_NODE, mem_start, mem_end);
-- 
2.17.0
