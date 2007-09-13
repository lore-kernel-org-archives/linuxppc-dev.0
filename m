Return-Path: <lethal@linux-sh.org>
Received: from smtp.ocgnet.org (smtp.ocgnet.org [64.20.243.3])
	by ozlabs.org (Postfix) with ESMTP id 43D75DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 20:19:43 +1000 (EST)
Date: Thu, 13 Sep 2007 18:53:46 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv
Message-ID: <20070913095346.GA28194@linux-sh.org>
References: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
	<46E8DF49.7090402@l4x.org> <5058.1189668156@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5058.1189668156@neuling.org>
Cc: hskinnemoen@atmel.com, Jan Dittmer <jdi@l4x.org>, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Alan Cox <alan@redhat.com>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 05:22:36PM +1000, Michael Neuling wrote:
> > > Commit f629307c857c030d5a3dd777fee37c8bb395e171 introduced uses of
> > > kernel_termios_to_user_termios_1 and user_termios_to_kernel_termios_1
> > > on all architectures.  However, powerpc, s390, avr32 and frv don't
> > > currently define those functions since their termios struct didn't
> > > need to be changed when the arbitrary baud rate stuff was added, and
> > > thus the kernel won't currently build on those architectures.
> > 
> > alpha, parisc, sh, sparc{64,}, xtensa are still broken with this error...
> 
> They need to include <asm-generic/termios.h> in asm-<arch>/termios.h
> like in powerpc.
> 
> Alternatively tonyb's patch should fix them.  Could also do that?
> 
Is there a consensus for this? It's a bit annoying to have this stuff
broken this late in 2.6.23. If Tony's patch gets applied, then this stuff
will work itself out. Otherwise everything has to be patched for
asm-generic/termios.h. In which case.. here's the patch to define them on
sh and sh64.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 include/asm-sh/termios.h   |   34 +---------------------------------
 include/asm-sh64/termios.h |   34 +---------------------------------
 2 files changed, 2 insertions(+), 66 deletions(-)

diff --git a/include/asm-sh/termios.h b/include/asm-sh/termios.h
index e7c8f86..c57f74e 100644
--- a/include/asm-sh/termios.h
+++ b/include/asm-sh/termios.h
@@ -49,39 +49,7 @@ struct termio {
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	*(unsigned short *) &(termios)->x = __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#include <asm-generic/termios.h>
 
 #endif	/* __KERNEL__ */
 
diff --git a/include/asm-sh64/termios.h b/include/asm-sh64/termios.h
index dc44e6e..b61ce95 100644
--- a/include/asm-sh64/termios.h
+++ b/include/asm-sh64/termios.h
@@ -60,39 +60,7 @@ struct termio {
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	*(unsigned short *) &(termios)->x = __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#include <asm-generic/termios.h>
 
 #endif	/* __KERNEL__ */
 
