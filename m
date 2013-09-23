Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 14/39] powerpc: Alignment handler shouldn't access VSX
 registers with TS_FPR
Date: Mon, 23 Sep 2013 12:04:48 +1000
Message-Id: <1379901913-5945-15-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TS_FPR macro selects the FPR component of a VSX register (the
high doubleword). emulate_vsx is using this macro to get the
address of the associated VSX register. This happens to work on big
endian, but fails on little endian.

Replace it with an explicit array access.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 25d8d8b..3049bd0 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -650,7 +650,7 @@ static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
 	flush_vsx_to_thread(current);
 
 	if (reg < 32)
-		ptr = (char *) &current->thread.TS_FPR(reg);
+		ptr = (char *) &current->thread.fpr[reg][0];
 	else
 		ptr = (char *) &current->thread.vr[reg - 32];
 
-- 
1.8.1.2
