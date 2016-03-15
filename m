Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qPZff3K32zDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 00:07:54 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160315130750.0E43C1A2375@localhost.localdomain>
Date: Tue, 15 Mar 2016 14:07:49 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some versions of GCC, reportedly before 4.8, fail with
arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
addressable

Change the one-element array into a simple variable to avoid this.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
---
Verified with GCC 4.4.4 and GCC 4.8.3

v2: compilation result is compliant with CPU6 ERRATA
    (using stw/lwz and not stwx/lwzx)

 arch/powerpc/include/asm/reg_8xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index d41412c..94d01f8 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -53,7 +53,7 @@
 #ifdef CONFIG_8xx_CPU6
 #define do_mtspr_cpu6(rn, rn_addr, v)	\
 	do {								\
-		int _reg_cpu6 = rn_addr, _tmp_cpu6[1];		\
+		int _reg_cpu6 = rn_addr, _tmp_cpu6;		\
 		asm volatile("stw %0, %1;"				\
 			     "lwz %0, %1;"				\
 			     "mtspr " __stringify(rn) ",%2" :		\
-- 
2.1.0
