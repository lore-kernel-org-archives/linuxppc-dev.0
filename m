Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 61CEB100EAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:08:26 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 03/17] fsl_rio: Remove FreeScale e500 conditionals
Date: Wed,  9 Nov 2011 19:07:01 -0500
Message-Id: <1320883635-17194-4-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Shaohui Xie <b21989@freescale.com>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Liu Gang <Gang.Liu@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>, Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "CONFIG_E500" conditional should be unnecessary.  The fsl_rio
hardware is only present on MPC85xx (e500/e500mc) anyways, although it
should build everywhere for better compile-test coverage.

The conditionally-defined fsl_rio_mcheck_exception() function lost its
two e500-specific constants in commit 82a9a4809f:
  powerpc/e500: fix breakage with fsl_rio_mcheck_exception

Specifically, the references to SPRN_MCSR and MCSR_BUS_RBERR were moved
to an e500-specific file.

This patch just removes the unnecessary #ifdef, as the entire file is
effectively dead code on non-e500 platforms anyways.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index de170fd..783e25c 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -281,7 +281,6 @@ struct rio_priv {
 
 static void __iomem *rio_regs_win;
 
-#ifdef CONFIG_E500
 int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *entry;
@@ -308,7 +307,6 @@ int fsl_rio_mcheck_exception(struct pt_regs *regs)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fsl_rio_mcheck_exception);
-#endif
 
 /**
  * fsl_rio_doorbell_send - Send a MPC85xx doorbell message
-- 
1.7.2.5
