Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 003261A05EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:56:42 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 16:26:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 34184E0072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:29:41 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAuI0p41287714
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:18 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAFLxe026111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:45:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 03/13] powerpc,
 offset: Change PACA_DSCR to PACA_DSCR_DEFAULT
Date: Mon, 18 May 2015 16:26:06 +0530
Message-Id: <1431946576-1009-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
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
index 0034b6b..9823057 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -247,7 +247,7 @@ int main(void)
 #endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
-	DEFINE(PACA_DSCR, offsetof(struct paca_struct, dscr_default));
+	DEFINE(PACA_DSCR_DEFAULT, offsetof(struct paca_struct, dscr_default));
 	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
 	DEFINE(PACA_STARTTIME_USER, offsetof(struct paca_struct, starttime_user));
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index afbc200..278888e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -556,7 +556,7 @@ BEGIN_FTR_SECTION
 	ld	r0,THREAD_DSCR(r4)
 	cmpwi	r6,0
 	bne	1f
-	ld	r0,PACA_DSCR(r13)
+	ld	r0,PACA_DSCR_DEFAULT(r13)
 1:
 BEGIN_FTR_SECTION_NESTED(70)
 	mfspr	r8, SPRN_FSCR
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 5754b22..bf8f34a 100644
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
index 4d70df2..faa86e9 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -324,7 +324,7 @@ kvm_start_guest:
 kvm_secondary_got_guest:
 
 	/* Set HSTATE_DSCR(r13) to something sensible */
-	ld	r6, PACA_DSCR(r13)
+	ld	r6, PACA_DSCR_DEFAULT(r13)
 	std	r6, HSTATE_DSCR(r13)
 
 	/* Order load of vcore, ptid etc. after load of vcpu */
-- 
1.9.3
