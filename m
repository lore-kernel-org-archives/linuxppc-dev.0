Return-Path: <b04825@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CEC2CDDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 05:25:51 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] qe: ucc_slow.guemr is in the wrong place
Date: Mon, 26 Mar 2007 14:25:42 -0500
Message-Id: <1174937142750-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The definition of struct ucc_slow puts the guemr register immediately after the
utpt register, when it should be at offset 0x90.  This patch adds the missing
0x52-byte padding.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/asm-powerpc/immap_qe.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 9fdd049..1020b7f 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -258,8 +258,9 @@ struct ucc_slow {
 	u8	uccs;		/* UCCx status register */
 	u8	res3[0x24];
 	__be16	utpt;
+	u8	res4[0x52];
 	u8	guemr;		/* UCC general extended mode register */
-	u8	res4[0x200 - 0x091];
+	u8	res5[0x200 - 0x091];
 } __attribute__ ((packed));
 
 /* QE UCC Fast */
-- 
1.5.0.2.260.g2eb065
