Return-Path: <albert_herranz@yahoo.es>
Received: from smtp120.mail.ukl.yahoo.com (smtp120.mail.ukl.yahoo.com
	[77.238.184.51]) by ozlabs.org (Postfix) with SMTP id 99715B7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 07:35:10 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v4 1/2] powerpc: reserve fixmap entries for early debug
Date: Thu,  3 Dec 2009 21:34:59 +0100
Message-Id: <731eb73d0a309d0c23b30bea3718b976c3782b71.1259871725.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259871725.git.albert_herranz@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259871725.git.albert_herranz@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a set of entries to the fixmap table to allow usage of known
reserved virtual address space by early debug code.

The address space reserved is the top 128K of the 32-bit address
space. This allows, if required, the use of a BAT to do the mappings.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/fixmap.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index f1f4e23..5c2c023 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -44,6 +44,9 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+	/* reserve the top 128K for early debugging purposes */
+	FIX_EARLY_DEBUG_TOP = FIX_HOLE,
+	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+((128*1024)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
-- 
1.6.3.3
