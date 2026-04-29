Return-Path: <linuxppc-dev+bounces-20277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EA6FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:26:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Gkn69jfz2ytT;
	Wed, 29 Apr 2026 22:26:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465601;
	cv=none; b=AzAekS/cc0cWj861OZZHDzDmSQI3LupByC9yxSwEhZ4+svoptzSTALSHkbo+mqGmwyHYgxkkCux0crRbw/H564/cKB7z3RLfW3rVkNXTMs9IVK3PggzN7sfXVUrPBI+G386kGbueyexTLhq105kqZU+6E2Qidz9KX7S7oGBc2FeYPWJI6KNSGX2WJ+/2yY1m+LqHtHVZ13QYnPWW88q3eMBJl+SV030/1fRGVZOHJrHkLBb14vfzaFBHgcv2JuZJtYMT5pDmJsbMgPbHauAN6LLkVelpwGiijAuAbe+0zCAboWNdF6I8Zh2lA0EK3qEbW4Pg5ZGkdvexdV3IG4xW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465601; c=relaxed/relaxed;
	bh=XLFb5FqEIsV1R+rY0LAHBlQnXXUBpkW40ns8Lo0jRwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgaci6bAmq4mtJYLApyR/Vzl2lbSIjbV13iuUvHRrpmKMlLX3xBN/MgvSgkV/G85yvdlk+WIfuHCGH5FwgQHkM4RohH8Jw+gITTwOaA5xx5w/IfHcW4OZhO6e85ZUPk9QdiCQ56YQLR6QTno/oP4kXJNo3u/lshVIR5arvUXKiPWHxiGvkSIvzad7+aLk6Ye2HdfI1mNHIUTqXW1C2Qj+pRCFhLAiwVciGvr5/QsE0MOg0XgABoxTD8LekwDZKWLWqzby2kDz0qbR7YYYnhWwvKOmEpKCnAzq2kyBA+K0DFme5/zuTfsSHOXiVcqr0H0poOW/2ERYd9WPa2DTUIg/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Klo6nKws; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Klo6nKws;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Gkm5sCPz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:26:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465601; x=1809001601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcnbBrCLet6KhQv9ffMklrkXZtBqvBKwCzYgPyMPV4M=;
  b=Klo6nKwsXDeIa5PXdd1GFrEhb88bYAAUuav3wVela0KQFWR2uw2yC9GZ
   gs04AUud+IZWk0lSrGnz1+sshYx5jGfL5pNo3SU/gCozVUE6ATjo31wUw
   5QwJMXPPwCz6sIibGbPsJUDSqFDbvc9YAuPw3/6+8x/2DXHt7DXcV2hsJ
   SrIYKK4F7FhHh+ybpPxdbjlcSGQauHLyvdvdrwnAsiRuwXrle7wPcreym
   fyhbfpYoRuhjH77iqO2B3hiZnZkY3BBS2PzLUtO0hvtolTpSOTeGil5gP
   ltBBYnYFHpUdvgnlYGEX0StkQq+STP7xrmm2Rpn69rhyP4Da22FkcTwO/
   g==;
X-CSE-ConnectionGUID: /u9gc1CfQ9mu0i08Np25Fw==
X-CSE-MsgGUID: /EmpmPN0TvWBJGXrqlHruw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557674"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:40 -0700
X-CSE-ConnectionGUID: eJ2+zU6sTeuUgdPAP8eYLg==
X-CSE-MsgGUID: H7blClL+SSOTRT9AmhNfxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669679"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/11] PCI: Log all resource claims
Date: Wed, 29 Apr 2026 15:26:07 +0300
Message-Id: <20260429122617.7324-2-ilpo.jarvinen@linux.intel.com>
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

There are two ways to graft resource into resource tree in PCI,
pci_assign_resource() and pci_claim_resource(). Only the former logs
the action which complicated troubleshooting the cases where resources
are assigned by pci_claim_resource() which mostly assigns the addresses
inherited from the FW.

Add logging into pci_claim_resource() to make troubleshooting easier.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index fbc05cda96ee..0d203325562b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -167,6 +167,8 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EBUSY;
 	}
 
+	pci_dbg(dev, "%s %pR: claiming\n", res_name, res);
+
 	return 0;
 }
 EXPORT_SYMBOL(pci_claim_resource);
-- 
2.39.5


