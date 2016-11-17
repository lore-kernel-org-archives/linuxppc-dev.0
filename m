Return-Path: <tklauser@distanz.ch>
Received: from mail.zhinst.com (mail.zhinst.com [212.126.164.98])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tKRDr3fSdzDvtK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 03:20:27 +1100 (AEDT)
From: Tobias Klauser <tklauser@distanz.ch>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix old style declaration GCC warnings
Date: Thu, 17 Nov 2016 17:20:24 +0100
Message-Id: <20161117162024.13344-1-tklauser@distanz.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix two [-Wold-style-declaration] GCC warnings by moving the inline
keyword before the return type.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/powerpc/kernel/prom_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 88ac964f4858..05d2556ebb9f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -461,14 +461,14 @@ static int __init prom_next_node(phandle *nodep)
 	}
 }
 
-static int inline prom_getprop(phandle node, const char *pname,
+static inline int prom_getprop(phandle node, const char *pname,
 			       void *value, size_t valuelen)
 {
 	return call_prom("getprop", 4, 1, node, ADDR(pname),
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
-static int inline prom_getproplen(phandle node, const char *pname)
+static inline int prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
-- 
2.11.0.rc0.7.gbe5a750
