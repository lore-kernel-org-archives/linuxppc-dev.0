Return-Path: <benh@ozlabs.org>
To: <bluesmoke-devel@lists.sourceforge.net>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Oct 2007 15:40:44 +1000
Subject: [PATCH 3/4] edac: Add Cell XDR memory definition
In-Reply-To: <1191476442.154524.519055590678.qpush@grosgo>
Message-Id: <20071004054105.71E73DDE07@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the definitions for the Rambus XDR memory type
used by the Cell processor. It's a pre-requisite for the followup
Cell EDAC patch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/edac/edac_core.h     |    2 ++
 drivers/edac/edac_mc_sysfs.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-work/drivers/edac/edac_core.h
===================================================================
--- linux-work.orig/drivers/edac/edac_core.h	2007-10-04 15:00:16.000000000 +1000
+++ linux-work/drivers/edac/edac_core.h	2007-10-04 15:34:20.000000000 +1000
@@ -138,6 +138,7 @@ enum mem_type {
 	MEM_DDR2,		/* DDR2 RAM */
 	MEM_FB_DDR2,		/* fully buffered DDR2 */
 	MEM_RDDR2,		/* Registered DDR2 RAM */
+	MEM_XDR,		/* Rambus XDR */
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -154,6 +155,7 @@ enum mem_type {
 #define MEM_FLAG_DDR2           BIT(MEM_DDR2)
 #define MEM_FLAG_FB_DDR2        BIT(MEM_FB_DDR2)
 #define MEM_FLAG_RDDR2          BIT(MEM_RDDR2)
+#define MEM_FLAG_XDR            BIT(MEM_XDR)
 
 /* chipset Error Detection and Correction capabilities and mode */
 enum edac_type {
Index: linux-work/drivers/edac/edac_mc_sysfs.c
===================================================================
--- linux-work.orig/drivers/edac/edac_mc_sysfs.c	2007-10-04 15:00:16.000000000 +1000
+++ linux-work/drivers/edac/edac_mc_sysfs.c	2007-10-04 15:34:26.000000000 +1000
@@ -73,7 +73,8 @@ static const char *mem_types[] = {
 	[MEM_RMBS] = "RMBS",
 	[MEM_DDR2] = "Unbuffered-DDR2",
 	[MEM_FB_DDR2] = "FullyBuffered-DDR2",
-	[MEM_RDDR2] = "Registered-DDR2"
+	[MEM_RDDR2] = "Registered-DDR2",
+	[MEM_XDR] = "XDR"
 };
 
 static const char *dev_types[] = {
