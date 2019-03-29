Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E7C10F05
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:23:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A075921871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OmL7RkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A075921871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W58n1tjszDqYt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 02:23:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4Y45WH5zDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="2OmL7RkT"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4Y43Z3Pz8vPD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:55:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4Y42Dhxz9sQr; Sat, 30 Mar 2019 01:55:36 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="2OmL7RkT"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4Y34ZZFz9sQq
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 01:55:35 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0901E2184C;
 Fri, 29 Mar 2019 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553871333;
 bh=KdTKq1KcQbDmW3tuWc74i4YdW/uxbHul1PUM6GwVyXY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=2OmL7RkTu/eNb7Xblqbeb9hFnqJaZtgc3NFYIgA/RE4pmYiP+Ho1daYJSuAzKZk68
 gtO1sguL0dnlfZAfvnu5sul4lzvZZf4p9L8bF1LD7HhB1EZoCEsdgnE6KsRkgmDsdw
 ONcXyKTXozydgykSo/bwDLJcs5Xcc/CwO00h7lEA=
Subject: Patch "[PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E" has been added to the 4.14-stable tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 15:54:46 +0100
In-Reply-To: <20190329112620.14489-14-mpe@ellerman.id.au>
Message-ID: <155387128622978@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-fsl-add-barrier_nospec-implementation-for-nxp-powerpc-book3e.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 15:53:50 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:26:01 +1100
Subject: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-14-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

From: Diana Craciun <diana.craciun@nxp.com>

commit ebcd1bfc33c7a90df941df68a6e5d4018c022fba upstream.

Implement the barrier_nospec as a isync;sync instruction sequence.
The implementation uses the infrastructure built for BOOK3S 64.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Split out of larger patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Kconfig               |    2 +-
 arch/powerpc/include/asm/barrier.h |    8 +++++++-
 arch/powerpc/lib/feature-fixups.c  |   31 +++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -239,7 +239,7 @@ config PPC
 config PPC_BARRIER_NOSPEC
     bool
     default y
-    depends on PPC_BOOK3S_64
+    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
 
 config GENERIC_CSUM
 	def_bool n
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,12 +76,18 @@ do {									\
 	___p1;								\
 })
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#define NOSPEC_BARRIER_SLOT   nop
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#define NOSPEC_BARRIER_SLOT   nop; nop
+#endif
+
 #ifdef CONFIG_PPC_BARRIER_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
  */
-#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_SLOT
 
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -318,6 +318,37 @@ void do_barrier_nospec_fixups(bool enabl
 }
 #endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
+{
+	unsigned int instr[2], *dest;
+	long *start, *end;
+	int i;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	instr[0] = PPC_INST_NOP;
+	instr[1] = PPC_INST_NOP;
+
+	if (enable) {
+		pr_info("barrier-nospec: using isync; sync as speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
 	long *start, *end;


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.14/powerpc-fsl-emulate-sprn_bucsr-register.patch
queue-4.14/powerpc-64-make-stf-barrier-ppc_book3s_64-specific.patch
queue-4.14/powerpc-fsl-fix-spectre_v2-mitigations-reporting.patch
queue-4.14/powerpc-64s-patch-barrier_nospec-in-modules.patch
queue-4.14/powerpc-pseries-query-hypervisor-for-count-cache-flush-settings.patch
queue-4.14/powerpc-64s-add-support-for-software-count-cache-flush.patch
queue-4.14/powerpc64s-show-ori31-availability-in-spectre_v1-sysfs-file-not-v2.patch
queue-4.14/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-64bit.patch
queue-4.14/powerpc-fsl-update-spectre-v2-reporting.patch
queue-4.14/powerpc-64-make-meltdown-reporting-book3s-64-specific.patch
queue-4.14/powerpc-64s-add-support-for-ori-barrier_nospec-patching.patch
queue-4.14/powerpc-use-barrier_nospec-in-copy_from_user.patch
queue-4.14/powerpc-fsl-sanitize-the-syscall-table-for-nxp-powerpc-32-bit-platforms.patch
queue-4.14/powerpc-fsl-add-macro-to-flush-the-branch-predictor.patch
queue-4.14/powerpc-fsl-add-barrier_nospec-implementation-for-nxp-powerpc-book3e.patch
queue-4.14/powerpc-security-fix-spectre_v2-reporting.patch
queue-4.14/powerpc-64-disable-the-speculation-barrier-from-the-command-line.patch
queue-4.14/powerpc-fsl-fix-the-flush-of-branch-predictor.patch
queue-4.14/powerpc-64-add-config_ppc_barrier_nospec.patch
queue-4.14/powerpc-fsl-enable-runtime-patching-if-nospectre_v2-boot-arg-is-used.patch
queue-4.14/powerpc-64-use-barrier_nospec-in-syscall-entry.patch
queue-4.14/powerpc-fsl-fixed-warning-orphan-section-__btb_flush_fixup.patch
queue-4.14/powerpc-fsl-add-nospectre_v2-command-line-argument.patch
queue-4.14/powerpc-64s-add-new-security-feature-flags-for-count-cache-flush.patch
queue-4.14/powerpc-fsl-add-infrastructure-to-fixup-branch-predictor-flush.patch
queue-4.14/powerpc-64s-enhance-the-information-in-cpu_show_spectre_v1.patch
queue-4.14/powerpc-64-call-setup_barrier_nospec-from-setup_arch.patch
queue-4.14/powerpc-asm-add-a-patch_site-macro-helpers-for-patching-instructions.patch
queue-4.14/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-32-bit.patch
queue-4.14/powerpc-64s-enable-barrier_nospec-based-on-firmware-settings.patch
queue-4.14/powerpc-fsl-flush-branch-predictor-when-entering-kvm.patch
queue-4.14/powerpc-powernv-query-firmware-for-count-cache-flush-settings.patch
