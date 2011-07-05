Return-Path: <anton@samba.org>
Date: Tue, 5 Jul 2011 16:12:02 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kdump: Fix timeout in crash_kexec_wait_realmode
Message-ID: <20110705161202.62dc7d24@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We check for timeout expiry in the outer loop, but we also need to
check it in the inner loop or we can lock up forever waiting for a
CPU to hit real mode.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/kernel/crash.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/crash.c	2011-07-05 15:04:18.512140484 +1000
+++ linux-powerpc/arch/powerpc/kernel/crash.c	2011-07-05 15:05:51.483747575 +1000
@@ -240,7 +240,8 @@ static void crash_kexec_wait_realmode(in
 		if (i == cpu)
 			continue;
 
-		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
+		while ((paca[i].kexec_state < KEXEC_STATE_REAL_MODE) &&
+				(msecs > 0)) {
 			barrier();
 			if (!cpu_possible(i)) {
 				break;
