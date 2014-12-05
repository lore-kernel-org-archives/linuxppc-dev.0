Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 8F4121A0BC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 22:20:28 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH] powerpc32: fix warning from include/asm-generic/termios-base.h
Message-Id: <20141205112025.330971A5D4F@localhost.localdomain>
Date: Fri,  5 Dec 2014 12:20:25 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When size is equal to 1, the test is always true so lets eliminate both 0 and 1
at first.

include/asm-generic/termios-base.h: In function 'user_termio_to_kernel_termios':
include/asm-generic/termios-base.h:35:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  if (get_user(termios->c_line, &termio->c_line) < 0)
  ^
include/asm-generic/termios-base.h: In function 'kernel_termios_to_user_termio':
include/asm-generic/termios-base.h:57:6: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      put_user(termios->c_line,  &termio->c_line) < 0 ||
      ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 9485b43..f3028d2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -54,7 +54,7 @@
 
 #define __access_ok(addr, size, segment)	\
 	(((addr) <= (segment).seg) &&		\
-	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
+	 (((size) <= 1) || (((size) - 1) <= ((segment).seg - (addr)))))
 
 #endif
 
-- 
2.1.0
