Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcs0D2859zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 20:33:16 +1100 (AEDT)
From: "Tobin C. Harding" <me@tobin.cc>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [RESEND PATCH] powerpc/pseries: move struct hcall_stats to c file
Date: Tue,  7 Mar 2017 20:32:42 +1100
Message-Id: <1488879162-20596-1-git-send-email-me@tobin.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct hcall_stats is only used in hvCall_inst.c.

Move struct hcall_stats to hvCall_inst.c

Resolves: #54
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Is this correct, adding 'Resolves: #XX' when fixing
github.com/linuxppc/linux issues?

 arch/powerpc/include/asm/hvcall.h            | 10 ----------
 arch/powerpc/platforms/pseries/hvCall_inst.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 77ff1ba..74599bd 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -364,16 +364,6 @@ long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
 long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
 long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);
 
-/* For hcall instrumentation.  One structure per-hcall, per-CPU */
-struct hcall_stats {
-	unsigned long	num_calls;	/* number of calls (on this CPU) */
-	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
-	unsigned long	purr_total;	/* total cpu time (PURR) of calls. */
-	unsigned long	tb_start;
-	unsigned long	purr_start;
-};
-#define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
-
 struct hvcall_mpp_data {
 	unsigned long entitled_mem;
 	unsigned long mapped_mem;
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index f02ec3a..892db4f 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -29,6 +29,16 @@
 #include <asm/trace.h>
 #include <asm/machdep.h>
 
+/* For hcall instrumentation.  One structure per-hcall, per-CPU */
+struct hcall_stats {
+	unsigned long	num_calls;	/* number of calls (on this CPU) */
+	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
+	unsigned long	purr_total;	/* total cpu time (PURR) of calls. */
+	unsigned long	tb_start;
+	unsigned long	purr_start;
+};
+#define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
+
 DEFINE_PER_CPU(struct hcall_stats[HCALL_STAT_ARRAY_SIZE], hcall_stats);
 
 /*
-- 
2.7.4
