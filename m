Return-Path: <xieyisheng1@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xQTZ12NdzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 21:38:58 +1000 (AEST)
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 20/21] powerpc/xmon: use match_string() helper
Date: Thu, 31 May 2018 19:11:25 +0800
Message-ID: <1527765086-19873-21-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/powerpc/xmon/xmon.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1..872ac8c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3161,7 +3161,7 @@ static void proccall(void)
 }
 
 #define N_PTREGS	44
-static char *regnames[N_PTREGS] = {
+static const char *regnames[N_PTREGS] = {
 	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
 	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
 	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
@@ -3196,18 +3196,17 @@ static void proccall(void)
 			regname[i] = c;
 		}
 		regname[i] = 0;
-		for (i = 0; i < N_PTREGS; ++i) {
-			if (strcmp(regnames[i], regname) == 0) {
-				if (xmon_regs == NULL) {
-					printf("regs not available\n");
-					return 0;
-				}
-				*vp = ((unsigned long *)xmon_regs)[i];
-				return 1;
-			}
+		i = match_string(regnames, N_PTREGS, regname);
+		if (i < 0) {
+			printf("invalid register name '%%%s'\n", regname);
+			return 0;
 		}
-		printf("invalid register name '%%%s'\n", regname);
-		return 0;
+		if (xmon_regs == NULL) {
+			printf("regs not available\n");
+			return 0;
+		}
+		*vp = ((unsigned long *)xmon_regs)[i];
+		return 1;
 	}
 
 	/* skip leading "0x" if any */
-- 
1.7.12.4
