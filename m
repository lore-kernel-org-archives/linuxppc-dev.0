Return-Path: <ddstreet@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 483BD2C035D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:25:54 +1100 (EST)
Received: by mail-ob0-f182.google.com with SMTP id wn1so830524obc.41
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 19:25:50 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: only save/restore SDR1 if in hypervisor mode
Date: Tue, 29 Oct 2013 22:25:14 -0400
Message-Id: <1383099914-4955-1-git-send-email-ddstreet@ieee.org>
Cc: jipan@redhat.com, Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, when not in hypervisor mode the kernel
Oopses during suspend or hibernation when accessing
the SDR1 register, because it is only available
in hypervisor mode.  Access to it needs to be
protected in BEGIN/END_FW_FTR_SECTION.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reported-by: Jimmy Pan <jipan@redhat.com>
Tested-by: Jimmy Pan <jipan@redhat.com>

---
 arch/powerpc/kernel/swsusp_asm64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 2204598..988f38d 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -114,7 +114,9 @@ _GLOBAL(swsusp_arch_suspend)
 	SAVE_SPECIAL(MSR)
 	SAVE_SPECIAL(XER)
 #ifdef CONFIG_PPC_BOOK3S_64
+BEGIN_FW_FTR_SECTION
 	SAVE_SPECIAL(SDR1)
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_LPAR)
 #else
 	SAVE_SPR(TCR)
 
@@ -231,7 +233,9 @@ nothing_to_copy:
 	/* can't use RESTORE_SPECIAL(MSR) */
 	ld	r0, SL_MSR(r11)
 	mtmsrd	r0, 0
+BEGIN_FW_FTR_SECTION
 	RESTORE_SPECIAL(SDR1)
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_LPAR)
 #else
 	/* Restore SPRG1, be used to save paca */
 	ld	r0, SL_SPRG1(r11)
-- 
1.8.3.1
