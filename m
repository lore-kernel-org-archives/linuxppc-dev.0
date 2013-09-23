Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 09/39] powerpc: Reset MSR_LE on signal entry
Date: Mon, 23 Sep 2013 12:04:43 +1000
Message-Id: <1379901913-5945-10-git-send-email-anton@samba.org>
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

We always take signals in big endian which is wrong. Signals
should be taken in native endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/signal_32.c | 3 ++-
 arch/powerpc/kernel/signal_64.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index bebdf1a..b386b0b 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1045,8 +1045,9 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
-	/* enter the signal handler in big-endian mode */
+	/* enter the signal handler in native-endian mode */
 	regs->msr &= ~MSR_LE;
+	regs->msr |= (MSR_KERNEL & MSR_LE);
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index f93ec28..8b51b02 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -773,8 +773,9 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 
 	/* Set up "regs" so we "return" to the signal handler. */
 	err |= get_user(regs->nip, &funct_desc_ptr->entry);
-	/* enter the signal handler in big-endian mode */
+	/* enter the signal handler in native-endian mode */
 	regs->msr &= ~MSR_LE;
+	regs->msr |= (MSR_KERNEL & MSR_LE);
 	regs->gpr[1] = newsp;
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
-- 
1.8.1.2
