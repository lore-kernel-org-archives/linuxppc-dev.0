Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix build break with PPC_EARLY_DEBUG_BOOTX=y
Date: Fri, 29 Nov 2013 14:55:22 +1100
Message-Id: <1385697322-14672-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A kernel configured with PPC_EARLY_DEBUG_BOOTX=y but PPC_PMAC=n and
PPC_MAPLE=n will fail to link:

  btext.c:(.text+0x2d0fc): undefined reference to `.rmci_off'
  btext.c:(.text+0x2d214): undefined reference to `.rmci_on'

Fix it by making the build of rmci_on/off() depend on
PPC_EARLY_DEBUG_BOOTX, which also enable the only code that uses them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/misc_64.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index e59caf8..64bf8db 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -246,8 +246,8 @@ _GLOBAL(__bswapdi2)
 	or	r3,r7,r9
 	blr
 
-#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
 _GLOBAL(rmci_on)
 	sync
 	isync
@@ -277,6 +277,9 @@ _GLOBAL(rmci_off)
 	isync
 	sync
 	blr
+#endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
+
+#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 
 /*
  * Do an IO access in real mode
-- 
1.8.3.2
