Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53A606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ+6NKoU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLlDW5zmvz2xNC;
	Sat, 07 Nov 2026 03:36:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793982971;
	cv=none; b=aTLJ/I1NfLJVG/4dmPQAzSF22NoDovYC2Ts5T1ENQ0NzeRJeOtqiydIFymRVh+EV8lSejnqGijlPVmK01LajO6pMhf7hrXDV/L56Xpg57gGkvNFtRBV/BPMWu9mwqYekYIeyO+dwNEIt2/SPt7IvPKW7EVUNk6RVIISgzre9zRVH8QgqNd1HTCj1FsJP29TXvYErQyCgUlTJNtT8Fwv2A7TJtPgDJ/sFozI3NtltSRC3SosowMqR6ZxXn3/I3C6efpGUFEiJNEGGbWErAj3l/rBcHGV+FL6ijdqkKJudPna4qz/9FV8kBTEt65Vgr2DGuTE+0AksUoI+mFzamy+StQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793982971; c=relaxed/relaxed;
	bh=nv6TTsQFVxrUPnd1xr2yM6p1zEbsWhtAzJp8hQu6xXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afBfK0ok2CmMuSUdVvLx37EmQK1rEHQ1XczM7mkT3PBJCriNt9qNXtiKC9UUkbs/z04PdcCmjHRqYsVeaGkcEGrmhspHh/CTkjo54QuXPqyzprqX0Ra9DNavh+J9PPyN6Qa7ivftOvZAv+dMevwGtW3fieeg70YlIrSLGL3kPihnBKhRE39AAq3mvLGfxFPtGqx51ZMML2SsyJ2wbpFX9uTjhUjZPKMLFdjIv3qWrxpm7hEyGR9Lb1ZRb+F0mQDgHzt/0SGXaCa28eIMmNyV2RGU7zpEbpSVp4J8rBy7QaELbGM4ip0yH+uSw/BtU6Ozg5FsnQvoA8WVLnSDk9bfTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ+6NKoU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ+6NKoU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLlDW24Tmz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 03:36:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 638F043B11;
	Fri,  6 Nov 2026 16:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298111F0089F;
	Fri,  6 Nov 2026 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982968;
	bh=nv6TTsQFVxrUPnd1xr2yM6p1zEbsWhtAzJp8hQu6xXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQ+6NKoUWgB3+OGPRQWiN9J4QdMcTEp0G9hgy1s7AO/GosjIRICg5FczP8KaIHPnB
	 ILdBrM+5+vzWYrGKPBzwy3nv2h2EUC6gl0xou7zdwN/FW7PkWtIl/9CxXuqIiC0FK6
	 1WlFQpxwWYfNT5cqW43XV1V67B2l9I0wFEIeia/xTmcdQ/9yXeFOtUagtGvmG58RH+
	 HW668Bg3z2STBpAKYgO5EQaZP/vjQR3TTjIWVywy7lAHJVDmNIlFr9juOPQ22ZpUvI
	 PA63sArHjmlXYS3w/H0/SYeOFtx7gEAElYQWpAzlqFFb6TLlVK2Ip52ztgAVb5RFrs
	 J5YWQaPTztvDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Sasha Levin <sashal@kernel.org>,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH 6.6.y 1/1] powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency
Date: Fri,  6 Nov 2026 11:35:46 -0500
Message-ID: <2026-11-06-1-daily-reply-0011-powerpc-iommu-api@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
References: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency

This is a hand-adapted replacement for af199e6ca29c ("powerpc/pseries/iommu:
Define spapr_tce_table_group_ops only with CONFIG_IOMMU_API") rather than a
clean cherry-pick, and it has no ack from the powerpc side.

Michael, Madhavan: could one of you review it? I will queue it for 6.6 once you
are happy with it.

-- 
Thanks,
Sasha

