Return-Path: <linuxppc-dev+bounces-24761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF0C531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sR81R58z2yr1;
	Fri, 24 Jul 2026 12:30:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860228;
	cv=none; b=b1InLz6VIkvA2seKQVwLu25Tit2rKdYW2CDOv226GMKAyphZgEJYGMbqNVZBPHhusPCaRMdG8pzU95pDAa93Jcv3myrJYyg33bSYkjtaMPQBUMaJHQeYx/G4DMbQTutrz790XDn/Fgi9KfAKKD4W6hMCBnJ7kdzGfSGJij+DRHjH8M6tqEWYbyQY14/gO9aOYWYxmGGIf2Oc5ucoflK0BOAtcXvqAqkYjlUg2b8aLVPqIvsuih5Rrvp/YdPkgfee6wXLzfN0o78fJ6F4UloIDxEySeuSP2laCf+b4900RxHnRUDCZmwdmicYVk7y4nbX2EZgDT3ESdcMfdIC184ZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860228; c=relaxed/relaxed;
	bh=+ZvTI/fcAWs1dkQ4W9g4AT4WdA/up4PGQNqGKnn0rhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5TSO2JM3b0hrTkwfcpgGSXhZQyTZReZudV3TGgV0A7qg7qFKcSVJl/Pmm8Em80QLLvud53OY+2jMTyz+XZdVM3GazjhZCQhDu0BSQ2PGhLW6pNFrwrnVf7ZOpm1KV0cN+HkSPHANTqI2lmAhXUe9qa/3LmGgwzCPpKh2ey8Ej++r3wCDP6FZIex+B0kkmzPRMWBsVIgP6peOu/J+5ugKh8ZZ7NedZitYVN4lpqpyCH4ZVDAy86OzEyuQrAE/trs9/MfnJQTeKxFA+KPI+kJDHNMR2YZ3I5wSe/ZpZbb42bV55pXXQLJYYASwdu0ZO2QzPPYy0fMBTCxQXZCwjsONQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=E36dmo78; dkim-atps=neutral; spf=pass (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=E36dmo78;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sR64zWwz2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:30:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860168;
	bh=+ZvTI/fcAWs1dkQ4W9g4AT4WdA/up4PGQNqGKnn0rhc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=E36dmo78kh/yyu/q/SFkWKgtLkmXa3lNLHr2zOdo+jTF5icGfxEpesU7j1j6LqF10
	 QQwvZdTVAlYgqiW3pimDLTXMBli0Soqng7q9p8S59eQcUdzXh9lkODYgaJpnoNS5zY
	 g2lv+WASdoWmV7/oPQi1SHKTdfaHsCYZQk5nlNqc=
X-QQ-mid: zesmtpip4t1784860156t81fb8ef9
X-QQ-Originating-IP: uU8Dw1tobLbkmKcfvIpWRxgng5wGRpu3yzVVioqlHrE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:29:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1489989829865237816
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
	gouhao@uniontech.com,
	namcao@linutronix.de,
	ynorov@nvidia.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v2 4/6] drm: remove dead WARN_ON NULL check after GFP_NOFAIL allocation
Date: Fri, 24 Jul 2026 10:28:49 +0800
Message-Id: <20260724022851.466017-5-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: OYMEOeTae7ml72uGin0H1C3pK5c9+QYjdQgDAuIFE8UGp823CcBF0aYB
	ZKuHTFQzUBDRlCCNVVKBEEqLTSr/VaM2rPwDKyCTrGbnV/MPothXGcA9BT0eRYmQRPQs8v2
	O6U4Zv7/YfNIf4td3jgO7KgvCtBJ9u/wHryrW3jKTlN5J3uC/8FdbZuQRjpJ1hz4CVS2aP0
	cVIqk7f9U5YjmgnEBzicWs3R5SAKrhjb4QrV0SGXtVI5T89n3z4Bact50WL9niureseFM8l
	o7HczQfFeKq92yiYknL5UJ5vPSjQypJ0hQHz0s6X3Jb/qCZ3qScVhP9foBlMtZB1qzhM0M1
	XOr0fOlJ29Owb8350tpKn9hHgezZ8iLzU60rhfTOvnBAL7GTvx5RMXuk8A12aNSqoTQoNYM
	lmz/BYgdNOz7lBNJo3kwQyrUFLtM8MYBPbR7mItQjPPMKrodCMyKu3sa7xu4uH7odekH2jj
	MST4050YnBUrc9R4S0ITAoIqo7WdL+JGjYo/TjZlKMWvBIEhRgF4NZ/x0TA8PQJXzv3OP5f
	k8Gi+t4iP5dIuRrh6QqKpxwO0OP8KL7aFEIvWHgvD6MbF9zJw0oQl8a0RxLyKG/8eRFGeqD
	eq2LGunZFJFHg8XULD5CdVu8m24dk4uOr7NOdIAxTiYkgBhT3/bxqOFEuZ5MVJk4K/WLLyY
	EdMYhJF3Woz7PcNdPEwvXCmSfW3oKNlmjzl3oOeGlV0bHYO2oZOtlkuTn/WI1A0wTL2iaQz
	GaG6V/QJd4YVSfzao5wBMOhbxXrc7vl2YmAIfmiPoXJNHVQamZDknqvoeFU7OcShz7Q+cAF
	ffLI7Eg+a53SaJ1S7DJHISPzn2g9ISKMdCMGoAOW2Z8gbuLw7ZLRev09eQUY67Jb2njfIr7
	75gfyFUDQeH6F3tLev9bvRRh76ZObFlCMldHLKJ+p7sug1V1PfXyPIT6HCb5RbiLQoq3ONE
	PIbQvv4jJ52LdZYvMhgz0Vg32VUnEh7Yc8qmgRzHY3T+o3iM54h+T8gzIZ7wdtBzQPu+GWW
	UblXcnNa763eZb0zlOcfpsdjvY4y9+DNmGrzpdGYXoPfJWhEQv
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

kzalloc_obj with the __GFP_NOFAIL flag will never return NULL, so the
subsequent WARN_ON(!ctx) is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 2c806b0146d67..e14814c30d8c0 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -149,11 +149,7 @@ void drm_modeset_lock_all(struct drm_device *dev)
 	int ret;
 
 	ctx = kzalloc_obj(*ctx, GFP_KERNEL | __GFP_NOFAIL);
-	if (WARN_ON(!ctx))
-		return;
-
 	mutex_lock(&config->mutex);
-
 	drm_modeset_acquire_init(ctx, 0);
 
 retry:
-- 
2.20.1


