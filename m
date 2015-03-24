Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56BBD1A0659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 09:49:43 +1100 (AEDT)
Date: Tue, 24 Mar 2015 17:44:11 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <scottwood@freescale.com>, Joel Stanley <joel@jms.id.au>, Anton Blanchard
 <anton@samba.org>, Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina
 <jkosina@suse.cz>, Ulrich Weigand <ulrich.weigand@de.ibm.com>, "Alexander
 Graf" <agraf@suse.de>, Stewart Smith <stewart@linux.vnet.ibm.com>, "Kyle
 Moffett" <Kyle.D.Moffett@boeing.com>
Subject: [PATCH 1/3] powerpc/e6500: set FTR_VMX_COPY
Message-ID: <20150324174411.9f084e8d41707de42533572a@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables the VMX/ALTIVEC optimised copy-to/from-user code in
arch/powerpc/lib/copyuser_power7.S.  The e6500 does, and the e5500
does not, have ALTIVEC.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/include/asm/cputable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 5cf5a6d..66ca94a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -391,7 +391,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT)
+	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT | CPU_FTR_VMX_COPY)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-- 
2.3.3
