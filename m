Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXxN2RPHzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:59:04 +1000 (AEST)
Message-Id: <c6a874f71f818f0f9559b4960b3a1e2aeebb9a19.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 11/12] powerpc/8xx: Use symbolic names for DSISR bits in DSI
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:59:00 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use symbolic names for DSISR bits in DSI

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 arch/powerpc/mm/fault.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 778a0e11d0e6..a1c2a2cfec7e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -595,7 +595,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	mfspr	r4,SPRN_DAR
-	andis.	r10,r5,0x4000
+	andis.	r10,r5,DSISR_NOHPTE@h
 	beq+	1f
 	tlbie	r4
 dtlbie:
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7a218f69f956..6948d0628cde 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -392,7 +392,7 @@ static void sanity_check_fault(bool is_write, unsigned long error_code) { }
 #else
 #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
 #if defined(CONFIG_PPC_8xx)
-#define page_fault_is_bad(__err)	((__err) & 0x10000000)
+#define page_fault_is_bad(__err)	((__err) & DSISR_NOEXEC_OR_G)
 #elif defined(CONFIG_PPC64)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
 #else
-- 
2.13.3
