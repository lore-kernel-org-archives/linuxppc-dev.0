Return-Path: <albert_herranz@yahoo.es>
Received: from smtp125.mail.ukl.yahoo.com (smtp125.mail.ukl.yahoo.com
	[77.238.184.56]) by ozlabs.org (Postfix) with SMTP id A75691007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 10:09:53 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 2/3] powerpc: udbg: add fixmap entry for early debug
Date: Tue,  1 Dec 2009 00:09:49 +0100
Message-Id: <0a6994b5a257def375c8114b132d044a7f416d11.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new entry to the fixmap table to allow low level early udbg drivers
to safely reserve virtual address space and create their I/O mappings.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/fixmap.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index f1f4e23..424e5a6 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -48,6 +48,9 @@ enum fixed_addresses {
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG
+	FIX_EARLY_DEBUG_BASE,
+#endif
 	/* FIX_PCIE_MCFG, */
 	__end_of_fixed_addresses
 };
-- 
1.6.3.3
