Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B9ED1A0AA5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 16:30:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E54392CE806C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB86UT2Q32964762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB86UTtG029012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:29 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc, offset: Change PACA_DSCR to PACA_DSCR_DEFAULT
Date: Mon,  8 Dec 2014 12:00:10 +0530
Message-Id: <1418020212-4303-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, anton@samba.org
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
index 9d7dede..b6fd715 100644
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
index 0905c8d..a2a1b58 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -564,7 +564,7 @@ BEGIN_FTR_SECTION
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
index edb2ccd..6ed2cf4 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -294,7 +294,7 @@ kvm_start_guest:
 	beq	kvm_no_guest
 
 	/* Set HSTATE_DSCR(r13) to something sensible */
-	ld	r6, PACA_DSCR(r13)
+	ld	r6, PACA_DSCR_DEFAULT(r13)
 	std	r6, HSTATE_DSCR(r13)
 
 	bl	kvmppc_hv_entry
-- 
1.9.3
