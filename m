Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
From: Emil Medve <Emilian.Medve@Freescale.com>
To: kumar.gala@Freescale.com, paulus@samba.org, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] Added missing CEURNR register
Date: Wed, 26 Sep 2007 12:03:40 -0500
Message-Id: <1190826220-14138-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to the publicly available MPC8360E RM (rev. 1 from 09/2006 and rev. 2
from 05/2007) and MPC8323E RM (rev. 1 from 09/2006), CEURNR is the QE microcode
revision number register and is located at offset 0x1b8 within the QE internal
register space

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

I'm writing a driver and I felt the need to know the microcode revision

This patch is against Paul's tree: c4d5e375470862fd741f93bf0686d7ac2f7fdce4

powerpc> scripts/checkpatch.pl 0001-Added-missing-CEURNR-register.patch 
Your patch has no obvious style problems and is ready for submission.

 include/asm-powerpc/immap_qe.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 1020b7f..02548f7 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -86,8 +86,9 @@ struct cp_qe {
 	__be16	ceexe4;		/* QE external request 4 event register */
 	u8	res11[0x2];
 	__be16	ceexm4;		/* QE external request 4 mask register */
-	u8	res12[0x2];
-	u8	res13[0x280];
+	u8	res12[0x3A];
+	__be32	ceurnr;		/* QE microcode revision number register */
+	u8	res13[0x244];
 } __attribute__ ((packed));
 
 /* QE Multiplexer */
-- 
1.5.3.GIT
