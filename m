Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 83520DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:54:30 +1100 (EST)
Date: Thu, 1 Mar 2007 08:54:27 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/7] mpc52xx suspend: bestcomm
Message-ID: <20070301075427.GA17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Save and restore bestcomm registers and SRAM.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Index: grant.git/arch/powerpc/platforms/52xx/bestcomm.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/bestcomm.c
+++ grant.git/arch/powerpc/platforms/52xx/bestcomm.c
@@ -395,4 +395,75 @@ EXPORT_SYMBOL(sdma_set_initiator);
 EXPORT_SYMBOL(sdma_free);
 EXPORT_SYMBOL(sdma);
 
+#ifdef CONFIG_PM
+static struct mpc52xx_sdma sdma_regs;
+static char saved_sram[0x4000]; /* copy of 16kB internal SRAM */
 
+int mpc52xx_sdma_suspend(void)
+{
+	int i;
+
+	sdma_regs.taskBar =	in_be32(&sdma.io->taskBar);
+	sdma_regs.currentPointer = in_be32(&sdma.io->currentPointer);
+	sdma_regs.endPointer =	in_be32(&sdma.io->endPointer);
+	sdma_regs.variablePointer = in_be32(&sdma.io->variablePointer);
+	sdma_regs.IntVect1 =	in_8(&sdma.io->IntVect1);
+	sdma_regs.IntVect2 =	in_8(&sdma.io->IntVect2);
+	sdma_regs.PtdCntrl =	in_be16(&sdma.io->PtdCntrl);
+	sdma_regs.IntPend =	in_be32(&sdma.io->IntPend);
+	sdma_regs.IntMask =	in_be32(&sdma.io->IntMask);
+
+	for (i=0; i<16; i++)
+		sdma_regs.tcr[i] = in_be16(&sdma.io->tcr[i]);
+	for (i=0; i<32; i++)
+		sdma_regs.ipr[i] = in_8(&sdma.io->ipr[i]);
+
+	sdma_regs.cReqSelect =	in_be32(&sdma.io->cReqSelect);
+	sdma_regs.task_size0 = in_be32(&sdma.io->task_size0);
+	sdma_regs.task_size1 = in_be32(&sdma.io->task_size1);
+	sdma_regs.MDEDebug =	in_be32(&sdma.io->MDEDebug);
+	sdma_regs.ADSDebug =	in_be32(&sdma.io->ADSDebug);
+	sdma_regs.Value1 =	in_be32(&sdma.io->Value1);
+	sdma_regs.Value2 =	in_be32(&sdma.io->Value2);
+	sdma_regs.Control =	in_be32(&sdma.io->Control);
+	sdma_regs.Status =	in_be32(&sdma.io->Status);
+	sdma_regs.PTDDebug =	in_be32(&sdma.io->PTDDebug);
+
+	memcpy(saved_sram, sdma.sram, sdma.sram_size);
+	return 0;
+}
+
+int mpc52xx_sdma_resume(void)
+{
+	int i;
+
+	memcpy(sdma.sram, saved_sram, sdma.sram_size);
+
+	out_be32(&sdma.io->taskBar, sdma_regs.taskBar);
+	out_be32(&sdma.io->currentPointer, sdma_regs.currentPointer);
+	out_be32(&sdma.io->endPointer, sdma_regs.endPointer);
+	out_be32(&sdma.io->variablePointer, sdma_regs.variablePointer);
+	out_8(&sdma.io->IntVect1, sdma_regs.IntVect1);
+	out_8(&sdma.io->IntVect2, sdma_regs.IntVect2);
+	out_be16(&sdma.io->PtdCntrl, sdma_regs.PtdCntrl);
+	out_be32(&sdma.io->IntPend, sdma_regs.IntPend);
+	out_be32(&sdma.io->IntMask, sdma_regs.IntMask);
+
+	for (i=0; i<16; i++)
+		out_be16(&sdma.io->tcr[i], sdma_regs.tcr[i]);
+	for (i=0; i<32; i++)
+		out_8(&sdma.io->ipr[i], sdma_regs.ipr[i]);
+
+	out_be32(&sdma.io->cReqSelect, sdma_regs.cReqSelect);
+	out_be32(&sdma.io->task_size0, sdma_regs.task_size0);
+	out_be32(&sdma.io->task_size1, sdma_regs.task_size1);
+	out_be32(&sdma.io->MDEDebug, sdma_regs.MDEDebug);
+	out_be32(&sdma.io->ADSDebug, sdma_regs.ADSDebug);
+	out_be32(&sdma.io->Value1, sdma_regs.Value1);
+	out_be32(&sdma.io->Value2, sdma_regs.Value2);
+	out_be32(&sdma.io->Control, sdma_regs.Control);
+	out_be32(&sdma.io->Status, sdma_regs.Status);
+	out_be32(&sdma.io->PTDDebug, sdma_regs.PTDDebug);
+	return 0;
+}
+#endif
Index: grant.git/arch/powerpc/platforms/52xx/bestcomm.h
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/bestcomm.h
+++ grant.git/arch/powerpc/platforms/52xx/bestcomm.h
@@ -473,6 +473,11 @@ extern void *sdma_sram_alloc(int size, i
 extern void sdma_init_bd(struct sdma *s);
 extern void sdma_init_bd2(struct sdma *s);
 
+#ifdef CONFIG_PM
+extern int mpc52xx_sdma_suspend(void);
+extern int mpc52xx_sdma_resume(void);
+#endif
+
 #define FIELD_OFFSET(s,f) ((unsigned long)(&(((struct s*)0)->f)))
 
 #endif  /* __BESTCOMM_BESTCOMM_H__ */
