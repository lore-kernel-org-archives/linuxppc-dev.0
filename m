Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcQ2MYpzF1P9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:02 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id z81so13251463wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:02 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 06/21] powerpc: Avoid comparison of unsigned long >= 0 in
 __access_ok
Date: Sun, 25 Feb 2018 18:22:21 +0100
Message-Id: <20180225172236.29650-7-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rewrite check size - 1 <= Y as size < Y since `size` is unsigned value.
Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
In file included from ./include/linux/uaccess.h:14:0,
                 from ./include/asm-generic/termios-base.h:8,
                 from ./arch/powerpc/include/asm/termios.h:20,
                 from ./include/uapi/linux/termios.h:6,
                 from ./include/linux/tty.h:7,
                 from arch/powerpc/kernel/signal_32.c:36:
./include/asm-generic/termios-base.h: In function ‘user_termio_to_kernel_termios’:
./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
   (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                   ^
./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro ‘__access_ok’
   __access_ok((__force unsigned long)(addr), (size), get_fs()))
   ^~~~~~~~~~~
./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macro ‘access_ok’
  if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
      ^~~~~~~~~
./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro ‘__get_user_check’
  __get_user_check((x), (ptr), sizeof(*(ptr)))
  ^~~~~~~~~~~~~~~~
./include/asm-generic/termios-base.h:36:6: note: in expansion of macro ‘get_user’
  if (get_user(termios->c_line, &termio->c_line) < 0)
      ^~~~~~~~
[...]
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 51bfeb8777f0..fadc406bd39d 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -49,7 +49,7 @@
 
 #define __access_ok(addr, size, segment)	\
 	(((addr) <= (segment).seg) &&		\
-	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
+	 (((size) == 0) || ((size) < ((segment).seg - (addr)))))
 
 #endif
 
-- 
2.11.0
