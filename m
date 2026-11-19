Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681260A2621
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVqLPv65
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPg55F3z2yVd;
	Thu, 19 Nov 2026 14:40:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059639;
	cv=none; b=W/LtU3Vo6DMbgx1g1bPJSwYMB9x25NP1Cj1YupWvvPCFjNObmxh6F2mxmmTxkNfJViH+u1LYbDl7yGnpslcuG8BZ0OR2uWomsrlwdk4eXtHSdTbjg8RGDChD1HreAmrAilGoNcuefI/QDmcUXs+9tNrKH9dZHVDC51mEiktZDCI9NvyjrJK9gH9FTsnoB4f7OJICYIkFPtIfUzMn5Iep3Xitxmk1M0QGzuHddu0Tyhv3FCV/cyKdRmZPFa5z4cjwdhCV+VY8LP0Gv/je6KpOhNUGyBO7FMPu/94/aTryZknbcEt5OtqUEuT8lKRA+a580FAn6EgB7diVt07Y5ZUk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059639; c=relaxed/relaxed;
	bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOpbl+WkyCxo/EQSa1CMaKA2SkwS9PudF/gYAOLkxGryZcQz6kSLYzVJ0Sm2q8r9uqta4i0F5SJFQZ9c1vZY2e5UT+pbFUZhOv8trW4f/acm4kLmcjmBnwq00w/AaBa535RNCAy48gjPGWGgqIe9ndnuyY4J8OKP2sl+K/udoE1hPWGhw8qBGEcBtq1tR0RNrt+9KTw8pa9zXaSGAVRUVzD/Uj9K/l5R4fq42mo872Ma+vDLXxA/8wZ5NjcQuMcFaEsAAoq9L8K38mFm71HDSgit9TNyTVY4gWr+eVezsdrjQP3Ork2bErmHSGOojTPESVOANFampVca6HzTtbi7Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVqLPv65; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVqLPv65;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPg0CsXz2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:39 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-380c28f9e35so477883eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059637; x=1795664437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=nVqLPv65vNzeydnHHAlIQe9HgioDUr2EGcAE/nYITaceIUIkThUespDN3TuZk7tiZ4
         MUBnfw0hZcrW/KUehexQknIQ2u8Kk3jyXS1UR96KWMvMCeI5Np3c6z5XUTx9wQeGQnbT
         ctDQEwvK149RpYAwldbkMRPQa1jjTIlEyQnrpTmZ1FakokFIC7zG88Dt+S7RcZTHc4QB
         xwJ4ZikPS8mn8cwtM9YCYhGN9duLB9DEOcwiHtGNzBAsmyNtrzsh3TzNmjG53Targ09l
         fb6Vjo1GiYYWZCqyD8QKE6hna9IbqXljGcySp7v2wMpQQuGZzZ0OHzngWwb64xOlbZ3i
         RsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059637; x=1795664437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0MBPJOKvnLE5rP9NIQzyUeRKGazCi9hDA+IfnK6LUo=;
        b=sqeTt0TUCoc+v14BrVBkrfWTuXjw40sKgtgEW+TKi5dPjJEYqfiH1lQlsVLO3RPPu3
         sC08JbeBhHF88bNY82b3QeigeOeaGHZSPJlkZcA0ikFo0mq/mZXMv8THgdiorIx0A0K+
         K9iwlmdrZRsAvfMAlHkvRoDa2XvqKBGFz7GE+1udEYDdH3vtzq51HtNbTjp7+a7wCT8m
         TwAZx7Xq9U8YLNRmsv2K/ELU4fUZyq8MsqKK7XjJbTvQxwnV3k4huz86UxvK4qdf9+bR
         PTQcqz3zTAqNRYnouEgET0IzVY0Ypdol3PaPRuPJcCsBDQ9WdlM5S72Vl/ZMRBpheoyj
         Dqrg==
X-Gm-Message-State: APuU4Z9aYsGdbwkNo0q1ekvdmQ3nZ5gSGppZROV8eaMMtdMXoIB+6mrw
	T6AT713Pnu398+C9ywuPaolXr3QXK4WBcsZmTEpFSqrXmflnoz5tFs7SJA6gIQ==
X-Gm-Gg: AZFdTZcanEc/ZuzwtCu8O4ttwfN+RCC4s+S++pZiDaKvHZ/04ML+0Il1SOZvnFEikjU
	pmQPVZh5uUOEbKyUbFvkzqbEh9sRkstd7UrhcJEgJCZIhedSxNxoxT4pwGZbgbEUIbS0F+tM6mb
	16dMZ9miGEPsHawIRhS7N94OGiAGciE/RlKWXA3H2nPAChe5g927qnEIeNur87rgtszbVdU/BDA
	XpNHd/v9TmA46BrrZj7Tn9YZaW8HYFXzFkFco1wGr6bNcurk1pZ4m33kw1Nxd2wfRvvJDmpXlJ0
	S8VEPjf88MfN1Un0yd9rng3PhpMZcomKjF4C8vtdYP9pJNBFaKWkVKc0C/RoIEXOXGKEBm7IKHl
	VQ4n1F5ebWuIdLrOpnTmLosPA5XwS8nZOu555MKMPFgOB2rPj8wehL0ZhdGo79ii9okelFL1I20
	+tF8spm3A1hPNkL7GQs56hFke3ZJ7oELrfF8sN3lIEK57XjWIQ331vTbM3HXT6QTAsJqoGVbcSh
	7J8uyfN2ardm8FXCKMRGRSY29uZvkGaWxK6ngTWjpGCkIXAsBr5bXp9rm6VpTCOlC2fnwjVtjFj
	9PhXWlD477VeEzHEKgNe7avlk+oalfbKdg==
X-Received: by 2002:a05:7300:da12:b0:36a:2473:9b2f with SMTP id 5a478bee46e88-38446cdd2b1mr694103eec.23.1795059637194;
        Wed, 18 Nov 2026 19:40:37 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:36 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 17/18] powerpc/powernv: Rework OPAL console write to remove conditional locking
Date: Thu, 19 Nov 2026 09:09:12 +0530
Message-Id: <f7e4448a35cc9d9161b20661cc589c03d565680c.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis reports:
  opal.c:454:7: error: spinlock 'opal_write_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  opal.c:493:3: error: releasing spinlock 'opal_write_lock' that was not held [-Werror,-Wthread-safety-analysis]

This patch rework the OPAL console write function to remove this
conditional locking to fix the reported build errors while enabling
Clang context analysis. We could have marked __context_unsafe(),
but this anyways simplifies the locking a bit.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 30 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..aea83c4be76d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -438,19 +438,13 @@ ssize_t opal_get_chars(uint32_t vtermno, u8 *buf, size_t count)
 	return 0;
 }
 
-static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
-				size_t total_len, bool atomic)
+static ssize_t __opal_put_chars_unlocked(uint32_t vtermno, const u8 *data,
+					 size_t total_len, bool atomic)
 {
-	unsigned long flags = 0 /* shut up gcc */;
 	ssize_t written;
 	__be64 olen;
 	s64 rc;
 
-	if (!opal.entry)
-		return -ENODEV;
-
-	if (atomic)
-		spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
 	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
@@ -489,10 +483,26 @@ static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
 	}
 
 out:
-	if (atomic)
+	return written;
+}
+
+static ssize_t __opal_put_chars(uint32_t vtermno, const u8 *data,
+				size_t total_len, bool atomic)
+{
+	unsigned long flags = 0;
+	ssize_t written;
+
+	if (!opal.entry)
+		return -ENODEV;
+
+	if (atomic) {
+		spin_lock_irqsave(&opal_write_lock, flags);
+		written = __opal_put_chars_unlocked(vtermno, data, total_len, true);
 		spin_unlock_irqrestore(&opal_write_lock, flags);
+		return written;
+	}
 
-	return written;
+	return __opal_put_chars_unlocked(vtermno, data, total_len, false);
 }
 
 ssize_t opal_put_chars(uint32_t vtermno, const u8 *data, size_t total_len)
-- 
2.39.5


