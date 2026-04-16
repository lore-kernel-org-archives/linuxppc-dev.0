Return-Path: <linuxppc-dev+bounces-19801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909AF8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:02:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnT5jcyz3bYf;
	Fri, 17 Apr 2026 04:01:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362509;
	cv=none; b=d2IIOre/F/CzIFoz7BdhJPj2WuOixnf6ha6TBzBr8XW2vQ4kIRw49v9k0j/0qKGIE3aWOe5fQoNRAVU5Hur0H2pXoH794voCQFaLfX3nViwH4eARa/BCTJdnC57A9Hn2CtQnz4mCyXBiADrE8K3u6eEpZ2Qo5jL287/ldghNXkAwYR93P3kWLKW+P6dGbHmkK6doepqI6oB3uTUQyoGri1mP/aQYU3bJ3mhT9CaHh0iOHnfSvif/TxC3Gp9mOc98KaFHc7VxapwdDT90h00t5ENNyvYpSorkMRklcNuzJRhDavD1tKt99eHpdKWW+c2yciW80DAB5JmifKk2f8KLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362509; c=relaxed/relaxed;
	bh=axWTOdBj3qxGrUfzgnw1/NkjBq2JcrH7suJbhcNa0k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFtRJhOZmB9/sSiZxi+aeXe7rMyEk8RVZrgeAAxydfpw4ALMyPF6wdZXS00NuXm9sY7AHJYWwy18jOQy8+hOOBxwcoMxD+3xNmw5ELiggn6TuOABeoHFU6FyznlZCsGNAq2mmCoQKLvJLqV87nFEhplt5eOcJhmuVZzU6cyZb1gsJj9S7L8ANp2t+KgFcKfMR32+bSS45tsDkhLjftPedIun77esAlr74QvhCoQDwSS0D/1bnDj+i/ANoVK37Qj21EUecSbco14en9Nye0p9YnFfGqfCbAIIOdfmTf+A+agyFzCJdXJ9QArKKHefxEJ6loGwWzs1B8JwF8VKURBBlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BrS5EtC2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BrS5EtC2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnT0Zzqz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 54BB140135;
	Thu, 16 Apr 2026 18:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22869C2BCB0;
	Thu, 16 Apr 2026 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362507;
	bh=z/qUE/WCrDQr3RvpHa7YYVIuPRUsL1w2bKCzec+b0mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrS5EtC2+VAT+/HCeg6bGBmketYhlQkAvF76NizvSwsl40yst7JHHvF7+u34ItyCj
	 E0VvAgBX0ehdEjy1WimGTGjBufJSz/A7YPaDXcT2MgCk1R9Q7+vb/L/4xSYSTP0LI1
	 Yj9z4sNT4vJSatLEbOhU4oZqWFqVS7nMzHROX21EWWHs7LV4SpVCSNJTdPziwHxpgP
	 +lcAswAkx7u6QrXK94zCpIbi0LN7GrU6FeWBGHBckNALHfSgPg+hzUDs1msZjjAmPx
	 gCp5Q8tXN5y0hIpTOIdNRu7lWQ9C1Zplfnkx1muakXgZZV9C8gu4TlZ5a09wLdddg9
	 Gu6nEhGR1pC7A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 10/23] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Thu, 16 Apr 2026 18:00:54 +0000
Message-ID: <20260416180107.777065-11-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, pci_sysfs_init() and sysfs_initialized compile
unconditionally, even on platforms where static attribute
groups handle all resource file creation.

Thus, place them behind a new HAVE_PCI_SYSFS_INIT macro,
especially as the late_initcall is only needed when:

  - HAVE_PCI_LEGACY is set, to iterate buses and create legacy
    I/O and memory files.

  - Neither HAVE_PCI_MMAP nor ARCH_GENERIC_PCI_MMAP_RESOURCE is
    set, to iterate devices and create resource files via the
    __weak pci_create_resource_files() stub override (this is
    how the Alpha architecture handles this currently).

On most systems both conditions are false and the entire
late_initcall compiles away.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 517efb6d71cc..d22bc5c48bc0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,7 +37,14 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
+#if defined(HAVE_PCI_LEGACY) || \
+	!defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+#define HAVE_PCI_SYSFS_INIT
+#endif
+
+#ifdef HAVE_PCI_SYSFS_INIT
 static int sysfs_initialized;	/* = 0 */
+#endif
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1792,6 +1799,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef HAVE_PCI_SYSFS_INIT
 static int __init pci_sysfs_init(void)
 {
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1818,6 +1826,7 @@ static int __init pci_sysfs_init(void)
 	return 0;
 }
 late_initcall(pci_sysfs_init);
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.53.0


