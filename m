Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXxL1GrNzDqpP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:59:02 +1000 (AEST)
Message-Id: <75790d577495824f18f00baf5791a106d9afa7d4.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 10/12] powerpc/8xx: Use symbolic PVR value
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the 8xx, PVR values defined in arch/powerpc/include/asm/reg.h
are nowhere used.

Remove all defines and add PVR_8xx

Use it in arch/powerpc/kernel/cputable.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h | 6 ++----
 arch/powerpc/kernel/cputable.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 70722e5b93e7..c36823d64ec9 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1247,10 +1247,8 @@
  * differentiated by the version number in the Communication Processor
  * Module (CPM).
  */
-#define PVR_821		0x00500000
-#define PVR_823		PVR_821
-#define PVR_850		PVR_821
-#define PVR_860		PVR_821
+#define PVR_8xx		0x00500000
+
 #define PVR_8240	0x00810100
 #define PVR_8245	0x80811014
 #define PVR_8260	PVR_8240
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e9ba5b84ac9b..760872916013 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1262,7 +1262,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #ifdef CONFIG_PPC_8xx
 	{	/* 8xx */
 		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00500000,
+		.pvr_value		= PVR_8xx,
 		.cpu_name		= "8xx",
 		/* CPU_FTR_MAYBE_CAN_DOZE is possible,
 		 * if the 8xx code is there.... */
-- 
2.13.3
