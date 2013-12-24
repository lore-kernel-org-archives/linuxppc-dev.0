Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7AD762C0201
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:21 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so6218349pad.30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:18 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 03/10] powerpc: introduce macro LOAD_REG_ADDR_PIC
Date: Tue, 24 Dec 2013 15:12:05 +0800
Message-Id: <1387869132-12650-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is used to get the address of a variable when the kernel is not
running at the linked or relocated address.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: A new patch in v4.

 arch/powerpc/include/asm/ppc_asm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index f595b98079ee..1279c59624ed 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -295,6 +295,11 @@ n:
  *   you want to access various offsets within it).  On ppc32 this is
  *   identical to LOAD_REG_IMMEDIATE.
  *
+ * LOAD_REG_ADDR_PIC(rn, name)
+ *   Loads the address of label 'name' into register 'run'. Use this when
+ *   the kernel doesn't run at the linked or relocated address. Please
+ *   note that this macro will clobber the lr register.
+ *
  * LOAD_REG_ADDRBASE(rn, name)
  * ADDROFF(name)
  *   LOAD_REG_ADDRBASE loads part of the address of label 'name' into
@@ -305,6 +310,14 @@ n:
  *      LOAD_REG_ADDRBASE(rX, name)
  *      ld	rY,ADDROFF(name)(rX)
  */
+
+/* Be careful, this will clobber the lr register. */
+#define LOAD_REG_ADDR_PIC(reg, name)		\
+	bl	0f;				\
+0:	mflr	reg;				\
+	addis	reg,reg,(name - 0b)@ha;		\
+	addi	reg,reg,(name - 0b)@l;
+
 #ifdef __powerpc64__
 #define LOAD_REG_IMMEDIATE(reg,expr)		\
 	lis     reg,(expr)@highest;		\
-- 
1.8.3.1
