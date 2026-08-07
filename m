Return-Path: <linuxppc-dev+bounces-25575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85585C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:46:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkR21h4fz3c7S;
	Fri, 07 Aug 2026 22:46:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073575;
	cv=none; b=DQuEfGeJknQCkuZflFP6bK1YXSx9GOgido9Ed6PX5aKfrS0pdhAh0HSK0p9uQeU4Y/9Tvf0nJksFhz4Q43DRUgNPK2uFAWyPYNTD944Fs9WWj3uziRAj2sYi2WuMg1xzphZspPXdF50H/R7NKKmGfSWYY4X2CBxgGuHlWLvdFp6HuFDnFN+fVgjYuWtRJFaHug5ZNFdvwhlnDfX7T8DRpXAPTvgZzf8IQU3PbRsnNzptvXi8QCeI4IldTM4EWc5+2ApFJpSq1Bxb216Y5DllA8iZZD1Cju82G/B0vWuFleMGM0hg4PAcbmZI/hjt7i1ZKCbAwBwOXaAiEfmvSHV41A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073575; c=relaxed/relaxed;
	bh=kQutZscQgfVs9oLrj7b6tlQLkreXpevbZpVL525toic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jsc00k3NzaRb9m+T6ZJx1nSPArIyefZxv/WBW/c3NuejyB6xe2m4GYIDcUZfiufuYEZZ7BDZoB76V4ntyMph30lJlPPwzi6tNkhBOgR63j1ps9M239P1HDfCd2Ck8aGCEmuY3K2eO4l15m6AdqjEfOeMDo3eEH2j/o1NNwWZz+g7KxTNG0Pnzuj4xtx6IAURMd+pQz+J7+JplpdC7R1+Fi/o2B65hYHKA8Mhdk5jlUw51uwWaJyqNVws3Mvu2pURr/VHklKnAanDRN9s2kTjCQHltJhC/psSm+VCTBPIhAzqHky4PmeSkiO5o5/gaYR2j0+VJAEKVziWHGUmx66wLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV8g6bLkz3bww
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:32:51 +1000 (AEST)
X-UUID: 7a50bbfc921011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4ffe52b2-c9d2-4a82-8f95-d7f12485106e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:da1f8b0372836705dd0ef92178018158,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a50bbfc921011f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 209916283; Fri, 07 Aug 2026 11:31:29 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/4] powerpc: assorted fixes (gpci, imc, energy, iommu)
Date: Fri, 07 Aug 2026 11:11:14 +0800
Message-ID: <cover.1786072274.git.liuxixin@kylinos.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi,

This series fixes some bugs in powerpc paths found by static review
of linux-next:

  1) hv-gpci sysfs hex formatting can overflow the PAGE_SIZE show
     buffer; switch to sysfs_emit_at() and return -EFBIG
  2) opal-imc debugfs names use char[16] with sprintf for a u32 id
  3) pseries energy walks H_BEST_ENERGY cnt and sprintf()s without
     page bounds
  4) iommu debugfs uses char[10] with %08lx while it_index is
     unsigned long

Patches are independent. Please review.

Thanks,
Xixin Liu

---

Xixin Liu (4):
  powerpc/perf: hv-gpci: bound sysfs hex formatting to PAGE_SIZE
  powerpc/powernv: opal-imc: fix debugfs name buffer size
  powerpc/pseries: energy: bound H_BEST_ENERGY cnt and sysfs output
  powerpc/iommu: fix debugfs name buffer for 64-bit it_index

 arch/powerpc/kernel/iommu.c                     |  9 +++--
 arch/powerpc/perf/hv-gpci.c                     | 77 +++++++++++++++---------
 arch/powerpc/platforms/powernv/opal-imc.c       |  7 +++--
 arch/powerpc/platforms/pseries/pseries_energy.c | 16 ++++-
 4 files changed, 75 insertions(+), 34 deletions(-)

-- 
2.43.0


