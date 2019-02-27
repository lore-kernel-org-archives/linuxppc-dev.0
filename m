Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E089C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 19:16:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB282133D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 19:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB282133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448llr6mhQzDqNH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 06:16:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448ljt4dTWzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 06:14:35 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2019 11:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; d="scan'208";a="150535022"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2019 11:14:31 -0800
Date: Wed, 27 Feb 2019 11:14:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>
Subject: Re: [RESEND PATCH 0/7] Add FOLL_LONGTERM to GUP fast and use it
Message-ID: <20190227191442.GB31669@iweiny-DESK2.sc.intel.com>
References: <20190220053040.10831-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220053040.10831-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-fpga@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, xen-devel@lists.xenproject.org,
 devel@lists.orangefs.org, linux-media@vger.kernel.org, kvm-ppc@vger.kernel.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 19, 2019 at 09:30:33PM -0800, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Resending these as I had only 1 minor comment which I believe we have covered
> in this series.  I was anticipating these going through the mm tree as they
> depend on a cleanup patch there and the IB changes are very minor.  But they
> could just as well go through the IB tree.
> 
> NOTE: This series depends on my clean up patch to remove the write parameter
> from gup_fast_permitted()[1]
> 
> HFI1, qib, and mthca, use get_user_pages_fast() due to it performance
> advantages.  These pages can be held for a significant time.  But
> get_user_pages_fast() does not protect against mapping of FS DAX pages.
> 
> Introduce FOLL_LONGTERM and use this flag in get_user_pages_fast() which
> retains the performance while also adding the FS DAX checks.  XDP has also
> shown interest in using this functionality.[2]
> 
> In addition we change get_user_pages() to use the new FOLL_LONGTERM flag and
> remove the specialized get_user_pages_longterm call.
> 
> [1] https://lkml.org/lkml/2019/2/11/237
> [2] https://lkml.org/lkml/2019/2/11/1789

Is there anything I need to do on this series or does anyone have any
objections to it going into 5.1?  And if so who's tree is it going to go
through?

Thanks,
Ira

> 
> Ira Weiny (7):
>   mm/gup: Replace get_user_pages_longterm() with FOLL_LONGTERM
>   mm/gup: Change write parameter to flags in fast walk
>   mm/gup: Change GUP fast to use flags rather than a write 'bool'
>   mm/gup: Add FOLL_LONGTERM capability to GUP fast
>   IB/hfi1: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
>   IB/qib: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
>   IB/mthca: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
> 
>  arch/mips/mm/gup.c                          |  11 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c         |   4 +-
>  arch/powerpc/kvm/e500_mmu.c                 |   2 +-
>  arch/powerpc/mm/mmu_context_iommu.c         |   4 +-
>  arch/s390/kvm/interrupt.c                   |   2 +-
>  arch/s390/mm/gup.c                          |  12 +-
>  arch/sh/mm/gup.c                            |  11 +-
>  arch/sparc/mm/gup.c                         |   9 +-
>  arch/x86/kvm/paging_tmpl.h                  |   2 +-
>  arch/x86/kvm/svm.c                          |   2 +-
>  drivers/fpga/dfl-afu-dma-region.c           |   2 +-
>  drivers/gpu/drm/via/via_dmablit.c           |   3 +-
>  drivers/infiniband/core/umem.c              |   5 +-
>  drivers/infiniband/hw/hfi1/user_pages.c     |   5 +-
>  drivers/infiniband/hw/mthca/mthca_memfree.c |   3 +-
>  drivers/infiniband/hw/qib/qib_user_pages.c  |   8 +-
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |   2 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |   9 +-
>  drivers/media/v4l2-core/videobuf-dma-sg.c   |   6 +-
>  drivers/misc/genwqe/card_utils.c            |   2 +-
>  drivers/misc/vmw_vmci/vmci_host.c           |   2 +-
>  drivers/misc/vmw_vmci/vmci_queue_pair.c     |   6 +-
>  drivers/platform/goldfish/goldfish_pipe.c   |   3 +-
>  drivers/rapidio/devices/rio_mport_cdev.c    |   4 +-
>  drivers/sbus/char/oradax.c                  |   2 +-
>  drivers/scsi/st.c                           |   3 +-
>  drivers/staging/gasket/gasket_page_table.c  |   4 +-
>  drivers/tee/tee_shm.c                       |   2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c         |   3 +-
>  drivers/vfio/vfio_iommu_type1.c             |   3 +-
>  drivers/vhost/vhost.c                       |   2 +-
>  drivers/video/fbdev/pvr2fb.c                |   2 +-
>  drivers/virt/fsl_hypervisor.c               |   2 +-
>  drivers/xen/gntdev.c                        |   2 +-
>  fs/orangefs/orangefs-bufmap.c               |   2 +-
>  include/linux/mm.h                          |  17 +-
>  kernel/futex.c                              |   2 +-
>  lib/iov_iter.c                              |   7 +-
>  mm/gup.c                                    | 220 ++++++++++++--------
>  mm/gup_benchmark.c                          |   5 +-
>  mm/util.c                                   |   8 +-
>  net/ceph/pagevec.c                          |   2 +-
>  net/rds/info.c                              |   2 +-
>  net/rds/rdma.c                              |   3 +-
>  44 files changed, 232 insertions(+), 180 deletions(-)
> 
> -- 
> 2.20.1
> 
