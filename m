Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	akpm@linux-foundation.org, paulus@samba.org,
	Alan Cox <alan@redhat.com>, "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Subject: [PATCH] powerpc: add new required termio functions
Date: Wed, 12 Sep 2007 12:04:39 +1000
Message-ID: <8018.1189562679@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The "tty: termios locking functions break with new termios type" patch
(f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
This adds the required API to asm-powerpc.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
This needs to go up for 2.6.23.

Should we really put these definitions in asm-generic/termios.h as I'm
guessing other architectures are broken too?

coopers@include/ % git grep kernel_termios_to_user_termios_1
asm-arm/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-cris/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-h8300/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-i386/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-ia64/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-m32r/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-m68k/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-mips/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-v850/termios.h:#define kernel_termios_to_user_termios_1(u, k)
asm-x86_64/termios.h:#define kernel_termios_to_user_termios_1(u, k)

 include/asm-powerpc/termios.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6-ozlabs/include/asm-powerpc/termios.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/termios.h
+++ linux-2.6-ozlabs/include/asm-powerpc/termios.h
@@ -80,6 +80,9 @@ struct termio {
 
 #include <asm-generic/termios.h>
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _ASM_POWERPC_TERMIOS_H */
