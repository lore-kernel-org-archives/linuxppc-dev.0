Return-Path: <SRS0=jy/z=HS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 03:34:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0132864DB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 03:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132864DB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dfmm94TrGz3bP8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 14:34:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Dfmlq4dS8z30HZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2021 14:33:43 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 20320AE8020D;
 Mon, 15 Feb 2021 22:33:09 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/2] powerpc/iommu: Stop crashing the host when VM is
 terminated
Date: Tue, 16 Feb 2021 14:33:05 +1100
Message-Id: <20210216033307.69863-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Killing a VM on a host under memory pressure kills a host which is
annoying. 1/2 reduces the chances, 2/2 eliminates panic() on
ioda2.


This is based on sha1
f40ddce88593 Linus Torvalds "Linux 5.11".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/iommu: Allocate it_map by vmalloc
  powerpc/iommu: Do not immediately panic when failed IOMMU table
    allocation

 arch/powerpc/kernel/iommu.c               | 19 ++++++-------------
 arch/powerpc/platforms/cell/iommu.c       |  3 ++-
 arch/powerpc/platforms/pasemi/iommu.c     |  4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c | 15 ++++++++-------
 arch/powerpc/platforms/pseries/iommu.c    | 10 +++++++---
 arch/powerpc/sysdev/dart_iommu.c          |  3 ++-
 6 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.17.1

