Return-Path: <linuxppc-dev+bounces-24726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79420C531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:59:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5WRL2mb5z2yVZ;
	Thu, 23 Jul 2026 22:59:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784795184;
	cv=none; b=XdLLS2CAq1uGbAf7lSNMJUsSFmeDWFKwaJKhNQbPDJ9rzaJG2xL34OjvBFzUCVZcMDXgcPj/ujhk3JD2xvx54gmwyiNrEPu6+inqIVqORc4JMSuAJhEZsIWOzU/X0nWsb+oBb+/WHm4a91pRJ+GKnfV+k0aydajPhdc6UdWH9vqDcpoJsfUo/362GFyUOC2cUV94adQtwTQQt6L60NhTOpRwmYf3meRB6wGyBt8YQR0h1Gw3avFdOirOCuw44ANEBrgjKPiWODGYQr38yID1uVu0GBqoICgO9HBejjc23wW789fFXFX7CRP5vEvBxPJRfmyC7HJhzzyIDFB+GeCRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784795184; c=relaxed/relaxed;
	bh=e6BVBwF2oSnNk0Jyon9PloP7eEkl7Bfr8eX/NbegyP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k08dcyIaklV3IBMik2RK04lAT3E5Kfnq9jzkbCbZXKlaY+bDdA3TaH5bGff2TTYw/zzc9sYQgWuuY37zakZxTqYkJIf/bvGV61z91v7KX//lTW596XODY2+IxSk8FxqZ+IzhHsIAgzAOKNW+u8eLiuvFSH90Y3Z0LfXf37itadSyuUi5CgT6Ei5uYHQFCkv98stPZl3YgV3knonNTvuvKuz4D6/Bxn+SGovVN1UZ6OnhmsasWN5QgoCWU0gudXc73Cd+HLYSu42yHi+uke/v7Se2tjf2ao3/lFctJNnZQrcCv8MSy6jm/UDxXfggWUnBLqXLPPHZFxJAdGvY1fpPRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=i+ls9Mc2; dkim-atps=neutral; spf=pass (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=i+ls9Mc2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 376 seconds by postgrey-1.37 at boromir; Thu, 23 Jul 2026 18:26:19 AEST
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5PNC6LS2z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 18:26:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784795144;
	bh=e6BVBwF2oSnNk0Jyon9PloP7eEkl7Bfr8eX/NbegyP0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=i+ls9Mc2HrvDgyAEynEuy0u/RN5b07G14pa+YtgMkYUPbEldUk/z9t+2xiBCFTBXb
	 HSI7SNUr02GOwOjRM44oyrLqpfha8+XVkRbrYfFqMihsyH9u5jBdcCMGRAJAbowPP+
	 VsYejWsJMa8Qwd1xiiCRZgVEdIH2CkWH6Ym2yYeo=
X-QQ-mid: zesmtpip2t1784794697t42615382
X-QQ-Originating-IP: NWrmr4ibVq33NqKXMPStiRl7JDz4LdgCYIBewkjnVFM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 16:18:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6575503778562141203
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	ynorov@nvidia.com,
	namcao@linutronix.de,
	mkchauras@gmail.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH 0/4] remove dead NULL checks after GFP_NOFAIL allocations
Date: Thu, 23 Jul 2026 16:18:09 +0800
Message-Id: <20260723081813.176792-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NMB3uNxca02m93879V3HllBfmWcx5BuPQBHnSrzXePSMCJdzhmff3WFG
	E6cj+fXzrNE9uDOXP+UUChIk3uRlvv4HfXR4jcABuYTSj79h9pyipWrm3b4lPQ0sy1ynFsD
	B9E19ZL0zrtPJVP7qe+45e9RUEORHNKpLLTbX9FGBGHYTkVlGdW3stBnzI+vBr26Cb1hyuz
	9GcQbbzHcpjSysrR57uNRl5M8j729whSIRZ/wYhaH+MOakM8TWA6CotpNRsSE93hcY0TiMp
	ikwQBf3m5IablSHE8m7hbAd5MWn1JO189IGp0czkSnw6viBKgLTRWfVDiLDhaxMmo1vkvFn
	2gGmhBTS7sqKmWuz9PGIGUlBuG9F1LZdonv/SZWkpyOjtxTEDePan1GPcVdcYLkKn3cFrC8
	qzQn18evg/iquDhip2YdNO7hONofWX3YKunNLAzsNKL2ZmURARAuLLKqUwcWlXJ3DqMast3
	S9Zz8KerTfVvnR5Glld2qWMskUi0ObpvQ68aPGdJ9FSJI7tET5wAlTth21pZNdxVMItElvN
	f1oAscQnv9xku+JHFvtQUuNx15DqsTWTMNvEKwfQeqOwak6teYTL+piHApk2c3By2pTub+y
	lI948To8An50S1w7N9UEFvQ/vBbpimWqSoqHgP2yGaeGYcVSHJAJMnwDNt3wIToCAFBdBEf
	n19TnC3TpD/eupyEW2GhxQob/VtCqhwVblFHzumv37/2yiA+zG1CSZN8dYYyhb9kVezvvEA
	T41DB8x1JwwInhb33XDwRRtkfyvLFABpWPf0jchePCSb5OpezD/XQ7iV371BBnH7vDaR+Ag
	oSJj/9jwy+YCGBw22AeBN/jPrmjJv2NJXMuBN9MQ4om11N4mV/Sv0jLCUo6OPSVvTNztJdW
	d5IbSoYs0X3osEe+0OdUfw0wGVOF/tgWAoDLcCdEOtEpmyQ6a67muIYN10q1FYA9uSRcgf1
	Zy9qV8YoNxV3ohrxdkmov/pBVOT974wbDrZXTB/dpIzPWz8F8UgvuU/ACKwVdiPcqcyCTso
	0DPhlM00lz5AE+jJYV
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This is a code cleanup series that removes unreachable
NULL checks (and associated error handling) that follow allocations
using __GFP_NOFAIL, which guarantees non-NULL return.

Gou Hao (4):
  powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
  drm: remove dead WARN_ON NULL check after GFP_NOFAIL allocation
  lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations
  RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations

 arch/powerpc/sysdev/xive/common.c  |  3 ---
 drivers/gpu/drm/drm_modeset_lock.c |  4 ----
 drivers/infiniband/hw/cxgb4/mem.c  | 10 ++--------
 lib/test_hmm.c                     |  6 ------
 4 files changed, 2 insertions(+), 21 deletions(-)

-- 
2.20.1


