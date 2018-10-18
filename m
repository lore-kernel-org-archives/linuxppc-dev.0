Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778CC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 07:55:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1BB204EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 07:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1BB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bLtp4PN0zF3NN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:55:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42bLrf3mbyzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 18:53:21 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id E7EAFAE80015;
 Thu, 18 Oct 2018 03:52:47 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/2] powerpc/iommu: Redo iommu groups
Date: Thu, 18 Oct 2018 18:52:41 +1100
Message-Id: <20181018075243.4798-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Sam Bobroff <sbobroff@linux.ibm.com>,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The aim is to:

1. simplify the code

2. get rid of iommu_table_group_link.
Now: iommu_table points to a list of iommu_table_group_link which
point to iommu_table_group (powerpc specific part of an IOMMU group);
one iommu_table_group_link per iommu_table_group per IODA PE.

Plan: add support of multiple IODA PEs per one generic IOMMU group,
I am just not sure how yet. We already have a case of GPU+NPU groups,
and a worse one is coming, with 3xGPU + 6xNVLink2.


Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/pseries: Remove IOMMU API support for non-LPAR systems
  powerpc/powernv/pseries: Rework device adding to IOMMU groups

 arch/powerpc/include/asm/iommu.h          | 12 +++----
 arch/powerpc/kernel/iommu.c               | 58 ++-----------------------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +-----
 arch/powerpc/platforms/powernv/pci.c      | 43 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c    | 55 ++++++++++++++---------------
 5 files changed, 76 insertions(+), 102 deletions(-)

-- 
2.11.0

