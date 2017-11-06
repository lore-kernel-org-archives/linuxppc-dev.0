Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmhK5GzWzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:59:13 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id j58so10029230qtj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:59:13 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 19/51] powerpc: Handle exceptions caused by pkey violation
Date: Mon,  6 Nov 2017 00:57:11 -0800
Message-Id: <1509958663-18737-20-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle Data and  Instruction exceptions caused by memory
protection-key.

The CPU will detect the key fault if the HPTE is already
programmed with the key.

However if the HPTE is not  hashed, a key fault will not
be detected by the hardware. The software will detect
pkey violation in such a case.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/fault.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4797d08..dfcd0e4 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -145,6 +145,24 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
+static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
+				    int si_code)
+{
+	int sig = SIGBUS;
+	int code = BUS_OBJERR;
+
+#ifdef CONFIG_PPC_MEM_KEYS
+	if (si_code & DSISR_KEYFAULT) {
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+		sig = SIGSEGV;
+		code = SEGV_PKUERR;
+	}
+#endif /* CONFIG_PPC_MEM_KEYS */
+
+	_exception(sig, regs, code, address);
+	return 0;
+}
+
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     unsigned int fault)
 {
@@ -391,11 +409,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return 0;
 
 	if (unlikely(page_fault_is_bad(error_code))) {
-		if (is_user) {
-			_exception(SIGBUS, regs, BUS_OBJERR, address);
-			return 0;
-		}
-		return SIGBUS;
+		if (!is_user)
+			return SIGBUS;
+		return bad_page_fault_exception(regs, address, error_code);
 	}
 
 	/* Additional sanity check(s) */
@@ -498,6 +514,12 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+
+#ifdef CONFIG_PPC_MEM_KEYS
+	if (unlikely(fault & VM_FAULT_SIGSEGV))
+		return __bad_area(regs, address, SEGV_PKUERR);
+#endif /* CONFIG_PPC_MEM_KEYS */
+
 	major |= fault & VM_FAULT_MAJOR;
 
 	/*
-- 
1.7.1
