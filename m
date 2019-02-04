Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718CC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:47:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD4E2082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="nPE5lITZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD4E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tXCD3trXzDqKV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 02:47:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="nPE5lITZ"; 
 dkim-atps=neutral
X-Greylist: delayed 459 seconds by postgrey-1.36 at bilbo;
 Tue, 05 Feb 2019 02:43:56 AEDT
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tX7J2BX3zDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 02:43:56 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id BFF0A41955;
 Mon,  4 Feb 2019 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1549294571; x=
 1551108972; bh=ckkiNzZnraUz0OeJAhto9pPke2xNchxTbRq1F9h5Tnk=; b=n
 PE5lITZ7Af+ox1vhBDzFEm1q8Znalt1/VuiPNm1uh1VwcgLvqYkult6y+VCFbiKL
 AZI+UgoqHcicP/VTwgCVVR3Ek8WHQdfw/gLI1GU8VhsPpg4pmH5Zx1s69ZqZiPw/
 kBrXD64DRQfZzOoPLnCLkJDfoGXo/943YtnKxosSbY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4Hv9eUi7R3F; Mon,  4 Feb 2019 18:36:11 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B69794122E;
 Mon,  4 Feb 2019 18:36:09 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:09 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH RFC v3 00/21] PCI: Allow BAR movement during hotplug
Date: Mon, 4 Feb 2019 18:35:40 +0300
Message-ID: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, linux@yadro.com,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Oliver <oohall@gmail.com>, Rajat Jain <rajatja@google.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If the firmware or kernel has arranged memory for PCIe devices in a way that
doesn't provide enough space for BARs of a new hotplugged device, the kernel
can pause the drivers of the "obstructing" devices and move their BARs, so
new BARs can fit into the freed spaces.

When a driver is un-paused by the kernel after the PCIe rescan, it should
check if its BARs had moved, and ioremap() them if needed.

Drivers indicate their support of the feature by implementing the new
rescan_prepare() and rescan_done() hooks in the struct pci_driver. If a
driver doesn't yet support the feature, BARs of its devices will be marked
as immovable by the IORESOURCE_PCI_FIXED flag.

To re-arrange the BARs and bridge windows this patch releases all of them
after a rescan and re-assigns in the same way as during the initial PCIe
topology scan at system boot.

Tested on:
 - x86_64 with "pci=realloc,assign-busses,use_crs pcie_movable_bars=force"
 - ppc64le POWER8 PowerNV (with extra arch-specific patches which will be
   introduced later) with "pci=realloc pcie_movable_bars=force"

Not so many platforms and test cases were covered, so all who are interested
are highly welcome to test on your setups - the more exotic the better!

Changes since v2:
 - Fixed double-assignment of bridge windows;
 - Fixed assignment of fixed prefetched resources;
 - Fixed releasing of fixed resources;
 - Fixed a debug message;
 - Removed auto-enabling the movable BARs for x86 - let's rely on the
   "pcie_movable_bars=force" option for now;
 - Reordered the patches - bugfixes first.

Changes since v1:
 - Add a "pcie_movable_bars={ off | force }" command line argument;
 - Handle the IORESOURCE_PCI_FIXED flag properly;
 - Don't move BARs of devices which don't support the feature;
 - Guarantee that new hotplugged devices will not steal memory from working
   devices by ignoring the failing new devices with the new PCI_DEV_IGNORE
   flag;
 - Add rescan_prepare()+rescan_done() to the struct pci_driver instead of
   using the reset_prepare()+reset_done() from struct pci_error_handlers;
 - Add a bugfix of a race condition;
 - Fixed hotplug in a non-pre-enabled (by BIOS/firmware) bridge;
 - Fix the compatibility of the feature with pm_runtime and D3-state;
 - Hotplug events from pciehp also can move BARs;
 - Add support of the feature to the NVME driver.

This patchset is a part of our work on adding support for hotplugging
bridges full of NVME and GPU devices (without special requirement such as
Hot-Plug Controller, reservation of bus numbers and memory regions by
firmware, etc.). Next patchset will implement the movable bus numbers.

Sergey Miroshnichenko (21):
  PCI: Fix writing invalid BARs during pci_restore_state()
  PCI: Fix race condition in pci_enable/disable_device()
  PCI: Enable bridge's I/O and MEM access for hotplugged devices
  PCI: Define PCI-specific version of the release_child_resources()
  PCI: hotplug: Add a flag for the movable BARs feature
  PCI: Pause the devices with movable BARs during rescan
  PCI: Wake up bridges during rescan when movable BARs enabled
  nvme-pci: Handle movable BARs
  PCI: Mark immovable BARs with PCI_FIXED
  PCI: Fix assigning of fixed prefetchable resources
  PCI: Release and reassign the root bridge resources during rescan
  PCI: Don't allow hotplugged devices to steal resources
  PCI: Include fixed BARs into the bus size calculating
  PCI: Don't reserve memory for hotplug when enabled movable BARs
  PCI: Allow the failed resources to be reassigned later
  PCI: Calculate fixed areas of bridge windows based on fixed BARs
  PCI: Calculate boundaries for bridge windows
  PCI: Make sure bridge windows include their fixed BARs
  PCI: Prioritize fixed BAR assigning over the movable ones
  PCI: pciehp: Add support for the movable BARs feature
  powerpc/pci: Fix crash with enabled movable BARs

 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/powerpc/platforms/powernv/pci-ioda.c     |   3 +-
 drivers/nvme/host/pci.c                       |  29 +-
 drivers/pci/bus.c                             |   7 +-
 drivers/pci/hotplug/pciehp_pci.c              |  14 +-
 drivers/pci/pci.c                             |  60 +++-
 drivers/pci/pci.h                             |  26 ++
 drivers/pci/probe.c                           | 271 +++++++++++++++++-
 drivers/pci/setup-bus.c                       | 245 ++++++++++++++--
 drivers/pci/setup-res.c                       |  43 ++-
 include/linux/pci.h                           |  14 +
 11 files changed, 678 insertions(+), 41 deletions(-)

-- 
2.20.1

