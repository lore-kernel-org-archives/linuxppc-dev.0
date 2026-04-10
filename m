Return-Path: <linuxppc-dev+bounces-19535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C2E99046
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:13:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsShT6Qhmz2ypV;
	Fri, 10 Apr 2026 17:13:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800254;
	cv=none; b=lxJVc/P5I4Qei0RkSqoWdASnNqSH3gRYEbqqTPkLifpno2rOj+IrqL2Rqp47/iZ1sB9i+ZC7bRWByutnegcU/1Va+nZ9jGhKjfNn/4HO/Li1BHA5f+Lr7scKq+9BijFTvtq3raFI698gQ33JaYUqmKQfv/nLNQK2GiYEjGVXvmtomvi9FoErmFIilzF0qqssxBLyeR4NBJ0j4OknEkgm+LJlCZnXQJlUaaOy+63vZ5jeBhhJSQEpjMi860iJyxr/+vcu+Ih/Ox6Ook9MXaQ5Hk1p9FxHQn3sr8bZYnDqLQw+jYGnab1mHte/B5GUtx+qeIsi2TMq397PqGc/4bweLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800254; c=relaxed/relaxed;
	bh=RlrOk1htmkLCudrvlN4P1j+ETttd8aInksHEcwHD94Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3cvfisRnWGNvMa80RUN3MEx9Ixrqk2QPV6JDKT5px4Z1EIbqS+bcmRf5yJ7YOsEoKWQU2ynt/CK/QvylOiejzDIUDw3xHbBhVXxl58fmn0W2dtuG80tf1BnNyvKXgYcUflIOpev5ztYnYVYpILSQBmdYO+tHEdJ0ke1wIA43poAcZfbmTMzNmNrxyiziAkK7bRY6miApMvAXYFua6Khv8Am3byVFKZOShAGKYwE7DSXON66HEvqyPEXHK89HJ8vWaaYIfsEhCux/ZZqaKDykkvCKXZXL94dBR9UIpwGzYwwQyRy1gTNb/Y3dMmeSj0+RwMOnYqSIEMP/l6EsXxWeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mvd/ZBK4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mvd/ZBK4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQrs5jGjz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:50:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1900941B41;
	Fri, 10 Apr 2026 05:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BADC19421;
	Fri, 10 Apr 2026 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800252;
	bh=O8kQ8QkL9LHeQ/3N8ubS2U25zz9aBbM59rexDGwqeT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mvd/ZBK4JZ3ugDIqD8qBy9RypOd44POFR5UdO2aVnaeCsYRDmuj7xaRUOqjsWJBTO
	 GKZCmPgluWSMZJSXSHZ4ZG1A8/CV8NehkGas7ShsLMUzybBt07DN5tw5TnBIXHZgFK
	 h8AZJqyveq2bqqPIp+fLbR9AeQp7vPrrPDGBWpq1SNDlC+IY42RcOaZSzMkw2RCcTq
	 jYqAT8AyDaC6GOXMoBFzqgTvieBBR4e2C1xa/RWHZr0uIB24wUEeNkvj0NBy92uFCY
	 JjiSIiKkJMIrqbd3jG8jW+xkOUfcSoEXbi+qCssvyWEZSXl94bNtD3cSubUswsl8jz
	 aQyqTwfkdjkkQ==
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
Subject: [PATCH 02/20] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Fri, 10 Apr 2026 05:50:22 +0000
Message-ID: <20260410055040.39233-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

Currently, when the sysfs attributes for PCI resources are added
dynamically, the resource access callbacks are only set when the
underlying BAR type matches, using .read and .write for IORESOURCE_IO,
and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
support.  As such, when the callback is not set, the operation inherently
fails.

After the conversion to static attributes, visibility callbacks will
control which resource files appear for each BAR, but the callbacks
themselves will always be set.

Thus, add a type check to pci_resource_io() and pci_mmap_resource()
to return -EIO for an unsupported resource type.

While at it, add parentheses around the bitwise flag test in
pci_mmap_resource() to make the precedence explicit, and to
match the preferred style.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad3c17f86c7f..008e0dd0de36 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1115,13 +1115,17 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (!(res->flags & IORESOURCE_MEM) &&
+	    !((res->flags & IORESOURCE_IO) && arch_can_pci_mmap_io()))
+		return -EIO;
+
+	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = (res->flags & IORESOURCE_MEM) ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
@@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_IO))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.53.0


