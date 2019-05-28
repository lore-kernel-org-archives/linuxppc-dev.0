Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F23C04AB3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 01:56:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6952075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="hyf9Q8Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6952075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CcQr4X9vzDqNk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 11:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=anastas.io
 (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.b="hyf9Q8Z6"; 
 dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CcMx6JWHzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 11:54:21 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 4DE997F8F9;
 Mon, 27 May 2019 20:54:19 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1559008460; bh=S+yWBPX56gfd9GxiSJQNtc5ODUe0FOjbu3z+0qj/29c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hyf9Q8Z6xg0ysEC/qTcXj7HEMeWHbzE0s06MANDXAnsuBi38wlXhQrGcK6vLLNIm0
 Y7IgJ4MStJzZB4qAMay5MRaL4bzraWcNmTOO8iZ2dZ/n0f2MKd788Hp6wWhouURh0m
 OnDXjA1OqKWM7kf30vLOmIwpeXTZpZxmVtLpRpOEjZoz8t08xKPJNwAEZjlGdH6um+
 xokMNSqeVrqVt4LU6bQdfkv4JnM8c7i2Mn/KaQHuJWAQCc1a19PKGKmPFnwdzOmsNu
 kPwTvvbkypcduuXoNdARh2upcVQxQccxneXayHdxQ4c7R2JmuPJ11hkKOp0qyfoYkv
 VwOK6mi0QWWaA==
From: Shawn Anastasio <shawn@anastas.io>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] powerpc/pseries: Allow user-specified PCI resource
 alignment after init
Date: Mon, 27 May 2019 20:54:12 -0500
Message-Id: <20190528015412.30521-4-shawn@anastas.io>
In-Reply-To: <20190528015412.30521-1-shawn@anastas.io>
References: <20190528015412.30521-1-shawn@anastas.io>
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
Cc: sbobroff@linux.ibm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 xyjxie@linux.vnet.ibm.com, bhelgaas@google.com, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On pseries, custom PCI resource alignment specified with the commandline
argument pci=resource_alignment is disabled due to PCI resources being
managed by the firmware. However, in the case of PCI hotplug the
resources are managed by the kernel, so custom alignments should be
honored in these cases. This is done by only honoring custom
alignments after initial PCI initialization is done, to ensure that
all devices managed by the firmware are excluded.

Without this ability, sub-page BARs sometimes get mapped in between
page boundaries for hotplugged devices and are therefore unusable
with the VFIO framework. This change allows users to request
page alignment for devices they wish to access via VFIO using
the pci=resource_alignment commandline argument.

In the future, this could be extended to provide page-aligned
resources by default for hotplugged devices, similar to what is
done on powernv by commit 382746376993 ("powerpc/powernv: Override
pcibios_default_alignment() to force PCI devices to be page aligned")

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/include/asm/machdep.h     |  3 +++
 arch/powerpc/kernel/pci-common.c       |  9 +++++++++
 arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2fbfaa9176ed..46eb62c0954e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -179,6 +179,9 @@ struct machdep_calls {
 
 	resource_size_t (*pcibios_default_alignment)(void);
 
+	/* Called when determining PCI resource alignment */
+	int (*pcibios_ignore_alignment_request)(void);
+
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
 	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ff4b7539cbdf..1a6ded45a701 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -238,6 +238,15 @@ resource_size_t pcibios_default_alignment(void)
 	return 0;
 }
 
+resource_size_t pcibios_ignore_alignment_request(void)
+{
+	if (ppc_md.pcibios_ignore_alignment_request)
+		return ppc_md.pcibios_ignore_alignment_request();
+
+	/* Fall back to default method of checking PCI_PROBE_ONLY */
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 #ifdef CONFIG_PCI_IOV
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
 {
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e4f0dfd4ae33..07f03be02afe 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -82,6 +82,8 @@ EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
+static int initial_pci_init_done; /* TRUE if initial pcibios init has completed */
+
 static void pSeries_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -749,6 +751,23 @@ static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
 }
 #endif
 
+static void pseries_after_init(void)
+{
+	initial_pci_init_done = 1;
+}
+
+static int pseries_ignore_alignment_request(void)
+{
+	if (initial_pci_init_done)
+		/*
+		 * Allow custom alignments after init for things
+		 * like PCI hotplugging.
+		 */
+		return 0;
+
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -797,6 +816,9 @@ static void __init pSeries_setup_arch(void)
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	ppc_md.pcibios_after_init = pseries_after_init;
+	ppc_md.pcibios_ignore_alignment_request =
+		pseries_ignore_alignment_request;
 }
 
 static void pseries_panic(char *str)
-- 
2.20.1

