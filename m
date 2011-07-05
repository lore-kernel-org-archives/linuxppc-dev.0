Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/kdump: Fix timeout in crash_kexec_wait_realmode
In-reply-to: <20110705161202.62dc7d24@kryten>
References: <20110705161202.62dc7d24@kryten>
Date: Tue, 05 Jul 2011 16:40:10 +1000
Message-ID: <29259.1309848010@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing code it pretty ugly.  How about we clean it up even more
like this?

From: Anton Blanchard <anton@samba.org>

We check for timeout expiry in the outer loop, but we also need to
check it in the inner loop or we can lock up forever waiting for a
CPU to hit real mode.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@kernel.org>

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 4e6ee94..cc6a9d5 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -242,12 +242,8 @@ static void crash_kexec_wait_realmode(int cpu)
 
 		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
 			barrier();
-			if (!cpu_possible(i)) {
+			if (!cpu_possible(i) || !cpu_online(i) || (msecs <= 0))
 				break;
-			}
-			if (!cpu_online(i)) {
-				break;
-			}
 			msecs--;
 			mdelay(1);
 		}
