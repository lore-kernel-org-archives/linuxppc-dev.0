Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DADC00449
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 00:45:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD778213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 00:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD778213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QZ1T2rN7zF39y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 10:45:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=alexander.h.duyck@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QXlM2bWdzF384
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 09:48:11 +1000 (AEST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Oct 2018 16:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; d="scan'208";a="97224389"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.7.198.152])
 by orsmga002.jf.intel.com with ESMTP; 03 Oct 2018 16:48:08 -0700
Subject: [PATCH] dma-direct: Fix return value of dma_direct_supported
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
To: iommu@lists.linux-foundation.org
Date: Wed, 03 Oct 2018 16:48:07 -0700
Message-ID: <20181003234746.3586.42014.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 04 Oct 2018 10:43:33 +1000
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
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
<= physiscal memory size") the logic of the test was changed from a "<" to
a ">=" however I don't see any reason for that change. I am assuming that
there was some additional change planned, specifically I suspect the logic
was intended to be reversed and possibly used for a return. Since that is
the case I have gone ahead and done that.

This addresses issues I had on my system that prevented me from booting
with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.

Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 kernel/dma/direct.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5a0806b5351b..65872f6c2e93 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 
 	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
 
-	if (mask >= phys_to_dma(dev, min_mask))
-		return 0;
-	return 1;
+	return mask >= phys_to_dma(dev, min_mask);
 }
 
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)

