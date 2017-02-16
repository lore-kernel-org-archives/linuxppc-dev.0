Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPMrJ5GBxzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:01:36 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id o64so2014068pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 09:01:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] powerpc: machine check allow handler to set severity and
 initiator
Date: Fri, 17 Feb 2017 03:01:11 +1000
Message-Id: <20170216170114.25247-2-npiggin@gmail.com>
In-Reply-To: <20170216170114.25247-1-npiggin@gmail.com>
References: <20170216170114.25247-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently these are hardcoded values.

mce_error_info should not have to be versioned because it's only used
for passing data from within the MCE subsystem.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mce.h  | 3 ++-
 arch/powerpc/kernel/mce.c       | 7 ++++---
 arch/powerpc/kernel/mce_power.c | 6 ++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index f97d8cb6bdf6..b2a5865ccd87 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -177,7 +177,8 @@ struct mce_error_info {
 		enum MCE_EratErrorType erat_error_type:8;
 		enum MCE_TlbErrorType tlb_error_type:8;
 	} u;
-	uint8_t		reserved[2];
+	enum MCE_Severity	severity:8;
+	enum MCE_Initiator	initiator:8;
 };
 
 #define MAX_MC_EVT	100
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index c6923ff45131..d7a88dce67e8 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -90,13 +90,14 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	mce->gpr3 = regs->gpr[3];
 	mce->in_use = 1;
 
-	mce->initiator = MCE_INITIATOR_CPU;
 	/* Mark it recovered if we have handled it and MSR(RI=1). */
 	if (handled && (regs->msr & MSR_RI))
 		mce->disposition = MCE_DISPOSITION_RECOVERED;
 	else
 		mce->disposition = MCE_DISPOSITION_NOT_RECOVERED;
-	mce->severity = MCE_SEV_ERROR_SYNC;
+
+	mce->initiator = mce_err->initiator;
+	mce->severity = mce_err->severity;
 
 	/*
 	 * Populate the mce error_type and type-specific error_type.
@@ -268,7 +269,7 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
-	       "Recovered" : "[Not recovered");
+	       "Recovered" : "Not recovered");
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
 	switch (evt->error_type) {
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 7353991c4ece..c37fc5fdd433 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -281,6 +281,9 @@ long __machine_check_early_realmode_p7(struct pt_regs *regs)
 	long handled = 1;
 	struct mce_error_info mce_error_info = { 0 };
 
+	mce_error_info.severity = MCE_SEV_ERROR_SYNC;
+	mce_error_info.initiator = MCE_INITIATOR_CPU;
+
 	srr1 = regs->msr;
 	nip = regs->nip;
 
@@ -352,6 +355,9 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
 	long handled = 1;
 	struct mce_error_info mce_error_info = { 0 };
 
+	mce_error_info.severity = MCE_SEV_ERROR_SYNC;
+	mce_error_info.initiator = MCE_INITIATOR_CPU;
+
 	srr1 = regs->msr;
 	nip = regs->nip;
 
-- 
2.11.0
