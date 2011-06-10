Return-Path: <minipli@r00tworld.net>
Received: from mail.r00tworld.net (grimli.r00tworld.net [83.169.44.195])
	by ozlabs.org (Postfix) with ESMTP id 5C7FEB6FB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 23:20:10 +1000 (EST)
From: Mathias Krause <minipli@googlemail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc, exec: remove redundant set_fs(USER_DS)
Date: Fri, 10 Jun 2011 15:10:22 +0200
Message-Id: <1307711422-14327-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com>
	<1307642718-22257-1-git-send-email-minipli@googlemail.com>
	<20110609155630.0f734351.akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The address limit is already set in flush_old_exec() so this
set_fs(USER_DS) is redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/powerpc/kernel/process.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 91e52df..885a2dd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -831,8 +831,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	unsigned long load_addr = regs->gpr[2];	/* saved by ELF_PLAT_INIT */
 #endif
 
-	set_fs(USER_DS);
-
 	/*
 	 * If we exec out of a kernel thread then thread.regs will not be
 	 * set.  Do it now.
-- 
1.5.6.5
