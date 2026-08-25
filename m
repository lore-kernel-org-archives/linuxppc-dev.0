Return-Path: <linuxppc-dev+bounces-26069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2A9C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 02:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTWrF28t8z2y2M;
	Tue, 25 Aug 2026 12:26:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787624813;
	cv=none; b=kfRRZXUYmBju1MqnzmrAf1cRPcr2TRyp0tjaW2G/iLnVvtKjad2+9ysjC1/9AUXdvbRpNdvxhSru6hApU/RGA1PsxvpF6dlM58PRwzrUzxzmSg2Dkt0rPC4UDQlLY9NfAutJaqistPd13MbZje/BrkFQxsSO8yl3FekvjNuG0Lc/FYR/kVWWzJRDim6mqlIfKSwW7gC5zilpJya2lvR3pQSQioTj/By2rwIt6juqCoElWnqClXa1zhaEewrJPVlNOVaVnxZ1PPQYHpmrX0TGMIXFTK/vuOUYnDNWvu/mliqSVC475t+ANeOXHlQqBWXI112M+NfN7LLsS1nZtRKLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787624813; c=relaxed/relaxed;
	bh=zY9nF2RQ3gTikZfjKcS1scrUKxgxGYtG8WcgkyAvxNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIEsVytmmEDdvkmoFRzUC9f9bOX4NWUsc/c54eBa+oFwN4wyARDj4y3RXQMlHOgUKHenZPyM+wlDYWIdOVXqVb+Ws6XedMtgV9OOCPvCmcibAQegeVrcRSsTII/0zNthW1r3ESYTizlVNYUDJAsjnnVTL86Vn0WjKEya0Wg0dPWWKLLmbz54uOHgx1l2cBIQDDyWl5Eh9bfYjOKg/L4ggBBH9fRLThnniI32yEiT3gWGvGQhX/C2rQA6n5qV/hWYKJt+GEZ7t/di0+/6b8JYCJIo8607Vk1eNgnx9nAaMQ7fYRnQUlfPkAu5N6FnnnMXM2tHjpbF1TKS2rJldYKzoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YeuQ+l2l; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YeuQ+l2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=fabio.m.de.francesco@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTWr93SzXz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 12:26:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624810; x=1819160810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=59oDA8OxqCcTABs6FaXD4uZZ6h0YHjbqVgHwIRKfCEk=;
  b=YeuQ+l2lCfThsyuy8qTBq1ZKYbnKlG7HmCZSkeFeSh6tjVOfSQcOq0Cx
   9sEiUuqxC7q5sJM7wP6VQ/IQMj9PJe1/BGDyXDctOx+XyGKrLM/7UzQHy
   ZxYGyXF9akkrxWuJXQuX3HpzoDSZkPCr0aylQwYx2V4cpuNpWbkD4ovMn
   HjckG3GhO3XgVVCv9X+336Ctda+lgR5HhOjMhWKekjaaAHoJqllA7G3Kf
   4DjdVCU3XzSkeugrYfrzVl2w+PlKoN4TuVH6DjRXQ3d+i6h3HsS/x6AxE
   5cLowZWM0kmZFVHPiSpFiblpNB7EbfZCBIhfApcnrQR99KDFWOa+ZqHdB
   w==;
X-CSE-ConnectionGUID: xN8vNazsQKukHEnsoCU7eg==
X-CSE-MsgGUID: PmkhDiUVQBak2QYdNhSuLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98760926"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98760926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:41 -0700
X-CSE-ConnectionGUID: qw57hyDPQVqR+IkyCbQLew==
X-CSE-MsgGUID: yqTxaTRTTP67lZe80asckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390022"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:34 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 00/13] Make SBR work for CXL Downstream Ports
Date: Tue, 25 Aug 2026 04:26:15 +0200
Message-ID: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Secondary Bus Reset (SBR), a Link Down or a Downstream Port
Containment (DPC) event on a CXL Downstream Port clears the Downstream
Component's captured Bus Number. CXL r4.0 sec 8.1.5.1 notes that, if the
Component then sources its Power Management (PM) Initialization traffic
with Requester Bus = 0, a Port with Access Control Services (ACS) Source
Validation (SV) enabled may reject the Component's CREDIT_RTN IP2PM
message, PM Initialization may fail to complete, and that "another
Secondary Bus Reset alone will not facilitate recovery". PCIe r7.0 sec
6.12.1.1 makes the rejection an error that is reported as ACS Violation.

The Implementation Note under sec 8.1.5.1 gives the sequence that avoids
it: save and clear Bus Master Enable and ACS SV, generate the SBR, wait
for Port PM Initialization Complete, restore both bits, continue device
re-initialization. This series takes a step further to a preventive
measure that avoids the ACS Violation in the first place, not after
failure.

Patches 1-5 restore HDM Decoder registers below a reset CXL Downstream
Port.

Patches 6-8 disable and re-enable the CXL Regions around the reset:
offline memory, invalidate CPU caches for its range, collect the set of
regions the CXL DPort which is SBR andunbind the driver.

Patch 9 disable and re-enable CXL regions across a Downstream Port reset
and registers the CXL region callbacks for a Downstream Port bus. We
want the reset to be called only when the CXL driver is loaded.

Patch 10 calls the CXL operations from pci_bridge_secondary_bus_reset().

Patch 11 issues the same sequence from dpc_reset_link().

Patches 12 and 13 gives root a sysfs attribute that conrols whether the
SBR is allowed to be unmasked and prevents kernel from unmasking SBR on
its own.

What user space finds after an SBR of a CXL Downstream Port: the dax
device returns under the same name, the region's HPA range, interleave
geometry and decoder programming are restored, and the media content is
unchanged for PMEM. System RAM comes back registered but offline.

Fabio M. De Francesco (13):
  cxl/pci: Make the HDM and Mem_Enable writes callable from cxl_core
  cxl/hdm: Add cxl_decoder_recommit() to restore one HDM decoder
  cxl/hdm: Add cxl_endpoint_enable_hdm_decode() to restore CXL.mem
    decode
  cxl/hdm: Reprogram the HDM Decoders below a CXL Port
  cxl/core: Restore the HDM decoders below a reset Downstream Port
  drivers/base/memory: Add cxl_offline_memory() to offline a physical
    range
  cxl/core: Add region disable and enable for a Downstream Port reset
  cxl/core: Collect the CXL regions routed through a Downstream Port
  PCI/CXL: Register CXL region callbacks for a Downstream Port bus reset
  PCI/CXL: Clear ACS SV across an SBR of a CXL Downstream Port
  PCI/DPC: Issue the CXL recovery SBR from DPC without offlining memory
  PCI/CXL: Add cxl_unmask_sbr to permit an SBR of a CXL Downstream Port
  PCI/CXL: Refuse an SBR of a CXL Downstream Port without the unmask
    consent

 Documentation/ABI/testing/sysfs-bus-pci |  16 +
 drivers/base/memory.c                   |  36 +++
 drivers/cxl/core/Makefile               |   2 +-
 drivers/cxl/core/core.h                 |  28 ++
 drivers/cxl/core/dport_sbr.c            | 374 ++++++++++++++++++++++++
 drivers/cxl/core/hdm.c                  | 341 +++++++++++++++++++++
 drivers/cxl/core/pci.c                  |  19 +-
 drivers/cxl/core/port.c                 |   4 +-
 drivers/cxl/core/ras.c                  |  10 +
 drivers/cxl/core/region.c               |   6 +-
 drivers/pci/pci-sysfs.c                 |  31 ++
 drivers/pci/pci.c                       | 254 +++++++++++++++-
 drivers/pci/pci.h                       |  15 +
 drivers/pci/pcie/dpc.c                  |  46 ++-
 include/linux/aer.h                     |   9 +
 include/linux/memory.h                  |   5 +
 include/linux/pci.h                     |  16 +
 include/uapi/linux/pci_regs.h           |   2 +
 tools/testing/cxl/Kbuild                |   2 +-
 19 files changed, 1193 insertions(+), 23 deletions(-)
 create mode 100644 drivers/cxl/core/dport_sbr.c

-- 
2.55.0


