Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1E606A322
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umwqvr4A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYk711Xbdz2y97;
	Wed, 25 Nov 2026 00:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795526669;
	cv=none; b=e+hKuZb1N+kycOy3M0Pl7F8rnx/c+BELuvSgb0evvpWBiUk29fUwcUKeNVaEl7AyXCBnAV2IkA49kKAH+gJcotzda2gEWBWj0OXSDD4YsJeItjOQ66CmLHGGaLer9Ru5M0LLJQGTYETrO5yX+90lARvnx0D9TjAjAFfOIl6zpqoStBkruS84054fA4TPPPC8Mi4n+k8CEQqlOfIcynvMyjZkA/1zeb1Jl2Sua78ttM/oLr7VjHy5DVC3lmbIGmS+kS4yv93CcVJabgDKwRHJJQH/RS4C3HpDln36MTsgZ913SbLsfo9AYgE0dWIQYYIz+UiJ7Qfx+vvyBKhimgYuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795526669; c=relaxed/relaxed;
	bh=v0H4IoVgValAY9KH3OFJ/PCc/BzfrhgHdAh2y4qLHXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE2NTJe5XP0vj3l86Z/FeM5AmD9ivmKZaO9gsaeGiHixUQ9aIdO1Y48MmV3Qw+iyGpMRHa2PbjeRaEvR3Dvsa7FnWOTb+E/lOd0wyfFvVQNQqVWb3rHLvpdHlgf9FBJIJ/IOQedYySE6dJWfB8yCca7hq8zkXow5z9GRyC5KTcCxaoC2nwn7EdVCbJreJkriIFZBExBIzZEHktqhu+m1kY3Z86hmb2gmAKLWC6Bi2eGcTDjYfaNxzHn0nQlrAmKmOLltBoBEc8+1ArTUelqEjHpN+Nt+i011PoEQ9woaIef5o8PVDp+hCbCWfHD6D9aqrZT9SxZjSZrnFpjb/5hN6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umwqvr4A; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Umwqvr4A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYk703nJ8z2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 00:24:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 668CA61B4D;
	Tue, 24 Nov 2026 13:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AE81F000D4;
	Tue, 24 Nov 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526664;
	bh=v0H4IoVgValAY9KH3OFJ/PCc/BzfrhgHdAh2y4qLHXg=;
	h=From:To:Cc:Subject:Date;
	b=Umwqvr4AnKylaFm8ULZShkTPVrAcrddgjFe3zvWC+PJkVGSUBE0elwcbPZsiUATv5
	 LajZ67VBd1XfH2sH/MFMLNfVKhWX28nrRTa/gOytvu90UHPUPASJ7Kx6hni/kb8zty
	 Ftn9XZl+dcYv9AyhhTCHjwfvkiJkvClw527rTUkiCMTBDzeCN5dnZX67QpG125u4/Y
	 GvjvVS+CRSTSCSENZVnQy0dBtLdtNYGFml/rh6qXbNfkEoxnVky1iicJTJqSmBNYxN
	 eeaPTskPsGD5CUFYI6t6p8P9aLpeRszCtRdqavos6+fvXlfRkabqIqp0UyKBs513C2
	 Jj2e/cDj1YGfA==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh/smu: Fix BCD encoding of the RTC month
Date: Tue, 24 Nov 2026 14:23:38 +0100
Message-ID: <20261124132342.235824-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=blum@kernel.org; h=from:subject; bh=+GUSgd/kcbCLQ0hx1ts0q6kx4rzcDkKxozzLPt4WMrI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNms/ff+iYU+t/iXJD1n0bkjG9RfHPiRzJL0RsT+vdthu RNlWh2bO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi/gyMDD8rv5/gmy6ZzH7v i9ivx0vXHHZ6/mJLzout/1K4/t/TnpzI8D8zieO2ou3m+xPLNm7ovyTgX/Ll7F5hgwN3/RRmCOs IefADAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SMU expects a one-based month encoded as BCD, while tm_mon is
zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
October as 0x0a instead of 0x10.

Add 1 to tm_mon before converting it to BCD.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/macintosh/smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index c463760710b6..fb93094ff608 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -374,7 +374,7 @@ static inline void smu_fill_set_rtc_cmd(struct smu_cmd_buf *cmd_buf,
 	cmd_buf->data[3] = hex2bcd(time->tm_hour);
 	cmd_buf->data[4] = time->tm_wday;
 	cmd_buf->data[5] = hex2bcd(time->tm_mday);
-	cmd_buf->data[6] = hex2bcd(time->tm_mon) + 1;
+	cmd_buf->data[6] = hex2bcd(time->tm_mon + 1);
 	cmd_buf->data[7] = hex2bcd(time->tm_year - 100);
 }
 
@@ -421,7 +421,7 @@ int smu_set_rtc_time(struct rtc_time *time, int spinwait)
 			      hex2bcd(time->tm_hour),
 			      time->tm_wday,
 			      hex2bcd(time->tm_mday),
-			      hex2bcd(time->tm_mon) + 1,
+			      hex2bcd(time->tm_mon + 1),
 			      hex2bcd(time->tm_year - 100));
 	if (rc)
 		return rc;

