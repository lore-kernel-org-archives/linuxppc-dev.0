Return-Path: <juhosg@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB7802C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 00:53:33 +1100 (EST)
From: Gabor Juhos <juhosg@openwrt.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: add missing NULL terminator to avoid boot panic on
 PPC40x
Date: Thu, 20 Dec 2012 14:44:28 +0100
Message-Id: <1356011068-26349-1-git-send-email-juhosg@openwrt.org>
Cc: Gabor Juhos <juhosg@openwrt.org>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The missing NULL terminator can cause a panic on
PPC405 boards during boot:

  Linux/PowerPC load: console=ttyS0,115200 root=/dev/mtdblock1 rootfstype=squashfs,jffs2 noinitrd init=/etc/preinit
  Finalizing device tree... flat tree at 0x6a5160
  bootconsole [udbg0] enabled
  Page fault in user mode with in_atomic() = 1 mm = (null)
  NIP = c0275f50  MSR = fffffffe
  Oops: Weird page fault, sig: 11 [#1]
  PowerPC 40x Platform
  Modules linked in:
  NIP: c0275f50 LR: c0275f60 CTR: c0280000
  REGS: c0275eb0 TRAP: 636f7265   Not tainted  (3.7.1)
  MSR: fffffffe <VEC,VSX,EE,PR,FP,ME,SE,BE,IR,DR,PMM,RI> CR: c06a6190  XER: 00000001
  TASK = c02662a8[0] 'swapper' THREAD: c0274000
  GPR00: c0275ec0 c000c658 c027c4bf 00000000 c0275ee0 c000a0ec c020a1a8 c020a1f0
  GPR08: c020f631 c020f404 c025f078 c025f080 c0275f10
   Call Trace:
   ---[ end trace 31fd0ba7d8756001 ]---

  Kernel panic - not syncing: Attempted to kill the idle task!

The panic happens since commit 9597abe00c1bab2aedce6b49866bf6d1e81c9eed
(sections: fix section conflicts in arch/powerpc), however the root
cause of this is that the NULL terminator were not added in commit
a4f740cf33f7f6c164bbde3c0cdbcc77b0c4997c (of/flattree: Add of_flat_dt_match()
helper function).

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <stable@vger.kernel.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/powerpc/platforms/40x/ppc40x_simple.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 969dddc..8f3920e 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -57,7 +57,8 @@ static const char * const board[] __initconst = {
 	"amcc,makalu",
 	"apm,klondike",
 	"est,hotfoot",
-	"plathome,obs600"
+	"plathome,obs600",
+	NULL
 };
 
 static int __init ppc40x_probe(void)
-- 
1.7.10
