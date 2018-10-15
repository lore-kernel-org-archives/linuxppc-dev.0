Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0854C7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:44:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A25E2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A25E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYRk3X8JzF3By
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYCh3gMQzF3Ft
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:36 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 53CB8AE807EA;
 Mon, 15 Oct 2018 05:33:03 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/5] powerpc/powernv/npu: Reworks for NVIDIA V100 + P9
 passthrough (part 2)
Date: Mon, 15 Oct 2018 20:32:56 +1100
Message-Id: <20181015093301.1007-1-aik@ozlabs.ru>
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
 Alistair Popple <alistair@popple.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a second set of patches required for passing through NVIDIA V100
with coherent memory. The full patchset is here:
https://github.com/aik/linux/tree/nv2
The matching QEMU is here:
https://github.com/aik/qemu/tree/nv2


This patchset reworks NPU DMA code to be used with VFIO. The exported symbols
are called from the NVIDIA driver so they must be able to work in both
powernv and pseries platforms.

This depends on skiboot's "npu2: Clear XTS_BDF_MAP when destroying context for next init_context"
posted earlier today.

Please comment. Thanks.



Alexey Kardashevskiy (5):
  powerpc/powernv/npu: Add helper to access struct npu for NPU device
  powerpc/powernv/npu: Collect all static symbols under one struct
  powerpc/powernv: Detach npu struct from pnv_phb
  powerpc/powernv/npu: Factor out OPAL calls from context manipulation
  powerpc/powernv/npu: Add helper to map GPU to LPAR

 arch/powerpc/include/asm/pci.h            |   4 +
 arch/powerpc/platforms/powernv/pci.h      |  18 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 298 ++++++++++++++++++++----------
 arch/powerpc/platforms/powernv/pci-ioda.c |   9 +-
 4 files changed, 212 insertions(+), 117 deletions(-)

-- 
2.11.0

