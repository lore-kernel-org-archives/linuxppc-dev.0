Return-Path: <B13201@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A634DDDED
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:51:06 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBA4p0BC008561
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 21:51:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBA4owFR027848
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 22:50:59 -0600 (CST)
From: Liu Yu <b13201@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix rounding bug in emulation for double float operating
Date: Mon, 10 Dec 2007 13:00:52 +0800
Message-Id: <11972628522442-git-send-email-b13201@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch fixes rounding bug in emulation for double float operating on PowerPC platform.

When pack double float operand, it need to truncate the tail due to the limited precision.
If the truncated part is not zero, the last bit of work bit (totally 3 bits) need to '|' 1.

This patch is completed in _FP_FRAC_SRS_2(X,N,sz) (arch/powerpc/math-emu/op-2.h).
Originally the code leftwards rotates the operand to just keep the truncated part,
then check whether it is zero. However, the number it rotates is not correct when
N is not smaller than _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in the improper case.

This patch fixes this issue.

Signed-off-by: Liu Yu <b13201@freescale.com>

---
 arch/powerpc/math-emu/op-2.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/math-emu/op-2.h b/arch/powerpc/math-emu/op-2.h
index b9b06b4..7d6f17c 100644
--- a/arch/powerpc/math-emu/op-2.h
+++ b/arch/powerpc/math-emu/op-2.h
@@ -59,7 +59,8 @@
     else								\
       {									\
 	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-	          (((X##_f1 << (sz - (N))) | X##_f0) != 0));		\
+	          (((X##_f1 << (2 * _FP_W_TYPE_SIZE - (N))) |		\
+		   X##_f0) != 0));					\
 	X##_f1 = 0;							\
       }									\
   } while (0)
-- 
1.5.2
