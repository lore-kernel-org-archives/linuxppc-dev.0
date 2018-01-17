Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH][RFC] opal: allow some opal calls to re-enter OPAL in case we
 take a NMI
Date: Wed, 17 Jan 2018 22:08:31 +1000
Message-Id: <20180117120831.22533-2-npiggin@gmail.com>
In-Reply-To: <20180117120831.22533-1-npiggin@gmail.com>
References: <20180117120831.22533-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not sure if I like this, as said in the other mail. Seems a bit
arbitrary. I wouldn't mind making a single special opal call,
OPAL_MAYDAY, which is allowed through the reentrancy check, stops
all other CPUs, prints some opal backtraces, then allows the remaining
CPU to issue more OPAL calls, so we can print the Linux console out,
reboot, etc.

That would require kernel change, so maybe we can do something like
this for older kernels.
---
 core/opal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/core/opal.c b/core/opal.c
index fd69359c4..d0dd5b3b3 100644
--- a/core/opal.c
+++ b/core/opal.c
@@ -145,7 +145,8 @@ int64_t opal_entry_check(struct stack_frame *eframe)
 	if (!opal_quiesce_state && cpu->in_opal_call) {
 		printf("CPU ATTEMPT TO RE-ENTER FIRMWARE! PIR=%04lx cpu @%p -> pir=%04x token=%llu\n",
 		       mfspr(SPR_PIR), cpu, cpu->pir, token);
-		if (token != OPAL_CEC_REBOOT &&
+		if (token != OPAL_QUIESCE &&
+				token != OPAL_CEC_REBOOT &&
 				token != OPAL_CEC_POWER_DOWN &&
 				token != OPAL_CEC_REBOOT2 &&
 				token != OPAL_SIGNAL_SYSTEM_RESET)
-- 
2.15.1
