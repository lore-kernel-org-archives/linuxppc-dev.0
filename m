Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A5C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 08:55:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C72215EA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 08:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C72215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JxKN0qTWzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 18:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 46JxG14bVFzDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 18:52:57 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 6E65FAE80037;
 Thu, 29 Aug 2019 04:52:32 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 0/5] powerpc/powernv/kvm: Invalidate multiple TCEs
 at once
Date: Thu, 29 Aug 2019 18:52:47 +1000
Message-Id: <20190829085252.72370-1-aik@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

So far TCE cache updates (IOMMU translation cache on POWER8/9
PHB/NPU units) were barely noticeable; however with 100+GB guests
we now see RCU stall warnings in guests because we spend too much
time in the host system firmware which does actual TCE cache
updates, hence this patchset.

This is a rework of
https://patchwork.ozlabs.org/patch/1149003/
https://patchwork.ozlabs.org/patch/1152985/ (cannot post link to the series
as it appears empty because of broken patchworks)

This depends on KVM-PPC's bugfix: https://patchwork.ozlabs.org/patch/1152937/

I expect 1/5 to go via the PPC tree, 2/5 via the KVM-PPC tree,
3/5 via the VFIO tree and the rest via the PPC tree.

Changes:
v3:
* added 4/5 to fix compile error from 5/5
* added "Book3S" to 2/5's subject line


This is based on sha1
42ac26d253eb Santosh Sivaraj "powerpc: add machine check safe copy_to_user".

Please comment. Thanks.



Alexey Kardashevskiy (5):
  powerpc/powernv/ioda: Split out TCE invalidation from TCE updates
  KVM: PPC: Book3S: Invalidate multiple TCEs at once
  vfio/spapr_tce: Invalidate multiple TCEs at once
  powerpc/pseries/iommu: Switch to xchg_no_kill
  powerpc/powernv/ioda: Remove obsolete iommu_table_ops::exchange
    callbacks

 arch/powerpc/include/asm/iommu.h          | 21 ++++++---
 arch/powerpc/kernel/iommu.c               | 23 ++++++----
 arch/powerpc/kvm/book3s_64_vio.c          | 29 ++++++++----
 arch/powerpc/kvm/book3s_64_vio_hv.c       | 38 +++++++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c | 56 ++++-------------------
 arch/powerpc/platforms/pseries/iommu.c    |  5 +-
 drivers/vfio/vfio_iommu_spapr_tce.c       | 18 +++++---
 7 files changed, 99 insertions(+), 91 deletions(-)

-- 
2.17.1

