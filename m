Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC76072282
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2xK9SMq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG096tDzz2yTQ;
	Tue, 03 Nov 2026 02:31:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633513;
	cv=none; b=mLpVcmwUL1uw/7hWIV+Jz+yjm8sTx6HuG9/S3v0LtwlGn2awEi5+REXJpnhfY5ek8vdUWa75fOY0TaHJH3CjCYds2Cbciphldwt9GQLDDXwyn9YE9hiVxyNepvpaEzIX47PGicW8LyYaBaRpEdpBerP1XQjcEoxr98B9TshwDV+L3/qilqY1ttVFLD8UsC9wq3bcoZs8s18e/N5R06R5ODVdxuIbus6xdP0JkRqTDVnV6hZlh1J0cla9TdCbVBtNFH1o8AGkBEhKgJyLHTxBGI9ytpoyi4NwQC9hm/N7Cx4cGG2AqJ65Boft6xguOVh7Qnwwq+kpIdOoh11WBOVf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633513; c=relaxed/relaxed;
	bh=ZSG+XZ0qJP6XeItaA48g0VFugtl9Yrf3DKIbb0+bgrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv3U3p/r3u0wagMNoVOmHuMjKs3lfT/gkXpo95OLKq66CErhc0SzOxL8PmlmKJZcUtwquctTRl+hrUmJLj6Cu96S4n+aJK1A8ZNSwks91HsRRh/7fo/ARkiGW85hjnlGtLek805PcRcc0Zy6iDX5i7EdPPCeVfAx84me4gfTJ+zw1eHNVT8UvERcOaqPPZ5f6He+jManTuzYSZVmKZ6IrT47fwmp0wADAk/Qu+3OQV5pDKfGw5F10d00l8cqXnqHvExTN7MGtq7s/hWktNDTAhLoDdrZfpf4f5nwgKCnQzUEucLZU83JE0XrWC1oODUU9P0pHV3orXwPpzutZnoJ5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2xK9SMq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2xK9SMq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG092rc6z2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 80535609D0;
	Mon,  2 Nov 2026 15:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B5D1F00A25;
	Mon,  2 Nov 2026 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633511;
	bh=ZSG+XZ0qJP6XeItaA48g0VFugtl9Yrf3DKIbb0+bgrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2xK9SMq0qWDFEeHQkMKbhnKE7r/1ZYbeJs+QVd1HX3l7hBWrFxL67IiI4Xzms3b2
	 iay9mXOi2qwd9DYXUVg23Ud9Jip6R3h3eCtPK0UOATneie4L/zdQFxdQi7IypT/ub4
	 slk6oI317WDZ3AqMUr2tI2bVXGPNR4De8psTG2T9vWpaI6sadpwHAS6R2kizoOirJu
	 HlTpBMb2gP9gIDnr9sFiIeBbKiDN85h8/i/nt3PlRv1gMJ4ZiXEVpYPOK/y6rialyi
	 HtedojKiJFnP/gI1V4n52aOMbIGsioYcRVF5hMmJ5EVj+I9YOxHJxK/iEAdMf088y2
	 Zt5fbG+gRPOCQ==
From: Thorsten Blum <blum@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	Stephen Chivers <schivers@mandarin.aust.csc.com>
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 6/6] powerpc/embedded6xx: Drop redundant initializations
Date: Mon,  2 Nov 2026 16:30:04 +0100
Message-ID: <20261102152957.300019-14-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102152957.300019-8-blum@kernel.org>
References: <20261102152957.300019-8-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=blum@kernel.org; h=from:subject; bh=RiHJeens/IMwaUmE7MVJthRKIR+M4XGfT2WVpk9hsHs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1rSqm/bV+Ku6Mn+7WDZ5K08dM8tcLoO5Z1kertqWu P+epOHKjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZgIy2FGhjkhm59/yVxaErZb eu/n7Xo2aq8sbnAl70s1/bTo1/7dnbyMDOdMLa5/e3Ohfvnl/dnW+3+x1wmsYDKz9SnysIuZ99/ 5IBcA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The variables are reassigned before their initial values are read. Drop
the redundant initializations.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index b6b4d0581fa9..b8a59e147dfa 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -53,10 +53,10 @@ static void __init mvme5100_pic_init(void)
 {
 	struct mpic *mpic;
 	struct device_node *np;
-	struct device_node *cp = NULL;
+	struct device_node *cp;
 	unsigned int cirq;
 	unsigned long intack = 0;
-	const u32 *prop = NULL;
+	const u32 *prop;
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (!np) {

