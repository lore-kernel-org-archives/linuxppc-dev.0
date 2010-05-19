Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a14b6e8101e0b1ef31b4096c4e9550e625d7558d.1274271144.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] rtasd: Don't start event scan if scan rate is zero
Date: Wed, 19 May 2010 22:12:32 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There appear to be Pegasos systems which have the rtas-event-scan
RTAS tokens, but on which the event scan always fails. They also
have an event-scan-rate property containing 0, which means call
event scan 0 times per minute.

So interpret a scan rate of 0 to mean don't scan at all. This fixes
the problem on the Pegasos machines and makes sense as well.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/rtasd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index e907ca6..638883e 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -490,6 +490,12 @@ static int __init rtas_init(void)
 		return -ENODEV;
 	}
 
+	if (!rtas_event_scan_rate) {
+		/* Broken firmware: take a rate of zero to mean don't scan */
+		printk(KERN_DEBUG "rtasd: scan rate is 0, not scanning\n");
+		return 0;
+	}
+
 	/* Make room for the sequence number */
 	rtas_error_log_max = rtas_get_error_log_max();
 	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
-- 
1.7.0.4
