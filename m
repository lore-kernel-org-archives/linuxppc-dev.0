Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DF606A339
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVaxfckk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPH2gGPz2yST;
	Thu, 19 Nov 2026 14:40:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059619;
	cv=none; b=XUPxO3+xO9vsWcI2iWduwVX+Yw/6gFHdKGz+5PMldq+4OU7mE7C2hDsVRsxHkahQqdz05Egxn4uidyr7scA+vp7sbVvwiw4/3iMgrP//DEzBsmbUAc2iRAiNOzo9SseIRvZNSjChKnq67syLhc6MOUk3ARR5YWRAlL5AdrkdVOwEhagfRKAKkGGCcsHX3SldWK7MLUgIhK6pDDuMv2FbkuIfIUZuBkI8K3McwjyvU5lNoVPXI2VtPQfGWdAHc50mMo9XiQtteuZO3f8w3JzH2iY6/Y3KLNVDM+Q3fC4dETkoeF5EQK37JihEpBvdhtdqL26sVPp6NDV3L1Nq2SwqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059619; c=relaxed/relaxed;
	bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbHkaN42Bu7FP8WuXmX6/rZKIQP0QtpuyuFP7+zl7224Ak7vFtAT2XpSxQqoA6/IBhhlqWk1E8/QNO7aHY3wyeAoys2jML+IKcMs+REi1hQcQXu63n+DQPsIzw/XMMSU+V2A4GEV7z/uWp2I8hfVl9RH2O2ePz4VBSgU1yjUEKel44z9UiUHnq9jJ6NWe9tt9WxjvmAaAvoT+usS22Ou6Ppaujp86hV8fR9TX0BEaBnGnu3WzmBeYuzd/w2cI6+U0HOVbwnH7Ge7fRS3VQq4yXuAPEYr2wU+2nt4VlB0J9D6eXoZON4PMgnYfdnWrJsAJ94rO6IJLpg+8fqB/Q4Ifg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVaxfckk; dkim-atps=neutral; spf=pass (client-ip=74.125.82.177; helo=mail-dy1-f177.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVaxfckk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.177; helo=mail-dy1-f177.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPG5qPQz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:18 +1100 (AEDT)
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2529757eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059616; x=1795664416; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=DVaxfckkrO1vEru79icTcAkXjOdsIIQYitaKWczCHC5c8cR6LkN16Sw8LnbverH4/B
         MVlxLRPJCmP7UpWTy5biIXnG8K9UzvkRKCKNdRQKkuQyiYKqcJLsiyZbm4U0JY6NipO0
         Dt/+T38SRBuSk22cLncr+Z4Y+tHl9AyVy/MtAHgwMUQvHaWPWOAagC3RmGHGgTuMfwIn
         IwVbi6LRq7wyhMEaCU8ReXXqhKMopkrownKgg+5ldlyuztc0IDpr6hnu05f+9tu/3Kgm
         zC0oVZUnajyguv+XzXVidT//5x0Gn48cyqC15ujihQcE2LJeCSaJ/beLCfXyfk8GaB35
         Rexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059616; x=1795664416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15P/O4uHafhoF2a9GtiIC0oqae4Qc4Z1UYDUjewxzlo=;
        b=JII0L+fi82S3F/SCHvg40OEnk6Hq75pr7BZap77LR1tw+WAQSVgVyrYRxCnq1ofMZg
         1sfjTxj8Fnq85uOUoNDQWXkZJCwizJZLqWNJYKQaPoWIV+22u//48k1YyfiiVxN7PKyh
         WVQRJteUKOQNeUQKUsjTCP18yJ6F1KzIyzN8tPEawgL2T7U8R7JJShcldO9q5RntTBMd
         mmG3e26KCqaemPwTzoZKEMj2g2fO6H1EIwK/nxO3um96EuKh7AU7PhFYh/Uorvo7iS05
         ENP1MEEH5AMqw6jDN9Kp4ZUa+VoZ+Zf8lWuwiDy7mHbdTaw6rxo5D0Yax5gn0zozXFDM
         NIkQ==
X-Gm-Message-State: APuU4Z9WskiH0wG4gcUncDT9VjjgQyXOHF4rgw+opWt+Bqx3ZqMSj6Cd
	YkMdx3Qd80WnFwXMr/pSJGEuU1lfd50SgQSp/mzoNLsRCy28D54Fy/dNw0hwkA==
X-Gm-Gg: AZFdTZcYXgJYMNUQq8AYsrDrkcwBWgaMP9zeSmOc+q1jpr2W2RM0wjgfTfrLvzp/59i
	3C9wfmAXrycG446d4TzwUe7BGArV5/S2nTDV4i5gW/+4Mh/y9APUWjwps4tfllopki1BP1m25bc
	9rgCQstRoZWX5C8LAUkxf0DtCyPTPAW5a7iZ5Z4yASaw8wSof00q1JVJgqd0osnYViMehCOdhjg
	TelVFGZpt38TFY7+3UI7WnyygcR3z9VuRvquR5W+ojA9aR9wMzln5IBeB3qr7iKzm5CgeGVH28B
	E+JXuBZBAOA4PyFjanibYTnk7oFkCT0vG2VQUnF5dRSeYLaGECS2JACoud5t2i/iiMdxNoQ4nFU
	VEaoKUiSYAiRO9YJJSiYa1z9tHfkPqceTZa/Ms33TiVpYJv7Qz4rp0YXhnrv5lBYEw9N6DfoGLW
	0l8E80t0mkLv2fjl0S05wJHUQxVVIMPdbcEX8aRhlfQp4UQw08rk4tzE7dqVQ2UyaTKveqhN5Mw
	EFFwtJfKsLZTflSzhLJD1kKS3mV28sRmmxgJbNw/upN/984WZAhIb1xOTLDPN+/s3QcBlUZ/XNr
	Z424wd0bQgEqEoEjQpNXTJ0vnCJ5QANOaQ==
X-Received: by 2002:a05:7300:f0c7:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-382827a7e7bmr4334711eec.33.1795059616249;
        Wed, 18 Nov 2026 19:40:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:15 -0800 (PST)
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
Subject: [PATCHv2 12/18] powerpc/pseries: Annotate the RTAS indices sequence lock context
Date: Thu, 19 Nov 2026 09:09:07 +0530
Message-Id: <dc943581f34fef51bac658bf9495e59bb56e54d7.1795058683.git.ritesh.list@gmail.com>
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


