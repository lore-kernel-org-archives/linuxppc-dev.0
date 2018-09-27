Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B00C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FD62172E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Zlle0pq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FD62172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lrpd3mRZzF395
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 09:38:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="Zlle0pq8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="Zlle0pq8"; 
 dkim-atps=neutral
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lrbm1QZhzF38p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 09:28:51 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bad66770000>; Thu, 27 Sep 2018 16:23:35 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 27 Sep 2018 16:23:33 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 27 Sep 2018 16:23:33 -0700
Received: from localhost.localdomain (10.110.48.80) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 23:23:33 +0000
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc/powernv/npu: Improve ATSD invalidation overhead
Date: Thu, 27 Sep 2018 16:23:08 -0700
Message-ID: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
X-Mailer: git-send-email 1.7.2.5
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.110.48.80]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1538090615; bh=XMaMhGCl9cW2972vYUJdhP0Xwi04kCydHLAGOfrMKnY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:X-Originating-IP:
 X-ClientProxiedBy:Content-Type;
 b=Zlle0pq8+dDXAcdr4j+tr1FLr5T75FGgopUZ1XZIZwWci+Q1S/w2KdFHCEvgK4vAn
 OGRGvu4SYmd7SQm57qMxxi0K9Ph2p0QQXBQitckYmdxzfWOst8HxydJMuPuTY98Fa9
 0q/h1A9a1IBtgQx+Gwf8hAzEP8Cnx+sG2/gE4B1MFpGtlBhQC2IKxzGmZMI3hih4Q4
 3bjoVNHfs9MV3C6QkwGMye6lz4npNtS9KGv4WNIO6BICaB7reFMaD3JROhtQwJI2QL
 2T8LzBSu+YaES1Cjr6KEyetwgOfYI+nfOeaQYBjxteS2TMuEdQ353v5zjrQrO9C++n
 Rgg6Kw8Mb99CA==
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When ATS is used in a process, all CPU TLB invalidates in that process
also trigger ATSD invalidates via mmu_notifiers. This additional overhead
is noticeable in applications which do heavy memory allocation or page
migration among nodes, particularly to and from GPUs.

This patch set reduces that overhead by rearranging how the ATSDs are
issued and by using size-based ATSD invalidates.

Mark Hairgrove (3):
  powerpc/powernv/npu: Reduce eieio usage when issuing ATSD invalidates
  powerpc/powernv/npu: Use size-based ATSD invalidates
  powerpc/powernv/npu: Remove atsd_threshold debugfs setting

 arch/powerpc/platforms/powernv/npu-dma.c |  177 ++++++++++++++---------------
 1 files changed, 85 insertions(+), 92 deletions(-)

-- 
1.7.2.5

