Return-Path: <linuxppc-dev+bounces-24729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F2C531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:00:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5WSL4QC3z2ygG;
	Thu, 23 Jul 2026 23:00:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784795193;
	cv=none; b=d0imJi+NfwMBWaEJZoqUSsMKAbvn5pxq92846oyRmQi5BG6W3tVAU5T0Sd2k6WDYeVn8vysldT9pbj+20s8nOB4BRVlaH9xdGLpvhEioM92iftJxa8FAwTlnceFBropCyJdto3bbTkoHQFsHW8wleF9dF2apuHX9TWbEeOszhe0CpkYkv/LKfie9inkmFksLp+Y4jpvLSdmVJXSnFjH7q4m34SUKknxfkwZGixDTtjm9/QEyVf/h8VhGY6I3EM+QUCEuiKNA+QRoQYtGenJl4BjUTgKFX6liLBK1hRvCWQmRHz9ODMFvfBaS+yufNDRqLzAFWi95BQHzTSWQ8UMaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784795193; c=relaxed/relaxed;
	bh=cfSzb1j3fDLRRpHqQ0EUwXS6MbMulPkc64LtYOOGOc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ei/V8w/3OqHi7216OxPldp2NZbwt1BDUKUlblwCZVWTeDLzTgN68WePE++BoJhsNJ0N9WoV1t2p7HUtJR4j3ON0aHxpAEpadwfrp0dwQS7/Qq2JWQiDkWWrO3WmVu+OFXaevQygQHH8JBj49iuZi9ItsHfxXJNtAbHJiok+tonbL4xdDu5L5BFS5voB2H9FOCL6+5Bha4cLsOHDuccBo/t/xH0NCFoJgpmFbcuBOQg3BIiRRiq7CtNoDwXf0rnGRIgGKangNBFHKy09JoKFh4IG9LN5wQ9zy6m1b416JFvvmPcFdHP5TwdFE6hvc3kRm9u6Bf86l3Y21U5UbV3vJRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=hohZnHeL; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=hohZnHeL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5PNT1BcXz2yFg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 18:26:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784795138;
	bh=cfSzb1j3fDLRRpHqQ0EUwXS6MbMulPkc64LtYOOGOc4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hohZnHeLgSo0xoMOQLw9HL2Pi675z90aJHjXn1kXQuvWbsfu80X4X7Lx29BHAdQnG
	 wEdrZXu1g76Fv+NPDrViZz+1OSXVAoozU1aIuhNkodlg+DYUFJoQLlm/+2pRba+TgF
	 qRDxgatbd4GIpE86cr/exJxvLhUZvFuEXO1i4T90=
X-QQ-mid: zesmtpip2t1784794718ta429b909
X-QQ-Originating-IP: bWv97cvpQpUfRA+67ASoV4xpS1e+WkNnwAen4+2FDbo=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 16:18:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2455247409279869291
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
Subject: [PATCH 4/4] RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations
Date: Thu, 23 Jul 2026 16:18:13 +0800
Message-Id: <20260723081813.176792-5-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260723081813.176792-1-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: Mf2c2cXG8XEibqlhAZbqeyGH2FYMtk1EmwumVo3TGIY624fsvVk6PwB7
	DT9m8LVB37jmZHHw5MOBaGjEUFP/FnO3BL/qn8pjnQ0rEL0XydBSwaKiY4ppD+B3DV22QOK
	D77HKq2aonlCOEDenxF2QqCLzu3cFEyA7pygaE4McGq1cWbHA16rfDQfvT4KzI/RITi9Abr
	NU/wshlxxKlywdmycuB0t62MCAEUfbHJnQ54vyR8qIU5tqAsqPnlTySrFTZvWejQXPWd14T
	PUuip28QdrcXFKEJoTna10Hf8QhE8UXz8HPh7tNw3X/Bndm7vBUm7VORkYKgN++uEi7AmV4
	h9oIeqEc06DQKP+vIr+wjWSK00Khmsx6XeRl83QINh0sUcLncytPyViiJ5mYlp8sUsC3+uQ
	I2RJ2GSlIPWENL2qwqMbPFb+engYLAZwXFn/bxOYK/+HJWCMxeTxRzWyQFNFzoPV0GxgnDi
	jV/UedcpolgPNkHmFh4pLcf0RqE/ZuHJVBvaagr+M1wtOrB29BG3l1GHsM1MDooFai255po
	Ltl3o2dtFwyALtrkrNbNx8L4ujdEVMrmckJSmJlwp0DpUHUaGXithwCt4PxL8PAPF3cz97n
	C0MjwmDCzMfOvqcTdd7z7OhQIooMwUGMQ/RrrdmdSYNd0tqhrfjpZdMQmHGN0sFLqj2/zab
	gAGTz/+W11LwQT5o4lfz10ytOH03Rn2x763Z2GmPpkP391lYGQ8Dqjf/blo81BKdGqm/xtX
	3qJZ9NxbX9NTkCwS5yAW0SDt0BE9cLpDO37inPKsH+gcaGIST+O99io7h8+6EHcyrSxPZpo
	8695u5p9Ve0ZPR++5I2FwVFCs2wr/CLkeeCrpEhCSohqkYpm4xoGMDN1hSlsSVRbCqkqRdO
	FihzEkeBpOlRxkg9qc0TqG3K8v7addyLDxhcNjgciSDZYlYQDbpP/5VupmuPtB4NkHk3vyd
	qgG47vVCE/EY1q6deMQ1dNd+kyhHwN7jkrEMpGD1z5DkaRZhvtufxyqYTWY3hO16j4gk6RS
	JGl5SfNhBM9dq4mJKH01Q7w/ExCK9DB6DE5ttRGw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

alloc_skb() with the __GFP_NOFAIL flag will never return NULL,
so the subsequent NULL checks and error handling are unreachable
dead code. Remove them.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/infiniband/hw/cxgb4/mem.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index cd1b01014198..08631de17c0a 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -74,11 +74,8 @@ static int _c4iw_write_mem_dma_aligned(struct c4iw_rdev *rdev, u32 addr,
 		c4iw_init_wr_wait(wr_waitp);
 	wr_len = roundup(sizeof(*req) + sizeof(*sgl), 16);
 
-	if (!skb) {
+	if (!skb)
 		skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
-		if (!skb)
-			return -ENOMEM;
-	}
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 	req = __skb_put_zero(skb, wr_len);
@@ -134,11 +131,8 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
 					 roundup(copy_len, T4_ULPTX_MIN_IO),
 				 16);
 
-		if (!skb) {
+		if (!skb)
 			skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
-			if (!skb)
-				return -ENOMEM;
-		}
 		set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 		req = __skb_put_zero(skb, wr_len);
-- 
2.20.1


