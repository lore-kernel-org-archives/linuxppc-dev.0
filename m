Return-Path: <linuxppc-dev+bounces-17588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B762EDA68F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:51:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQKyz4nTDz3c40;
	Wed, 04 Mar 2026 02:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772553067;
	cv=none; b=FQua0u8fQt9CdjKn9+AO0umaQGCVbIyoLw0PDmhfOoc3W4QcEdQvekOljmtW2KpMOswOA9MZlBovKsB9CcYvi25/9Ajsg3HRN41ztAt23GriQJxaFsKzLstogTcgrJ3Nh1ncA8URI2zzx6JIGRFTcFPuiCdIbk+fM2f9skPJhP9mLcPX28wtxQUyBGGWew3WccDT3cxOGdJOCoM4b2BKa9Cgm9GcpFJBewEdLGa6ZqxUZwg6BMvNHe4aNPIZMYBkh73xX3n/pJsL+dD3hdwjNdpsFE5gTbvFdDtqcQN6TH6WLKzI0JuEvubwc8Jg7T/xwJSX7J92t+LACl27xY6eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772553067; c=relaxed/relaxed;
	bh=nhYbY9JpemZA/SSNPnIlbeSZ1rFMmu1MfW/XoDAMS/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RIkwAuhp6kiZlFh7EB/2IAPgFyymmLTtMgvSZvg3i/RtnXg8w5njz+v5nyRt1zzyETKME77jup66v3QZ1AjC39kIGgGoyUNAIBsNCg0teUoXA2oFF3cNnJTcSUXff64qliD/jpUEZv8GvNqrLklVrVLuxjImuS7eKxTamh1Dq8N5HXwRC0GyaHTXrp65ybMD9pj2OZYwv2AP49BogioEeC0G0a3oOXGBpRfnU2ocKgiDgIvT1PR6RPtnaPdkCW+xxtGKANWQw6Q+V3jtpzReB9AQcA/e80nIOJ4T0H7zrX967tkKWzRJ/04oyVGblGTBqz5Crn2HqTixwOvzm1sZwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvLhGrVT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvLhGrVT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQKyx1stNz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 02:51:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9F6060053;
	Tue,  3 Mar 2026 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F80BC19422;
	Tue,  3 Mar 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772553062;
	bh=79m/nJ/QDMP8KLr5bX+4nacC2eKgzRySRWsaV7zH+GM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fvLhGrVTUoKflqESHQQVMzU2LPTVN0i5gxbPA3D71X7sPFycd5zSIHa6GuxhCc8da
	 yWCmJh3/EP4ObpSLW21ShzenPXlXUdGM27GvLcyfje/alAkndorPfGMBhTjKEHr51M
	 fKx1ewYyEsJyD+HX/ZnGWAuLGFxGCNe6266pR/uYXkHvl7aWs01H/9aS7CIrDvKjIB
	 SIvxlYbBdOew18yfmdH2KIa3iQFcc/7qsxCnKFTiVt85LtWz0m5UFMose/poisoreK
	 /dKJV0tEIlhI7DBAgaPuKcXGyqNbUa7ihHafadB9IvfgDJE18rrJca0N902lMaFMpo
	 KLlQaANi5Khig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D47EDA68F;
	Tue,  3 Mar 2026 15:51:02 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH RESEND v2 0/5] PowerPC: A few cleanups in MPC83xx
 devicetrees
Date: Tue, 03 Mar 2026 16:50:50 +0100
Message-Id: <20260303-mpc83xx-cleanup-v2-0-187d3a13effa@posteo.net>
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
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772553061; l=1655;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=79m/nJ/QDMP8KLr5bX+4nacC2eKgzRySRWsaV7zH+GM=;
 b=zrNwdxzIbYzU/MGAyY0HR5Ici/8ZnZZKhC/bkSy+egATOEhlLVs9Q8qIji2hiK+Duui3GPCGi
 0UMAJUK79SjD43EpU71/2yC+3eOnMXb+/fK9RPUc0p7Xbco4jcxUGsh
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This series contains a few cleanups for mpc8315erdb.dts and other
PowerPC devicetrees, which are hopefully uncontroversial.

Some of the patches were previously part of another, larger series,
titled "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board", but that
series became too unwieldy to carry on. For this reason, this series
starts at version 2.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (5):
      powerpc: dts: mpc8313erdb: Use IRQ_TYPE_* macros
      powerpc: dts: mpc8315erdb: Use IRQ_TYPE_* macros
      powerpc: dts: mpc8315erdb: Rename LED nodes to comply with schema
      powerpc: dts: mpc8315erdb: Add missing #cells properties to SPI bus
      powerpc: dts: mpc83xx: Add unit addresses to /memory

 arch/powerpc/boot/dts/asp834x-redboot.dts |   2 +-
 arch/powerpc/boot/dts/mpc8308_p1m.dts     |   2 +-
 arch/powerpc/boot/dts/mpc8308rdb.dts      |   2 +-
 arch/powerpc/boot/dts/mpc8313erdb.dts     |  61 ++++++++-------
 arch/powerpc/boot/dts/mpc8315erdb.dts     | 119 ++++++++++++++++--------------
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |   2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts    |   2 +-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts  |   2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   2 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts    |   2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |   2 +-
 12 files changed, 109 insertions(+), 91 deletions(-)
---
base-commit: d3f2d8e7de622d2a2d4283cb545e51745d87f0c5
change-id: 20260101-mpc83xx-cleanup-4de8df290c75

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



