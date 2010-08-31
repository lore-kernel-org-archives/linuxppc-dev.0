Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 68E9EB70FE
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:15:27 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: Linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] PPC: Fix compilation of fsl_rio.c
Date: Tue, 31 Aug 2010 04:15:21 +0200
Message-Id: <1283220922-20369-3-git-send-email-agraf@suse.de>
In-Reply-To: <1283220922-20369-1-git-send-email-agraf@suse.de>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a52c8f52 introduced machine check magic for the RapidIO chip.
Unfortunately it was so magical that it used constants that aren't even
defined!

This patch bluntly comments out the broken constant's usage. This
probably means that said functionality thus doesn't work, but at
least it makes it compile for me.

CC: Alexandre Bounine <alexandre.bounine@idt.com>
CC: Thomas Moll <thomas.moll@sysgo.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/sysdev/fsl_rio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 6425abe..dba2969 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -245,7 +245,7 @@ static int (*saved_mcheck_exception)(struct pt_regs *regs);
 static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *entry = NULL;
-	unsigned long reason = (mfspr(SPRN_MCSR) & MCSR_MASK);
+	unsigned long reason = (mfspr(SPRN_MCSR) /* & MCSR_MASK */);
 
 	if (reason & MCSR_BUS_RBERR) {
 		reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
-- 
1.6.0.2
