Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gxQ3PrZzF189
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:02:34 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id l4so3881780pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:02:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 4/4] powerpc/xmon: Detect if OPAL was interrupted and mark
 unrecoverable
Date: Fri, 16 Mar 2018 20:02:12 +1000
Message-Id: <20180316100212.5110-5-npiggin@gmail.com>
In-Reply-To: <20180316100212.5110-1-npiggin@gmail.com>
References: <20180316100212.5110-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xmon can be entered via sreset NMI (from a management sreset, or an
NMI IPI), which can interrupt OPAL. xmon will then issue OPAL calls
to read and write the console, which re-enter OPAL and will destroy
the OPAL stack. So xmon must not attempt to recover in this case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

--
Skiboot at the moment will spew messages about re-entrant call
detected and things will go bad from there. I have some patches
for it that allow a few calls through that allow the console to
work from xmon, obviously still not recoverable.
---
 arch/powerpc/include/asm/opal.h       |  2 ++
 arch/powerpc/platforms/powernv/opal.c |  5 +++++
 arch/powerpc/xmon/xmon.c              | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 12e70fb58700..b7efd9b0c720 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -27,6 +27,8 @@ extern struct kobject *opal_kobj;
 /* /ibm,opal */
 extern struct device_node *opal_node;
 
+bool in_opal_text(u64 address);
+
 /* API functions */
 int64_t opal_invalid_call(void);
 int64_t opal_npu_destroy_context(uint64_t phb_id, uint64_t pid, uint64_t bdf);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c15182765ff5..88627b59ea2e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -64,6 +64,11 @@ static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
 static struct task_struct *kopald_tsk;
 
+bool in_opal_text(u64 address)
+{
+	return (address >= opal.base && address < opal.base + opal.size);
+}
+
 void opal_configure_cores(void)
 {
 	u64 reinit_flags = 0;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..482709933c46 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -510,6 +510,20 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
 	xmon_fault_jmp[cpu] = recurse_jmp;
 
+	if (firmware_has_feature(FW_FEATURE_OPAL)) {
+		if (in_opal_text(regs->nip)) {
+			printf("WARNING: cpu 0x%x stopped in OPAL, cannot recover\n", cpu);
+			regs->msr &= ~MSR_RI;
+			/*
+			 * It should be possible to return to OPAL if we
+			 * didn't do anything else here, but xmon makes
+			 * re-entrant OPAL calls to print console, which will
+			 * trash the OPAL stack. So we have to mark ourselves
+			 * as non-recoverable here.
+			 */
+		}
+	}
+
 	bp = NULL;
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
 		bp = at_breakpoint(regs->nip);
-- 
2.16.1
