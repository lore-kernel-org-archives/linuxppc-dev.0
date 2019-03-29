Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:15:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E232184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJOuI/bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E232184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W502487dzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 02:15:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4Xq4lPLzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:55:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DJOuI/bJ"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4Xq2Hj4z8w0T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:55:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4Xq1tQQz9sQq; Sat, 30 Mar 2019 01:55:23 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DJOuI/bJ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4Xp5F43z9sPp
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 01:55:22 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27B902184C;
 Fri, 29 Mar 2019 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553871320;
 bh=DKg6tR/2OS8ijF2eOkxmz/HCQ2KgkFVg4hddMaL4eaQ=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=DJOuI/bJp5ie8Iz3YEit5eJfgGOXvKPixAm53DWftIYQ2i1Lq9ysS0jUBU1KvGF/2
 qOtopN9/4/YKr9Z7TWXmyB7h7gKvsuioQLYwb8T3zJ6BoEUiSn2SJ1i+2Rmig4Qxtt
 fNRswKTk2zChIV3Hc/NGy4gUgz2vUvb497opoqMA=
Subject: Patch "[PATCH stable v4.14 03/32] powerpc/64s: Enable barrier_nospec
 based on firmware settings" has been added to the 4.14-stable tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 15:54:46 +0100
In-Reply-To: <20190329112620.14489-4-mpe@ellerman.id.au>
Message-ID: <15538712866873@kroah.com>
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

    [PATCH stable v4.14 03/32] powerpc/64s: Enable barrier_nospec based on firmware settings

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-64s-enable-barrier_nospec-based-on-firmware-settings.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 15:53:50 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:25:51 +1100
Subject: [PATCH stable v4.14 03/32] powerpc/64s: Enable barrier_nospec based on firmware settings
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-4-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

From: Michal Suchanek <msuchanek@suse.de>

commit cb3d6759a93c6d0aea1c10deb6d00e111c29c19c upstream.

Check what firmware told us and enable/disable the barrier_nospec as
appropriate.

We err on the side of enabling the barrier, as it's no-op on older
systems, see the comment for more detail.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/setup.h       |    1 
 arch/powerpc/kernel/security.c         |   59 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c |    1 
 arch/powerpc/platforms/pseries/setup.c |    1 
 4 files changed, 62 insertions(+)

--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,6 +52,7 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -23,6 +23,65 @@ static void enable_barrier_nospec(bool e
 	do_barrier_nospec_fixups(enable);
 }
 
+void setup_barrier_nospec(void)
+{
+	bool enable;
+
+	/*
+	 * It would make sense to check SEC_FTR_SPEC_BAR_ORI31 below as well.
+	 * But there's a good reason not to. The two flags we check below are
+	 * both are enabled by default in the kernel, so if the hcall is not
+	 * functional they will be enabled.
+	 * On a system where the host firmware has been updated (so the ori
+	 * functions as a barrier), but on which the hypervisor (KVM/Qemu) has
+	 * not been updated, we would like to enable the barrier. Dropping the
+	 * check for SEC_FTR_SPEC_BAR_ORI31 achieves that. The only downside is
+	 * we potentially enable the barrier on systems where the host firmware
+	 * is not updated, but that's harmless as it's a no-op.
+	 */
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
+
+	enable_barrier_nospec(enable);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int barrier_nospec_set(void *data, u64 val)
+{
+	switch (val) {
+	case 0:
+	case 1:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!!val == !!barrier_nospec_enabled)
+		return 0;
+
+	enable_barrier_nospec(!!val);
+
+	return 0;
+}
+
+static int barrier_nospec_get(void *data, u64 *val)
+{
+	*val = barrier_nospec_enabled ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_barrier_nospec,
+			barrier_nospec_get, barrier_nospec_set, "%llu\n");
+
+static __init int barrier_nospec_debugfs_init(void)
+{
+	debugfs_create_file("barrier_nospec", 0600, powerpc_debugfs_root, NULL,
+			    &fops_barrier_nospec);
+	return 0;
+}
+device_initcall(barrier_nospec_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -123,6 +123,7 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
+	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -534,6 +534,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_barrier_nospec();
 }
 
 static void __init pSeries_setup_arch(void)


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
