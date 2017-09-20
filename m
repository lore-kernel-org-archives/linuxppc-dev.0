Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxrcT4SKrzDqYR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:15:37 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i130so1197339pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 00:15:37 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 npiggin@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 4/5] powerpc/mce: Hookup ierror (instruction) UE errors
Date: Wed, 20 Sep 2017 17:15:11 +1000
Message-Id: <20170920071512.19522-5-bsingharora@gmail.com>
In-Reply-To: <20170920071512.19522-1-bsingharora@gmail.com>
References: <20170920071512.19522-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hookup instruction errors (UE) for memory offling via memory_failure()
in a manner similar to load/store errors (derror). Since we have access
to the NIP, the conversion is a one step process in this case.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 66b0a5d..31ec893 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -488,7 +488,8 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
 
 static int mce_handle_ierror(struct pt_regs *regs,
 		const struct mce_ierror_table table[],
-		struct mce_error_info *mce_err, uint64_t *addr)
+		struct mce_error_info *mce_err, uint64_t *addr,
+		uint64_t *phys_addr)
 {
 	uint64_t srr1 = regs->msr;
 	int handled = 0;
@@ -540,8 +541,23 @@ static int mce_handle_ierror(struct pt_regs *regs,
 		}
 		mce_err->severity = table[i].severity;
 		mce_err->initiator = table[i].initiator;
-		if (table[i].nip_valid)
+		if (table[i].nip_valid) {
 			*addr = regs->nip;
+			if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
+				table[i].error_type == MCE_ERROR_TYPE_UE) {
+				unsigned long pfn;
+				struct mm_struct *mm;
+
+				if (user_mode(regs))
+					mm = current->mm;
+				else
+					mm = &init_mm;
+
+				pfn = addr_to_pfn(mm, regs->nip);
+				if (pfn != ULONG_MAX)
+					*phys_addr = pfn;
+			}
+		}
 		return handled;
 	}
 
@@ -675,7 +691,8 @@ static long mce_handle_error(struct pt_regs *regs,
 		handled = mce_handle_derror(regs, dtable, &mce_err, &addr,
 				&phys_addr);
 	else
-		handled = mce_handle_ierror(regs, itable, &mce_err, &addr);
+		handled = mce_handle_ierror(regs, itable, &mce_err, &addr,
+				&phys_addr);
 
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
 		handled = mce_handle_ue_error(regs);
-- 
2.9.5
