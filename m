Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BJ2L0mJqzF2Lr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 06:33:13 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id z73so3300801wrb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:33:13 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/19] powerpc: Mark variables as unused
Date: Wed, 28 Mar 2018 21:33:07 +0200
Message-Id: <20180328193307.978-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-4-malat@debian.org>
References: <20180322202007.23088-4-malat@debian.org>
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

Add gcc attribute unused for two variables. Fix warnings treated as errors
with W=1:

  arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: move path within ifdef DEBUG_PROM

 arch/powerpc/kernel/prom_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index acf4b2e0530c..4163b11abb6c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
 	const char *opt;
 
 	char *p;
-	int l = 0;
+	int l __maybe_unused = 0;
 
 	prom_cmd_line[0] = 0;
 	p = prom_cmd_line;
@@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
 static void __init prom_init_mem(void)
 {
 	phandle node;
-	char *path, type[64];
+	char *path __maybe_unused, type[64];
 	unsigned int plen;
 	cell_t *p, *endp;
 	__be32 val;
@@ -1406,7 +1406,6 @@ static void __init prom_init_mem(void)
 	prom_debug("root_size_cells: %x\n", rsc);
 
 	prom_debug("scanning memory:\n");
-	path = prom_scratch;
 
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
@@ -1431,6 +1430,7 @@ static void __init prom_init_mem(void)
 		endp = p + (plen / sizeof(cell_t));
 
 #ifdef DEBUG_PROM
+		path = prom_scratch;
 		memset(path, 0, PROM_SCRATCH_SIZE);
 		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
 		prom_debug("  node %s :\n", path);
-- 
2.11.0
