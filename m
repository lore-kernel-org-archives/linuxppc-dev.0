Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpss63SFGzDrcy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:22 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id 7so2357460qtz.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:22 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 22/25] powerpc: capture the violated protection key on fault
Date: Fri,  8 Sep 2017 15:45:10 -0700
Message-Id: <1504910713-7094-31-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Capture the protection key that got violated in paca.
This value will be later used to inform the signal
handler.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/paca.h   |    3 +++
 arch/powerpc/kernel/asm-offsets.c |    5 +++++
 arch/powerpc/mm/fault.c           |   11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 04b60af..51c89c1 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -97,6 +97,9 @@ struct paca_struct {
 	struct dtl_entry *dispatch_log_end;
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	u64 dscr_default;		/* per-CPU default DSCR */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	u16 paca_pkey;                  /* exception causing pkey */
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #ifdef CONFIG_PPC_STD_MMU_64
 	/*
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8cfb20e..361f0d4 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -241,6 +241,11 @@ int main(void)
 	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
 	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
 	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	OFFSET(PACA_PKEY, paca_struct, paca_pkey);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
 	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
 	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a16bc43..ad31f6e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -153,6 +153,7 @@ static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
 
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	if (si_code & DSISR_KEYFAULT) {
+		get_paca()->paca_pkey = get_pte_pkey(current->mm, address);
 		sig = SIGSEGV;
 		code = SEGV_PKUERR;
 	}
@@ -509,8 +510,16 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
-			is_exec, 0))
+			is_exec, 0)) {
+		/*
+		 * The pgd-pdt...pmd-pte tree may not  have  been fully setup.
+		 * Hence we cannot walk the tree to locate the pte, to locate
+		 * the key. Hence lets use vma_pkey() to get the key; instead
+		 * of get_pte_pkey().
+		 */
+		get_paca()->paca_pkey = vma_pkey(vma);
 		return __bad_area(regs, address, SEGV_PKUERR);
+	}
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 
-- 
1.7.1
