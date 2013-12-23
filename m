Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/xmon: Don't loop forever in get_output_lock()
Date: Mon, 23 Dec 2013 23:46:04 +1100
Message-Id: <1387802766-7199-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

If we enter with xmon_speaker != 0 we skip the first cmpxchg(), we also
skip the while loop because xmon_speaker != last_speaker (0) - meaning we
skip the second cmpxchg() also.

Following that code path the compiler sees no memory barriers and so is
within its rights to never reload xmon_speaker. The end result is we loop
forever.

This manifests as all cpus being in xmon ('c' command), but they refuse
to take control when you switch to them ('c x' for cpu # x).

I have seen this deadlock in practice and also checked the generated code to
confirm this is what's happening.

The simplest fix is just to always try the cmpxchg().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index af9d346..500105c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -309,12 +309,12 @@ static void get_output_lock(void)
 
 	if (xmon_speaker == me)
 		return;
+
 	for (;;) {
-		if (xmon_speaker == 0) {
-			last_speaker = cmpxchg(&xmon_speaker, 0, me);
-			if (last_speaker == 0)
-				return;
-		}
+		last_speaker = cmpxchg(&xmon_speaker, 0, me);
+		if (last_speaker == 0)
+			return;
+
 		timeout = 10000000;
 		while (xmon_speaker == last_speaker) {
 			if (--timeout > 0)
-- 
1.8.3.2
