Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA7606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAnOFQ1A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tg0DcNz30DK;
	Fri, 20 Nov 2026 15:04:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147466;
	cv=none; b=A+FTh0WGIizPD00usoM4SF3MzXvvnzFDqJ0uckjZxWzqjhPhYPmv2COLzBB4hAqsQsZof5ECQuy77F+xzu2d1eNVVm15WqoseGy1VXiIHyi1SXYZXjexwPammify54szDaNXyxXK1joQe6NKnP5HGEPOXgey+ISzKQW+kQ+tBwWOk86jwHZt0on2Gw75au9F89kJ+FVAZ591mSZLqtwBnAhCrcT2yRHxnT2gVILpJ6Mndgyd7erMV1SnfIh1aJ2lz6JTajX0ityIOHjJWJiUCmlUF4trMyk3dip7tCqD/rZ34WmZZwC0oZWn1ioDG0qyPg57VIGWHWp2uPljlbRbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147466; c=relaxed/relaxed;
	bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOsggX5kKg0FNuAjSn6nW63160FBduTnrB24VP+c9aY9qVJttvvlPpykAOcoXXhioLU9hPSKHHcuNBESadA1XbDN0pM9hLMQzal+UKEuPRVu5XnE6pDBCF7EyuYLYx8y7f0H9pPpdDYkSK9R9c5nFo0ieeUklW1zpjYG0X0KbcRLHRBDlmemxG1e0OKKDTfHKBSjOg7LMEwR8ViNrooQeVDpIn5nc8OtvcWeNZVxcaetoAXEsA0DyBNuoaPDA9ts/RcBPT1+y01GzI4zEYOKfbC7ZFVp7a1yZVjyoCIjWV36xak3Lc+jC6QIeQF9Nc8PYOuBmoA3fwn85Qp413M31Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAnOFQ1A; dkim-atps=neutral; spf=pass (client-ip=74.125.82.52; helo=mail-dl1-f52.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAnOFQ1A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.52; helo=mail-dl1-f52.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tf3KXnz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:26 +1100 (AEDT)
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so782323c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147464; x=1795752264; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=gAnOFQ1AlDmkd4KKKMqkakU+knQRfEdM7iaxY3Be6+KOrvQExlxZJGr7jWUMEQAUxm
         prpjOlNSwDt3BhhIAwOtjb2A/dYgkNSAsQtXods6Fx/NYPdUzZHvQYnTExQBCKsNWd6P
         1Zx1Ky6SYfI2+0EQ+G/XLZ1XMpMHr1jCl60XyzdNdi9qq7sxmrPyJv4vnH3KYvCxrRin
         5npLgAA6JEneqLCy5sKS9i/F4cBy0w+6bvMBhfGu1UUhkQyVa3QcKIpqnm1gK09qZQgF
         tIiTbb1DL7mjV9eCifh2i/GmAj1RCtAetLOjfNeWgkzC1p9Zm7/L3TXh5hwjb7satzUu
         JGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147464; x=1795752264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=Yqsk+cCvCryzVhdlYIbYZ65gYhKad/8Bc9f9uEFTJ8nO1nyo3edDQ8G0T3ZQwGodjt
         DkPNxyrOh2Eeq0J9B3WqXGPCQvSpVAiTRhFrjNAt9SRNovtMHTGnnvaGGOcQ/jTbwC8I
         9+oSlrekdZqGo+Fg5EC7ryRl4DqS0KE1+l0wLPS6bElz1MMNb3ff5zjA4t1nDy4RS7Fl
         vDk2ygVK8Zq7UZYXiu+z7LkWuIt+529wsbidecEBPa9SpFI2nCRl/B/TRl1KzkISPRqG
         NdLFsxpM15P/7/v7gAtEDJVnlX1WzvcDmFyyh+A1MxqA1iOt8dP2bWgup84TIZjnLV9B
         l9pg==
X-Gm-Message-State: APuU4Z+pPbZVvqRjsulLUwZJ2Au2aITAo2y+jRqxJdZGNPmCc/20bzZV
	8uag7Vt16VBYAGe+3PaohUaYOuPK9yiWU41QJLbQXBZfEcW10XIpa0VXN2iJAA==
X-Gm-Gg: AZFdTZfS2C6Ru38ZdG1VI1UXSsg3IzzOB9pL4y3Dy3+wWnSTvFmN1keLsutjRA+NBhM
	dR1Nw7vweR8pXPCnL26gY8OydATQtd5XNVsiaeUYcq9WNWoYTUesOQU4Jz1CVed1MDI3N0a1C2x
	8w1KLoK7eISgZN4TB8Uottt3XwwZR4yQG9XXko/gIkfSEs0kWV6jbNws9zSvmqTt7RQ0bWrPr8O
	2v0UBAnexYTje4EG4GkUZ6lErv0taUYpN/Tqm6wE6mZYMgN2VnvkQAbl6+g/GPq2BoFh3+aFiDk
	8XgdaNRrWovmc4VWuppDrBPRYmXJuc5nQW18pT+w2HzVhOEqa/1uKXgIwpLksrKR+BDzUgWoQ5W
	uQoLQ3iC42iWNdx12+cJsn82E3GKLd7kx1CKVU+hK8GqRzGCLMEgMWQGFhy597MA488ZUNtoF4u
	dJnb5UgM61B+YN5ViAJw1b6PdTaXG4P+b/Yjqu4gjwSNJfWjJ33l2fpjOsA95g2jxF9X/UVwquB
	HE5+niyFL8iEdvH6zF7F4YtRrGcNn2J6YSS5Rx4iJQBmazN5CBQeV5gA3kfI81OJ5ykrH1coFun
	AU7liUHA8kndtTdrlN3wQTvccXYq9KebBg==
X-Received: by 2002:a05:7300:3e93:b0:383:bef:b6f6 with SMTP id 5a478bee46e88-385701574f4mr1638420eec.21.1795147463979;
        Thu, 19 Nov 2026 20:04:23 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:23 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 13/19] powerpc/pseries: Annotate the RTAS indices sequence lock context
Date: Fri, 20 Nov 2026 09:33:12 +0530
Message-Id: <4d966d74a0d6c6f5fb4ff04a116796097f4f29ab.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
  papr-indices.c:145:1: error: mutex 'rtas_ibm_get_indices_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-indices.c:158:2: error: releasing mutex 'rtas_ibm_get_indices_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to indices_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-indices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-indices.c b/arch/powerpc/platforms/pseries/papr-indices.c
index 3c7545591c45..3f3b88f708a3 100644
--- a/arch/powerpc/platforms/pseries/papr-indices.c
+++ b/arch/powerpc/platforms/pseries/papr-indices.c
@@ -126,8 +126,10 @@ static int rtas_ibm_get_indices(struct rtas_get_indices_params *params)
  * indices_sequence_begin() - Begin a indices retrieval sequence.
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_get_indices_lock held. indices_sequence_end() releases it.
  */
 static void indices_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_get_indices_lock)
 {
 	struct rtas_get_indices_params  *param;
 
@@ -150,6 +152,7 @@ static void indices_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by indices_sequence_begin().
  */
 static void indices_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_get_indices_lock)
 {
 	struct rtas_get_indices_params *param;
 
-- 
2.39.5


