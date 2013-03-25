Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews07.kpnxchange.com (cpsmtpb-ews07.kpnxchange.com
 [213.75.39.10]) by ozlabs.org (Postfix) with ESMTP id 622C62C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 21:32:17 +1100 (EST)
Message-ID: <1364207531.1390.271.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove two lines of dead code
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Mon, 25 Mar 2013 11:32:11 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit c1fb6816fb1b78dd94b673b0fdaa9a7a16e97bd1 ("powerpc: Add
relocation on exception vector handlers") added two lines of code that
depend on the macro CONFIG_HVC_SCOM. That macro doesn't exist. Perhaps
it was intended to use CONFIG_PPC_SCOM here. But since
"maintence_interrupt" is a typo and there's nothing in arch/powerpc that
looks like maintenance_interrupt it seems best to just delete these
lines.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested, but low risk anyway.

 arch/powerpc/kernel/exceptions-64s.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 200afa5..9181353 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -870,10 +870,6 @@ tm_unavailable_relon_pSeries_1:
 	. = 0x5500
 	b	denorm_exception_hv
 #endif
-#ifdef CONFIG_HVC_SCOM
-	STD_RELON_EXCEPTION_HV(0x5600, 0x1600, maintence_interrupt)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1600)
-#endif /* CONFIG_HVC_SCOM */
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
 	/* Other future vectors */
-- 
1.7.11.7
