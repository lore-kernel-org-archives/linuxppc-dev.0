Return-Path: <SRS0=/+OH=4Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A562C3F2CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 19:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914A2468E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 19:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914A2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Tft85w33zDrPh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 06:36:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TfqH2ZCkzDrMv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Feb 2020 06:33:55 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 11:33:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="257212162"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 11:33:51 -0800
Subject: [PATCH v3 0/5] libnvdimm: Cross-arch compatible namespace alignment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 28 Feb 2020 11:17:46 -0800
Message-ID: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-kernel@vger.kernel.org,
 Jeff Moyer <jmoyer@redhat.com>, Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Changes since v2 [1]:
- Fix up a missing space in flags_show() (Jeff)

- Prompted by Jeff saying that v2 only worked for him if
  memremap_compat_align() returned PAGE_SIZE (which defeats the purpose)
  I developed a new ndctl unit test that runs through the possible
  legacy configurations that the kernel needs to support. Several changes
  fell out as a result:

  - Update nd_pfn_validate() to add more -EOPNOTSUPP cases. That error
    code indicates "Stop, the pfn looks coherent, but invalid. Do not
    proceed with exposing a raw namespace, require the user to
    investigate whether the infoblock needs to be rewritten, or the
    kernel configuration (like PAGE_SIZE) needs to change."

  - Move the validation of fsdax and devdax infoblocks to
    nd_pfn_validate() so that the presence of non-zero 'start_pad' and
    'end_trunc' can be considered in the alignment validation.

  - Fail namespace creation when the base address is misaligned. A
    non-zero-start_pad prevents dax operation due to original bug of
    ->data_offset being base address relative when it should have been
    ->start_pad relative. So, reject all base address misaligned
    namespaces in nd_pfn_init().

[1]: http://lore.kernel.org/r/158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com

---

Review / merge logistics notes:

Patch "libnvdimm/namespace: Enforce memremap_compat_align()" has
changed enough that it needs to be reviewed again.

Patch "mm/memremap_pages: Introduce memremap_compat_align()" still
needs a PowerPC maintainer ack for the touches to
arch/powerpc/mm/ioremap.c.

---

Aneesh reports that PowerPC requires 16MiB alignment for the address
range passed to devm_memremap_pages(), and Jeff reports that it is
possible to create a misaligned namespace which blocks future namespace
creation in that region. Both of these issues require namespace
alignment to be managed at the region level rather than padding at the
namespace level which has been a broken approach to date.

Introduce memremap_compat_align() to indicate the hard requirements of
an arch's memremap_pages() implementation. Use the maximum known
memremap_compat_align() to set the default namespace alignment for
libnvdimm. Consult that alignment when allocating free space. Finally,
allow the default region alignment to be overridden to maintain the same
namespace creation capability as previous kernels.

The ndctl unit tests, which have some misaligned namespace assumptions,
are updated to use the alignment override where necessary.

Thanks to Aneesh for early feedback and testing on this improved
alignment handling.

---

Dan Williams (5):
      mm/memremap_pages: Introduce memremap_compat_align()
      libnvdimm/pfn: Prevent raw mode fallback if pfn-infoblock valid
      libnvdimm/namespace: Enforce memremap_compat_align()
      libnvdimm/region: Introduce NDD_LABELING
      libnvdimm/region: Introduce an 'align' attribute


 arch/powerpc/Kconfig                      |    1 
 arch/powerpc/mm/ioremap.c                 |   21 +++++
 arch/powerpc/platforms/pseries/papr_scm.c |    2 
 drivers/acpi/nfit/core.c                  |    4 +
 drivers/nvdimm/dimm.c                     |    2 
 drivers/nvdimm/dimm_devs.c                |   95 +++++++++++++++++----
 drivers/nvdimm/namespace_devs.c           |   23 ++++-
 drivers/nvdimm/nd.h                       |    3 -
 drivers/nvdimm/pfn_devs.c                 |   34 ++++++-
 drivers/nvdimm/region_devs.c              |  132 ++++++++++++++++++++++++++---
 include/linux/libnvdimm.h                 |    2 
 include/linux/memremap.h                  |    8 ++
 include/linux/mmzone.h                    |    1 
 lib/Kconfig                               |    3 +
 mm/memremap.c                             |   23 +++++
 15 files changed, 307 insertions(+), 47 deletions(-)

base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
