Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 May 2008 10:00:55 +1000
Subject: [PATCH 1/2] [POWERPC] Fix bogus paca->_current initialization
Message-Id: <20080507000236.1CD33DDE19@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When doing lockdep, I had two patches to initialize paca->_current
early. One bogus, and one correct. Unfortunately both got merged
as the bad one ended up being part of the main lockdep patch by
mistake. This causes memory corruption at boot. This patch removes
the offending code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/head_64.S |    4 ----
 1 file changed, 4 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/head_64.S	2008-05-07 09:54:17.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2008-05-07 09:54:23.000000000 +1000
@@ -1517,10 +1517,6 @@ _INIT_STATIC(start_here_multiplatform)
 	addi	r2,r2,0x4000
 	add	r2,r2,r26
 
-	/* Set initial ptr to current */
-	LOAD_REG_IMMEDIATE(r4, init_task)
-	std	r4,PACACURRENT(r13)
-
 	/* Do very early kernel initializations, including initial hash table,
 	 * stab and slb setup before we turn on relocation.	*/
 
