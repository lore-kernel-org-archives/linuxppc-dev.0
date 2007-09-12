Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
Date: Thu, 13 Sep 2007 01:16:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
Subject: Define termios_1 functions for powerpc, s390, avr32 and frv
Cc: Michael Neuling <mikey@neuling.org>, hskinnemoen@atmel.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit f629307c857c030d5a3dd777fee37c8bb395e171 introduced uses of
kernel_termios_to_user_termios_1 and user_termios_to_kernel_termios_1
on all architectures.  However, powerpc, s390, avr32 and frv don't
currently define those functions since their termios struct didn't
need to be changed when the arbitrary baud rate stuff was added, and
thus the kernel won't currently build on those architectures.

This adds definitions of kernel_termios_to_user_termios_1 and
user_termios_to_kernel_termios_1 to include/asm-generic/termios.h
which are identical to kernel_termios_to_user_termios and
user_termios_to_kernel_termios respectively.  The definitions are the
same because the "old" termios and "new" termios are in fact the same
on these architectures (which are the same ones that use
asm-generic/termios.h).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

Linus, this seems a bit cleaner than putting ifdefs in
drivers/char/tty_ioctl.c, and it fixes the compile error on powerpc.
Your choice whether to use this patch or Tony's.

diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index 3769e6b..33dca30 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -63,6 +63,8 @@ static inline int kernel_termios_to_user_termio(struct termio __user *termio,
 
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
 
 #endif	/* __ARCH_TERMIO_GETPUT */
 
