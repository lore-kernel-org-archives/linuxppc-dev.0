Return-Path: <linuxppc-dev+bounces-20282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990F3FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:27:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Glw2PBvz2yty;
	Wed, 29 Apr 2026 22:27:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465660;
	cv=none; b=irfin2LDUFKYtDsfqyNkW58HSeI05eFm/TdOCFmiQjfS69G+5l/EYKxMFy8sfLEHmqS1oe+AgVSTN0KpZ1eOgYTJ47KKsoVp48AWUv1YRnfWca5oMgPRrbLZ7AO2zacgpoWe2b7swyJC3cl+7nrp0xGRKU7Zv0UE0O/G0Q3DmY1cug5OJzsV+hklOEEU5P5iLo+QUylIq30SaMRLr0l8+gXoXkN0oT0x48fNXq/eBCjaVoL5mXUrWqUiuy7z9ZYPnBg7XhnHMysvcHWKwwWK1Zg40dg+sKV/bSAhyzNq7bHr/EISU5CoWRioWNiOAboLWfyPuLI1G1rKd/7iB91+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465660; c=relaxed/relaxed;
	bh=CxVYbyyvnEZ9UyHfQvADbGg6OHPT0UrCEg0RtR18FYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwWwYVxTPwZMOZnR80KDf6+1s9M5IP/qjnqoMylLujC7OlOp+kcqpSxv4hj5AlL6F/bs7LRcKccP9L0jUaps6ghNFJj+FAP9EDnMHnpnSJkEadqtZWZae3DvhKL82RZx6Cid+iC8IorJGfGrK7BQNEghDcTcLJuS2hHoGCw8YJZ1CIXVyp98iuKMw6+RXuEfKf6yUfvO4t8fHVlJQ9ufPi11RMS5vSC/n1Y5KlE4sceOcCjyW8DOnBx5wCIklDYwdnkuJBEHyIHpc7GRAY70gtPYvkhrhVHZocidHmdJZq0hdpIbKKLf/Yg8d4gytsn/t8ESEcqrgT+I9QeTJIW50g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCDLmhkB; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCDLmhkB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Glv0Gvyz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:27:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465660; x=1809001660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=av6nUtlRUMx1I+d/0rUy1n4lGYX7MGYYBRJ36tkOEdo=;
  b=GCDLmhkBhVVIE/c5OQmr5XD900qvQSFftBhvEbrvFxS81gO+WaD/g+tW
   aGEFXpe7QGwwSC9fvNvcAoR04gbZDmr860Z+OTqlDpkdNTrMNTbtxkRm7
   892EwBY3OFmb4vvucidnY3EWlv6x52HzCVQrZsiRs7cWBAH2QFTsBIKO3
   XtVqzTGuyY2XCNEQvs8sgwWM2LKO+YtJUXzNPQau3hpYxeptyXJyj2lNq
   p7bcW+Qed5L1s06OpllLOU2mpsOP+6iKlAioLnryYlyq5oU5hTSzqJN8h
   SX5aDAKIlYLyb6E5gHlS/kh+wPzdrWGtspml4mMsuxgwQSr/Jw4R6Ie2y
   A==;
X-CSE-ConnectionGUID: h8O4+7RBQ6CAjFL6HpZUNA==
X-CSE-MsgGUID: 1+m/JQ5zQq+gXB3gUZ+/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101826"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101826"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:36 -0700
X-CSE-ConnectionGUID: YbPY7mx3RA+0HaaKTn90OA==
X-CSE-MsgGUID: gjkuTCivS++kW7ekDhzxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512290"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/11] powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get() pci_dev const
Date: Wed, 29 Apr 2026 15:26:12 +0300
Message-Id: <20260429122617.7324-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
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

Convert input pci_dev for pseries_get_iov_fw_value() and pnv_iov_get()
to const to be able to convert pcibios_iov_resource_alignment() as well
in an upcoming change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/powerpc/platforms/powernv/pci.h   | 2 +-
 arch/powerpc/platforms/pseries/setup.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 42075501663b..032b2081aedb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -251,7 +251,7 @@ struct pnv_iov_data {
 	struct resource holes[PCI_SRIOV_NUM_BARS];
 };
 
-static inline struct pnv_iov_data *pnv_iov_get(struct pci_dev *pdev)
+static inline struct pnv_iov_data *pnv_iov_get(const struct pci_dev *pdev)
 {
 	return pdev->dev.archdata.iov_data;
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..b670c6fdfcea 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -658,7 +658,8 @@ enum get_iov_fw_value_index {
 	WDW_SIZE      = 3     /*  Get Window Size */
 };
 
-static resource_size_t pseries_get_iov_fw_value(struct pci_dev *dev, int resno,
+static resource_size_t pseries_get_iov_fw_value(const struct pci_dev *dev,
+						int resno,
 						enum get_iov_fw_value_index value)
 {
 	const int *indexes;
-- 
2.39.5


