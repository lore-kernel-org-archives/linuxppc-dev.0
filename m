Return-Path: <linuxppc-dev+bounces-21856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC67BC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4FS2TJ6z2xdh;
	Tue, 02 Jun 2026 18:46:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390012;
	cv=none; b=jEt1F8IpaCy39ObjPhE1spZw3vCEkfE4jcHWg2mlurHxBKM5AxcV5uAECT1K4bV64c4e3+sLP23r38iPUp4trINxSPuigKMmWTfyGApPviLczAzYJ574D3a9PqpFsDe7TSBbCj7LzkSLOjRITY070+veldqt1gpKNnj+KErYtSJcP7CUAuUY4n/S7Or1EM7++a1CMQt3XJoEl/9LyV+pXyIJ9ot1tot0i1jOeajOENX7F+YjCdgI15R+3bbXZdbkBCO/wqu1e60eNoiXfZlWrPVvH7F1VEjD4n8nQOulGKHX5FfnxX2UP6vWp8YYA/7yF+mBo+cOfxUqUWzXwk8KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390012; c=relaxed/relaxed;
	bh=LiEEid79s+fgL4A9HaCEIKw/byNtZpi2RLsgMHT4Q/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frZnHdeYiZGGULBOEL26utKAQsO5IWt2HycHAAqbysPZvsERgTzr6tA4KO+uX/AAyV5dhnr0JGb1WJkHncwS9D1dkPR085ubR8Fdd9HqEliDuVPmLauwWcEfKXRtwjqYoGGEb6blJu4el6O24Fgb7YRZasLfKIAlCV0oGEd3Y7UMbZnDDoK2RNEVhMgBpgGa5mCTmmKskD9aOTUNImUir2BgEiQZEbTUf0yXZHju6SyxHJG+tbOm6y9augMkBUygqBWduO5WSKfOd33yxeZe1Lr/9k4QPFP+H5fEs/h2SevF/A6AiKzGug92OKFe4P8Yg6ORSkhBgNJhIwuaaApRlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IquNWICy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IquNWICy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4FR3s0zz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:46:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C76E437C8;
	Tue,  2 Jun 2026 08:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E71F00898;
	Tue,  2 Jun 2026 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390008;
	bh=LiEEid79s+fgL4A9HaCEIKw/byNtZpi2RLsgMHT4Q/I=;
	h=From:To:Cc:Subject:Date;
	b=IquNWICywuPr71nz++tMfPi5ripLIQn1vQHI4EWlER8HP5biO3SLG/rzvuCKMvS2W
	 +nFxkr0O0jq0iNoZFa6bFx1aO73H0XFrzkmKUO2WK57qLRV1TrDVfV1ilWwkpLciMx
	 ZuBSvxOWE0LNuPuK2OxlFqeHInGX2oxqhio2TYlue+Rtpzcnr+ddRdbHKFdcTH1PDo
	 WWUWo6alXsQlCdyWhbdXB7mbEEyC3Azk+gos5csU6WTkFJi1Ptmg0JGroHX35eFh4l
	 2vZ3lmUsemK5A1UgVSDwAEsarTaGzng6qFmuj54BHDWgEt/omzuixsiGzb3OHZeGjV
	 g9OWRmQS9w3HQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/8] powerpc/signal: Convert to scoped user access
Date: Tue,  2 Jun 2026 10:46:29 +0200
Message-ID: <cover.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=chleroy@kernel.org; h=from:subject:message-id; bh=R2aUlUFncexEQx4LTNpm1qke0XTPqwNDBsdBxdAl65k=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzch4s7T3tvzm9uZrX3guHFx++O+v6PUT+VIOnV7MU mC4Pp31WEcpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYyNpghn9a7hpHjgXPe5yr l5qdtiWdz6dfo4O/8pvsJnmdtpzzf6cx/PdYlrBXS3HjloUpxbVfL+n6W+bdjD9i9CPss+Ykydf rZ/ADAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

This series converts powerpc architecture signal handling to scoped
user access and enlarges some of the block accesses to minimise the
number of times user access has to be opened and closed.

As mentioned in individual patches, some bring real performance
improvement.

This series is built from previous series [1] which predates
implementation of scoped user access.

[1] https://lore.kernel.org/all/1718f38859d5366f82d5bef531f255cedf537b5d.1631861883.git.christophe.leroy@csgroup.eu/T/#t

Changes in v2:
- Add a stub setup_tm_sigcontexts() for when CONFIG_PPC_TRANSACTIONAL_MEM is not set in patch 2

Christophe Leroy (CS GROUP) (8):
  powerpc/signal32: Convert to scoped user access
  powerpc/signal64: Untangle setup_tm_sigcontexts() and
    user_access_begin()
  powerpc/signal64: Convert to scoped user access
  powerpc/signal64: Access function descriptor with scoped user access
  powerpc/signal: Include the new stack frame inside the user access
    block
  signal: Add unsafe_copy_siginfo_to_user()
  powerpc/uaccess: Add unsafe_clear_user()
  powerpc/signal: Use unsafe_copy_siginfo_to_user()

 arch/powerpc/include/asm/uaccess.h |  20 ++
 arch/powerpc/kernel/signal_32.c    | 498 ++++++++++++++---------------
 arch/powerpc/kernel/signal_64.c    | 138 ++++----
 include/linux/signal.h             |  15 +
 include/linux/uaccess.h            |   1 +
 kernel/signal.c                    |   5 -
 6 files changed, 334 insertions(+), 343 deletions(-)

-- 
2.54.0


