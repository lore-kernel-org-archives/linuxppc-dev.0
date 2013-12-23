Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/xmon: Fix timeout loop in get_output_lock()
Date: Mon, 23 Dec 2013 23:46:05 +1100
Message-Id: <1387802766-7199-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1387802766-7199-1-git-send-email-mpe@ellerman.id.au>
References: <1387802766-7199-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As far as I can tell, our 70s era timeout loop in get_output_lock() is
generating no code.

This leads to the hostile takeover happening more or less simultaneously
on all cpus. The result is "interesting", some example output that is
more readable than most:

    cpu 0x1: Vector: 100 (Scypsut e0mx bR:e setV)e catto xc0p:u[ c 00
    c0:0  000t0o0V0erc0td:o5 rfc28050000]0c00 0 0  0 6t(pSrycsV1ppuot
    uxe 1m 2 0Rx21e3:0s0ce000c00000t00)00 60602oV2SerucSayt0y 0p 1sxs

Fix it by using udelay() in the timeout loop. The wait time and check
frequency are arbitrary, but seem to work OK. We already rely on
udelay() working so this is not a new dependency.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 500105c..051037e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -315,10 +315,17 @@ static void get_output_lock(void)
 		if (last_speaker == 0)
 			return;
 
-		timeout = 10000000;
+		/*
+		 * Wait a full second for the lock, we might be on a slow
+		 * console, but check every 100us.
+		 */
+		timeout = 10000;
 		while (xmon_speaker == last_speaker) {
-			if (--timeout > 0)
+			if (--timeout > 0) {
+				udelay(100);
 				continue;
+			}
+
 			/* hostile takeover */
 			prev = cmpxchg(&xmon_speaker, last_speaker, me);
 			if (prev == last_speaker)
-- 
1.8.3.2
