Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3B606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypxP6zqm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tZ6843z2xHX;
	Fri, 20 Nov 2026 15:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147462;
	cv=none; b=C8MzurzOA1lZHrOVBp31fRSMs9LEXwzZYMTnG/M45L/FUdCZQsDX85RHrgY/L1/rDrLoCRzn5uCXTn1CKZG0HZYlUpOD76zdWiQ01Y3d97IqJikDm1LmiKUll4boDkSKYJuaC09lJ+cGyRTZwy4fHHRmeyyIEtfIvs/g4BNnnQ5ExjYLChj5PBvif0YEZyDiPD44UomdFTMgyPt5O8AQk+CqzYdbOsVvrzYO+1GoIrg9xmTIK3zNn9LBtFUQBNUi4knRAKCjdBXTM9zjKUiP1z80bPTMOV1aE8/dO6X3AdE7aB4CbUpU6FXx/aRun2BEmwXFQSJLkcVd+MuigQtU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147462; c=relaxed/relaxed;
	bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAR9Ef+2EhGzNYuXesMxTX3A4lZze3SUnarHLVBUfIOEiW+4H2l5dw7IN0kKHpeTNhEkL88B8rGt2qgI8qe3X8aEdVCrp376ocI+NVTUweuHpGcLHo7MXVoiBoKbUvVGrRc6H4q5aHSqUZVZ0j6xDcNJdzFk/r8ggvzoiDAht0lmE2Cba6dCpw+Gv4Tssfvqp7hGhHnpD9+Ab/Wz79GPGR219WWuZiCTlHXHfVYNDx4ViBjwG5jjI0j1NfUO2MTnIgXdbnAsth+4psHeQQEE5MIwe7J0ZhFL0GFzMe9DIJ+z8SQiJkgHFpKre6hiGnL0NOyUcwz0vqmGdPIXVRetNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypxP6zqm; dkim-atps=neutral; spf=pass (client-ip=74.125.82.172; helo=mail-dy1-f172.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypxP6zqm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.172; helo=mail-dy1-f172.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tZ20LDz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:22 +1100 (AEDT)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38431138772so542008eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147460; x=1795752260; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=ypxP6zqm4JwMCKsLaq4vldeefgXzDXoCk+j2v7PJ9oYdRg6xTQKE6/aA26gxZv4EKJ
         UzsfUudza+O1/HAbWX7zRF9RM7XFfEnFgKQ0AlvpXN6hPAiTpAwFC5dIfjzflEtanBnw
         eX49mMgfK2TUf5klKdH8dMGWBK3tTB6Dw0B3oyoiO0ta8Q41n6lXYjfEbEVNQcldFjNR
         fetZzyd5DBHaSHgLNgqM612s0Fp+OzkeMUZ+sUNtH5+CSdsZvhXZAWTBdYggnnyUW03/
         F3NiucbESa1qSDCdrGcHYXAWSabPRAYoLnvexIZQbeFuJSieAxzE/7lHBRQp4bKr7Y7w
         /H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147460; x=1795752260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNfLUpbUrpvHXxk7v5s6Ji6TChmuV33nC5/6JAhIS7E=;
        b=vBboI8UibNIZ5Lgu4hGR35CfDxQlZ6+kQNxnbdModlmu+uwg9dIBmvEy6fbsNTM7MF
         DNA7DDrdNQPsvX4Jj4f8O4qEnx/UDZQRfpYNNVLE8mWFiAQQYD6mlH3pxSXL0duiKlce
         kvtzbPoGY8LMvQx7a0O3AgTjV2X9YbImm1GyiU8bpMbebMSuuIYE5pzHeFg9Qjo2nH6Z
         3gHk+jZ/WVJgNBpfLiUB3TTr6fGXidSXEO6O06ebTIgGrhRCg9Ps+n7XTxYF+NWtNOfW
         udds+jkGsn3icdZ+yAL8DDqR4f0S2gKbMQm8EqLzcZCZG+o9C48qGlzPGh9cOqLV2YQN
         7ZbA==
X-Gm-Message-State: APuU4Z8+j75XJ54Nqwb+zZb9k3yFcgFbmbsxFgTccnD7cdEVeV2Hlx04
	NI8jrs667GNTHoEgRJmSOE91ZIGPS5K7SE3tGK55SjRd4G3E4OLuaisUtiegcA==
X-Gm-Gg: AYBFou25rd69H7vegengYphKOPoBDYoo1pjRxV/o8gXhZKa1WAsYU/G9PPUeVshAbmF
	nr+eaPASMz0QTN1IdReqV9qlTlqpU9homut5JQLhakCZsmiC/FmKjvocoM0gLaPmXOcxYrNrPrR
	TjrnPjxe9lOL4ubMuxCnFFqrscltqqoDLdZjV/j8ESN6RJxPjAbxV4Pu9Ji32rzNrqMsjBHIlpe
	K8ZS3bIbZgOMsXI1H6P7fKhN1GZG/FhNQIhW3AoTvoA0mBre2p6NdH4zvHGyh3xj2cJyFRFG3dr
	LOVX60JPcR3TmDFMnWlxX2oa52ZU7Z10Da/04/d3WhoARFShLPmTMeUnyDHZqsYUYTQaMZ9dtGx
	lY6OEUTxtkSufExPjOB0tAp9+/imYbC6KErCC8Mh5Ij0sUtEWEqp/yxBrpx4SzrhBHbu9yiF9DN
	HBrsM50NKUnN2DTT07g90YHkQ+/o964uIXxUa3692JRGJ3sQZpUz+J5f1uKGdCePd2ZqM+1yhGi
	a7EjB+UqVLiTQhYji3hWxvcLoU/AkPvdJr4b4j3axjqLCMHrNeadoIR93nXFhntNwyPa8ncsrRD
	U1IObIBmC0IhiFd/JF3dhy9/xSDKSi/I2VK4n7umifVoJW0TU7qK9rY=
X-Received: by 2002:a05:7301:152f:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3856c6b35b5mr1616327eec.2.1795147459846;
        Thu, 19 Nov 2026 20:04:19 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:18 -0800 (PST)
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
Subject: [PATCHv3 12/19] powerpc/pseries: Annotate the VPD sequence lock context
Date: Fri, 20 Nov 2026 09:33:11 +0530
Message-Id: <13d51cfa826c7c9ab2ce4955a6c6bd18580efe78.1795147055.git.ritesh.list@gmail.com>
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
  papr-vpd.c:151:1: error: mutex 'rtas_ibm_get_vpd_lock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  papr-vpd.c:165:2: error: releasing mutex 'rtas_ibm_get_vpd_lock' that was not held [-Werror,-Wthread-safety-analysis]

Add the necessary annotations to in vpd_sequence_{begin|end}(),
to fix these errors for enabling Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-vpd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index f38c188fc4a1..8d210454cff1 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -123,8 +123,10 @@ static int rtas_ibm_get_vpd(struct rtas_ibm_get_vpd_params *params)
  * @seq: vpd call parameters from sequence struct
  *
  * Context: May sleep.
+ * Returns with rtas_ibm_get_vpd_lock held. vpd_sequence_end() releases it.
  */
 static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
+		__acquires(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 	/*
@@ -157,6 +159,7 @@ static void vpd_sequence_begin(struct papr_rtas_sequence *seq)
  * Releases resources obtained by vpd_sequence_begin().
  */
 static void vpd_sequence_end(struct papr_rtas_sequence *seq)
+		__releases(&rtas_ibm_get_vpd_lock)
 {
 	struct rtas_ibm_get_vpd_params *vpd_params;
 
-- 
2.39.5


