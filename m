Return-Path: <linuxppc-dev+bounces-18074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172BE112585A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:36:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWHwg2Fjxz3cDV;
	Thu, 12 Mar 2026 04:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773250579;
	cv=none; b=lSnOtrb95Y6IcI/cdZtBPM9uPAzjV88mL8aW3qzqrJPV5/cQB9xVNfXVB4kZiNOEMalTR+xTsiNOXrRakEmaycDeovglM4V2KO5twEr9OU80ze/HkNmVXhyn/hHBsuWmk4hbV8QaOewBln1c8FrkkE73qBHb5SSc9E2abYjyRL84ddrUIOEI4DCGUoT5J9KO94NNqMfcsLyRX/nZ1kCSHp1vBcyfylTw2J9f+mUgmVx2W+/MRw0/29nSOmFqoaC62n/0o79diOKJl4bk4+4vUy8Q4l3f+iV0QXiG5KTlcp0Wkhc2CdvliP3Q8Pdi+Mxed4QqIpYxjgmqyrKa/QhwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773250579; c=relaxed/relaxed;
	bh=FKtS2aBClbTNgCJfNbhbBu4hx+UFx8ABXzEiQJIpFho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fhBOL6r/y5GbkdkXIgqclDNX/KA+40xg/V264XmHXXa7TFKwX0/3pIITdkApvsUWvtjhXfKguugVGWyLOL2UTiDnpYk93u1B+ieh1w5FAIeNPmZiJEGrCgMx1xbT71D3arVE2SD2poLAY2ns1kg0v2+isX45JZrigTKT3kniLOVDkgaQ6sR4gu8xDHCLtnD4+OKeTzPZK6u8OEszxfDeIbXM/CGkCOtH7tLJyAeXiNUlzo85LoyFsow6xyLO+DuvK319bZniGRYcvkdL2OODFVAcd1Tqs9upDXRKEQCg7OGSv8gL3mvMia1WOsXmkEiRuavUC75tpOSb8iUG2R9iDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hD+N6huC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hD+N6huC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWHwf3lfXz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:36:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A494860054;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50357C4CEF7;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773250575;
	bh=xjKTDTd8ojlA8FfIUmj0qcyQ4/gIsPJELfOQhU0E5aQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hD+N6huCGVpA94OuTRFfz+OQZwF0c1V89jFdwN0lqNGJLyqOFHBVok/JJx03aMYoy
	 VvDb08YDTb+yYTvzDnkEgEc1mPCjgMB7zP2OiZIJF6y6OPIrr/otto2pI/VKb+Ytnz
	 ITeVcow0EgEKnI2aTStmFsSth4Mxzud4tW4ZC/3D9lOMw3mFHvcjEmcWYpxcEFqU1K
	 Pt84v6sNfN/YJSSgyhe42vX1f29MyBkEYV4Zpn2V8knwGUFYgPJJoJgc1ivi5BxQdD
	 AEZA701uudzFrCUMgo9AxowAiH9fubXZ/zbSEOQbJ1t2YTeDkB7dRVTOjh9JPfxW/j
	 wzGuiGcKyyqUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418991125811;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/3] PowerPC/Wii: A few devicetree cleanups
Date: Wed, 11 Mar 2026 18:35:55 +0100
Message-Id: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
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
X-B4-Tracking: v=1; b=H4sIAPunsWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ND3fLMTN3i5IzU3ERdkyQTg2Rz8zSLZMtEJaCGgqLUtMwKsGHRsbW
 1AN6YVydcAAAA
X-Change-ID: 20260311-wii-schema-4b40c77f8c9a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Link Mauve <linkmauve@linkmauve.fr>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773250574; l=575;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=xjKTDTd8ojlA8FfIUmj0qcyQ4/gIsPJELfOQhU0E5aQ=;
 b=zhOibk57Sy5roTUBK9nE4MIkOyWyEqD34XxRVVNfbYQWWc+tDK26S9c1UQSMK+MxO+zpyAUb9
 7UVSXf+7ErzDw7eZ57HKw/M1HVBeW+/0UfquAISraqRVWUdU/ae8n5x
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This series contains a few minor fixes to make wii.dts somewhat more
compliant with the DT schemas.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (3):
      powerpc: wii: Add unit address to /memory
      powerpc: wii: Fix GPIO key name pattern
      powerpc: wii: Fix LED name pattern

 arch/powerpc/boot/dts/wii.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 6af06d984685645b4f80132a8defb09747b10989
change-id: 20260311-wii-schema-4b40c77f8c9a

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



