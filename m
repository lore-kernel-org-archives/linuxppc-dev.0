Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/hw_brk: Fix off by one error when validating DAWR
 region end
Date: Mon, 01 Jul 2013 14:19:50 +1000
Message-ID: <14367.1372652390@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Data Address Watchpoint Register (DAWR) on POWER8 can take a 512
byte range but this range must not cross a 512 byte boundary.

Unfortunately we were off by one when calculating the end of the region,
hence we were not allowing some breakpoint regions which were actually
valid.  This fixes this error.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 3.9+

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1150ae7..f0b47d1 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -176,7 +176,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
 		if ((bp->attr.bp_addr >> 10) != 
-		    ((bp->attr.bp_addr + bp->attr.bp_len) >> 10))
+		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
 			return -EINVAL;
 	}
 	if (info->len >
