Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CNb1RKczDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:59:27 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id a66so16022788qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:59:27 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 34/62] powerpc: capture the violated protection key on fault
Date: Sat, 15 Jul 2017 20:56:36 -0700
Message-Id: <1500177424-13695-35-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/include/asm/paca.h   |    1 +
 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/mm/fault.c           |    8 ++++++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c8bd1fc..0c06188 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -94,6 +94,7 @@ struct paca_struct {
 	u64 dscr_default;		/* per-CPU default DSCR */
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	u64 paca_amr;			/* value of amr at exception */
+	u16 paca_pkey;                  /* exception causing pkey */
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 17f5d8a..7dff862 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -244,6 +244,7 @@ int main(void)
 
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 	OFFSET(PACA_AMR, paca_struct, paca_amr);
+	OFFSET(PACA_PKEY, paca_struct, paca_pkey);
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a6710f5..6423277 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -265,6 +265,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (error_code & DSISR_KEYFAULT) {
 		code = SEGV_PKUERR;
 		get_paca()->paca_amr = read_amr();
+		get_paca()->paca_pkey = get_pte_pkey(current->mm, address);
 		goto bad_area_nosemaphore;
 	}
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
@@ -453,6 +454,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 			is_exec, 0)) {
 		get_paca()->paca_amr = read_amr();
+		/*
+		 * The pgd-pdt...pmd-pte tree may not  have  been fully setup.
+		 * Hence we cannot walk the tree to locate the pte, to locate
+		 * the key. Hence  lets  call  vma_pkey() to get the key here
+		 * instead of get_pte_pkey().
+		 */
+		get_paca()->paca_pkey = vma_pkey(vma);
 		code = SEGV_PKUERR;
 		goto bad_area;
 	}
-- 
1.7.1
