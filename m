Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A5186689AE
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jan 2006 02:15:04 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id k0NC7eln229512
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 12:07:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP
	id k0NC7dsw221946
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 13:07:39 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k0NC7dE6016412
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 13:07:39 +0100
Date: Mon, 23 Jan 2006 13:07:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] powerpc: Fix sigmask handling in sys_sigsuspend.
Message-ID: <20060123120737.GG9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Better save the sigmask instead of throwing it away so it can be restored.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Completely untested. Just noticed this when adding TIF_RESTORE_SIGMASK
support for s390.

 arch/powerpc/kernel/signal_32.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3747ab0..c6d0595 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -254,11 +254,9 @@ int do_signal(sigset_t *oldset, struct p
  */
 long sys_sigsuspend(old_sigset_t mask)
 {
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
