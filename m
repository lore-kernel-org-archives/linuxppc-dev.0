Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19064B6F8B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:31:55 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 05/10] KVM: PPC: Read out syscall instruction on trap
Date: Tue,  9 Aug 2011 18:31:43 +0200
Message-Id: <1312907508-14599-6-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a few traps where we cache the instruction that cause the trap
for analysis later on. Since we now need to be able to distinguish
between SC 0 and SC 1 system calls and the only way to find out which
is which is by looking at the instruction, we also read out the instruction
causing the system call.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_segment.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index aed32e5..678b6be 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -213,11 +213,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	beq	ld_last_inst
 	cmpwi	r12, BOOK3S_INTERRUPT_PROGRAM
 	beq	ld_last_inst
+	cmpwi	r12, BOOK3S_INTERRUPT_SYSCALL
+	beq	ld_last_prev_inst
 	cmpwi	r12, BOOK3S_INTERRUPT_ALIGNMENT
 	beq-	ld_last_inst
 
 	b	no_ld_last_inst
 
+ld_last_prev_inst:
+	addi	r3, r3, -4
+
 ld_last_inst:
 	/* Save off the guest instruction we're at */
 
-- 
1.6.0.2
