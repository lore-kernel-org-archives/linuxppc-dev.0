Return-Path: <linuxppc-dev+bounces-25043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC9C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 22:13:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9RRt6WTGz2xKh;
	Thu, 30 Jul 2026 08:13:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785358707;
	cv=none; b=ciRYgk7CxJrhNWKpzodv8LcsrNQorR5FMB4f09N6d+hWO8SfLv8oDaLB6B21igFv+WhFUUyg1pOvMLgMcHtZl31mzX7Y9gmdbuFsX1X8QV0ZYAUnXTwXqHt2m4BNrZDRD8sMUkPoJ5OLDx4JcW7CYkQwbOZ9wgoWKDIB3mJLG4wzT4kCfLpw0mvBCW0sdodPC/codFXY1j1oqmo9dzA/LIonzxUhfrWl00FGVCESET/558HyECzwLgVbf1rv5yHE2pfuEcWePHAm4fbjVJmMJ/SIqmyH60JFDsgvbwZNtiopNrxpzjh0ZcehkBsEgDow5DsEbkt5dHnwbTdySpvsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785358707; c=relaxed/relaxed;
	bh=bIypgKC30nmQmKcIQ2yV5qlZHiiAZ6S3FaUpt5Pssag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fq9m6hUJdUV1Cw5v+0JcXsDno7fIrCPiyQqRSBuC3biOcJIRyJZKFg8XsUYVnDcNQOPehYAnsiCrzyZZA9zbXZ+dGKQ10nKiixa71vbcZ9gEdWJvz2oLcjK9VQ6gU5M1oc5eo1LT9of/Q+UemrxDoZkdR1M7bbpCg3jAtzbVj6AUfDXX/SBiUUtSuKkm+69RttAN8s+vZAHfF2G2EvdHI8+0cNvMPGR9O/Q/YVjU1OX9QWWYGUuFZjHm7IknQMbNboLeDdZtl4s3/C1Zbn9BdxFUp78Xolbw7nfcyg4PKH9fezssSbG7rLAV5dd08YJlkbTcaUPOyRTKrfsCm5LDpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 497 seconds by postgrey-1.37 at boromir; Thu, 30 Jul 2026 06:58:26 AEST
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9PnG2NvHz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:58:26 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 84BD970932E1; Wed, 29 Jul 2026 22:50:03 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
Date: Wed, 29 Jul 2026 22:49:54 +0200
Message-ID: <20260729204958.755143-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two local variables were only set but never read on 32-bit PowerPC,
which causes an error during compilation.

This series first makes the 64-bit guards consistent by converting all
uses of CONFIG_PPC64 to use __powerpc64__ instead, and then guard the
two variables rc and suffix behind __powerpc64__ checks.

Link Mauve (2):
  powerpc/sstep: Consistently use one define to check arch bit width
  powerpc/sstep: Don’t define variables we won’t be using

 arch/powerpc/lib/sstep.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)


base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
-- 
2.55.0


