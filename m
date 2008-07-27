Return-Path: <roland@redhat.com>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by ozlabs.org (Postfix) with ESMTP id 98B04DDDE7
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 16:49:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc: tracehook_signal_handler
In-Reply-To: Roland McGrath's message of  Saturday, 26 July 2008 23:48:59 -0700
	<20080727064859.69692154280@magilla.localdomain>
References: <20080727064859.69692154280@magilla.localdomain>
Message-Id: <20080727064950.F2F69154280@magilla.localdomain>
Date: Sat, 26 Jul 2008 23:49:50 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the powerpc signal handling code call tracehook_signal_handler()
after a handler is set up.  This means that using PTRACE_SINGLESTEP to
enter a signal handler will report to ptrace on the first instruction of
the handler, instead of the second.  This is consistent with what x86 and
other machines do, and what users and debuggers want.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/signal.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 7aada78..11a5c45 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -9,7 +9,7 @@
  * this archive for more details.
  */
 
-#include <linux/ptrace.h>
+#include <linux/tracehook.h>
 #include <linux/signal.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -177,6 +177,12 @@ int do_signal(sigset_t *oldset, struct pt_regs *regs)
 		 * its frame, and we can clear the TLF_RESTORE_SIGMASK flag.
 		 */
 		current_thread_info()->local_flags &= ~_TLF_RESTORE_SIGMASK;
+
+		/*
+		 * Let tracing know that we've done the handler setup.
+		 */
+		tracehook_signal_handler(signr, &info, &ka, regs,
+					 test_thread_flag(TIF_SINGLESTEP));
 	}
 
 	return ret;
