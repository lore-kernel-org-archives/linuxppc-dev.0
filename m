Return-Path: <SRS0=hyM8=TB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E247C43219
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 05:30:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E1A2081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 05:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E1A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44v6RR4MByzDqSN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 15:30:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44v6Q165h9zDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2019 15:28:57 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 25E73AE80053;
 Wed,  1 May 2019 01:28:23 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2 0/2] powerpc/ioda2: Another attempt to allow DMA
 masks between 32 and 59
Date: Wed,  1 May 2019 15:28:20 +1000
Message-Id: <20190501052822.64667-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an attempt to allow DMA masks between 32..59 which are not large
enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
on the max order, up to 40 is usually available.


This is based on sha1
37624b58542f Linus Torvalds "Linux 5.1-rc7".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/powernv/ioda2: Allocate TCE table levels on demand for default
    DMA window
  powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
    pages

 arch/powerpc/include/asm/iommu.h              |  8 ++-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/kernel/iommu.c                   | 58 +++++++++++++------
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 20 +++----
 arch/powerpc/platforms/powernv/pci-ioda.c     | 40 +++++++++++--
 5 files changed, 90 insertions(+), 38 deletions(-)

-- 
2.17.1

