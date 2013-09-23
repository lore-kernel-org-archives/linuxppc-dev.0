Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 29/39] powerpc/powernv: Fix OPAL entry and exit in little
 endian mode
Date: Mon, 23 Sep 2013 12:05:03 +1000
Message-Id: <1379901913-5945-30-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8f38445..2a03e1e 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -34,7 +34,7 @@
 	mtmsrd	r12,1;			\
 	LOAD_REG_ADDR(r0,.opal_return);	\
 	mtlr	r0;			\
-	li	r0,MSR_DR|MSR_IR;	\
+	li	r0,MSR_DR|MSR_IR|MSR_LE;\
 	andc	r12,r12,r0;		\
 	li	r0,token;		\
 	mtspr	SPRN_HSRR1,r12;		\
@@ -45,6 +45,13 @@
 	hrfid
 
 _STATIC(opal_return)
+	/*
+	 * Fixup endian on OPAL return... we should be able to simplify
+	 * this by instead converting the below trampoline to a set of
+	 * bytes (always BE) since MSR:LE will end up fixed up as a side
+	 * effect of the rfid.
+	 */
+	FIXUP_ENDIAN
 	ld	r2,PACATOC(r13);
 	ld	r4,8(r1);
 	ld	r5,16(r1);
-- 
1.8.1.2
