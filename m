Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC1C432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 22:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B822072A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="GZ2V7+gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B822072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47FCzl1wVKzF6BM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 09:42:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yadro.com (client-ip=89.207.88.252; helo=mta-01.yadro.com;
 envelope-from=r.bolshakov@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="GZ2V7+gb"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F2LX0zfczF6Pr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2019 02:28:32 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 512BD42F13;
 Fri, 15 Nov 2019 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-disposition:content-type:content-type:mime-version
 :message-id:subject:subject:from:from:date:date:received
 :received:received; s=mta-01; t=1573831707; x=1575646108; bh=5I0
 qlFsD/6qkO9Q90l8beRR+HsrAVuvuSVaE8ni23ok=; b=GZ2V7+gbAnd/v1SDSoV
 gQk++PjHQNZc3n/xLqJu05ZiRulN2ha1ZNK77RrIwxwCsK1iWYAw4Qt653ygQeGu
 ZuTk/6vGCSEqXPorD1LPciYomJqsB/reqgV/lsF2WDXPcaRRK8WM+uJTW4OFq6wz
 6Jv7WlxdVUQfhpx7Z/aOiwa0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWmDexcDP9pg; Fri, 15 Nov 2019 18:28:27 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id E325642A6D;
 Fri, 15 Nov 2019 18:28:26 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 15
 Nov 2019 18:28:26 +0300
Date: Fri, 15 Nov 2019 18:28:26 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Subject: HPT allocation failures on POWER8 KVM hosts
Message-ID: <20191115152826.hvcu3borgx4hp275@SPB-NB-133.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-Mailman-Approved-At: Sat, 16 Nov 2019 09:41:08 +1100
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
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Aneesh,

We're running a lot of KVM virtual machines on POWER8 hosts and
sometimes new VMs can't be started because there are no contiguous
regions for HPT because of CMA region fragmentation.

The issue is covered in the LWN article: https://lwn.net/Articles/684611/
The article points that you raised the problem on LSFMM 2016. However I
couldn't find a follow up article on the issue.

Looking at the kernel commit log I've identified a few commits that
might reduce CMA fragmentaiton and overcome HPT allocation failure:
  - bd2e75633c801 ("dma-contiguous: use fallback alloc_pages for single pages")
  - 678e174c4c16a ("powerpc/mm/iommu: allow migration of cma allocated
    pages during mm_iommu_do_alloc")
  - 9a4e9f3b2d739 ("mm: update get_user_pages_longterm to migrate pages allocated from
    CMA region")
  - d7fefcc8de914 ("mm/cma: add PF flag to force non cma alloc")

Are there any other commits that address the issue? What is the first
kernel version that shouldn't have the HPT allocation problem due to CMA
fragmentation?

Thank you,
Roman
