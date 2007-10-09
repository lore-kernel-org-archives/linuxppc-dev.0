Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 037D9DE03B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 17:03:59 +1000 (EST)
Date: Tue, 9 Oct 2007 17:03:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Align the sys_call_table
Message-Id: <20071009170357.ffe23910.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our _GLOBAL macro does a ".align 2" so the alignment is fine for 32
bit, but on 64 bit it is possible for it to end up only 4 byte aligned.
I don't know if it matters, but it can't hurt to 8 byte align it.

It also means that when we build with --emit_relocs, none of our 64 bit
relocations are to misaligned places.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/systbl.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 579de70..93219c3 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -39,6 +39,8 @@
 #ifdef CONFIG_PPC64
 #define sys_sigpending	sys_ni_syscall
 #define sys_old_getrlimit sys_ni_syscall
+
+	.p2align	3
 #endif
 
 _GLOBAL(sys_call_table)
-- 
1.5.3.4
