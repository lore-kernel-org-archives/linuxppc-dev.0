Return-Path: <linuxppc-dev+bounces-18168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1CE105F790
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:14:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXL2F6Qphz3cK8;
	Fri, 13 Mar 2026 21:14:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396885;
	cv=none; b=mT2wj+NyqSsCnV3Sq80iJWMiSGV9d+NpGRh/Sia2Ygeu/kW6yHrQcEsBW76jYiW6qwCEU5/H8Sa/klpjuivywQRMEI3ILxq1bpTT2+XJkDBuWNrF9KJyU+znEKO6thpZzM88myJ0G2UdONC9yImqbZCZxo2qKa3xlmNQsInzbPuRATR+TezVOm5suFexsXaU5vpFuD+SNvgLCUO+/R57DyfMbHzOGd/dC5nsoQBLT/Fv3jqSB5HyJvVi/wVUvJwo9Wl64T1PLQ+rXBr6tU+murfptnRjPzF23maiDeVu7inpPxduV/sPTUx+KWYzIK1r5SGnlsDwEK4YNaaNmkW/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396885; c=relaxed/relaxed;
	bh=l0OzTegF+r5FOvdZ3fT8Y4ZklWMxJboKfmMRGr5GtqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D+2J0LLi3Sy80733EZ0YW9SvyN2OTUuzvV0c5Sw7g0qbETcC4U2ereD9J3mUt003EaBiweynN/e3CPfAa1ssOLxrVKWEtUzxhM3HXiEjL3Scjo4qe2+la/0hDUrLn3Qy6Nrl0HCSRloLxkxNKwdqojJa+348K6xTLcmTblXiiEYnNByJRaju1ghvD1NI5FZbh6+ib8EGHo9TtvlMTxDhIkwapPm0tMy8I0LnsPfbeGiQxVK7uYQrDimCcbTJI6zP7bbomI1GhAUybvgm0UtH9LXAwfmQDwyozW4bwQEKKZQa8rr06xWlp5cuk5rjXrsysbXXWjiyxgD4NRQL9rjvJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RDSErkRo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RDSErkRo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXL2F1ws5z3cK4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 21:14:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AB866012B;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F82EC19421;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396882;
	bh=Kf6XOEnYm2GvG4lKYi0o2kULPxTSxS+f7wvZBuUn3qQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RDSErkRoUtRZ8DCUAT7+b/7KfmS5lk1ldfy7Qt4fxyJvKU5/NCXa2/u40tycui2H/
	 DcJ44Y6isRjXXqZix9VVVuQ5zHyF0qaoAX1p7LVHqkvCWuZkctZit/+SCHRzKQe2XT
	 lHlXUyTHkjSO6MWlNubeHBFQlDje0YOxK03M96yzzPYp0mT74ycL6jraWiSraAyAzC
	 L6oIh8t6yTgxKRhJZtajnbLRvzgK1jPqJbbS/xdqeFQP0Cu+Ra40JBjmMRAIbDEdST
	 hOuoVNhiwS9VefQsdJIWyvf5gCVSj9FmVznscvGPXSB9ASojgcWB1A6Nl4JCUSQ29s
	 TLN6hXgXwTCHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1465105F790;
	Fri, 13 Mar 2026 10:14:41 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] Add missing model properties to PowerPC DTs
Date: Fri, 13 Mar 2026 11:14:22 +0100
Message-Id: <20260313-ppc-model-v1-0-bf19b3d1b65d@posteo.net>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH7js2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNj3YKCZN3c/JTUHF1zUwNTY3OLJEsLS2MloPqCotS0zAqwWdGxtbU
 AL1hY3lsAAAA=
X-Change-ID: 20260103-ppc-model-7505378b9893
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396881; l=1021;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Kf6XOEnYm2GvG4lKYi0o2kULPxTSxS+f7wvZBuUn3qQ=;
 b=KR6jIkoaxRRvaO5H3NOKWTIZDnjVVcw5alUG/E6A+QYykmdXiuqYmjGMGm67s0m6z8dNfL+zI
 K4Mx3SvUePHAb20hXi6kVl5kuVpjjL7UiiBDmsK+6H8I1U1SRyG9Eq3
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

The devicetree spec requires a /model property, but many of the powerpc
devicetrees don't have one. This series is an attempt to fix it.

One practical advantage is that scripts/make_fit.py will no longer throw
an error when invoked with the powerpc DTs.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      powerpc: dts: mpc8315erdb: Add missing model property
      powerpc: dts: Add missing model properties

 arch/powerpc/boot/dts/mpc8308_p1m.dts  | 1 +
 arch/powerpc/boot/dts/mpc8308rdb.dts   | 1 +
 arch/powerpc/boot/dts/mpc8315erdb.dts  | 1 +
 arch/powerpc/boot/dts/mpc836x_rdk.dts  | 1 +
 arch/powerpc/boot/dts/mpc8377_rdb.dts  | 1 +
 arch/powerpc/boot/dts/mpc8377_wlan.dts | 1 +
 arch/powerpc/boot/dts/mpc8378_rdb.dts  | 1 +
 arch/powerpc/boot/dts/mpc8379_rdb.dts  | 1 +
 8 files changed, 8 insertions(+)
---
base-commit: c9849854bc5ce9afca21f97bb17b7ff763fdf159
change-id: 20260103-ppc-model-7505378b9893

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



