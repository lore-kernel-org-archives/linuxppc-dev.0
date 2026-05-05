Return-Path: <linuxppc-dev+bounces-20485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42393CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 18:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g96w5549sz2xmV;
	Wed, 06 May 2026 04:48:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778006885;
	cv=none; b=HAc6bm50D+ZCNTp7o30mnbouzPP/iic+uTFNR4cgmbCG1RnHNtojiGihSoohesWOP8CrC7j34bnXfSVLfOkMMK4w3cfwLbihcvCjFyo14ZARkXRABoYq6HxS33t0283Ps4JALnRg62CZ0O6wQhdIiqRveu00y8PS8OKDo5CEALG3xHV98W1YMROViImohDJ3F/6SHkBbblXqQTMVq1Q+hCmx6/NV9t80xNKcsXY+K34Y28beqo2npCQRSyxGGqxATgl6bHOy2L1Hy7dSy9VobY49ykJ1aMcwloFTyzRQutPxC5oTMPu4/qsDX0/TpnAAXZbTeOqG37lRYRQ713reDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778006885; c=relaxed/relaxed;
	bh=XREJEEfSek/Xj2uGntFZYjRSQ0aoG7ACXGkF2wgYcMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BbqA1fCGVaDBOSGhkiTz5eJVEk4W0DkEAiAnC7FRduwxbbRVuYjuC5Go3E3mN90AZzyC4jTotFV6pSHcQP8nMg9G3aRicNmh9lOdFFfB/6lZivAU5aL22kutvSe8pGO2+3+09rg2eXeb08Kmvhf6451JAxXq8Jtl+nJK+xyMzHTHu/xpAS8413MLCSdp/CQ6kmng2Puu5uWheG2Q1pCKa+jFz1T8X6eYReyOedqRoJZ25XbLZNG6zyu3BWsaDx45Zcs1Xk2Dmj/g0EPvIEHCCjcYatj5S99HfLP85p7UnvlYeKFT0/4gp/fbhP1zpKzd4x2GVQSY2Y6Saq1oMwCuQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rBDG1FF2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rBDG1FF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g96w453g5z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 04:48:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3246760181;
	Tue,  5 May 2026 18:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F9C2BCB4;
	Tue,  5 May 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006881;
	bh=teXecu22ncC0odwTbIa/grLpjdGgQoUcrHaZTwpAgfo=;
	h=From:Date:Subject:To:Cc:From;
	b=rBDG1FF20de1d9wVtP/yIhz2wDBI95eiXlPMg5DVTa4/XTduyzX6VxPeWf14yH7Dk
	 jMvjcrx3ZZKUwjT5qJPECZOFYlONm880X8iSfkl3ZnC0zVNd3O0/EOT1jT1kFCiTcl
	 BeYoR7e8IxudY6hmduX0vgtwC52yR/RN4YQUlQ5AlbIuJDwMIpAU3tVP9kL2hftpGf
	 oaJ+j/e0BqmCnGZu+12hEjyIPjZvsOlxgMV7iytgV+U/+KrCiIq2avfaYcSA7ehWD7
	 myJdo0A83Kz7OdeyU3elTy7WUCrVucwT8zsPhKsx+Cj3o1dNP6HqbjGXwf0hL8bNN8
	 jCTUVlFG/ehhA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 05 May 2026 20:47:56 +0200
Subject: [PATCH v3] powerpc/g5: Enable all windfarms by default
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33N0QrCIBTG8VcZXmeoy6Vd9R7RhXNHJ5UODSuG7
 54bdBFEl/8Pzu/MKEF0kNChmVGE7JILvka7aZAelbeA3VAbMcI4ZYTjKTwg3pTGlmMdvHEWd5I
 yAbIduNihejhFMO65oqdz7dGle4iv9Uemy/qXyxRTLDoilZJ7TTU5XiB6uG5DtGjxMvsYHanIT
 4NVQw/CUC160yv4Mkopb0/NwiL5AAAA
X-Change-ID: 20251205-powermac-g5-config-69128e93d584
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

The G5 defconfig is clearly intended for the G5 Powermac
series, and that should enable all the available
windfarm drivers, or the machine will overheat a short
while after booting and shut itself down, which is
annoying.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
I wonder why this never gets applied. Am I doing something wrong?
Is the patch stupid? No-one cares?
---
Changes in v3:
- Rebased on v7.1-rc1
- Link to v2: https://lore.kernel.org/r/20260120-powermac-g5-config-v2-1-cd8f1c8bfbae@kernel.org

Changes in v2:
- Rebased on v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251205-powermac-g5-config-v1-1-8609aa97c1c0@kernel.org

To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/configs/g5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 04bbb37f5978..f74ccc06f4c1 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -85,6 +85,8 @@ CONFIG_PMAC_SMU=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_WINDFARM=y
 CONFIG_WINDFARM_PM81=y
+CONFIG_WINDFARM_PM72=y
+CONFIG_WINDFARM_RM31=y
 CONFIG_WINDFARM_PM91=y
 CONFIG_WINDFARM_PM112=y
 CONFIG_WINDFARM_PM121=y

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20251205-powermac-g5-config-69128e93d584

Best regards,
--  
Linus Walleij <linusw@kernel.org>


