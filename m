Return-Path: <linuxppc-dev+bounces-8881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BAAC54ED1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 May 2025 23:23:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b3PVt1Zm2z3byj;
	Fri, 23 May 2025 09:23:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747956230;
	cv=none; b=Dk5iNtr+3TH3xsmMU1ulfy4OUpqOEJ9OMgC855FPDuNmdYSRa6aK/zHZmRtmH0x9Gi1YzM+CmiR+e+5QoCFJtytCh2JCJwOZn5Z/bOUXjB7ho0UxVve1YYgtHCryTnzUzkkU/CHQlwcEfGMTVnQC/CIfVvtNslop/SxpuSdxWPsTq5/9p/jZ5YWiMk1Y4IKX1np3/ADxuD9RABEkh6Yjq1kCyKkhIfm89FjvFoz3c1vyxsGR5ZOGQk4YiMjNcqJm5w7aZoAV9gCwahXzdvErVqXm+ebJYd4g8qw9k8AbdSF/HAns8LRzu83yOAdYVWpdetxbLp54hsodxA3/G7Mh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747956230; c=relaxed/relaxed;
	bh=B0b1k1CYjE8vVMTsjuXy8dh30GI8IjHYTGX/4FscUEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h21U1WOOcWcF+SsS3KtN4g3Plx+2EBcAZLydh3J8VvD+HSj+AsRP+UnmGFGdzLBdRpXoeSRhiOt5PzRxBKJOuq9zlPRUm7wYjrWB1j5XRuz2nyUWJHfjc2fYjJWSxviECs9kRKQkE/F1ZIJ85FSIACxE4G+BvcWdxwq3u7uO8yoZ/MpbDJXztOsdbY49lwGvuH6h23uE4pU4bkfVWHigrP91NovCLAJ99SDIs1k3Mn3smoiK3LgexlW2E00IrOYjFfIwEuRkNS2WnkcKWPhJq5j2viQfz8J5B1ZYTanFULVsIXhzQgvwHkbmulolfOkn+/5PndxrQ9osyGavu7U9Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t3FVszZr; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t3FVszZr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b3PVs2Fnxz2yr4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2025 09:23:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E886F5C6BEF;
	Thu, 22 May 2025 23:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8485CC4CEE4;
	Thu, 22 May 2025 23:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956226;
	bh=IpozNL8P1/qwMOXg42wi4u8eXPEwz1FArxo4wownd8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3FVszZrWQ8AwjTu2VrLM7kQ3E5+zH+9fiWnTLc6A+EJ7XMcNeAbNqj1RvW4EVcdl
	 41XMXVpTMQ/MM/W2H7lafTdHo3jBL69KeAt7OpmwXQ3sKJpuX2tgMCduJx8d/z+ZCn
	 802n1BH3bTsqqwE4cjwB9T08orGdn6g59EPE2nATihd/N/xRGkqt7squYugq9LgMFr
	 QGhDGGqzWzoD7ZJRZxREa/piwSZ7XN/SJKNUBX4g0dH7ErzL1IlvLwQRP+3AbsNApQ
	 C1sW73uQD37I1fbt0nVu524HnqzQdBA4yBuzNO2RRkA/DWpsDlYQqIh4BzbfbBhfIY
	 rHNhT0hUKPA/Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 01/20] PCI/DPC: Initialize aer_err_info before using it
Date: Thu, 22 May 2025 18:21:07 -0500
Message-ID: <20250522232339.1525671-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the struct aer_err_info "info" was allocated on the stack
without being initialized, so it contained junk except for the fields we
explicitly set later.

Initialize "info" at declaration so it starts as all zeros.

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-2-helgaas@kernel.org
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df42f15c9829..3daaf61c79c9 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 void dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
-	struct aer_err_info info;
+	struct aer_err_info info = {};
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-- 
2.43.0


