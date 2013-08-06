Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 50/63] powerpc: Remove hard coded FP offsets in alignment
 handler
Date: Wed,  7 Aug 2013 02:02:07 +1000
Message-Id: <1375804940-22050-51-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment handler assumes big endian ordering when selecting
the low word of a 64bit floating point value. Use the existing
union which works in both little and big endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 573728b..ceced33 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -891,7 +891,7 @@ int fix_alignment(struct pt_regs *regs)
 #ifdef CONFIG_PPC_FPU
 			preempt_disable();
 			enable_kernel_fp();
-			cvt_df(&data.dd, (float *)&data.v[4]);
+			cvt_df(&data.dd, (float *)&data.x32.low32);
 			preempt_enable();
 #else
 			return 0;
@@ -931,7 +931,7 @@ int fix_alignment(struct pt_regs *regs)
 #ifdef CONFIG_PPC_FPU
 		preempt_disable();
 		enable_kernel_fp();
-		cvt_fd((float *)&data.v[4], &data.dd);
+		cvt_fd((float *)&data.x32.low32, &data.dd);
 		preempt_enable();
 #else
 		return 0;
-- 
1.8.1.2
