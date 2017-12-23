Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3rvW59ntzDsQM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Dec 2017 03:49:43 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id 62so13144614pld.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 08:49:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] powerpc: System reset avoid interleaving oops using die
 synchronisation
Date: Sun, 24 Dec 2017 02:49:22 +1000
Message-Id: <20171223164923.10587-2-npiggin@gmail.com>
In-Reply-To: <20171223164923.10587-1-npiggin@gmail.com>
References: <20171223164923.10587-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The die() oops path contains a serializing lock to prevent oops
messages from being interleaved. In the case of a system reset
initiated oops (e.g., qemu nmi command), __die was being called
which lacks that synchronisation and oops reports could be
interleaved across CPUs.

A recent patch 4388c9b3a6ee7 ("powerpc: Do not send system reset
request through the oops path") changed this to __die to avoid
the debugger() call, but there is no real harm to calling it twice
if the first time fell through. So go back to using die() here.
This was observed to fix the problem.

Fixes: 4388c9b3a6ee7 ("powerpc: Do not send system reset request through the oops path")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f3eb61be0d30..109989676776 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -337,7 +337,7 @@ void system_reset_exception(struct pt_regs *regs)
 	 * No debugger or crash dump registered, print logs then
 	 * panic.
 	 */
-	__die("System Reset", regs, SIGABRT);
+	die("System Reset", regs, SIGABRT);
 
 	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.15.0
