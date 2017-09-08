Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpss30776zDrd8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:19 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id d70so2319717qkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:18 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
Date: Fri,  8 Sep 2017 15:45:08 -0700
Message-Id: <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
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

Handle Data and  Instruction exceptions caused by memory
protection-key.

The CPU will detect the key fault if the HPTE is already
programmed with the key.

However if the HPTE is not  hashed, a key fault will not
be detected by the  hardware. The   software will detect
pkey violation in such a case.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/fault.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4797d08..a16bc43 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -145,6 +145,23 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
+static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
+					int si_code)
+{
+	int sig = SIGBUS;
+	int code = BUS_OBJERR;
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (si_code & DSISR_KEYFAULT) {
+		sig = SIGSEGV;
+		code = SEGV_PKUERR;
+	}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
+	_exception(sig, regs, code, address);
+	return 0;
+}
+
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     unsigned int fault)
 {
@@ -391,11 +408,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
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
@@ -492,6 +507,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(access_error(is_write, is_exec, vma)))
 		return bad_area(regs, address);
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
+			is_exec, 0))
+		return __bad_area(regs, address, SEGV_PKUERR);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
+
+	/* handle_mm_fault() needs to know if its a instruction access
+	 * fault.
+	 */
+	if (is_exec)
+		flags |= FAULT_FLAG_INSTRUCTION;
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
-- 
1.7.1
