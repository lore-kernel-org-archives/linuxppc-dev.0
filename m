Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4b4NqyzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:43 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id p21so205907qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:43 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v5 30/38] powerpc: capture AMR register content on pkey violation
Date: Wed,  5 Jul 2017 14:22:07 -0700
Message-Id: <1499289735-14220-31-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

capture AMR register contents, and save it in paca
whenever a pkey violation is detected.

This value will be needed to deliver pkey-violation
signal to the task.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/paca.h   |    3 +++
 arch/powerpc/kernel/asm-offsets.c |    5 +++++
 arch/powerpc/mm/fault.c           |    2 ++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1c09f8f..c8bd1fc 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -92,6 +92,9 @@ struct paca_struct {
 	struct dtl_entry *dispatch_log_end;
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	u64 dscr_default;		/* per-CPU default DSCR */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	u64 paca_amr;			/* value of amr at exception */
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #ifdef CONFIG_PPC_STD_MMU_64
 	/*
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 709e234..17f5d8a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -241,6 +241,11 @@ int main(void)
 	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
 	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
 	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	OFFSET(PACA_AMR, paca_struct, paca_amr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
 	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
 	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index ea74fe2..a6710f5 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -264,6 +264,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	if (error_code & DSISR_KEYFAULT) {
 		code = SEGV_PKUERR;
+		get_paca()->paca_amr = read_amr();
 		goto bad_area_nosemaphore;
 	}
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
@@ -451,6 +452,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 			is_exec, 0)) {
+		get_paca()->paca_amr = read_amr();
 		code = SEGV_PKUERR;
 		goto bad_area;
 	}
-- 
1.7.1
