Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qy5y2t00zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:03:02 +1000 (AEST)
Message-Id: <f8bb44fbb9aeb9acbe442d38f5baf2da49d179e8.1526995927.git.christophe.leroy@c-s.fr>
In-Reply-To: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
References: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 3/3] powerpc/mm: Use instruction symbolic names in
 store_updates_sp()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 16:02:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use symbolic names defined in asm/ppc-opcode.h
instead of hardcoded values.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v7: New

 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/mm/fault.c               | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 18883b8a6dac..4436887bc415 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -162,6 +162,7 @@
 /* VMX Vector Store Instructions */
 #define OP_31_XOP_STVX          231
 
+#define OP_31   31
 #define OP_LWZ  32
 #define OP_STFS 52
 #define OP_STFSU 53
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index dc64b8e06477..20f696c10bb3 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -76,23 +76,23 @@ static bool store_updates_sp(unsigned int inst)
 		return false;
 	/* check major opcode */
 	switch (inst >> 26) {
-	case 37:	/* stwu */
-	case 39:	/* stbu */
-	case 45:	/* sthu */
-	case 53:	/* stfsu */
-	case 55:	/* stfdu */
+	case OP_STWU:
+	case OP_STBU:
+	case OP_STHU:
+	case OP_STFSU:
+	case OP_STFDU:
 		return true;
-	case 62:	/* std or stdu */
+	case OP_STD:	/* std or stdu */
 		return (inst & 3) == 1;
-	case 31:
+	case OP_31:
 		/* check minor opcode */
 		switch ((inst >> 1) & 0x3ff) {
-		case 181:	/* stdux */
-		case 183:	/* stwux */
-		case 247:	/* stbux */
-		case 439:	/* sthux */
-		case 695:	/* stfsux */
-		case 759:	/* stfdux */
+		case OP_31_XOP_STDUX:
+		case OP_31_XOP_STWUX:
+		case OP_31_XOP_STBUX:
+		case OP_31_XOP_STHUX:
+		case OP_31_XOP_STFSUX:
+		case OP_31_XOP_STFDUX:
 			return true;
 		}
 	}
-- 
2.13.3
