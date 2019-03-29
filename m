Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F017C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:34:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3EB217F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3EB217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W04s6WjdzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 22:34:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vzvq1FXHzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 22:26:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Vzvp58qwz9sQs; Fri, 29 Mar 2019 22:26:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44Vzvp3jbPz9sR0; Fri, 29 Mar 2019 22:26:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.14 03/32] powerpc/64s: Enable barrier_nospec based
 on firmware settings
Date: Fri, 29 Mar 2019 22:25:51 +1100
Message-Id: <20190329112620.14489-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329112620.14489-1-mpe@ellerman.id.au>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michal Suchanek <msuchanek@suse.de>

commit cb3d6759a93c6d0aea1c10deb6d00e111c29c19c upstream.

Check what firmware told us and enable/disable the barrier_nospec as
appropriate.

We err on the side of enabling the barrier, as it's no-op on older
systems, see the comment for more detail.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h       |  1 +
 arch/powerpc/kernel/security.c         | 59 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c |  1 +
 arch/powerpc/platforms/pseries/setup.c |  1 +
 4 files changed, 62 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8f3e5f6de0dd..cd436d208b40 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,6 +52,7 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4eb9d2b252e3..7553951b500a 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -23,6 +23,65 @@ static void enable_barrier_nospec(bool enable)
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
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index fd143c934768..e6f8505a3818 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -123,6 +123,7 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
+	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 45f814041448..ac12ec4d839d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -534,6 +534,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_barrier_nospec();
 }
 
 static void __init pSeries_setup_arch(void)
-- 
2.20.1

