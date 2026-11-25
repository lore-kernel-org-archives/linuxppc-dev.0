Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CD606A332
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuhqqkxU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZT266JvGz2xwP;
	Thu, 26 Nov 2026 05:37:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795631870;
	cv=none; b=gdbCUsfDL8M2RMFInVArAdCvq4wISOsdwbcsyZP9Bpbc6tiHa9YIx7j2us909GHNy+T2Wt8WITSiGVO0bAbUJMxRlmyDQM9VImMEnHU9O7YBKOmaRoeIepvOTq3VxlKo8R8WhDK6mlteW3WG2WZt575EA8erw989qVt5Izad5+J8xpOa09sKZGs0vLQj78N93do8AcUrK7XzKnLf/jSN9U1QeAErLtp/8huAipAqqalZwtpb0K7n6yUayAub6zngteVyTHcJEG1Vt1TG/io2S4RUHioZIN7J4oOsGuTtvxg/YzEXRWmoMnJ8WyEgxpK+f7CBdhDtL/n+Fh7AKS1yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795631870; c=relaxed/relaxed;
	bh=VvIVtBkvtGBFf7JTar8jn3hRuHbpXMIKOcL+nCDLYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3AQYlHZdapWkKtwuNA2Ltl9dfPPXqXDmHCrlp/Iyt1cFnKhKD6s+ajUIPYf5P2kUkPXvuBobrGmOuyX2zyu/Nb1FxBgU8DsWKzmqmA55ZQaPkIoq9/vbt/pkdIkWkWVUXI56o05cSEefm+hlRCoTOSMfT4xe14E6bSe2/fHs0CwDE9NRg9RQnHDi/XdGZSOxyMKA1Aq29HauTw5hCJv7uYuen7cuDx0xc9nqQjHEzfYhtW04NGHKkxsSwGqp/+Yc9Og5BEMk2Iz7+DQory5lMcM7KXoRtIHgoaue2C89V/5zmdFEfZPZ49DiIisVX4TqDEJwq52TMrcAY8W8I25Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuhqqkxU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuhqqkxU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZT256VQDz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:37:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 884CE60D2E;
	Wed, 25 Nov 2026 18:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B325E1F000CF;
	Wed, 25 Nov 2026 18:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631865;
	bh=VvIVtBkvtGBFf7JTar8jn3hRuHbpXMIKOcL+nCDLYgA=;
	h=From:To:Cc:Subject:Date;
	b=KuhqqkxUrkKw2SiwuVxOBC1cnaP1pO4UbmKEp2HNT+hRwrEaFWf7lrtWlH6puvaHQ
	 4uK5lF9sP/WpBFig+TYs76ndpMoJy7okxRz4nd0iT9NHNcTvTj+pu7684lVmeNvfum
	 qpylcDtp1POZDFhVXugyz/CVFvnaCoWfgxJzJax00M9y8XHxHeMAzJGI3Qa+2+/WPq
	 wFcTBFBVA0AKxPPXq6PQyxA0KAP3LncAgGMnDsNyRDV5avpdpCF2WgzdSCs5EbIGbc
	 pa75LvsVWzTOLF9jWt9Y98c9UXU3gjHKYXTN1b86K+Fi7wuO5DAdSg3+ShzZ5bDa16
	 twtpernTqyG0w==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh/windfarm: Zero-initialize cached fan value
Date: Wed, 25 Nov 2026 19:37:10 +0100
Message-ID: <20261125183712.312766-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=blum@kernel.org; h=from:subject; bh=NhEsTHLQWbMD4L+rcbjxknD8d/KdG+dK8aTCZLjFkuQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNnsWjd2aUba5iR7J37980R6Wcb1Chd3FtNA9603HMVtW PMF3p7pKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIkI7mNkeH3+GOORzAoZ53lH jGy61dl5w6b6sjjbh/35seSN7t6mMkaGy26HLbd2O3FzzpjycaqKQvWqvKID+6eem3JV+nfWIZU 5TAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

smu_fan_create() allocates the control with kmalloc_obj(), which leaves
fct->value uninitialized. Once the control is registered, reading the
fan control via sysfs and smu_fan_get() before the first call to
smu_fan_set() can therefore expose uninitialized heap data.

Use kzalloc_obj() to zero-initialize the control instead.

Note that smu_fan_get() returns the cached value set by smu_fan_set()
without querying the SMU. The initial value of 0 is thus only a
placeholder and does not indicate that the fan is stopped.

Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/macintosh/windfarm_smu_controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 671ff959bf06..2f4dc0e2be40 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -149,7 +149,7 @@ static struct smu_fan_control *smu_fan_create(struct device_node *node,
 	const u32 *reg;
 	const char *l;
 
-	fct = kmalloc_obj(struct smu_fan_control);
+	fct = kzalloc_obj(*fct);
 	if (fct == NULL)
 		return NULL;
 	fct->ctrl.ops = &smu_fan_ops;

