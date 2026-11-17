Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEA606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hzdkVEcg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT9BD2Vjfz2xcB;
	Tue, 17 Nov 2026 14:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794885988;
	cv=none; b=kJzlXukNQ9aQWXkYXSP/91Y0J1oqb/8kFREiRBOGEu6CGv9SG48PK6vg13n7RaTGUYIkEHnSZwLJXpSr2SogANQ96WyBPFDL9i/yH3RPNNfHE4m9MmuumTNiq37q00LJqkalERT94OqO13v5VhYUvJtHXJmOtsgCnt38GF7QTfdAK9d8KHkQiKs5bwBAqfTZgqT0MHB5NBWLERt0Me5nDObySGcOV0t8saGNuUMihyet4964Awgal/Z4dikqJKeA4TE4PXkB3NBnYdT0govy5NZRoYFhKBL99CZcJmxqDGwXOAUOF50OwsyQsKgC/qOmD1Ucsbh+9dnFyQ+m2+vqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794885988; c=relaxed/relaxed;
	bh=f+RUblqoorE+DmrbdAwb+wwbOFEmVzV1Vh23cpuMpTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxEBzf4eXybRWnuxCFyq9r/Xa0nnK7Pn1gmoEhFyPgdg7vcd9fGzStYf/x6yVUiLI4vNcRBjOVwSexfgPXf5QCbQexvlRejXllJSoWhDzYN1ndUh6VWtWYzJ+TgA5sNc7ACWQn88f3ZYNhffc2ULb9LSP24oZhJz2Hdl6HGMrDHbmoIzynALsP8FFg+5LLS9G/xqu0SuHMpCriBpwbNeGVw2WKK6L4TbpjA99XOAUZVHhUcR2E6ybGSNaFFuUWzW7pBCthvDkzyBaFqsOadnFMKDQMkSKA2LcWu8CWb03iz0PZAFHMuUbM+/M7t7srZYAa3JSnEVWAx15Qo0zhg/pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hzdkVEcg; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hzdkVEcg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 166 seconds by postgrey-1.37 at boromir; Tue, 17 Nov 2026 14:26:24 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT9B820nxz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 14:26:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f+
	RUblqoorE+DmrbdAwb+wwbOFEmVzV1Vh23cpuMpTA=; b=hzdkVEcgWpdUFB7arC
	/n8ZIiQTOLSKL2Hdfp7b1+vyB/3rpLJljkMw4WPZCIr3JO4mttIabTHEORyoFWe5
	d0b8p+tc32BLIcNnzproxsc2rmJbpmZXWhaUo50Dq2bBZTy3xP6w6CpTVXeSiDvs
	BISfNpCfE28TR6MLi2is1tAWs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX_0CIyPtq1HcFIQ--.40278S2;
	Tue, 17 Nov 2026 11:22:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	bharata@linux.ibm.com,
	paulus@ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] fix: KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Tue, 17 Nov 2026 11:22:47 +0800
Message-Id: <20261117032247.1053075-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_0CIyPtq1HcFIQ--.40278S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17tFyxGrWfKrWxJF4UXFb_yoWfJFcE9w
	40qanrZw4rAr4j93Z5Za9IgFs8Jr48GrWFk34Yq3srArZI9w4DKrZ2yrnxuFy8W3yqyrZx
	CFWvyF9Iyr1FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKSdyUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QrtXGr7yIqVuQAA3p
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
directly, bypassing the existing error path. Jump to the existing
error path to clean up before returning the error.

Fixes: ca9f4942670c ("KVM: PPC: Book3S HV: Support for running secure guests")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..620097f292b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
 	r = kvmppc_uvmem_init();
 	if (r < 0) {
 		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
-		return r;
+		goto err;
 	}
 
 #if defined(CONFIG_KVM_XICS)
-- 
2.25.1


