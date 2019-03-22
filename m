Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE6AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4682190A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ETh0Q+H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4682190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QySr5TH9zDqRm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 09:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="ETh0Q+H5"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QyR51XbyzDqQR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 09:06:08 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id w18so5851990itj.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zPnyPNGnsO/md2Fj5yEAI9x91Hz7J9uO8l7Sk2KMvIo=;
 b=ETh0Q+H5NErnf+anAIeNX89EpJjpuFOFrGA549zU6YNjyodAclghZqMAQhCYHmsdpr
 VBr/q0cU6fGUQZpceBNwr0M+bLWwnpat9RsFa50fk6EH+Ej3wT3fiVBe0lVTwTugrloo
 iFU6UFQ36JWbIMUYlh8YNEcsGoj838Wu1icdiWs1qphTBfThMQQSRXpaXXYbY3iRIz+R
 okhh/FvQVRXB/Q8a7q6XyZrBKwLnS/7Qc7BIuqBvFeFzP4QdI3IylwYJd+W54gfYHbbY
 V3ldQH0uIH3yxe3qtmId36/CRAoD48vcD7efQl3U/JsBsrDrQh+HlYfRz2uDtxUe2MaL
 raAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zPnyPNGnsO/md2Fj5yEAI9x91Hz7J9uO8l7Sk2KMvIo=;
 b=NFL6J8Dqm6f2kLBu5bQN2qGtmU5SmOusM0B8D/b4NRB6HeggmqeXqPIqKHyFgG1FpN
 a/GyKVGVrvpOuma5NOm28MSnrI3bMdiRl4dPhwWDYxqIcN2U/CP9uVpCHVCRbCGMPblK
 gow2ij9So3AWM2raisDKFJGtjn65U0+Kio+4hiVRpvklQTOx1DkhLTlWQH4J74kK8IkQ
 CD+KwXy9ppIIUkPqoKgNQM/0sRuO/STfj+OL3NRLg8UMelaG92GAEO/5JQAZS6054mrH
 fvC9zO8VRD0BHmqKWjOh5Kxu7dNdVMt3fhzLm6oEYwBdH+8G2Jngy816giTmKjGvGtTf
 sxew==
X-Gm-Message-State: APjAAAW8Oy6GKCkhhkuc5u4F56FwdNLYmfnBT8F8v8WR7ULfmXxX+FQf
 kpgI0hOXXsx7fN7tW6+a+/H60UcUBl9ecaMAOUQ=
X-Google-Smtp-Source: APXvYqzvkOUTluGSKTjETBKJlQ9d9U0bafaXjVPDo287WeJSv03XpVRn3tgZfH8AGEVriQsCe7Tjp8XH5gu+GSmr/AQ=
X-Received: by 2002:a24:298b:: with SMTP id p133mr3554913itp.43.1553292365179; 
 Fri, 22 Mar 2019 15:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-4-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-4-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Mar 2019 15:05:53 -0700
Message-ID: <CAA9_cmd9gUWMbpkP_AuxZ08iqvZdxjbtDoR-FpSjAyhZJisRZA@mail.gmail.com>
Subject: Re: [RESEND 3/7] mm/gup: Change GUP fast to use flags rather than a
 write 'bool'
To: ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> To facilitate additional options to get_user_pages_fast() change the
> singular write parameter to be gup_flags.
>
> This patch does not change any functionality.  New functionality will
> follow in subsequent patches.
>
> Some of the get_user_pages_fast() call sites were unchanged because they
> already passed FOLL_WRITE or 0 for the write parameter.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes from V1:
>         Rebase to current merge tree
>         arch/powerpc/mm/mmu_context_iommu.c no longer calls gup_fast
>                 The gup_longterm was converted in patch 1
>
>  arch/mips/mm/gup.c                         | 11 ++++++-----
>  arch/powerpc/kvm/book3s_64_mmu_hv.c        |  4 ++--
>  arch/powerpc/kvm/e500_mmu.c                |  2 +-
>  arch/s390/kvm/interrupt.c                  |  2 +-
>  arch/s390/mm/gup.c                         | 12 ++++++------
>  arch/sh/mm/gup.c                           | 11 ++++++-----
>  arch/sparc/mm/gup.c                        |  9 +++++----
>  arch/x86/kvm/paging_tmpl.h                 |  2 +-
>  arch/x86/kvm/svm.c                         |  2 +-
>  drivers/fpga/dfl-afu-dma-region.c          |  2 +-
>  drivers/gpu/drm/via/via_dmablit.c          |  3 ++-
>  drivers/infiniband/hw/hfi1/user_pages.c    |  3 ++-
>  drivers/misc/genwqe/card_utils.c           |  2 +-
>  drivers/misc/vmw_vmci/vmci_host.c          |  2 +-
>  drivers/misc/vmw_vmci/vmci_queue_pair.c    |  6 ++++--
>  drivers/platform/goldfish/goldfish_pipe.c  |  3 ++-
>  drivers/rapidio/devices/rio_mport_cdev.c   |  4 +++-
>  drivers/sbus/char/oradax.c                 |  2 +-
>  drivers/scsi/st.c                          |  3 ++-
>  drivers/staging/gasket/gasket_page_table.c |  4 ++--
>  drivers/tee/tee_shm.c                      |  2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c        |  3 ++-
>  drivers/vhost/vhost.c                      |  2 +-
>  drivers/video/fbdev/pvr2fb.c               |  2 +-
>  drivers/virt/fsl_hypervisor.c              |  2 +-
>  drivers/xen/gntdev.c                       |  2 +-
>  fs/orangefs/orangefs-bufmap.c              |  2 +-
>  include/linux/mm.h                         |  4 ++--
>  kernel/futex.c                             |  2 +-
>  lib/iov_iter.c                             |  7 +++++--
>  mm/gup.c                                   | 10 +++++-----
>  mm/util.c                                  |  8 ++++----
>  net/ceph/pagevec.c                         |  2 +-
>  net/rds/info.c                             |  2 +-
>  net/rds/rdma.c                             |  3 ++-
>  35 files changed, 79 insertions(+), 63 deletions(-)


>
> diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
> index 0d14e0d8eacf..4c2b4483683c 100644
> --- a/arch/mips/mm/gup.c
> +++ b/arch/mips/mm/gup.c
> @@ -235,7 +235,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>   * get_user_pages_fast() - pin user pages in memory
>   * @start:     starting user address
>   * @nr_pages:  number of pages from start to pin
> - * @write:     whether pages will be written to
> + * @gup_flags: flags modifying pin behaviour
>   * @pages:     array that receives pointers to the pages pinned.
>   *             Should be at least nr_pages long.
>   *
> @@ -247,8 +247,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>   * requested. If nr_pages is 0 or negative, returns 0. If no pages
>   * were pinned, returns -errno.
>   */
> -int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> -                       struct page **pages)
> +int get_user_pages_fast(unsigned long start, int nr_pages,
> +                       unsigned int gup_flags, struct page **pages)

This looks a tad scary given all related thrash especially when it's
only 1 user that wants to do get_user_page_fast_longterm, right? Maybe
something like the following. Note I explicitly moved the flags to the
end so that someone half paying attention that calls
__get_user_pages_fast will get a compile error if they specify the
args in the same order.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 76ba638ceda8..c6c743bc2c68 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1505,8 +1505,15 @@ static inline long
get_user_pages_longterm(unsigned long start,
 }
 #endif /* CONFIG_FS_DAX */

-int get_user_pages_fast(unsigned long start, int nr_pages, int write,
-                       struct page **pages);
+
+int __get_user_pages_fast(unsigned long start, int nr_pages,
+               struct page **pages, unsigned int gup_flags);
+
+static inline int get_user_pages_fast(unsigned long start, int
nr_pages, int write,
+                       struct page **pages)
+{
+       return __get_user_pages_fast(start, nr_pages, pages, write ?
FOLL_WRITE);
+}

 /* Container for pinned pfns / pages */
 struct frame_vector {
