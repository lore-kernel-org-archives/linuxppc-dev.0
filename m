Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 800F6B7003
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 17:49:00 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 16 Apr 2012 07:41:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3G7mcfP19792050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 17:48:38 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3G7mbjV001030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 17:48:37 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] [44x][KEXEC] Fix/Initialize PID to kernel PID before the TLB
 search
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 16 Apr 2012 13:18:21 +0530
Message-ID: <20120416074720.1517.90935.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize the PID register with kernel pid (0) before we start
setting the TLB mapping for KEXEC. Also set the MMUCR[TID] to kernel
PID.

This was spotted while testing the kexec on ISS for 47x. ISS  doesn't
return a successful tlbsx for a kernel address with PID set to a user PID.
Though the hardware/qemu/simics work fine.

This patch is harmless and initializes the PID to 0 (kernel PID) which
is usually the case during a normal kernel boot. This would fix the kexec
on ISS for 440. I have tested this patch on sequoia board.

Signed-off-by: Suzuki K Poulose <suzuki@in.ibm.com>
Cc:	Josh Boyer <jwboyer@us.ibm.com>
---

 arch/powerpc/kernel/misc_32.S |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7cd07b4..d7e05d2 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -761,8 +761,12 @@ relocate_new_kernel:
 	mr	r30, r4
 	mr	r31, r5
 
-	/* Load our MSR_IS and TID to MMUCR for TLB search */
-	mfspr	r3,SPRN_PID
+	/* 
+	 * Load the PID with kernel PID (0).
+	 * Also load our MSR_IS and TID to MMUCR for TLB search.
+	 */
+	li	r3, 0
+	mtspr	SPRN_PID, r3
 	mfmsr	r4
 	andi.	r4,r4,MSR_IS@l
 	beq	wmmucr
