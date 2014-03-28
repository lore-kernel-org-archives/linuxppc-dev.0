Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/tm: Remove unnecessary r1 save
Date: Fri, 28 Mar 2014 16:40:33 +1100
Message-Id: <1395985234-27281-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1395985234-27281-1-git-send-email-mikey@neuling.org>
References: <1395985234-27281-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We save r1 to the scratch SPR and restore it from there after the trechkpt so
saving r1 to the paca is not needed.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/tm.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 03567c0..0535c7f 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -320,8 +320,6 @@ _GLOBAL(__tm_recheckpoint)
 	 */
 	SAVE_NVGPRS(r1)
 
-	std	r1, PACAR1(r13)
-
 	/* Load complete register state from ts_ckpt* registers */
 
 	addi	r7, r3, PT_CKPT_REGS		/* Thread's ckpt_regs */
-- 
1.8.3.2
