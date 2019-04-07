Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C2C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:26:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100EB20693
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100EB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cZ7x5xM2zDqLP
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 23:26:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cYmc1nM6zDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 23:09:36 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BCA5B2E388295C2AE7BA;
 Sun,  7 Apr 2019 20:48:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 7 Apr 2019 20:47:58 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry
 <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott
 <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Martin Schwidefsky" <schwidefsky@de.ibm.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
 <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
 linux-ia64 <linux-ia64@vger.kernel.org>
Subject: [PATCH v4 0/6] normalize IOMMU dma mode boot options
Date: Sun, 7 Apr 2019 20:41:41 +0800
Message-ID: <20190407124147.13576-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sun, 07 Apr 2019 23:15:08 +1000
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
Cc: Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As Robin Murphy's suggestion:
"It's also not necessarily obvious to the user how this interacts with
IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
would be better to refactor the whole lot into a single selection of something
like IOMMU_DEFAULT_MODE anyway."

In this version, I tried to normalize the IOMMU dma mode boot options for all
ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
lazy(mapping but defer the IOTLB invalidation), strict. But currently each
ARCHs defined their private boot options, different with each other. For
example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.


Zhen Lei (6):
  iommu: use iommu.dma_mode to replace iommu.passthrough and
    iommu.strict
  iommu: keep dma mode build options consistent with cmdline options
  iommu: add iommu_default_dma_mode_get() helper
  s390/pci: use common boot option iommu.dma_mode
  powernv/iommu: use common boot option iommu.dma_mode
  x86/iommu: use common boot option iommu.dma_mode

 Documentation/admin-guide/kernel-parameters.txt | 42 +++++++-------------
 arch/ia64/include/asm/iommu.h                   |  2 -
 arch/ia64/kernel/pci-dma.c                      |  2 -
 arch/powerpc/platforms/powernv/pci-ioda.c       | 23 +----------
 arch/s390/pci/pci_dma.c                         | 20 +++-------
 arch/x86/include/asm/iommu.h                    |  1 -
 arch/x86/kernel/pci-dma.c                       | 20 ----------
 drivers/iommu/Kconfig                           | 36 ++++++++++++++---
 drivers/iommu/amd_iommu.c                       | 12 +++---
 drivers/iommu/amd_iommu_init.c                  |  4 --
 drivers/iommu/amd_iommu_types.h                 |  6 ---
 drivers/iommu/intel-iommu.c                     |  7 +---
 drivers/iommu/iommu.c                           | 52 ++++++++++++++++---------
 include/linux/iommu.h                           | 16 ++++++++
 14 files changed, 108 insertions(+), 135 deletions(-)

-- 
1.8.3


