Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADFC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:21:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9132084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3dhzuKoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9132084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YkFM5bHrzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="3dhzuKoW"; 
 dkim-atps=neutral
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YkCY3qw7zDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 09:19:37 +1100 (AEDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32Kd3B7163968;
 Tue, 2 Apr 2019 20:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=80amkJDfmO8rQR51MIz8k/sRGV6h3aL7PZ9G0VgPgaI=;
 b=3dhzuKoWxKS942ub9epZAEYv9lHvjtSKguDUksCdLymSkrm4017tbZP/McvSHb7vgphg
 HG1QB1Mh/DUs2M5kG4NtQfn/NpSXSuW/JfOB9deJC8CuMJJ6BXSKb4Dc9r/dk4bYPbkq
 P/R8IH1neNmPTMdwZ4cjHRaRJeCuYXwP8IRNDyEQHjd6RFituOicmQsVLgc6AzvOXMZ2
 073tkjOQNg/UWN0G0z2uEi3ss0M9iEeF0pZfTmw0omvIW/7BX9PB9k1EJnV7GNRcOyGz
 bftpAc2WL/XOoenSSKb/on4FvPH4QftOeOijD0L4mkW56CTL89av5zBJx06UQWAi81s4 +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2rj0dnkyvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:42:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KfG0w064769;
 Tue, 2 Apr 2019 20:42:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2rm8f4yjxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:42:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32Kg9r8029935;
 Tue, 2 Apr 2019 20:42:09 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Apr 2019 13:42:09 -0700
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: akpm@linux-foundation.org
Subject: [PATCH 0/6] convert locked_vm from unsigned long to atomic64_t
Date: Tue,  2 Apr 2019 16:41:52 -0400
Message-Id: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020138
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org,
 Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, daniel.m.jordan@oracle.com, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

From patch 1:

  Taking and dropping mmap_sem to modify a single counter, locked_vm, is
  overkill when the counter could be synchronized separately.
  
  Make mmap_sem a little less coarse by changing locked_vm to an atomic,
  the 64-bit variety to avoid issues with overflow on 32-bit systems.

This is a more conservative alternative to [1] with no user-visible
effects.  Thanks to Alexey Kardashevskiy for pointing out the racy
atomics and to Alex Williamson, Christoph Lameter, Ira Weiny, and Jason
Gunthorpe for their comments on [1].

Davidlohr Bueso recently did a similar conversion for pinned_vm[2].

Testing
 1. passes LTP mlock[all], munlock[all], fork, mmap, and mremap tests in an
    x86 kvm guest
 2. a VFIO-enabled x86 kvm guest shows the same VmLck in
    /proc/pid/status before and after this change
 3. cross-compiles on powerpc

The series is based on v5.1-rc3.  Please consider for 5.2.

Daniel

[1] https://lore.kernel.org/linux-mm/20190211224437.25267-1-daniel.m.jordan@oracle.com/
[2] https://lore.kernel.org/linux-mm/20190206175920.31082-1-dave@stgolabs.net/

Daniel Jordan (6):
  mm: change locked_vm's type from unsigned long to atomic64_t
  vfio/type1: drop mmap_sem now that locked_vm is atomic
  vfio/spapr_tce: drop mmap_sem now that locked_vm is atomic
  fpga/dlf/afu: drop mmap_sem now that locked_vm is atomic
  powerpc/mmu: drop mmap_sem now that locked_vm is atomic
  kvm/book3s: drop mmap_sem now that locked_vm is atomic

 arch/powerpc/kvm/book3s_64_vio.c    | 34 ++++++++++--------------
 arch/powerpc/mm/mmu_context_iommu.c | 28 +++++++++-----------
 drivers/fpga/dfl-afu-dma-region.c   | 40 ++++++++++++-----------------
 drivers/vfio/vfio_iommu_spapr_tce.c | 37 ++++++++++++--------------
 drivers/vfio/vfio_iommu_type1.c     | 31 +++++++++-------------
 fs/proc/task_mmu.c                  |  2 +-
 include/linux/mm_types.h            |  2 +-
 kernel/fork.c                       |  2 +-
 mm/debug.c                          |  5 ++--
 mm/mlock.c                          |  4 +--
 mm/mmap.c                           | 18 ++++++-------
 mm/mremap.c                         |  6 ++---
 12 files changed, 89 insertions(+), 120 deletions(-)


base-commit: 79a3aaa7b82e3106be97842dedfd8429248896e6
-- 
2.21.0

