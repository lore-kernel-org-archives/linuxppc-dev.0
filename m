Return-Path: <linuxppc-dev+bounces-24760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57479C531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sR33Hcnz2ygL;
	Fri, 24 Jul 2026 12:30:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860223;
	cv=none; b=KuJLrquTtNg3RuV37C0gJS2SnOrlfnSQrcHxAsAxJEk5MQyxfsKlAxf3R4ungAbBaWYGOraA1EHGSRPq/AyYnEUR3V1+dDxyaVgQ54+6ZZSPrwcm78Q3XKLmUf2sBAIJilk9Ajkm5U0ZRiDJmB7VuIPasFifR5Woc4z/7306FGroY7OBxsb5KcyBIqdiDZZW+lXG98XziBOY7ebPICLE4cVvQqMWY5L3K5XDi+lojL6B0EPuEDI3nuPFRFxBQWFCn7RVkhEXv3w6CBZbcdJPQU7aaP+9k4wtmFj4PT/A3/pMgDR1TemHMUA8v7GP3En6o1XCFKStxSTejedkMunijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860223; c=relaxed/relaxed;
	bh=OyqXJDBODKL4i9r4faSbxqKqbqbjK9rOASLwkWPXzB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEw58utIl2yt9uZT7f8NsZhFQ0cTx6YlAIgEqrLIOqbqAfmVGHiepJow9IZkhxXE4sg472MetX+FUNm+Pa0sFJqWgpqkVrtLwfdSEE65BwDZMSnFE9b3uv+kOxrsuGOkLzUZ46eWd1kB7WSroezdJSzMVpbnbeaFQjjKkfbtTgpws7WJWjbNGVZSL8EuS6DR92Mmu71j4g83XxGvGUf9Mu2MD8WrQLqE4OcHv5LCFbRAizpcHMmBLS1eZmgAwcSpNWX3TV0iK7eE8m6B5wpel35Rzr2v+doJGPLRHZRB/rVAxavsm9iIbQqD7Mc30JE3M/S7X5UvTykBQlmq9abM0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ImOl3V+3; dkim-atps=neutral; spf=pass (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ImOl3V+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65048 seconds by postgrey-1.37 at boromir; Fri, 24 Jul 2026 12:30:22 AEST
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sR23zRlz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:30:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860168;
	bh=OyqXJDBODKL4i9r4faSbxqKqbqbjK9rOASLwkWPXzB4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ImOl3V+3qmGjRisyVUVd9mh2AZ0NFSJDdEzDIqUpNvqoNTKhOzOi6KGDffGACMmtR
	 Ieie27rcygsxcHg/b5/K/9wRnsRHf46IlOy9eN5HlR7Vl9LPGQaDr1c7Xc6lm8x8IL
	 1q3YhVXJS2PN8fyIiZ8h9JL89x+DGRIhNn+dO7mU=
X-QQ-mid: zesmtpip4t1784860161t8fb1ed23
X-QQ-Originating-IP: aBJCglJ9q/YAKBS1d2e+RK0bytOzmdANKIZ+RTuS4uM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:29:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 645947347967007313
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
Subject: [PATCH v2 5/6] lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations
Date: Fri, 24 Jul 2026 10:28:50 +0800
Message-Id: <20260724022851.466017-6-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: Np0qb5kW85KCuNY3xhEmso47MerfeFTbCZJksQvsspwKG4y8W/dSUAIJ
	o6T2XrDMq8Ny079obbh/15my0oIoTTh5Al/5YBcUGt1SrNHpB6XoRjGZn4I4WIyKhhQD4yp
	wL7/KGUC/5HnZgk+vOC85+Q85wemSC5rwAmNTgxHO7VYvN0cbzDl2XaE7anozmElgRsHxf4
	SwBbBLKDAjZ1hFTffhFP4yPGT4YkayfvoNQSJ96qgKuempHLdy2lFVVGVe7OyvFR0+LrhL1
	ow+Vo3ryePzZI3ZLJBQdS8lOFHch9FxLyJMvSvLYvRNHYGtHA25tDAXaOcGLpPPQ4QEAl3u
	AK7wV3wid9+QuzR+YvEtHrxFoI2XUqVcO9kduuOyGFn1f1A5wASrI+Ms4zuS/Qnmelfqud/
	hgYdWPHGXnp0/5S5Yg3VyTODWbxn8UHMMoNG/FT/DOSmXvldmRiF+zGVPRBlFtFiMqIAUeb
	OMmn4w8UzEAzQuF217Yxnw3q0NJQiTrfhEMHDYpn6qTYy+iaFCxRxcZgZtAO3Tt2xvePc5Z
	Lk1hCqd+HruliBG0wIkiLet8vYVKF4RdemSAmTH55HCPsppaGOIVJA9VhhItBk7q9HPaw/b
	Hon3kA/KYYZxnEBPN2I8+q/ZX/BNjpUy3l+yOTTIG5YJPdZ0YyZjowrqehl/g0j+qVOhSD8
	/eiMyMQarJTFCaV2KE+vYEu5CsF1e4HQVL6BblgB2mb8xSkEIpXhSaJVgkz5ewZP2EFRhAI
	zsV3vbv9d/s+fVkcqmgTpBjo9ZX+XK+B/oKLOEiukvTtTVhnOJfa8xTSbQyzPIo9DBlAhDF
	9Occ8f3ZhFpGklfTu/PjRRvVRW2vrzD+Bk7oy9yvaapbDkuvlp3glUjr7ijgZGub/muIQ+y
	KALgB9mmIAVqAAud3IYSLDySzrSR8e9/BzO/NzCILP+7UnYh3EC6ZhjxgYy6Zsq82jTY73c
	7jdM0SZuDPpkNmKdllRZ34UEXgpDAGb7FLqqSgZab6AJk32fR8DaSerg3iBO4YIhirJwqzb
	X7WJrXUhAh9+l/6CovzVRJbyG4pgo0bAMZaK7aCOJDJPqcIXXWJ9HDz1tdfGY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

kvcalloc with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL checks are unreachable dead code. Remove them.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 lib/test_hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 9c59d1ceb5b57..d615e4e5fc447 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1209,16 +1209,10 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 	if (!mmget_not_zero(mm))
 		return -EINVAL;
 
-	ret = -ENOMEM;
 	src_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*src_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!src_pfns)
-		goto free_mem;
-
 	dst_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*dst_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!dst_pfns)
-		goto free_mem;
 
 	ret = 0;
 	mmap_read_lock(mm);
-- 
2.20.1


