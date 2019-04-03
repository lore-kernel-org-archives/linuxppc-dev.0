Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA5C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 12:55:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DCF20830
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 12:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ul68qe+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DCF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z5fJ1jfhzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 23:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="Ul68qe+l"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z5cJ4JKkzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 23:53:46 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33ChXe2100938;
 Wed, 3 Apr 2019 12:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NHT9PqacVbcb+iEdSEkiTY4KiJSA+ruLSKxJflNrU5g=;
 b=Ul68qe+lCVRnB8QxIbkSLnknGO8ENEkGNFXBYcdNdl49HLsfdL7wxQGQtZVnqZxRnrHt
 mOw3455ycB8dfibQLUWzKyx60JJCSBmHpcBd8VYj9vk2bbSpthszKkxhWxUTZJnAGavK
 pr4/QDDvWxsSiDFQVVmeOJosIbw4NG1hl3h29ap6VBUGtu4AgJxL1ckkTTdVXdrb+d1p
 EenRHGIcBO4W52S1FCoIoFgTJt9ubJ8eE8gg3I80gxVw3gHqLqHMSMscwfxVg73NczAP
 ZqEoI5ilfojmvKUJ5yhSJzowimyc801vAD377rzf4zdeBlXz+bPq9kcK211+i4ZEcpkV 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2rhyvt8swk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 12:51:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Co47M064129;
 Wed, 3 Apr 2019 12:51:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2rm8f52vra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 12:51:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33CpEC3031705;
 Wed, 3 Apr 2019 12:51:15 GMT
Received: from [10.152.35.85] (/10.152.35.85)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 03 Apr 2019 05:51:14 -0700
Subject: Re: [PATCH 0/6] convert locked_vm from unsigned long to atomic64_t
To: Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
Date: Wed, 3 Apr 2019 08:51:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030088
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux_lkml_grp@oracle.com,
 kvm@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/2/2019 4:41 PM, Daniel Jordan wrote:
> Hi,
> 
> From patch 1:
> 
>   Taking and dropping mmap_sem to modify a single counter, locked_vm, is
>   overkill when the counter could be synchronized separately.
>   
>   Make mmap_sem a little less coarse by changing locked_vm to an atomic,
>   the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> This is a more conservative alternative to [1] with no user-visible
> effects.  Thanks to Alexey Kardashevskiy for pointing out the racy
> atomics and to Alex Williamson, Christoph Lameter, Ira Weiny, and Jason
> Gunthorpe for their comments on [1].
> 
> Davidlohr Bueso recently did a similar conversion for pinned_vm[2].
> 
> Testing
>  1. passes LTP mlock[all], munlock[all], fork, mmap, and mremap tests in an
>     x86 kvm guest
>  2. a VFIO-enabled x86 kvm guest shows the same VmLck in
>     /proc/pid/status before and after this change
>  3. cross-compiles on powerpc
> 
> The series is based on v5.1-rc3.  Please consider for 5.2.
> 
> Daniel
> 
> [1] https://lore.kernel.org/linux-mm/20190211224437.25267-1-daniel.m.jordan@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20190206175920.31082-1-dave@stgolabs.net/
> 
> Daniel Jordan (6):
>   mm: change locked_vm's type from unsigned long to atomic64_t
>   vfio/type1: drop mmap_sem now that locked_vm is atomic
>   vfio/spapr_tce: drop mmap_sem now that locked_vm is atomic
>   fpga/dlf/afu: drop mmap_sem now that locked_vm is atomic
>   powerpc/mmu: drop mmap_sem now that locked_vm is atomic
>   kvm/book3s: drop mmap_sem now that locked_vm is atomic
> 
>  arch/powerpc/kvm/book3s_64_vio.c    | 34 ++++++++++--------------
>  arch/powerpc/mm/mmu_context_iommu.c | 28 +++++++++-----------
>  drivers/fpga/dfl-afu-dma-region.c   | 40 ++++++++++++-----------------
>  drivers/vfio/vfio_iommu_spapr_tce.c | 37 ++++++++++++--------------
>  drivers/vfio/vfio_iommu_type1.c     | 31 +++++++++-------------
>  fs/proc/task_mmu.c                  |  2 +-
>  include/linux/mm_types.h            |  2 +-
>  kernel/fork.c                       |  2 +-
>  mm/debug.c                          |  5 ++--
>  mm/mlock.c                          |  4 +--
>  mm/mmap.c                           | 18 ++++++-------
>  mm/mremap.c                         |  6 ++---
>  12 files changed, 89 insertions(+), 120 deletions(-)
> 
> base-commit: 79a3aaa7b82e3106be97842dedfd8429248896e6

Hi Daniel,
  You could clean all 6 patches up nicely with a common subroutine that
increases locked_vm subject to the rlimit.  Pass a bool arg that is true if
the  limit should be enforced, !dma->lock_cap for one call site, and
!capable(CAP_IPC_LOCK) for the rest.  Push the warnings and debug statements
to the subroutine as well.  One patch could refactor, and a second could
change the locking method.

- Steve
