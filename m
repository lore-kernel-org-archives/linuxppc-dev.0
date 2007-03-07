Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Mar 2007 11:27:37 +0100
Subject: [PATCH 1/3] powerpc: Fix warning in prom_parse.c of_irq_map_oldworld()
Message-Id: <20070307102745.159C2DDED3@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function spews a warning due to possible use of an uninitialized
variable. This can happen on broken device-trees or when called with
a NULL argument. Makes ure we properly fail instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/prom_parse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tika/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-tika.orig/arch/powerpc/kernel/prom_parse.c	2007-03-05 14:19:31.000000000 +0100
+++ linux-tika/arch/powerpc/kernel/prom_parse.c	2007-03-05 14:19:38.000000000 +0100
@@ -916,7 +916,7 @@
 static int of_irq_map_oldworld(struct device_node *device, int index,
 			       struct of_irq *out_irq)
 {
-	const u32 *ints;
+	const u32 *ints = NULL;
 	int intlen;
 
 	/*
