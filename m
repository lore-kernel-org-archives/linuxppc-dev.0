Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews04.kpnxchange.com (cpsmtpb-ews04.kpnxchange.com
 [213.75.39.7]) by ozlabs.org (Postfix) with ESMTP id C91FC2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:28:01 +1100 (EST)
Message-ID: <1363858076.1390.104.camel@x61.thuisdomein>
Subject: [PATCH] memblock: kill "config MAX_ACTIVE_REGIONS"
From: Paul Bolle <pebolle@tiscali.nl>
To: James Hogan <james.hogan@imgtec.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Mundt
 <lethal@linux-sh.org>
Date: Thu, 21 Mar 2013 10:27:56 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig symbol MAX_ACTIVE_REGIONS is unused. Commit
0ee332c1451869963626bf9cac88f165a90990e1 ("memblock: Kill
early_node_map[]") removed the only place were it was actually used. But
it did not remove its Kconfig entries (for powerpc and sh).

Remove those two entries (and the entry for metag, that popped up in
v3.9-rc1).

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Eyeball tested again.

1) It felt silly to split this clean up patch into three patches. But if
the maintainers involved disagree I'm happy to split and resend it. 

 arch/metag/mm/Kconfig | 5 -----
 arch/powerpc/Kconfig  | 5 -----
 arch/sh/mm/Kconfig    | 7 -------
 3 files changed, 17 deletions(-)

diff --git a/arch/metag/mm/Kconfig b/arch/metag/mm/Kconfig
index 794f26a..03fb8f1 100644
--- a/arch/metag/mm/Kconfig
+++ b/arch/metag/mm/Kconfig
@@ -93,11 +93,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "2" if SPARSEMEM
-	default "1"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 867ace7..b674397 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -427,11 +427,6 @@ config NODES_SHIFT
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "256" if PPC64
-	default "32"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5a43a87..dba285e 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -137,13 +137,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "6" if (CPU_SUBTYPE_SHX3 && SPARSEMEM)
-	default "2" if SPARSEMEM && (CPU_SUBTYPE_SH7722 || \
-		       CPU_SUBTYPE_SH7785)
-	default "1"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
-- 
1.7.11.7
