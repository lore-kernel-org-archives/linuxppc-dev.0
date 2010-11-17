Return-Path: <Shan.Hai@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 435A3B717B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 13:24:11 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id oAH2O8ke001833
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 18:24:08 -0800 (PST)
From: Shan Hai <shan.hai@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix SPE float to integer conversion failure
Date: Wed, 17 Nov 2010 10:28:53 +0800
Message-Id: <1289960933-5172-2-git-send-email-shan.hai@windriver.com>
In-Reply-To: <1289960933-5172-1-git-send-email-shan.hai@windriver.com>
References: <1289960933-5172-1-git-send-email-shan.hai@windriver.com>
Cc: Shan Hai <shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Conversion from float to integer should based on both the instruction
encoding and the sign of the operand.

Signed-off-by: Shan Hai <shan.hai@windriver.com>
---
 arch/powerpc/math-emu/math_efp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 41f4ef3..64faf10 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -320,7 +320,8 @@ int do_spe_mathemu(struct pt_regs *regs)
 			} else {
 				_FP_ROUND_ZERO(1, SB);
 			}
-			FP_TO_INT_S(vc.wp[1], SB, 32, ((func & 0x3) != 0));
+			FP_TO_INT_S(vc.wp[1], SB, 32,
+					(((func & 0x3) != 0) || SB_s));
 			goto update_regs;
 
 		default:
@@ -458,7 +459,8 @@ cmp_s:
 			} else {
 				_FP_ROUND_ZERO(2, DB);
 			}
-			FP_TO_INT_D(vc.wp[1], DB, 32, ((func & 0x3) != 0));
+			FP_TO_INT_D(vc.wp[1], DB, 32,
+					(((func & 0x3) != 0) || DB_s));
 			goto update_regs;
 
 		default:
@@ -589,8 +591,10 @@ cmp_d:
 				_FP_ROUND_ZERO(1, SB0);
 				_FP_ROUND_ZERO(1, SB1);
 			}
-			FP_TO_INT_S(vc.wp[0], SB0, 32, ((func & 0x3) != 0));
-			FP_TO_INT_S(vc.wp[1], SB1, 32, ((func & 0x3) != 0));
+			FP_TO_INT_S(vc.wp[0], SB0, 32,
+					(((func & 0x3) != 0) || SB0_s));
+			FP_TO_INT_S(vc.wp[1], SB1, 32,
+					(((func & 0x3) != 0) || SB1_s));
 			goto update_regs;
 
 		default:
-- 
1.7.0.2
