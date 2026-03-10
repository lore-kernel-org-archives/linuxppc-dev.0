Return-Path: <linuxppc-dev+bounces-17985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D7FD88D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 00:56:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVskW4szpz2xZK;
	Wed, 11 Mar 2026 11:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773148518;
	cv=none; b=ACx0hJMRwnui+ZAiV0s3wHt8xgvz7EjJTqu3Hkv+Kp/KB7y4WCc+GikEl9J2ozlTLwMCzTeClGHXXATlkOaXQPC7baLr/Gm8aQKRf1UzJDduGM7As7jyXJCWzW9YJ/0XzALQkvvBaHo/s6r05NjkTaR0z4s4aSYCq/JXXMfNFBDH+fmv998WuJCEhKbb9OeorEaO8ZaG2lDMQY+tW/DmlkX8GORmx8BIRK8/BestIr7VPoZTO44UposR3claY7NuYiHUBtJBmPV2tNY//Dgwn/6hjByoKKI9Eoava/AUAQMYmzKjen7CtSiVJLIj7WTPQqBjtWlmd4oS+g9WLS4QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773148518; c=relaxed/relaxed;
	bh=dAaAL2bSaHFST8Z7y7B5rVa7Pqgb3PRmEPcRCp/FoW4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jw7LpCDitP0BSL8SiwLwamMqzip/d6Ig+TKyUxWJzQMMgNcS8TSZkYUcM5DgElqstRIt+Lhofk2F1yO2MkAG7NXcWh5LywkHMokA7i5TUIls6oZV7v76koaxRBFxLnVQGrpoFJ6akMlXjxh3b7EN/YFk8LBQ+g3VfLMsmeIQuJ5XR54XqvyYY3X6RVbPLULK9OMpRLh8WLinnCwHvKs3jLG7hZjjESO29ME2z+Q6SzceJozb1tI9NilcOKel7joGK3p+qaGNEvTBZlHbKZtwb9V5ZmODmEnSubPPNKmp5+yMZsg5s+IEOx3+qUtxnk9PZKT0K3l5Er5QN09v40Rlwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gua0ykss; dkim-atps=neutral; spf=pass (client-ip=203.205.221.221; helo=out203-205-221-221.mail.qq.com; envelope-from=1742789905@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gua0ykss;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.221; helo=out203-205-221-221.mail.qq.com; envelope-from=1742789905@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3757 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 00:15:14 AEDT
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4fVZ9t3mw9z2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 00:15:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773148506; bh=dAaAL2bSaHFST8Z7y7B5rVa7Pqgb3PRmEPcRCp/FoW4=;
	h=From:To:Cc:Subject:Date;
	b=gua0ykssCzJhftY013wUODugDjYJIza7uXuTIn+uE9mk7XX1HoG4RYnrV61B3S61A
	 QLmKVVsicxAXwPlw/plj3tgx2shHA5T7Pdw58LGcn3rQ10fnubfMDIz0PKmoXnjCDG
	 vRcWrxkzK3kQ5+IXnorDy5oeiRhJA5wC/rR1tkrY=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 2D22C8B4; Tue, 10 Mar 2026 20:11:18 +0800
X-QQ-mid: xmsmtpt1773144678t5qus6dj6
Message-ID: <tencent_770FE404794D670E2ACDFA144EFDA35AC305@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJBOgVfCMaPom1z1vdwQSoYB1zGpFNKYpnXZmwXGoubgpCDvQClD
	 joVU98FQEheYN78vjc8/kNxRrDf7yWqDNYcuDV+Ddw17EqXPyHMIYLFy2f4qAobGbOmtKXODuJCo
	 n2SbtZ3YmvccWa6+vuGoo1ZZWmVBUK4A6K3ui3HL7ozotj+qgesAnXJZ8RWe533ym3V7mAM4t8En
	 01O7gAitaotAN2/ljZc4B5mg4k/G0cP86SGDqzz3u9YlEemcguUESI6SJ34Q7i+tBdZNC9GMlSxx
	 GoPYs64mk0pyDc5kdJwyPrzZG5t5Vd+MnMOilA4tVpG9biqCIMBgmweYvRZOdDETi0U3ghJQ3Qcg
	 dq5+2lBMh+nZvXMJbNgZTLXFT16RHPwcJhhYEqhHMC6GClhS/K48wFBkOBJUeZNGrwBbX3ep72mn
	 p+PWIoXMVRQy4ogaAA5Imq9Fx6Ms+DP7Ua6sI58T/P/8SyRFe9qZl1Jchc+qLZOV8MrFCfmGivmr
	 boDQ4TK6kF9AIDxIuJl65doHM3fYCQlyzvwnxfY0N4pR68kcfmzmKPBYxZqjnGFmMZZw5DdNvgUL
	 NLKsSdCDlE/RT2jhG/9neuL9IzXkNz9LpoUwz+2jeWo80Y/XiITymbVlPUCQcd0KCMxFufwDjdly
	 SxASAOxuK9gER8iW+Mknal1aH6GDN9/iWhzkQwEJ7LnZ0hyRZTHwek+i4nAiRAUnz5BF9LRjkndr
	 qf9zxyBGLFJqABAPd+B8p+ng50xsaqwq3iLrBheG6BQhGmdoXY988tpoin1ETEqUyxQKeFziHdE9
	 ZZIdK7Yk0rB+x24Pvtnwn4Uh9v1FHMZLz9dabK/QMbkg9TnSvDBGxF/om4AWb+vw6/V1CNNRoboK
	 sYkWhmrxK7XRFwaw+b+OZMahMYt4ohFSeX8jpySl+zfOejl5pd8mltOR3BaHlPoxbMHQP/1IVk6P
	 rppfGd+0UCJb6eVU61NYVMuvwgN7Jj5ybEhsbsMZF8/VrrKaLjU/3UEKrUdnIsSCj8biywlcjHgM
	 hQd+Vc3HWWpgUUCbSzO3JMHVR65i4iP/h/i5FTp0JwCLdCo3BB6oLSmKPg2PZNFUA4bLgXCg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Wang Jun <1742789905@qq.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>
Subject: [PATCH] soc: fsl: qe: Fix potential NULL pointer dereference in qe_reset()
Date: Tue, 10 Mar 2026 20:11:14 +0800
X-OQ-MSGID: <20260310121114.34906-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
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

The function qe_reset() uses qe_immr without checking if it is NULL,
which could happen if ioremap() failed earlier. Add a NULL check and
perform ioremap() if needed; if it still fails, print an error and
return to avoid crashing the system.

Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/soc/fsl/qe/qe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 70b6eddb867b..6dcfa340970a 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -86,8 +86,13 @@ static phys_addr_t get_qe_base(void)
 
 void qe_reset(void)
 {
-	if (qe_immr == NULL)
+	if (qe_immr == NULL) {
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
+		if (qe_immr == NULL) {
+			pr_err("QE: cannot remap IMMR\n");
+			return;
+		}
+	}
 
 	qe_snums_init();
 
-- 
2.43.0


