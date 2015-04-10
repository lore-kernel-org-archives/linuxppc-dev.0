Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75DEF1A2D62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 18:31:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 619B92CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8V7sp35389650
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8UgPl025880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:30:42 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/13] powerpc,
 offset: Change PACA_DSCR to PACA_DSCR_DEFAULT
Date: Fri, 10 Apr 2015 14:00:02 +0530
Message-Id: <1428654612-23539-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PACA_DSCR offset macro tracks dscr_default element in the paca
structure. Better change the name of this macro to match that
of the data element it tracks. Makes the code more readable.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/asm-offsets.c       | 2 +-
 arch/powerpc/kernel/entry_64.S          | 2 +-
 arch/powerpc/kernel/tm.S                | 4 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4717859..d51a14a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -246,7 +246,7 @@ int main(void)
 #endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
-	DEFINE(PACA_DSCR, offsetof(struct paca_struct, dscr_default));
+	DEFINE(PACA_DSCR_DEFAULT, offsetof(struct paca_struct, dscr_default));
 	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
 	DEFINE(PACA_STARTTIME_USER, offsetof(struct paca_struct, starttime_user));
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d180caf2..117ca4b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -551,7 +551,7 @@ BEGIN_FTR_SECTION
 	ld	r0,THREAD_DSCR(r4)
 	cmpwi	r6,0
 	bne	1f
-	ld	r0,PACA_DSCR(r13)
+	ld	r0,PACA_DSCR_DEFAULT(r13)
 1:
 BEGIN_FTR_SECTION_NESTED(70)
 	mfspr	r8, SPRN_FSCR
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 2a324f4..dbd2c18 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -293,7 +293,7 @@ dont_backup_fp:
 	ld	r2, STK_GOT(r1)
 
 	/* Load CPU's default DSCR */
-	ld	r0, PACA_DSCR(r13)
+	ld	r0, PACA_DSCR_DEFAULT(r13)
 	mtspr	SPRN_DSCR, r0
 
 	blr
@@ -473,7 +473,7 @@ restore_gprs:
 	ld	r2, STK_GOT(r1)
 
 	/* Load CPU's default DSCR */
-	ld	r0, PACA_DSCR(r13)
+	ld	r0, PACA_DSCR_DEFAULT(r13)
 	mtspr	SPRN_DSCR, r0
 
 	blr
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6cbf163..541863d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -283,7 +283,7 @@ kvm_start_guest:
 kvm_secondary_got_guest:
 
 	/* Set HSTATE_DSCR(r13) to something sensible */
-	ld	r6, PACA_DSCR(r13)
+	ld	r6, PACA_DSCR_DEFAULT(r13)
 	std	r6, HSTATE_DSCR(r13)
 
 	bl	kvmppc_hv_entry
-- 
1.9.3
