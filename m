Return-Path: <sr@denx.de>
Date: Fri, 19 Jan 2007 09:05:47 +0100 (MET)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses
MIME-Version: 1.0
Content-Type: text/plain;  charset="us-ascii"
Message-Id: <200701190906.09112.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses

On systems that supply a real 64bit address (with
CONFIG_RESOURCES_64BIT enabled), don't use the fixup function. This
allows us to use the fixup function when no ERPN is specified and use
the 64 bit address when the ERPN is supplied.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit d615194752d1729211296a3afbf5adb94f2b8444
tree 11f5db07bce1cb3adc4d4be8b4d5b09076221656
parent c32ef45a856a08df6942c5efa1e8abc6e4b9ee0e
author Stefan Roese <sr@denx.de> Fri, 19 Jan 2007 09:02:28 +0100
committer Stefan Roese <sr@denx.de> Fri, 19 Jan 2007 09:02:28 +0100

 arch/ppc/mm/pgtable.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 354a940..1ef63da 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -156,9 +156,19 @@ ioremap64(unsigned long long addr, unsigned long size)
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);
-
-	return ioremap64(addr64, size);
+	/*
+	 * On systems that supply a real 64bit address
+	 * (with CONFIG_RESOURCES_64BIT enabled), don't use the
+	 * fixup function.
+	 * This allows us to use the fixup function when no ERPN
+	 * is specified and use the 64 bit address when the ERPN
+	 * is suppied.
+	 */
+	if ((unsigned long long)addr && 0xffffffff00000000ULL)
+		return ioremap64(addr, size);
+	else
+		return ioremap64(fixup_bigphys_addr(addr, size),
+				 size);
 }
 #endif /* CONFIG_PHYS_64BIT */
 
