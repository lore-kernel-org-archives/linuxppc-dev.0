Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5AFC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:50:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390652184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSPA45Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390652184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1Fs2f9FzDqYS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="dSPA45Xd"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z19H3xxvzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 09:46:11 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BMhVEI072777;
 Mon, 11 Feb 2019 22:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=Phi3yo5tGmVy0t3cuMS6IWQIWpdGP9aDbdf7nHYEaVU=;
 b=dSPA45Xdtxu6Z+Dit8MpYT+2EEXMoS2OYxCbo5qFygIAgtfMhwLWimjbpu6roq5OhjY0
 03EpjfiBvqMwMfBMAp57e7VJmclU/as0otGXzAMM9YUcv+18kFe47aLQCFGzYOfJtTsN
 2MzrrXcXLndV08bOkKsdZZczHP55rAI/s8yGOF9TsHEBordy7zWJ8ENOV2m4ty+cOmrn
 4kJtoz4bF9VbZrTThQvL7M4pxrEoKkxLVAnDpWllM4KoL6/nlkO6zRcQ89Z2niBYKWDZ
 VxijvUlOImfGrr2tI3Q0cDnpVui5UCSEL4Ha1M8N0cM7IZm9fpGzvzNg5aZRDtxLXgjt 8Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2130.oracle.com with ESMTP id 2qhrek8q7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1BMimFO012607
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:48 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BMih6b013811;
 Mon, 11 Feb 2019 22:44:43 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 14:44:43 -0800
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: jgg@ziepe.ca
Subject: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:32 -0500
Message-Id: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110162
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, daniel.m.jordan@oracle.com, linux-mm@kvack.org,
 alex.williamson@redhat.com, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

This series converts users that account pinned pages with locked_vm to
account with pinned_vm instead, pinned_vm being the correct counter to
use.  It's based on a similar patch I posted recently[0].

The patches are based on rdma/for-next to build on Davidlohr Bueso's
recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
sense for these to be routed the same way, despite lack of rdma content?

All five of these places, and probably some of Davidlohr's conversions,
probably want to be collapsed into a common helper in the core mm for
accounting pinned pages.  I tried, and there are several details that
likely need discussion, so this can be done as a follow-on.

I'd appreciate a look at patch 5 especially since the accounting is
unusual no matter whether locked_vm or pinned_vm are used.

On powerpc, this was cross-compile tested only.

[0] http://lkml.kernel.org/r/20181105165558.11698-8-daniel.m.jordan@oracle.com
[1] http://lkml.kernel.org/r/20190206175920.31082-1-dave@stgolabs.net

Daniel Jordan (5):
  vfio/type1: use pinned_vm instead of locked_vm to account pinned pages
  vfio/spapr_tce: use pinned_vm instead of locked_vm to account pinned
    pages
  fpga/dlf/afu: use pinned_vm instead of locked_vm to account pinned
    pages
  powerpc/mmu: use pinned_vm instead of locked_vm to account pinned
    pages
  kvm/book3s: use pinned_vm instead of locked_vm to account pinned pages

 Documentation/vfio.txt              |  6 +--
 arch/powerpc/kvm/book3s_64_vio.c    | 35 +++++++---------
 arch/powerpc/mm/mmu_context_iommu.c | 43 ++++++++++---------
 drivers/fpga/dfl-afu-dma-region.c   | 50 +++++++++++-----------
 drivers/vfio/vfio_iommu_spapr_tce.c | 64 ++++++++++++++---------------
 drivers/vfio/vfio_iommu_type1.c     | 31 ++++++--------
 6 files changed, 104 insertions(+), 125 deletions(-)

-- 
2.20.1

