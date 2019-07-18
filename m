Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05743C76191
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 05:16:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2832173E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 05:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2832173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45q2RW5C5czDqbh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 15:16:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45q2Lm4h34zDqJY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 15:12:16 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 89354AE807E8;
 Thu, 18 Jul 2019 01:11:39 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 0/4] powerpc/ioda2: Yet another attempt to allow DMA
 masks between 32 and 59
Date: Thu, 18 Jul 2019 15:11:35 +1000
Message-Id: <20190718051139.74787-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is an attempt to allow DMA masks between 32..59 which are not large
enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
on the max order, up to 40 is usually available.

This is an optimization and not a bug fix for DMA API usage.

Changelogs are in the patches.


This is based on sha1
a2b6f26c264e Christophe Leroy "powerpc/module64: Use symbolic instructions names.".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  powerpc/powernv/ioda: Fix race in TCE level allocation
  powerpc/iommu: Allow bypass-only for DMA
  powerpc/powernv/ioda2: Allocate TCE table levels on demand for default
    DMA window
  powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
    pages

 arch/powerpc/include/asm/iommu.h              |  7 +-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/kernel/dma-iommu.c               | 11 ++-
 arch/powerpc/kernel/iommu.c                   | 74 +++++++++++++------
 arch/powerpc/platforms/cell/iommu.c           |  2 +-
 arch/powerpc/platforms/pasemi/iommu.c         |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 38 ++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c     | 42 +++++++++--
 arch/powerpc/platforms/pseries/iommu.c        |  8 +-
 arch/powerpc/platforms/pseries/vio.c          |  2 +-
 arch/powerpc/sysdev/dart_iommu.c              |  2 +-
 11 files changed, 129 insertions(+), 61 deletions(-)

-- 
2.17.1

