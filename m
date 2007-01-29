Return-Path: <sr@denx.de>
Date: Mon, 29 Jan 2007 09:42:23 +0100 (MET)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses
References: <200701190906.09112.sr@denx.de>
	<1169207845.28708.2.camel@crusty.rchland.ibm.com>
In-Reply-To: <1169207845.28708.2.camel@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Message-Id: <200701290942.10515.sr@denx.de>
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
commit 1d49664db83cbf3a982846745eaaa4a1eb2e429f
tree 596eb295efef6c996f140778491111dfd90fc968
parent 5263bf65d6342e12ab716db8e529501670979321
author Stefan Roese <sr@denx.de> Mon, 29 Jan 2007 09:37:37 +0100
committer Stefan Roese <sr@denx.de> Mon, 29 Jan 2007 09:37:37 +0100

 arch/ppc/mm/pgtable.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 354a940..2f9a311 100644
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
+	if ((unsigned long long)addr & 0xffffffff00000000ULL)
+		return ioremap64(addr, size);
+	else
+		return ioremap64(fixup_bigphys_addr(addr, size),
+				 size);
 }
 #endif /* CONFIG_PHYS_64BIT */
 
