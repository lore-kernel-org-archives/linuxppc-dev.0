Return-Path: <linuxppc-dev+bounces-19536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B669E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:13:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsShg5tScz2yhD;
	Fri, 10 Apr 2026 17:13:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800258;
	cv=none; b=EnK4kH2cMyOcLbfnD+jTcjh2oiVYDAVk0ZapIpfQtfZW4MTgAGwTcMyMTk9HJIZoYJFwAEssf5Cr66liReH6BtJghUEU7pllM3Xr5PQj3y6ER4J7elzevstCXUzC6XyaQMvA+E5SUAeDa7Q/FzQZgK+XpP6kEx1i7XGs4PFQW281QolxSMgdYGUH9kmqsemBi4zvEOyyi/OqUKTkjU0gI01na7CgrsF/GZtUTFVApKeM5TyknhxiqJGE9YbE0cknpQIOfIGOPseRdxtH1MTIb+CrR+3KuJM2vBguTt0/WUBpO2dUa9Wzzoe6OvOgNsFUazn1RnsKCbJOgSY9xdEt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800258; c=relaxed/relaxed;
	bh=GLiuV8rayT6Be58B3pYbPEr4u1RA9Ql7++PPei8OIqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grE19XRfOya/DZV08ARCYTkHUVuuA750CsaLYClncnoadFPZGtMfqNjtpUi4jEjAR/8UsBNYi3AFCNIusZMoeJqKF8SkkjTJ06OP3gZFXp4mYxqyIvYdEq9hAWGq7q2p+k4SzV+jaNP3jMHNvFi9I0WLiZAy8pGcJKIwIeeN2rGea0BUnPeLgBBCsiOjhal5kNn2fDSj7vqlIRBuya8ML7N8ikKjoAU1N64MOV568gLbhEgiJAMcI6x2jSMJnEgKRVIqwT9ex95hL+R9Z4z5StOKVFdz401GFumz/A9Vv3SNKN2kMKFWPiWbaiI9oDes0jvWtlRH/4kWoJyqxqBEIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rXzq+qXX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rXzq+qXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQrx49q1z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:50:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C0A8A60125;
	Fri, 10 Apr 2026 05:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A5EC19421;
	Fri, 10 Apr 2026 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800255;
	bh=adotA/V+MQ7wgPmgyJRZLabHOEzjzDHEZuvNSiVnByw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXzq+qXXGHKFdTEHH4V081hOqLkNfjy+xN3A5I8xX0aYNfICbiGwyuZ4M+EQxV/y8
	 OVas0PkRjej2GjVa2TpozsrFLkYhADO2Z8BI5c2RQD0sS8lgX0nPAxSSs67Y6iYShi
	 lvNfF4hO12cIERJz/rc/oWrrJbCoIAn68jxSdQvtmMTEw3QXQ+sE4UCgB12QfpXAoM
	 dCptzylbzbnOLJUlrfaV/rJhjXggRsRzdxjmQwbmp8TFGemSxaNRFSU/akdoECuUJD
	 KrIhwYEurakMPTHwHiNXwIAYdQhuwAcruK1YVIHeaP5RBsLznbYH+ivhACQkevt7ew
	 KKmng7Ls70EVw==
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
Subject: [PATCH 03/20] PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is zero
Date: Fri, 10 Apr 2026 05:50:23 +0000
Message-ID: <20260410055040.39233-4-kwilczynski@kernel.org>
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

Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
so the default generic_file_llseek() would consult iomem_inode for the
file size, which knows nothing about the attribute.  That is why this
custom llseek callback exists.

Currently, the legacy and resource attributes have .size set at creation
time, as such, using the attr->size is sufficient.  However, the upcoming
static resource attributes will have .size == 0 set, since they are const,
and the .bin_size callback will be used to provide the real size to kernfs
instead.

Thus, update pci_llseek_resource() to derive the file size from the
BAR using pci_resource_len() instead of reading the attr->size directly.

The custom pci_llseek_resource() helper has been added in commit
24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
entries").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 008e0dd0de36..ac4e7c516e78 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
  */
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
-		    struct kobject *kobj __always_unused,
+		    struct kobject *kobj,
 		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
-	return fixed_size_llseek(filep, offset, whence, attr->size);
+	struct pci_dev *pdev;
+	int bar;
+
+	if (attr->size)
+		return fixed_size_llseek(filep, offset, whence, attr->size);
+
+	pdev = to_pci_dev(kobj_to_dev(kobj));
+	bar = (unsigned long)attr->private;
+
+	return fixed_size_llseek(filep, offset, whence,
+				 pci_resource_len(pdev, bar));
 }
 
 #ifdef HAVE_PCI_LEGACY
-- 
2.53.0


