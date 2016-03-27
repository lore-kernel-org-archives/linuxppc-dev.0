Return-Path: <zhaoxiu.zeng@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXnRj2MDjzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 17:38:25 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id 1so11379831pal.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 23:38:25 -0700 (PDT)
Subject: [PATCH 09/31] Add powerpc-specific parity functions
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Torsten Duwe <duwe@lst.de>, Scott Wood <oss@buserror.net>,
 Anton Blanchard <anton@samba.org>, Christophe Leroy <christophe.leroy@c-s.fr>
From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Message-ID: <56F77FBA.1090304@gmail.com>
Date: Sun, 27 Mar 2016 14:37:46 +0800
MIME-Version: 1.0
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset=gbk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 arch/powerpc/include/asm/bitops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc62..90ee0f2 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -269,8 +269,15 @@ unsigned int __arch_hweight16(unsigned int w);
 unsigned int __arch_hweight32(unsigned int w);
 unsigned long __arch_hweight64(__u64 w);
 #include <asm-generic/bitops/const_hweight.h>
+#define __arch_parity4(w) (__arch_hweight8((w) & 0xf) & 1)
+#define __arch_parity8(w) (__arch_hweight8(w) & 1)
+#define __arch_parity16(w) (__arch_hweight16(w) & 1)
+#define __arch_parity32(w) (__arch_hweight32(w) & 1)
+#define __arch_parity64(w) ((unsigned int)__arch_hweight64(w) & 1)
+#include <asm-generic/bitops/const_parity.h>
 #else
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #endif
 
 #include <asm-generic/bitops/find.h>
-- 
2.5.5
