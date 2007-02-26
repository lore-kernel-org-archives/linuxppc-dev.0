Return-Path: <mokuno@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 95356DDED7
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 19:21:08 +1100 (EST)
Date: Mon, 26 Feb 2007 17:21:05 +0900
From: MOKUNO Masakazu <mokuno@sm.sony.co.jp>
To: paulus@samba.org
Subject: [PATCH] powerpc: Remove some redunant isync instructions
Message-Id: <20070226171709.A2E8.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove some redundant isync instructions.

enable_64b_mode() already does an isync, so there is no need to do it again.

Signed-off-by: MOKUNO, Masakazu <mokuno@sm.sony.co.jp>

---
 arch/powerpc/kernel/head_64.S |    2 --
 1 files changed, 2 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/kernel/head_64.S
+++ ps3-linux-dev/arch/powerpc/kernel/head_64.S
@@ -1555,7 +1555,6 @@ _GLOBAL(generic_secondary_smp_init)
 	
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
-	isync
 
 	/* Set up a paca value for this processor. Since we have the
 	 * physical cpu id in r24, we need to search the pacas to find
@@ -1851,7 +1850,6 @@ __secondary_start_pmac_0:
 _GLOBAL(pmac_secondary_start)
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
-	isync
 
 	/* Copy some CPU settings from CPU 0 */
 	bl	.__restore_cpu_ppc970

--
Masakazu MOKUNO
