Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FCC7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:56:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB4320853
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB4320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYjX5HHwzDqNG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYQ64GX4zDrWW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:42:38 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 6386EAE807F6;
 Mon, 15 Oct 2018 05:42:35 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/3] vfio/spapr_tce: Reworks for NVIDIA V100 + P9
 passthrough (part 3)
Date: Mon, 15 Oct 2018 20:42:30 +1100
Message-Id: <20181015094233.1324-1-aik@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a third set of patches required for passing through NVIDIA V100
with coherent memory. The full patchset is here:
https://github.com/aik/linux/tree/nv2
The matching QEMU is here:
https://github.com/aik/qemu/tree/nv2

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU.

This does not address the interconnected GPUs, this will be posted as
a separate patchset in a few days.

This depends on:
[PATCH kernel 0/4] vfio/spapr_tce: Reworks for NVIDIA V100 + P9 passthrough (part 1)
[PATCH kernel 0/5] powerpc/powernv/npu: Reworks for NVIDIA V100 + P9 passthrough (part 2)
[PATCH kernel RFC 3/3] powerpc/pseries/iommu: Use memory@ nodes in max RAM address calculation

Please comment. Thanks.



Alexey Kardashevskiy (3):
  vfio_pci: Allow mapping extra regions
  vfio_pci: Allow regions to add own capabilities
  vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] [10de:1db1] subdriver

 drivers/vfio/pci/Makefile           |   1 +
 drivers/vfio/pci/vfio_pci_private.h |   8 +
 include/uapi/linux/vfio.h           |  18 ++
 drivers/vfio/pci/vfio_pci.c         |  51 ++++-
 drivers/vfio/pci/vfio_pci_nvlink2.c | 409 ++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/Kconfig            |   4 +
 6 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c

-- 
2.11.0

