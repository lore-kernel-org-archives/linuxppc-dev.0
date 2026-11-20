Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31B606A32A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqFLmsnt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tk5XyCz30DZ;
	Fri, 20 Nov 2026 15:04:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147470;
	cv=none; b=YKN6d+3AMUIzKbp5xuO1+S+XnQUXJGr4uN2PQwCQXd3cs5j6mXkKqIylf2zyAMwYN25KnPi3N1J1DPAjLrgh3C3AHDFYSWR3Y8ftGtYC83Ld6HLy6lK3t1k27dL88c8hOoRKOl+WtezHMhXbvcdgA9zu0QhWtf0AufF4+fjFmfZLGbiXst/JkgBJdQun1D0MtSz55yfgtTI5gtyujx1/7HbijxddXcep9nJ5QSQrjcvRdFpGBqswiQqfqnQhyOmvTSqyTmM48Qz7r6qRalpBfKRESS2vkHbqIgeAx68RXAyVsk8WaQeDQgPvscWKn04S2VTE4jCzro2nkKNor30leg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147470; c=relaxed/relaxed;
	bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/OHonZmu+TAQHQeVemtAdSJU1dn/9kWTMrx1Of/fk+lTIxsF9TC3FhNzi/trgQfcxoESJxYBlgBu2G/IJ/iZGgIuuFzHejIaM8ArT/RjeI4WZdt5/8O1SZ4h0WLXZlBKrTreh2HF10NZO3ZwjYko39AZkHwnuOnRrL2FLiqbvttbm1rBaDiMVp7UXaTokXY2WjNcHQb7mQR8T+tUvbee2MUlqS7vumS94TXwTZ2KA2UNwQ+/zZwKt4UC4GLsMfJIoOeFcLP9wFefYmgD9U2Aq76nHXLj+c+iY9isf8TzO7VJppzQej/mj4hbMohSuAMVYPzXTuETM+nVyKTUSXkWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqFLmsnt; dkim-atps=neutral; spf=pass (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqFLmsnt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tk0fbQz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:30 +1100 (AEDT)
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38564b4b017so486785eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147468; x=1795752268; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=YqFLmsnt8XER1Afq34P0h24yjTnA3GspOLESnz6Kg08mlvhTv+/j6fHvZlTriWu2ch
         Al5wvZxF03HS3sqe9SVso6BZy5gUHMGzHTJApaC4LxyLYEcjZ/JJyOy933mkhOrNy4dc
         zQbGOouoGjqfKlTHr0ICFTy25DGa1CtlTBUsAYpYOHuDFYULNDwV+G+pjVIb00jdNtmW
         WWIw9iZWgxyuYIi7O+zAlExGMCjflHtpB5RKEdVKG/Rs2OCkNlB6qPZo2G/iPdWTW0tQ
         C/vqTVwY8CT9HOeJ5Wb0QLZE6gWaquweZNKWuN+XcYu39GPRpHSC0lKRiP5Jcl2rIMix
         RgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147468; x=1795752268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMwW2JLY+HI916hc5v6/gg4kWQ5njDV9vffDoqUd5vA=;
        b=FtulXjOxu8QkZuNPOZuA+MDgWh3WAi9eRwjdHteJpLQTwegoAcFgj/1ZZFbWbwdNRK
         loN9cXBgcVp3nLlVD5okvYMUWrL3nEwB/+MMDlsQA44lLB4q7NMdkqX/G6Otp3Z8N1f6
         k5T/ceyXXq+47qNdmqExZdh4hxoAn5ylLPVAOsyyYhocHh1x48qy+WLrJ+jXun2GA2BQ
         6HXkzf1dNTDwSFULk/xgZvC6D9uWAWLqERIdZGf/hvDHIAo28Fcq6ciXtm3Mu9nTRce1
         SuCgjMA/4QLDr5rX8V1mQfu8EVDabdMZhvHtxXwUrbEOO5AThgQgl9Z0ng/c7dycb21f
         KPng==
X-Gm-Message-State: APuU4Z9wNSfDqLqupWfzvl6tIaeZ1y9J8JwnAMhDU/Sda9Lgs+X6Efaj
	EXOOj8A3H5KXSd+Uk505uV+YBb6IQc9xSYVMLhStph7QBa+IhfZAQoQfdqne7Q==
X-Gm-Gg: AZFdTZcblhE2jSPQUJvDQX3gWzj+bgSURgKEQ+WqkABT1eVrzM2fwzoDso3mzHxSv9g
	6tvwad1+HJweNdsm6J1GBs02qK4Qf2SuEyTyRIjyRH2j3UIjBnOGKQ+sJ++W2BymiOygh+Rhc60
	KB5siJtpK0UkzxQbHetzGfhKrn9GCyEJSVvX2zpBhTCMTC5n5okPRY9p9e+XzQsNummFfVP3V/V
	/28Nx5TJZ5wN9T8t8UN/tCj4uyooiS6Q4dDCHIkeAm2PAG3p/tXOW678nZUzx+uWpXATpl0jRsI
	OyGJDHOYp2PcQwo/GTJFL4DtIGVZIMWZuhYViNkpEHTywLH3BuzDHh1+vGdTyk/98mKr/3jGD3H
	E3e+Lc5pF0mlOyfu7CM8KMce3RjgzNRO+aV7KUtqpKx7t7Dx9A6eurSdDtLRm9OVQtCj0q6oXY+
	Dg4n5f/782tyObhQEdu85YH3yK92MI2qwjOMvqKpzZB5EINUcBUjz5wQVydNlEMq68QgvlJiR8v
	KXw+zIgkzbUUh+rA5o73AhvukXRG+S/H/DHJNP/gPyXtG+cDrg69RK83t96GlS+wUWxWPmBZaBA
	DIQIeHrRbArFeUKhwRMAwWw7bWZHkHZQsQ==
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id 5a478bee46e88-3856c6b00fdmr1716713eec.2.1795147467898;
        Thu, 19 Nov 2026 20:04:27 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:27 -0800 (PST)
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
Subject: [PATCHv3 14/19] powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
Date: Fri, 20 Nov 2026 09:33:13 +0530
Message-Id: <2345452806a2a056bd8355e12cec2a060f385d2f.1795147055.git.ritesh.list@gmail.com>
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
  papr-phy-attest.c:154:1: error: mutex 'rtas_ibm_physical_attestation_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-phy-attest.c:169:2: error: releasing mutex 'rtas_ibm_physical_attestation_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to phy_attest_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-phy-attest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-phy-attest.c b/arch/powerpc/platforms/pseries/papr-phy-attest.c
index 350ba26e5962..d2bc5c0da422 100644
--- a/arch/powerpc/platforms/pseries/papr-phy-attest.c
+++ b/arch/powerpc/platforms/pseries/papr-phy-attest.c
@@ -133,8 +133,11 @@ static int rtas_physical_attestation(struct rtas_phy_attest_params *params)
  * @seq: user specified parameters for RTAS call from seq struct.
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_physical_attestation_lock held.
+ * phy_attest_sequence_end() releases it.
  */
 static void phy_attest_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_physical_attestation_lock)
 {
 	struct rtas_phy_attest_params *param;
 
@@ -161,6 +164,7 @@ static void phy_attest_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by phy_attest_sequence_begin().
  */
 static void phy_attest_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_physical_attestation_lock)
 {
 	struct rtas_phy_attest_params *param;
 
-- 
2.39.5


