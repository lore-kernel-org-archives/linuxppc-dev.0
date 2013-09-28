Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com
 [IPv6:2a00:1450:4010:c04::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 203F02C0246
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 18:22:59 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id q8so2973937lbi.39
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 01:22:55 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc: net: filter: fix DIVWU instruction opcode
Date: Sat, 28 Sep 2013 10:22:00 +0200
Message-Id: <1380356521-3432-1-git-send-email-murzin.v@gmail.com>
Cc: matt@ozlabs.org, netdev@vger.kernel.org,
 Vladimir Murzin <murzin.v@gmail.com>, dborkman@redhat.com, edumazet@google.com,
 paulus@samba.org, davem@davemloft.net
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

Suggested-by: Vassili Karpov <av1474@comtv.ru>
Reviewed-by: Vassili Karpov <av1474@comtv.ru>
Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
Acked-by: Matt Evans <matt@ozlabs.org>
---
Changelog

v1->v2

Added credit to Vassili Karpov (malc) who kindly reviewed generated assembly
[1] and highlighted usage of signed division.
Note: temporary, for technical reason, he's not able to receive email.

[1]http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg71635.html

 arch/powerpc/include/asm/ppc-opcode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index eccfc16..0a4a683 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -171,7 +171,7 @@
 #define PPC_INST_MULLW			0x7c0001d6
 #define PPC_INST_MULHWU			0x7c000016
 #define PPC_INST_MULLI			0x1c000000
-#define PPC_INST_DIVWU			0x7c0003d6
+#define PPC_INST_DIVWU			0x7c000396
 #define PPC_INST_RLWINM			0x54000000
 #define PPC_INST_RLDICR			0x78000004
 #define PPC_INST_SLW			0x7c000030
-- 
1.8.1.5
