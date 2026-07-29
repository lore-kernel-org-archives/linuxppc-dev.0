Return-Path: <linuxppc-dev+bounces-24956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E242DC54F52
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 01:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8vrd3kW2z2yjN;
	Wed, 29 Jul 2026 11:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785288577;
	cv=none; b=NPlvMy5TiFPubaCkAj8ASQCJGnpQZyhlbUtl7akoAG9oskrVQS/awySjQZM1r0qeV03iddI2RAOzF+/ZT0XNONbNeoHZcluE5miyCNe2sK19Rlcb+1v5gGxONKVxp1ZOQuJyUaqLlaENFpe19xINBM88XSmtPspz8rXqT9mKqvz6JBLaMb2qqVDZy537skg973fMAIoI/9iMN19+WYJK1d0+rWv+996XH1SAN1ItibJ8ML6gT5ARpNAvFdCyHDAwrw2kp+cWXyXEMsO0cok3iI7MNGyulNL1GIRWA/4cH38omQWP4a9xqvaJ9u18s43QbheSDK5rRbLXg4+kTdgq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785288577; c=relaxed/relaxed;
	bh=OO0ypjdKYokVu6bw2fqmTfjAg0MQ8faNrHl/+k53l9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmVi39VHZ2JU4i+zdWziviieLmMPOOuCvnsziwMTFXiI3Lb2rrpjDko56OxnOHixiHlPIdP/HWTs5ex9+qVrpz1Yy3lkLL7GDgyoMPWMvcsn+C2GV1LzcPhlZYnAqwyW444m5rinj/gzDL6IMY6NZEY9BfCE3motiFmorOpJxGm+3A+qOXHbeBERtnfQyeJjpvTkrBCdidt1b9kskUEtExT2ApO2VUwJmT5GMt5cbctvsJ45tmp1cnlbdZS57boRibFqMl8IfdvDlzlLBSHRbGbovOW2W7siwAsNpTmL+z7XqVhXlRj/JNi64kPvQGlfyG3AO0wsQ71rlQx9h59KOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=da4r6/rz; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=da4r6/rz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8vrb0HJdz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:29:32 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OO0ypjdKYokVu6bw2fqmTfjAg0MQ8faNrHl/+k53l9E=;
	b=da4r6/rzOYTyIusWWSVuZDqRxOOLpW6dZMINtWqUwZcZkn+ocXpFQkuHaVexY6d58xj7P2mYd
	4tdfXWd+vEFlIMMl0lY+tYx9Xgen5OkVB3eX5gerqHeJPa+s2GAXfg78rG8VNJNnovWR9Rn3Jg9
	v5T2r18FRcgPbQXduDmgNfg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8vdW21RlznTVx;
	Wed, 29 Jul 2026 09:19:59 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C11AC4057A;
	Wed, 29 Jul 2026 09:29:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 09:29:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <sourabhjain@linux.ibm.com>, <rppt@kernel.org>,
	<baoquan.he@linux.dev>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ritesh.list@gmail.com>, <bauerman@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/3] powerpc/kexec_file: Fix some bugs
Date: Wed, 29 Jul 2026 09:29:45 +0800
Message-ID: <20260729012948.2797865-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Fix some powerpc bugs pointed out by Sashiko AI:
- Memory leak
- Null-ptr-def
- Overlapping memory range truncation .

Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/

Changes in v2:
- Split Powerpc bugfix patch into this separate patch set.
- v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t

Jinjie Ruan (3):
  powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
  powerpc/kexec_file: Fix null-ptr-def in extra size calculation
  powerpc/kexec_file: Prevent kexec range truncation

 arch/powerpc/kexec/crash.c        |  2 +-
 arch/powerpc/kexec/file_load_64.c |  2 +-
 arch/powerpc/kexec/ranges.c       | 12 +++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.34.1


