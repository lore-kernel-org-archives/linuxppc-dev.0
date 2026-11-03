Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE8606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8hK42/k
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJw0F2wWrz2xSZ;
	Wed, 04 Nov 2026 04:04:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793725453;
	cv=none; b=NkzddGXPT/LdOwouIuez6t07qE8V7qd1FTIDOrFEp6vpmRBrfkaf/aS2KWHJ000J1jFBqYaoivFHglnYKYOYk2HtPfryz35f14gkS43mGDvom/gxwmLuI7tx7o7lb5goJ42YF4TRobb4/TYkI5XR9Yh0/OSpmPKl7zCkM5DbR0R8IYtsfJ3YzzPrRnY3YS87j5dTkwqs2KlCZfY4d4Ntq5MeYyWqcVLHoK2g/A1zhBMswS8IqkDCBUFNig+5yfkdDVh26A2hvJdPCWSeWu6ADG5f7KacxeJne9LGm9KbSxXy3xBW3xLY9sq+CsUpLsUeMVnhVNCvvmF9oBSBwnJTig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793725453; c=relaxed/relaxed;
	bh=b9+auSGcppcWBJt5SXqZ+rpU4e/kF1LrHal7/DP4er4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h75W1bziX1TdqqjDQj7UYIAmdK7As5M50OKI4SmIrEDlsrVUKgr8XWfibWDFYm2PVG1EXMjit8aEssSyzr+6yKm1uLKB5lhMVif8T83rks5byU0pHA0/Jai2FnHmfGeBOGveGN2IPQr45967N6b12ERWQe5hzSpLXiNGslPlhvGIJQaDh67dwzT95+hCk6b6t9qDeoR6RitfkY8sYyX8trOnCU+Da6fddatBs27Yqb4b5TSCm5tUPMMvlbn0XDo2XO55PsQ6KvnMVKZwXgWmhY/4dGTICs8G/VOjrnBEsbYx3woQppA55aqgmgl3Bnkrpq4x5tYdJmIQKgerUwU+TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8hK42/k; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8hK42/k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJw0D2GYlz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:04:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2910E439BC;
	Tue,  3 Nov 2026 17:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8991F00919;
	Tue,  3 Nov 2026 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725450;
	bh=b9+auSGcppcWBJt5SXqZ+rpU4e/kF1LrHal7/DP4er4=;
	h=From:To:Cc:Subject:Date;
	b=X8hK42/kJSydfw5D7Z9vK6U/2atKWnn6X4aEuOK/xvwEg1InLj/BgvlmYhK87WZmD
	 Ry2aL84xe5bMxBFYEb8HdxPX//Fw72r7f0yekVfDigVlKcVm9pFkZShSYtyoJnPul0
	 r97OE/i5vU5D206Z7AWNU5YOYm15eOoXb8cYRV3BcR3XuKAGB+JXBjmRRlXFzmWF2s
	 JDbN+Wz9SnZ00Pzl7z5YxJlPDPb2xqsmH7fW9C6R03OTtEth5fhzD8M8JqtjID/ZCJ
	 WhDRUptZd0BQpW8cWqCvfr9FzqTD9zrADKpchRYLEkFJyILYfgi90JQvgJcmRH2HU5
	 zrvejDf+NsgQw==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/wii: Remove redundant 0x prefixes
Date: Tue,  3 Nov 2026 18:03:03 +0100
Message-ID: <20261103170305.455444-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=blum@kernel.org; h=from:subject; bh=Yq4Pqu7vixPkoEgJnOzjdkuzWq7FRDjW3JsIaDihh6k=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvhE/q2kg4XPBd4bRR6XBW4s4Zb1zchB7veW3CFXHO9 rkMB6dlRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzkVjwjw77m6/+FIhrdHBl7 lCqmz5D1W7D47EuWjussAnFPRUWZbjP8Tzwzr/LYW6uf05+8TTh3dH8pVxXTuctfFrEr8swS/F7 /lQ8A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefixes to avoid printing 0x0x.

Fixes: 7b69600d4da0 ("powerpc/wii: fix resource printk format warnings")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 91a8f0a7086e..e9c84793cc4d 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -145,7 +145,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
+	pr_info("controller at %pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 1522a8bece29..a1bdb83fe51f 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -171,7 +171,7 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
+	pr_info("controller at %pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index e7eec328f121..928d082abf56 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -73,10 +73,8 @@ static void __iomem *__init wii_ioremap_hw_regs(char *name, char *compatible)
 	}
 
 	hw_regs = ioremap(res.start, resource_size(&res));
-	if (hw_regs) {
-		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
-			&res.start, hw_regs);
-	}
+	if (hw_regs)
+		pr_info("%s at %pa mapped to 0x%p\n", name, &res.start, hw_regs);
 
 out_put:
 	of_node_put(np);

