Return-Path: <SRS0=T73o=BE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 09:11:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7732070B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 09:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7732070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BDL156p9rzF1LJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 19:11:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=weiyongjun1@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDKzB5VMvzDqb0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2020 19:10:13 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 30156A69D2BABADBC4C6;
 Sat, 25 Jul 2020 17:10:04 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 17:09:56 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Hulk Robot <hulkci@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, Dan Williams
 <dan.j.williams@intel.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, "Santosh
 Sivaraj" <santosh@fossix.org>
Subject: [PATCH -next] powerpc/papr_scm: Make some symbols static
Date: Sat, 25 Jul 2020 17:19:49 +0800
Message-ID: <20200725091949.75234-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
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
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yongjun <weiyongjun1@huawei.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sparse tool complains as follows:

arch/powerpc/platforms/pseries/papr_scm.c:97:1: warning:
 symbol 'papr_nd_regions' was not declared. Should it be static?
arch/powerpc/platforms/pseries/papr_scm.c:98:1: warning:
 symbol 'papr_ndr_lock' was not declared. Should it be static?

Those variables are not used outside of papr_scm.c, so this
commit marks them static.

Fixes: 85343a8da2d9 ("powerpc/papr/scm: Add bad memory ranges to nvdimm bad ranges")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 8fd441d32487..3d1235a76ba9 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -94,8 +94,8 @@ struct papr_scm_priv {
 	u64 health_bitmap;
 };
 
-LIST_HEAD(papr_nd_regions);
-DEFINE_MUTEX(papr_ndr_lock);
+static LIST_HEAD(papr_nd_regions);
+static DEFINE_MUTEX(papr_ndr_lock);
 
 static int drc_pmem_bind(struct papr_scm_priv *p)
 {

