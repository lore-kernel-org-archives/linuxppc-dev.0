Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40n9Kd00K5zF291
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 11:18:28 +1000 (AEST)
Date: Fri, 18 May 2018 11:18:33 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
    linux-kernel@vger.kernel.org
Message-Id: <a93c26abed5911cd92cf51b50bc4a0ca278188de.1526602763.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH RESEND] powerpc/lib: Fix "integer constant is too large" build
 failure
ReSent-Message-ID: <alpine.LNX.2.21.1805181118300.26@nippy.intranet>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My powerpc-linux-gnu-gcc v4.4.5 compiler can't build a 32-bit kernel
any more:

arch/powerpc/lib/sstep.c: In function 'do_popcnt':
arch/powerpc/lib/sstep.c:1068: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1069: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1070: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c:1079: error: integer constant is too large for 'long' type
arch/powerpc/lib/sstep.c: In function 'do_prty':
arch/powerpc/lib/sstep.c:1117: error: integer constant is too large for 'long' type

This file gets compiled with -std=gnu89 which means a constant can be
given the type 'long' even if it won't fit. Fix the errors with a 'ULL'
suffix on the relevant constants.

Fixes: 2c979c489fee ("powerpc/lib/sstep: Add prty instruction emulation")
Fixes: dcbd19b48d31 ("powerpc/lib/sstep: Add popcnt instruction emulation")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
This change was compile tested but not regression tested.
---
I'm re-sending this because the first submission didn't show up on
patchwork.ozlabs.org, apparently because I sent it without any
message-id header. Sorry about that.
---
 arch/powerpc/lib/sstep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..49427a3ee104 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1065,9 +1065,10 @@ static nokprobe_inline void do_popcnt(const struct pt_regs *regs,
 {
 	unsigned long long out = v1;
 
-	out -= (out >> 1) & 0x5555555555555555;
-	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
-	out = (out + (out >> 4)) & 0x0f0f0f0f0f0f0f0f;
+	out -= (out >> 1) & 0x5555555555555555ULL;
+	out = (0x3333333333333333ULL & out) +
+	      (0x3333333333333333ULL & (out >> 2));
+	out = (out + (out >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
 
 	if (size == 8) {	/* popcntb */
 		op->val = out;
@@ -1076,7 +1077,7 @@ static nokprobe_inline void do_popcnt(const struct pt_regs *regs,
 	out += out >> 8;
 	out += out >> 16;
 	if (size == 32) {	/* popcntw */
-		op->val = out & 0x0000003f0000003f;
+		op->val = out & 0x0000003f0000003fULL;
 		return;
 	}
 
@@ -1114,7 +1115,7 @@ static nokprobe_inline void do_prty(const struct pt_regs *regs,
 
 	res ^= res >> 16;
 	if (size == 32) {		/* prtyw */
-		op->val = res & 0x0000000100000001;
+		op->val = res & 0x0000000100000001ULL;
 		return;
 	}
 
-- 
2.16.1
