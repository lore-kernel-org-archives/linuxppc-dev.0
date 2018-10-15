Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A6C7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:32:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EC7205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYBM63QdzF3Jm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:32:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YY1c1Rl1zF3Kp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:24:52 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 4822BAE80026;
 Mon, 15 Oct 2018 05:24:19 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/4] vfio/spapr_tce: Reworks for NVIDIA V100 + P9
 passthrough (part 1)
Date: Mon, 15 Oct 2018 20:24:12 +1100
Message-Id: <20181015092416.47380-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a first set of patches required for passing through NVIDIA V100
with coherent memory. The full patchset is here:
https://github.com/aik/linux/tree/nv2
The matching QEMU is here:
https://github.com/aik/qemu/tree/nv2

This particular patchset prepares for having device memory which is not
backed with page structs.

Does 4/4 really need splitting?


Please comment. Thanks.



Alexey Kardashevskiy (4):
  powerpc/mm/iommu: Rename mm_iommu_get
  powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a
    region
  powerpc/mm/iommu: Make mm_iommu_new() fail on existing regions
  powerpc/vfio/iommu/kvm: Do not pin device memory

 arch/powerpc/include/asm/iommu.h       |  5 +-
 arch/powerpc/include/asm/mmu_context.h |  9 +++-
 arch/powerpc/kernel/iommu.c            |  9 ++--
 arch/powerpc/kvm/book3s_64_vio.c       | 18 ++++---
 arch/powerpc/mm/mmu_context_iommu.c    | 97 +++++++++++++++++++++++++++++-----
 drivers/vfio/vfio_iommu_spapr_tce.c    | 65 +++++++++++++++--------
 6 files changed, 151 insertions(+), 52 deletions(-)

-- 
2.11.0

