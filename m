Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DB606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=suf7Bwoe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMc65X2gz2xnZ;
	Tue, 17 Nov 2026 22:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914166;
	cv=none; b=l4l9mA1SkXmg4I/+hcN4cEajWBYWLVGT8rcNI7Q6vKEX+zyKgnANKRCPnHGhC8fa6ujbJJjetggbft8Y9NiUmMyYoC0mZ1G2N0m40fBGM4uJzTC7qeVtZKLCNwDq8z9fCTUOXLeJxu8p238qoiRzFxmbkLXIOAahm0gn8K03RQQAERe2qKcvHnkHKUAVCRKpdnpjqANNg3cJoWvs13xi5/F6XHmnCAjfgg8b2gIHfrU6H8VCrb6UPb947gLWb6Oi9blijulM8NYA5Aycl0ehq9X2BU7pQP9Dw0e6oftCPeFmq4kQ5iMRGpGEu93qZFrK1zkNQIzeWn3eU+a8kllNug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914166; c=relaxed/relaxed;
	bh=i/j6OXhWE2BWJFu74iOeMBHWT4Il0cJQsXX5eDzeUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlWxRZX8xrgVaX6uJTPwAjQX07PsqFI7HzuFqUgc5NmyBSv+xxOyYT5Pp3I93Ja4DrPhs8GGwDm0s5RQS//q8TMcTHDg2LrCglbAPKWpMUsYjNAfwUEU7C33nX1nxdR0G+Jax9l2Z1QLchUVP9Y3VH3RU7sNN9+9xucEZ6Trk0zIScrbrX+HmCshKwZz4AQmpVsg3t2oODsde1zspftkK8npI28oWHCRgugUt4KH8F1ihcZIPykAkQdBmIxolLueLGq44bxbAivc3vJdoBtY1qp7Yi77mwaAe6/efHQ0xZE5GoBEJc7BUjGVqg2KEn3zuWNcslvTe2RcfFu5OxpXbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=suf7Bwoe; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=suf7Bwoe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMc41S3Zz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:16:02 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E0151476;
	Tue, 17 Nov 2026 03:15:27 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15C383F763;
	Tue, 17 Nov 2026 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914130; bh=m2BGvWlESmAk3p+3a2LbqSeYpicuTAHuyckwikWeVZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=suf7Bwoe+FfV9WdUTtJshf5GvzmpqDFdT13KI6zdzgZSuDlMSWM/C6p8v3xd18boJ
	 8lRSXBXzFbDtddOXGUfQbtumJdfH5SrNnU9OOMEMbg/F6yoPctDCX7mAyCVo4rRfaf
	 EIbk/hsVBTaFOn1s3qAx+03aDWURAIrSIx3uYPK4=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 00/19] ACPI: APEI: Share CPER reporting between GHES and extlog
Date: Tue, 17 Nov 2026 12:10:10 +0100
Message-ID: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This patchset should be applied on top of [1].

GHES and acpi_extlog handle many of the same CPER sections, but have
separate implementations that do not always report errors in the same
way. This series brings that code together so both paths can use the
same reporting helpers.

Most of the patches prepare for that move. MCE reporting for Memory
Error Section 2 is also added. In the MCE extended-log policy, tracing
and PCIe/CXL handling no longer depend on whether a RAS daemon is
registered. Only fatal CPER records are printed to the console, as
briefly suggested at [2]. For nonfatal records,
users need tracing enabled or a subsystem handler that reports the error.

With the common helper, GHES can emit memory trace events even without
an EDAC driver registered. CXL media records that cannot be queued are
reported through the nonstandard trace event instead of being dropped.

[1] https://lore.kernel.org/lkml/20261113132600.3355836-1-pierre.gondois@arm.com/
[2] https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/

++++++++++++
+ Testing: +
++++++++++++

Some examples of kernel logs,
tested on x86/arm64:

CPER Memory Error section:
{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
{1}[Hardware Error]: event severity: recoverable
{1}[Hardware Error]:  Error 0, type: recoverable
{1}[Hardware Error]:  fru_text: ABCDEFGHIJKLMNOPQRST
{1}[Hardware Error]:   section_type: memory error
{1}[Hardware Error]:    error_status: A read was issued to data that has been poisoned (0x00000000007f1a00)
{1}[Hardware Error]:   physical_address: 0xffffffffffffffff
{1}[Hardware Error]:   physical_address_mask: 0xffffffffffffffff
{1}[Hardware Error]:   node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7
{1}[Hardware Error]:   error_type: 15, physical memory map-out event
{1}[Hardware Error]:   DIMM location: not present. DMI handle: 0xfeff
$ [arm64 specific log]
EDAC MC0: 1 UE physical memory map-out event on unknown memory (node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7 DIMM location: not present. DMI handle: 0xfeff page:0xfffffffffffff offset:0xfff grain:1 - APEI location: node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7 DIMM location: not present. DMI handle: 0xfeff status(0x00000000007f1a00): A read was issued to data that has been poisoned)
Memory failure: 0xfffffffffffff: recovery action for non struct page pfn: Ignored

CPER Memory Error section 2:
{2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
{2}[Hardware Error]: event severity: recoverable
{2}[Hardware Error]:  Error 0, type: recoverable
{2}[Hardware Error]:  fru_text: ABCDEFGHIJKLMNOPQRST
{2}[Hardware Error]:   section_type: memory error 2
{2}[Hardware Error]:   error_status: A read was issued to data that has been poisoned (0x00000000007f1a00)
{2}[Hardware Error]:   physical_address: 0xffffffffffffffff
{2}[Hardware Error]:   physical_address_mask: 0xffffffffffffffff
{2}[Hardware Error]:   node:65535 card:65535 module:65535 rank:4294967295 bank_group:255 bank_address:255 device:4294967295 row:4294967295 column:4294967295 bit_position:4294967295 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:255
{2}[Hardware Error]:   error_type: 15, physical memory map-out event
{2}[Hardware Error]:   status: 0x01
{2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000feff
$ [arm64 specific log]
EDAC MC0: 1 UE physical memory map-out event on unknown memory (node:65535 card:65535 module:65535 rank:4294967295 bank_group:255 bank_address:255 device:4294967295 row:4294967295 column:4294967295 bit_position:4294967295 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:255 DIMM location: not present. DMI handle: 0x0000feff page:0xfffffffffffff offset:0xfff grain:1 - APEI location: node:65535 card:65535 module:65535 rank:4294967295 bank_group:255 bank_address:255 device:4294967295 row:4294967295 column:4294967295 bit_position:4294967295 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:255 DIMM location: not present. DMI handle: 0x0000feff status(0x00000000007f1a00): A read was issued to data that has been poisoned section_status:0x01)
Memory failure: 0xfffffffffffff: recovery action for non struct page pfn: Ignored

Non standard (i.e. random GUID):
{3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
{3}[Hardware Error]: event severity: recoverable
{3}[Hardware Error]:  Error 0, type: recoverable
{3}[Hardware Error]:  fru_text: ABCDEFGHIJKLMNOPQRST
{3}[Hardware Error]:   section type: unknown, 12345678-1234-5678-9abc-def012345679
{3}[Hardware Error]:   section length: 0x21
{3}[Hardware Error]:   00000000: 746e7953 69746568 6f6e2063 6174736e  Synthetic nonsta
{3}[Hardware Error]:   00000010: 7261646e 50432064 65205245 746e6576  ndard CPER event
{3}[Hardware Error]:   00000020: 00                                               .

PCI:
{4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
{4}[Hardware Error]: event severity: recoverable
{4}[Hardware Error]:  Error 0, type: recoverable
{4}[Hardware Error]:  fru_text: ABCDEFGHIJKLMNOPQRST
{4}[Hardware Error]:   section_type: PCIe error
{4}[Hardware Error]:   port_type: 0, PCIe end point
{4}[Hardware Error]:   device_id: 0000:01:00.0
{4}[Hardware Error]:   slot: 0
{4}[Hardware Error]:   secondary_bus: 0x00
{4}[Hardware Error]:   vendor_id: 0x1234, device_id: 0x5678
{4}[Hardware Error]:   class_code: 000000
{4}[Hardware Error]:   aer_cor_status: 0x00000000, aer_cor_mask: 0x00000000
{4}[Hardware Error]:   aer_uncor_status: 0x00004000, aer_uncor_mask: 0x00000000
{4}[Hardware Error]:   aer_uncor_severity: 0x00000000
{4}[Hardware Error]:   TLP Header: 00000000 00000000 00000000 00000000
AER: 0000:01:00.0: no pci_dev found

Tracing:
x86:
extlog_mem_event: {1} recoverable error: physical memory map-out event physical addr: ffffffffffffffff (mask lsb: 0) node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7 DIMM location: not present. DMI handle: 0xfeff FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST
mce_record: CPU: 0, MCGc/s: 100010a/0, MC255: bc0000000000009f, IPID: 0000000000000000, ADDR: ffffffffffffffff, MISC: 0000000000000080, SYND: 0000000000000000, RIP: 00:<0000000000000000>, TSC: 0, PPIN: 0, vendor: 2, CPUID: 663, time: 1794906879, socket: 0, APIC: 0, microcode: 1000065, vendor data: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
extlog_mem2_event: {2} recoverable error: validation_bits: 0x3fffbf error_status: 0x7f1a00 physical_addr: 0xffffffffffffffff physical_addr_mask: 0xffffffffffffffff node: 65535 card: 65535 module: 65535 bank: 65535 device: 4294967295 row: 4294967295 column: 4294967295 rank: 4294967295 bit_pos: 4294967295 chip_id: 255 error_type: 15 status: 0x1 requestor_id: 0xffffffffffffffff responder_id: 0xffffffffffffffff target_id: 0xffffffffffffffff mem_array_handle: 0xfeff mem_dev_handle: 0xfeff FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST
mce_record: CPU: 0, MCGc/s: 100010a/0, MC255: bc0000000000009f, IPID: 0000000000000000, ADDR: ffffffffffffffff, MISC: 0000000000000080, SYND: 0000000000000000, RIP: 00:<0000000000000000>, TSC: 0, PPIN: 0, vendor: 2, CPUID: 663, time: 1794906882, socket: 0, APIC: 0, microcode: 1000065, vendor data: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
non_standard_event: severity: 2; sec type:78563412-3412-7856-9abc-def012345679; FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST; data len:33; raw data:53 79 6e 74 68 65 74 69 63 20 6e 6f 6e 73 74 61 6e 64 61 72 64 20 43 50 45 52 20 65 76 65 6e 74 00

arm64:
extlog_mem_event: {1} recoverable error: physical memory map-out event physical addr: ffffffffffffffff (mask lsb: 0) node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7 DIMM location: not present. DMI handle: 0xfeff FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST
mc_event: 1 Uncorrected error: physical memory map-out event on unknown memory (mc:0 location:-1:-1:-1 address:0xffffffffffffffff grain:1 syndrome:0x00000000 APEI location: node:65535 card:65535 module:65535 rank:65535 bank_group:255 bank_address:255 device:65535 row:262143 column:65535 bit_position:65535 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:7 DIMM location: not present. DMI handle: 0xfeff status(0x00000000007f1a00): A read was issued to data that has been poisoned)
memory_failure_event: pfn 0xfffffffffffff: recovery action for non struct page pfn: Ignored
extlog_mem2_event: {2} recoverable error: validation_bits: 0x3fffbf error_status: 0x7f1a00 physical_addr: 0xffffffffffffffff physical_addr_mask: 0xffffffffffffffff node: 65535 card: 65535 module: 65535 bank: 65535 device: 4294967295 row: 4294967295 column: 4294967295 rank: 4294967295 bit_pos: 4294967295 chip_id: 255 error_type: 15 status: 0x1 requestor_id: 0xffffffffffffffff responder_id: 0xffffffffffffffff target_id: 0xffffffffffffffff mem_array_handle: 0xfeff mem_dev_handle: 0xfeff FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST
mc_event: 1 Uncorrected error: physical memory map-out event on unknown memory (mc:0 location:-1:-1:-1 address:0xffffffffffffffff grain:1 syndrome:0x00000000 APEI location: node:65535 card:65535 module:65535 rank:4294967295 bank_group:255 bank_address:255 device:4294967295 row:4294967295 column:4294967295 bit_position:4294967295 requestor_id:0xffffffffffffffff responder_id:0xffffffffffffffff target_id:0xffffffffffffffff chip_id:255 DIMM location: not present. DMI handle: 0x0000feff status(0x00000000007f1a00): A read was issued to data that has been poisoned section_status:0x01)
memory_failure_event: pfn 0xfffffffffffff: recovery action for non struct page pfn: Ignored
non_standard_event: severity: 2; sec type:78563412-3412-7856-9abc-def012345679; FRU: 00000000-0000-0000-0000-000000000000 ABCDEFGHIJKLMNOPQRST; data len:33; raw data:53 79 6e 74 68 65 74 69 63 20 6e 6f 6e 73 74 61 6e 64 61 72 64 20 43 50 45 52 20 65 76 65 6e 74 00

Pierre Gondois (19):
  x86/APEI: Extract common CPER memory error reporting helper
  x86/APEI: Report Memory Error Section 2 through MCE
  ras: Bound CPER FRU strings in trace events
  ACPI: APEI: Use empty FRU values if valid bit is absent
  PCI/AER: Embed aer_capability_regs copy in struct aer_recover_entry
  ACPI: APEI: Remove aer allocation in ghes_handle_aer()
  ACPI: extlog: Provide HEST generic data to extlog_print_pcie()
  ACPI: extlog: Align extlog_print_pcie() and ghes_handle_aer()
  ACPI: extlog: Report errors independently of RAS consumers
  ACPI: extlog: Simplify fatal record printing
  RAS: Remove unused ras_userspace_consumers()
  ACPI: extlog: Extract CPER reporting from acpi_extlog
  ACPI: APEI: Share helpers with the common CPER reporter
  ACPI: APEI: Return status from cxl_cper_post_event()
  ACPI: APEI: Extend common CPER reporting for GHES section types
  ACPI: extlog: Report error severity using GHES bindings in MCE
  ACPI: APEI: Share the extlog PCIe handler with GHES
  ACPI: APEI: Route GHES section reporting through extlog
  PCI/ERR: Avoid NULL bridge pointer

 arch/x86/include/asm/mce.h        |   5 +-
 arch/x86/kernel/acpi/apei.c       |   7 +
 arch/x86/kernel/cpu/mce/apei.c    |  43 ++++--
 drivers/acpi/acpi_extlog.c        | 138 ++---------------
 drivers/acpi/apei/Makefile        |   2 +-
 drivers/acpi/apei/apei-base.c     |   5 +
 drivers/acpi/apei/apei-internal.h |   7 +
 drivers/acpi/apei/extlog.c        | 236 ++++++++++++++++++++++++++++++
 drivers/acpi/apei/ghes.c          | 168 +++------------------
 drivers/pci/pcie/aer.c            |  34 ++---
 drivers/pci/pcie/err.c            |   5 +
 drivers/ras/debugfs.c             |  10 --
 drivers/ras/ras.c                 |   2 +-
 include/acpi/apei.h               |   1 +
 include/acpi/ghes.h               |   4 -
 include/linux/aer.h               |   2 +-
 include/linux/ras.h               |   2 -
 include/ras/ras_event.h           |   8 +-
 18 files changed, 345 insertions(+), 334 deletions(-)
 create mode 100644 drivers/acpi/apei/extlog.c

--
2.43.0

