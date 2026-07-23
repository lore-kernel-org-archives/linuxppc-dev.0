Return-Path: <linuxppc-dev+bounces-24727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C10C531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:59:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5WRv2MFyz2yVZ;
	Thu, 23 Jul 2026 22:59:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784795184;
	cv=none; b=bOa7ovG9ah6L3GWMkpGVPQZFOXW2FO/ZuwQwZmWaFxr8K37zxmLEIDligaJLYbSI7rbkGsmqgE1pH4tWakLW+IFeSU3mdh6qDcxym5B27OmBJ+zNaG1HcDkdTizHzrKof35SZB8t8vnAJpdg65f8wXrK7WwE3i4PDRprUSUdzmsMPo6DIX7OZFmytK7djzxD+sbxYX5ryvFzcvuiayrMQQcKrPHfx+o4/Z9MXDhZKKj0UhIfCRY8tulLuUZfmYbWUWvos2TDbFqD0v2UIDZR+FqDRoMDodcGmwzOwcUk+DPV162D8OCZaI/8+0J0+Pn/gEfbsqjg1mpTOGtWD7O7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784795184; c=relaxed/relaxed;
	bh=M/ih3PE8BMb0rsQpbXEWQtv8rMoC5z+b1JH5VZrcmKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWtLROZFv1q/Xg55STIZEtTgt9EXN1qcRkDjjI7W/GQN6h8Uyzg+r79flCS2sYx9tS1q7wZQvm+ZGxiDaK7vbZPZmzPFMgm3ppB5gmPe2JmJSe00RXVXIM8AWvKVPv7Tm5/aai/j043zwWkbdCmdLUHQiUfpZsdlimsxsuz3rMq3qmcfYSqoQ13aMzbAiysUBPgEi1Vvq+SbBZ18Pe7n8tDzx2hQyI2r0GcsU7lXMDxBny2+ByMMn4MW2I6/TB86IqhxAVYyumKKwcUrQUxM0EAY4viftsGn0b4vykwaVetPf9EKDEp0Du9GoJL34TqOlNtkzSCOHE2fuXf9ulOHqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=l4Y86vTT; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=l4Y86vTT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 373 seconds by postgrey-1.37 at boromir; Thu, 23 Jul 2026 18:26:23 AEST
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5PNH2Lgrz2yFg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 18:26:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784795139;
	bh=M/ih3PE8BMb0rsQpbXEWQtv8rMoC5z+b1JH5VZrcmKA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=l4Y86vTTQBksDstEaRtGVNKGp83bqDKKInMX2RrTjo5zxztI7wgX2/tlWv1mc7fuY
	 iB+CGPnYh3aaWbJxXT6TzurFcYCx3lQUJH6/4RaPNxe13++Hmw0i1/NFVQzBRpUsGR
	 YZodF96wIDW9BEa0AIUulUm96XI0wxEl/gCvM9Zc=
X-QQ-mid: zesmtpip2t1784794703tfaa1232e
X-QQ-Originating-IP: Vy8SA80zHSIgO+PkAaA5Jfe2lJklerHx6qvJlapt3Sk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 16:18:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6715730035353289087
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
Subject: [PATCH 1/4] powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
Date: Thu, 23 Jul 2026 16:18:10 +0800
Message-Id: <20260723081813.176792-2-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: N2/jAoEINgTTroA5CUbOYIjYTE95pJvrJSmDCiXZyRiFJp4GkcgN3dZM
	Ol6xSGQRhOPR3fIjT2evaH5gbUy+aU6DvAk+CRgLlVdPdOb2TiEpa/WjRPpG8SCleG6lySN
	xbJWSPKHd6k7qUKf+HgWwiWfhqablRwdTWbfkEG9p82yVkxzTWQK4+53U6CTRnlITg/WRRG
	FwEDDnYjFJObiKRbsU4hPIb9xOE/zq2RkOhPjRK6bVnKBdoyKtvlK2mqTKd9dppZkYKsVeB
	irYn7OSLnHWmYhUeT0Gfpw9/VSd4pp911/Ss61xjw0gApGQZ/5lDlb0x/idZf+hi+5QZxWJ
	wBBDw/+pVle8ySSPfx4DsEcCu0nXcm0KpFs76S5kMGrwvGk2xXTWmoDuXFdNgScXWwKR5oc
	y6bKxZpuCQVEQELXldz5aNCnt65bjL606Ib2dYXDU/TuAHWjoa0vgdDg2Y8QdcYkH/awiL9
	OhIjD3anTvlT4DjworINbhj9WI4hTPM01FzcvkM/KG0qU1tSjOmy3WFbvyqLnBTXGKpCFJv
	d5eat3h2pO0hxJrPbuJu6gprp77N2r88CWYsDpJQTxkp2bFwIIEqK6ZTW3bl6CiIjQaEYBi
	IWx0JtXDks6Cc9nZBqHQZnexaCglVuUEOj/lITdkgwY1xtkAF6EZpdG/rMpqFT2jqav6Uo2
	UScZALEVZla5in5DujQ98rpemh/JgAyJ4wfQjyqu44ZQsj8NRi+Tibps59mIRV8U6qKfNS/
	GojcERx2uBcMKZooNu1QNLf3e65mNVDjFv+5uUaxa7vhEvkaJL9Ixp4qzdJxAVrw5VRQpH2
	miUXt5H3XP8hZ24Rjh1Hd7e1GjWNbWf91h6U3IBq2snpZ1zhaCUoIBpJ2kVKtz5Kzm6nJ/E
	kS3NfQO+iMU3V4vaDpysXdSWJhuvQpl5pGwUzB39gVl1sKHoqTJzt4sXMTFCDYb1ShzZ+P/
	0jXomWHZkENP71WYi4KC6trLgT2lZsCHLZEp6/vr2psQaqO0WaaLXlfJPBHLcNUP+mikEOx
	m6zo/AUUgDpz9S8mT59qA60Fk8Cn+ltd10b9hl/kZEq/hj7hJW
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL check is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 arch/powerpc/sysdev/xive/common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dadd1f46ec93..79d7854259cb 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
 
 	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
 				 GFP_KERNEL | __GFP_NOFAIL);
-	if (!xive_ipis)
-		goto out_free_domain;
-
 	for_each_node(node) {
 		struct xive_ipi_desc *xid = &xive_ipis[node];
 		struct xive_ipi_alloc_info info = { node };
-- 
2.20.1


