Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQfxX3p4tzDvn2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 15:25:20 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so7101199pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 20:25:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Leonidas S . Barbosa" <leosilva@linux.vnet.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] crypto: vmx - rebuild generated asm when target changes
Date: Sat, 26 Nov 2016 15:24:59 +1100
Message-Id: <20161126042459.1964-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switching from big endian to little endian can fail to regenerate
the crypto assembly properly. Switch to using standard form of
kbuild dependency checking (i.e., use FORCE and if_changed).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/crypto/vmx/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index b47da00..16ab2a0 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -1,6 +1,8 @@
 obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 
+targets += aesp8-ppc.S ghashp8-ppc.S
+
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 TARGET := linux-ppc64le
 else
@@ -11,13 +13,13 @@ TARGET := linux-ppc64
 endif
 endif
 
-quiet_cmd_perl = PERL $@
+quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
 
-$(src)/aesp8-ppc.S: $(src)/aesp8-ppc.pl
-	$(call cmd,perl)
+$(src)/aesp8-ppc.S: $(src)/aesp8-ppc.pl FORCE
+	$(call if_changed,perl)
   
-$(src)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl
-	$(call cmd,perl)
+$(src)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl FORCE
+	$(call if_changed,perl)
 
 .PRECIOUS: $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S
-- 
2.10.2
