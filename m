Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBt1c3TzF3Hd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:34 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id a5-v6so897213qtp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:34 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 3/9] powerpc/pkeys: key allocation/deallocation must not
 change pkey registers
Date: Tue, 17 Jul 2018 06:51:04 -0700
Message-Id: <1531835470-32691-4-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
References: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Key allocation and deallocation has the side effect of programming the
UAMOR/AMR/IAMR registers. This is wrong, since its the responsibility of
the application and not that of the kernel, to modify the permission on
the key.

Do not modify the pkey registers at key allocation/deallocation.

This patch also fixes a bug where a sys_pkey_free() resets the UAMOR
bits of the key, thus making its permissions unmodifiable from user
space.  Later if the same key gets reallocated from a different thread
this thread will no longer be able to change the permissions on the key.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   11 -----------
 arch/powerpc/mm/pkeys.c          |   27 ---------------------------
 2 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 5ba80cf..3312606 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -94,8 +94,6 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 		__mm_pkey_is_allocated(mm, pkey));
 }
 
-extern void __arch_activate_pkey(int pkey);
-extern void __arch_deactivate_pkey(int pkey);
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  * Relies on the mmap_sem to protect against concurrency in mm_pkey_alloc() and
@@ -124,11 +122,6 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 	ret = ffz((u32)mm_pkey_allocation_map(mm));
 	__mm_pkey_allocated(mm, ret);
 
-	/*
-	 * Enable the key in the hardware
-	 */
-	if (ret > 0)
-		__arch_activate_pkey(ret);
 	return ret;
 }
 
@@ -140,10 +133,6 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	if (!mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
-	/*
-	 * Disable the key in the hardware
-	 */
-	__arch_deactivate_pkey(pkey);
 	__mm_pkey_free(mm, pkey);
 
 	return 0;
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 7dc0024..cd0e623 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -218,33 +218,6 @@ static inline void init_iamr(int pkey, u8 init_bits)
 	write_iamr(old_iamr | new_iamr_bits);
 }
 
-static void pkey_status_change(int pkey, bool enable)
-{
-	u64 old_uamor;
-
-	/* Reset the AMR and IAMR bits for this key */
-	init_amr(pkey, 0x0);
-	init_iamr(pkey, 0x0);
-
-	/* Enable/disable key */
-	old_uamor = read_uamor();
-	if (enable)
-		old_uamor |= (0x3ul << pkeyshift(pkey));
-	else
-		old_uamor &= ~(0x3ul << pkeyshift(pkey));
-	write_uamor(old_uamor);
-}
-
-void __arch_activate_pkey(int pkey)
-{
-	pkey_status_change(pkey, true);
-}
-
-void __arch_deactivate_pkey(int pkey)
-{
-	pkey_status_change(pkey, false);
-}
-
 /*
  * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
  * specified in @init_val.
-- 
1.7.1
