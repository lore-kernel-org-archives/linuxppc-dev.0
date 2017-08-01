Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMLxB2qF2zDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 02:14:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v71G9nLc129233
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 12:14:19 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c2udyn3rx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 12:14:19 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 13:14:17 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v71GEEHR22216718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 13:14:15 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v71GEEIC004304
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 13:14:15 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
 <87shhgdx5i.fsf@linux.vnet.ibm.com> <87d18fu6o1.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-arch@vger.kernel.org, corbet@lwn.net,
 arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
In-reply-to: <87d18fu6o1.fsf@concordia.ellerman.id.au>
Date: Tue, 01 Aug 2017 13:14:02 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d18fw9it.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> Ram Pai <linuxram@us.ibm.com> writes:
> ...
>>> +
>>> +	/* We got one, store it and use it from here on out */
>>> +	if (need_to_set_mm_pkey)
>>> +		mm->context.execute_only_pkey = execute_only_pkey;
>>> +	return execute_only_pkey;
>>> +}
>>
>> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
>> are read 3 times in total, and AMR is written twice. IAMR is read and
>> written twice. Since they are SPRs and access to them is slow (or isn't
>> it?),
>
> SPRs read/writes are slow, but they're not *that* slow in comparison to
> a system call (which I think is where this code is being called?).

Yes, this code runs on mprotect and mmap syscalls if the memory is
requested to have execute but not read nor write permissions.

> So we should try to avoid too many SPR read/writes, but at the same time
> we can accept more than the minimum if it makes the code much easier to
> follow.

Ok. Ram had asked me to suggest a way to optimize the SPR reads and
writes and I came up with the patch below. Do you think it's worth it?

The patch applies on top of this series, but if Ram includes it I think
he would break it up and merge it into the other patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


>From f6e73e67d325c4a1952c375072ca35156a9f2042 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Mon, 31 Jul 2017 20:22:59 -0300
Subject: [PATCH] powerpc: Cache protection key registers in
 __execute_only_pkey

Pass around a struct with the contents of AMR, IAMR and AMOR, as well as
flags indicating whether those fields hold valid values and whether they
should be committed back to the registers.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |  18 ++++--
 arch/powerpc/mm/pkeys.c          | 120 +++++++++++++++++++++++++++++----------
 2 files changed, 104 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index e61ed6c332db..66f15dbc5855 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -129,12 +129,15 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 		mm_set_pkey_is_allocated(mm, pkey));
 }
 
-extern void __arch_activate_pkey(int pkey);
+struct pkey_regs_cache;
+
+extern void __arch_activate_pkey(int pkey, struct pkey_regs_cache *regs);
 extern void __arch_deactivate_pkey(int pkey);
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  */
-static inline int mm_pkey_alloc(struct mm_struct *mm)
+static inline int __mm_pkey_alloc(struct mm_struct *mm,
+				  struct pkey_regs_cache *regs)
 {
 	/*
 	 * Note: this is the one and only place we make sure
@@ -162,10 +165,15 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 	 * enable the key in the hardware
 	 */
 	if (ret > 0)
-		__arch_activate_pkey(ret);
+		__arch_activate_pkey(ret, regs);
 	return ret;
 }
 
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	return __mm_pkey_alloc(mm, NULL);
+}
+
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
 	if (!pkey_inited)
@@ -206,13 +214,13 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 }
 
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
+		unsigned long init_val, struct pkey_regs_cache *regs);
 static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	if (!pkey_inited)
 		return -EINVAL;
-	return __arch_set_user_pkey_access(tsk, pkey, init_val);
+	return __arch_set_user_pkey_access(tsk, pkey, init_val, NULL);
 }
 
 static inline bool arch_pkeys_enabled(void)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 1424c79f45f6..718ea23f8184 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -22,52 +22,92 @@ u32  initial_allocation_mask;	/* bits set for reserved keys */
 #define PKEY_REG_BITS (sizeof(u64)*8)
 #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
 
-static bool is_pkey_enabled(int pkey)
+/*
+ * The registers controlling memory protection keys are expensive to access, so
+ * we want to cache their values in code paths that might need to use them more
+ * than once.
+ */
+struct pkey_regs_cache {
+	u64 amr;
+	u64 iamr;
+	u64 uamor;
+
+	bool amr_valid;
+	bool iamr_valid;
+	bool uamor_valid;
+
+	bool write_amr;
+	bool write_iamr;
+	bool write_uamor;
+};
+
+static bool is_pkey_enabled(int pkey, struct pkey_regs_cache *regs)
 {
-	return !!(read_uamor() & (0x3ul << pkeyshift(pkey)));
+	u64 uamor = (regs && regs->uamor_valid) ? regs->uamor : read_uamor();
+	return !!(uamor & (0x3ul << pkeyshift(pkey)));
 }
 
-static inline void init_amr(int pkey, u8 init_bits)
+static inline void init_amr(int pkey, u8 init_bits,
+			    struct pkey_regs_cache *regs)
 {
 	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
-	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
+	u64 amr = (regs && regs->amr_valid) ? regs->amr : read_amr();
+
+	amr = (amr & ~((u64)(0x3ul) << pkeyshift(pkey))) | new_amr_bits;
 
-	write_amr(old_amr | new_amr_bits);
+	if (regs) {
+		regs->amr = amr;
+		regs->amr_valid = regs->write_amr = true;
+	} else
+		write_amr(amr);
 }
 
-static inline void init_iamr(int pkey, u8 init_bits)
+static inline void init_iamr(int pkey, u8 init_bits,
+			     struct pkey_regs_cache *regs)
 {
 	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
-	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
+	u64 iamr = (regs && regs->iamr_valid) ? regs->iamr : read_iamr();
 
-	write_iamr(old_iamr | new_iamr_bits);
+	iamr = (iamr & ~((u64)(0x3ul) << pkeyshift(pkey))) | new_iamr_bits;
+
+	if (regs) {
+		regs->iamr = iamr;
+		regs->iamr_valid = regs->write_iamr = true;
+	} else
+		write_iamr(iamr);
 }
 
-static void pkey_status_change(int pkey, bool enable)
+static void pkey_status_change(int pkey, bool enable,
+			       struct pkey_regs_cache *regs)
 {
-	u64 old_uamor;
+	u64 uamor;
 
 	/* reset the AMR and IAMR bits for this key */
-	init_amr(pkey, 0x0);
-	init_iamr(pkey, 0x0);
+	init_amr(pkey, 0x0, regs);
+	init_iamr(pkey, 0x0, regs);
 
 	/* enable/disable key */
-	old_uamor = read_uamor();
+	uamor = (regs && regs->uamor_valid) ? regs->uamor : read_uamor();
 	if (enable)
-		old_uamor |= (0x3ul << pkeyshift(pkey));
+		uamor |= (0x3ul << pkeyshift(pkey));
 	else
-		old_uamor &= ~(0x3ul << pkeyshift(pkey));
-	write_uamor(old_uamor);
+		uamor &= ~(0x3ul << pkeyshift(pkey));
+
+	if (regs) {
+		regs->uamor = uamor;
+		regs->uamor_valid = regs->write_uamor = true;
+	} else
+		write_uamor(uamor);
 }
 
-void __arch_activate_pkey(int pkey)
+void __arch_activate_pkey(int pkey, struct pkey_regs_cache *regs)
 {
-	pkey_status_change(pkey, true);
+	pkey_status_change(pkey, true, regs);
 }
 
 void __arch_deactivate_pkey(int pkey)
 {
-	pkey_status_change(pkey, false);
+	pkey_status_change(pkey, false, NULL);
 }
 
 /*
@@ -75,12 +115,12 @@ void __arch_deactivate_pkey(int pkey)
  * for @pkey to that specified in @init_val.
  */
 int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val)
+		unsigned long init_val, struct pkey_regs_cache *regs)
 {
 	u64 new_amr_bits = 0x0ul;
 	u64 new_iamr_bits = 0x0ul;
 
-	if (!is_pkey_enabled(pkey))
+	if (!is_pkey_enabled(pkey, regs))
 		return -EINVAL;
 
 	/* Set the bits we need in AMR:  */
@@ -89,23 +129,37 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	else if (init_val & PKEY_DISABLE_WRITE)
 		new_amr_bits |= AMR_WR_BIT;
 
-	init_amr(pkey, new_amr_bits);
+	init_amr(pkey, new_amr_bits, regs);
 
 	if ((init_val & PKEY_DISABLE_EXECUTE))
 		new_iamr_bits |= IAMR_EX_BIT;
 
-	init_iamr(pkey, new_iamr_bits);
+	init_iamr(pkey, new_iamr_bits, regs);
 	return 0;
 }
 
-static inline bool pkey_allows_readwrite(int pkey)
+static inline bool pkey_allows_readwrite(int pkey, struct pkey_regs_cache *regs)
 {
 	int pkey_shift = pkeyshift(pkey);
+	u64 uamor = (regs && regs->uamor_valid) ? regs->uamor : read_uamor();
+	u64 amr;
 
-	if (!(read_uamor() & (0x3UL << pkey_shift)))
+	if (regs && !regs->uamor_valid) {
+		regs->uamor = uamor;
+		regs->uamor_valid = true;
+	}
+
+	if (!(uamor & (0x3UL << pkey_shift)))
 		return true;
 
-	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
+	amr = (regs && regs->amr_valid) ? regs->amr : read_amr();
+
+	if (regs && !regs->amr_valid) {
+		regs->amr = amr;
+		regs->amr_valid = true;
+	}
+
+	return !(amr & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
 }
 
 int __execute_only_pkey(struct mm_struct *mm)
@@ -113,11 +167,12 @@ int __execute_only_pkey(struct mm_struct *mm)
 	bool need_to_set_mm_pkey = false;
 	int execute_only_pkey = mm->context.execute_only_pkey;
 	int ret;
+	struct pkey_regs_cache regs = { 0 };
 
 	/* Do we need to assign a pkey for mm's execute-only maps? */
 	if (execute_only_pkey == -1) {
 		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
+		execute_only_pkey = __mm_pkey_alloc(mm, &regs);
 		if (execute_only_pkey < 0)
 			return -1;
 		need_to_set_mm_pkey = true;
@@ -131,7 +186,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	 * ourselves.
 	 */
 	if (!need_to_set_mm_pkey &&
-	    !pkey_allows_readwrite(execute_only_pkey))
+	    !pkey_allows_readwrite(execute_only_pkey, &regs))
 		return execute_only_pkey;
 
 	/*
@@ -139,7 +194,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	 * other than execution.
 	 */
 	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
-			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE), &regs);
 	/*
 	 * If the AMR-set operation failed somehow, just return
 	 * 0 and effectively disable execute-only support.
@@ -149,6 +204,13 @@ int __execute_only_pkey(struct mm_struct *mm)
 		return -1;
 	}
 
+	if (regs.write_amr)
+		write_amr(regs.amr);
+	if (regs.write_iamr)
+		write_iamr(regs.iamr);
+	if (regs.write_uamor)
+		write_uamor(regs.uamor);
+
 	/* We got one, store it and use it from here on out */
 	if (need_to_set_mm_pkey)
 		mm->context.execute_only_pkey = execute_only_pkey;
-- 
2.13.0
