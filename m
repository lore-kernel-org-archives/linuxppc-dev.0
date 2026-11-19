Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC866606A334
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxpCpkek
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPZP4ZwWz2y2T;
	Thu, 19 Nov 2026 14:48:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795060093;
	cv=none; b=aWXyPsLyJ6zGNce6jcLVivSwBj4FfGRXin4x5JiTltj/hMn6QXnB6Y6sEaTPYuvkN6y3ph/Uifwfg7+QwkrfTAMs87kgT8M6Q/9uO6Cj32292QTcJGVuMSgaCPjyoq/shyYTKokO90EaSpGb/moi20IxwEjhWcr7WHGItMaXLyJwvJ0hF4aC2PG7ziObEh2hzxxihhmDXd3TP23OSlYLw+KiTMQ85v0WuVZkj1bqBlipvKTzh0daXqEb4+O47cgf3Bzhg+b3uA0I3bi7kIMvNhV+pUz8BZB9JcoahHLK9NjbyKpJlfADsCbzJ49V2ns8lwGH2aBhLDX91EcvpEAIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795060093; c=relaxed/relaxed;
	bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrlYgN5K6iai3ruJgcUZEQtosHaGH/JikPH3caPTKEhgAP4xfPQRdCni1EiBkYcMstGevh9M5Vf+S25b9dmKlETbhJJFXkjsaiAY5BA3H2XH0bFibay4oSgO1U6hK53ChKnKDYZlVk39GT6xOU7i7EhHOG/1VXYLK9D6AtLjI1AQvvLTcL2U7HlXt80rUtON1MXu57RAXzuNAfDJavkJfXeXc9x2DpfVhd75jG70ueUZOXCy7kvGzPsxUNLycv4a54EeqNXVqBAejBriwHLoeXY01yG1JNjYuv15Ii+DL/ubdPoHAS+/uwuH7B/iR9EfJ1NtE+1HW65miwSFaH+k/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxpCpkek; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxpCpkek;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=hj351016@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPZN49lSz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:48:12 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso995414a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795060090; x=1795664890; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
        b=oxpCpkekJNPcHdamoU2fFXoy6FycAfm7L/KxXEqwYGwiRMOiaZ7xt7IRGEzamWyf2m
         uZ3urQ3GhA89rcFtQcg4sRNZbynsmPhpkfHjBeWLuNpfamDWHiGKcI4DRblNEiq4D3nf
         Oe6p94Jd9hZnvjiSuFMoRXIYQa0OZemd4VhGdAlurhftGCT6tva0WLAKd+5Ehs7Zkfax
         29nhoFYRKnp7Xk2gLGG638Z+/PBstV8tRN7598VDoVsk4ntSv2CKk5L6+fPhCNYqqQdV
         lK3uMsQicHOQxB77Nf642sg+thulcNKn9VQ4AsRazZoPQMSTt3eBi5e2XD/QVm012Ey1
         +DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060090; x=1795664890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
        b=K3Nsy0WbE2PsGZaaHrlcfdZ4Hw04ZYRUzbYkizhoyUF8Tt8KHVV9AtWc9I+3r4lI70
         KKr3pS5lsmcPmtXYKFDaDE3pXNmfrXrROEsGQ9dLa6P81Ry27INMb9gARrwvvpJCmHlp
         XM1AEo4yeCmVal1ORXPK+V39aAz2HdehrdRzDImx797HxBkOcoDPGK024hd2wq1tJSgH
         A1IipKJ3VGzsKv6VxsefV0nfaDwxVXYC5B9yHPGViUobSE32tYTt9ilBu1XFSZ94IIj8
         I3VPFPvyZwY9Uoec1D37ZJ7riIkj8J6Jjd0BaOxidiw2ZqH+PzUEOjLVw65eF3Gh54q3
         ZEQQ==
X-Forwarded-Encrypted: i=1; AL+hErGfcbmyNdvi9zwLmwCMS88/9dlmkH+tSxv/LPYW4iMui9UN57yKZdl72QxA9YrmLmbow+he+5OXIhyFvbQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9X6pr7blMiGpmodiar2cMWWbOAOz12GWI13Vm6ipZL9m6fmgaj
	zkg/by+JX8OSQxg88wL4GXxB41/C29iOOZssRYz4JNrg83U3wmsJyMkCE/fwboQb
X-Gm-Gg: AZFdTZdxHBlNZjDzljWnCDy0e0JEfr7oJVG0rt9U99lEPGtiRbzQo04Nqm/77RlPBqi
	ixzEo0eEcEl/zbcEMr+fFQs4958CZuJDg03jBy1HQA0H6uiLTUT820oqEEpb2YwzK5hLVxqK8tX
	2lC0e1n5bzvYC5mvA+laVjZDg7xfM+1vk6rJu8Z85attoHRSJrTxD9pxhIPcHmURds80rin+OMJ
	eb/uVL3QBJ+EW9p9WcYVY3DhzTDvCKzyiQxhfN+vXRfi241lmw7n2Lbz3GpYegR8L0N7Io8zd8s
	m/fBQu3PL7i3aHAInGx4HgNv7CsAHJjSdBNXf5Qjt6nO2BZNowOYjpIGhJLXhgEvEwQLBLcoMO0
	SezrQj94mIpv70VHGz9/R8Hfpz9IPJydHRZelEuIc/0eYZCVSv1LCzV4sRpbnX6KK5OZJkr1gIN
	68F4xWSXevfYPF8K1Sx6wvI+wNId7miK0/QnOA7fg0MZwCiWe9zGx4OdFmTxgab6hhB1q5BOGcW
	6R0ebUYMTo72K3g1JqE+pKIjr5nMDkzl2PxMw8g6tDMf4snIO7mHtXIqKDtsn1pg6AJyhM3sB53
	Lz5ywvkv6qGNiEOwm4TwEleFt7sXKGe2DVCnYnS5Ze6Y+6O5
X-Received: by 2002:a17:90a:d445:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b3d0686792mr4179890a91.6.1795060089811;
        Wed, 18 Nov 2026 19:48:09 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d629ccsm316045a91.7.2026.11.18.19.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:48:09 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] powerpc/papr_scm: initialise metadata_size before reading it
Date: Thu, 19 Nov 2026 12:47:45 +0900
Message-ID: <20261119034745.1460361-1-hj351016@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

papr_scm_probe() reads "ibm,metadata-size" into metadata_size without
checking the return value, and the property is optional, as the comment
right above the call says.  of_property_read_u32() only writes the output
when it can decode a value, so for a device tree without that property
p->metadata_size is set from an uninitialised stack value.

p->metadata_size is the bound for the metadata get/set commands:

	if ((hdr->in_offset + hdr->in_length) > p->metadata_size)

so a garbage value decides which metadata accesses are accepted.
Initialise it to zero, which makes those commands reject every access
when the platform does not advertise a metadata area.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 5c3bf06bb59b..e9895e9b070c 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1361,7 +1361,7 @@ static struct notifier_block mce_ue_nb =
 static int papr_scm_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
-	u32 drc_index, metadata_size;
+	u32 drc_index, metadata_size = 0;
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
 	u8 uuid_raw[UUID_SIZE];
-- 
2.51.0


