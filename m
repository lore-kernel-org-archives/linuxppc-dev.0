Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7ED872C03E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:04:16 +1000 (EST)
Received: by mail-lb0-f179.google.com with SMTP id x18so7772944lbi.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 09:04:12 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: net: filter: fix DIVWU instruction opcode
Date: Wed, 11 Sep 2013 18:03:30 +0200
Message-Id: <1378915410-2262-1-git-send-email-murzin.v@gmail.com>
Cc: mikey@neuling.org, paulus@samba.org, Vladimir Murzin <murzin.v@gmail.com>,
 matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently DIVWU stands for *signed* divw opcode:

7d 2a 4b 96 	divwu   r9,r10,r9
7d 2a 4b d6 	divw    r9,r10,r9

Use the *unsigned* divw opcode for DIVWU.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index d7fe9f5..c91842c 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -218,7 +218,7 @@
 #define PPC_INST_MULLW			0x7c0001d6
 #define PPC_INST_MULHWU			0x7c000016
 #define PPC_INST_MULLI			0x1c000000
-#define PPC_INST_DIVWU			0x7c0003d6
+#define PPC_INST_DIVWU			0x7c000396
 #define PPC_INST_RLWINM			0x54000000
 #define PPC_INST_RLDICR			0x78000004
 #define PPC_INST_SLW			0x7c000030
-- 
1.7.10.4
