Return-Path: <linuxppc-dev+bounces-20360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF8FFF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:13:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hh85FDZz3bjb;
	Fri, 01 May 2026 14:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608776;
	cv=none; b=lwYSwMvzvXMXfHs+9GcSq1oLpDN5IB2S/iuImOcU1x8ymw2iWJNKE9/RnbnrrE9QOhkFRGeBOmvIomJ0nAfYyvsc14RAvrPbpCaFW3ucjdVs1ycgB8yjdgr+TChXccDbW0JgE48kIDjjZyBxiUNL3ODGMZaCNUsFljvlKT58bJ+92MVnxE5+eMr0I1OAoaqEBhHgtnqbpmave7LINH0zvgVkWrHEXILcNa9F+XcQk+NiyABrvRo/GEMpqi3vMMRJ04SrYH9ovhDdcoUOeqRMCupjduaHSZDrOwsDHvr5xj5Du9H7BRRRLUWoEkVYGZlrPf8Z0EbTOTKdKUINdOLoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608776; c=relaxed/relaxed;
	bh=1IdD6EU2KzCmQB+Jz51O2QI4Dbo0L2jyb+O2zTYQf2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQMNa7IrZjlyBK2Q4OUxH9l5BFGcUV+4P+Tj/eFZsullMCHMMhAGUhy2DRo6VolPnG/M+FZPzum4UFyuzLJLjkOJRj0e45btRAz+ipNoUtoeWSFc1MP4o/rVIl07D/HO9eXNQehrWD/Kt1CzNQSGVwm0RNo1FRfZEBQ1E29KmLOT74WRNAHQBihHH3PlNYaGoLd71cB0jS7x8QlBpZZEqrnUNAa8EsoXpZ/MkSMwL2+B3ruzieAQecCoy6MGKC0dM9FEoYt+cz2SyULKcH24/oUzA+y/3TU8YCredEP2/N772sm2xChHnR0Rk2zidyY2p2ul39Jf5y092n/yz9hDcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYpKl8Yp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYpKl8Yp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hh80kwsz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:55 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82d0b68837aso893678b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608773; x=1778213573; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IdD6EU2KzCmQB+Jz51O2QI4Dbo0L2jyb+O2zTYQf2I=;
        b=KYpKl8YpNRXkjQKFwJ/1NKkrlc5tLgf6jNlTh8gGqTifAYLJktuSoXvOzzGzAIRIFS
         E4i9TS/gPO3Rcdu7QNUTKzgM2t7qO1ot13ZQF8hpTTGFXLoRYnRli8QwFNEaHQ8pup8Y
         RG4FIMETTYG4ykd6B0c26sUu9EAThKCXSXlJXV7MdPn5cp9uWCoLNPZy8/AAThcC1m1Q
         0cIWyO0gqlAPly7Cic4TPE2HCnjQmMYnAglFy/ExAO8IBjPwecqm3leJE16XH0RswRwx
         EdsHnVZ0h3mJnXV3xAhsJDwRHr6Q5MhWaKlkeLFnyLP9XTwyCl78nrVQmy1CSNNuhN2v
         b12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608773; x=1778213573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IdD6EU2KzCmQB+Jz51O2QI4Dbo0L2jyb+O2zTYQf2I=;
        b=ZPBLav3uChho+5qms/5IwLCJu2/TaXXnvp1G2Vd0X4FtYuNL/keU3gqHd+oYo2aYKi
         PWT+D1T/DNsDpu57Vy9+/b5PLryzYJlQReCqshpTuIBKsCJP6+Yyu1ow+1/KwemAxkk3
         W/V79OXH9sJFaiEEmk/hgIMroL3ITAZTqneMoBenN12/ds1slTHGoh4pt1BWFp/zlAbz
         LTPOXMOUOLORiITZS4DldQdIjP3jGGgi6AZfNwfkOFtKZILQGqxWOuJ35aR/p1OWA1v6
         KqaYg1ZrnnCgbPDDwXzrK/ZbxCfJTz+2AZ2krBa1aRP2ub24OE2GcN3lVQponnyCz+MB
         c/ZA==
X-Gm-Message-State: AOJu0YzPon2Bo3RGTiESM4KCsIYkbGzSGRbtpLIHqdbGGbvFRJNnuHSd
	IqCoIM8RfR5+tkpm3YJbknpNknhjGV/tbg5ue/XlMz15o/SVMGuxqGUH+iJ+HI0x
X-Gm-Gg: AeBDieviO/cDnWG/6pxxBcm6UmE9baGCCGJpNEZEHX5j5Un1rXdNPaemQDNtUSf3Tif
	thh03i+DDHm3LuFFaiFcPtxK6qrVbNA7iFfV+RrqvMeugBthryAQMIgVfEsuj5jClSvCB09zu0h
	mj9FNEAHANMEGOeIKTdXc81iH4CedVe4wngxV0vy1JuijmJTJ4GAvypw4ZeyjjoLtBQvv1R6DLi
	WZX+geG7XR/A4V/gH7rpqEVIm6aMXZ7nzggP142d2oHdZKQVDyImRmtnKkDDFSMWPJQ0ER6Jqud
	bcunsT/6LhuXV/urA9SrKXzWSs9pLnA2svxGFQhYpgaG2zZXn+8NjiooVVsUiTTDrNWV9na8NlC
	ySixLYKqNacEl5CAGqbJXfJRVkgez6reO6jOP5O6llV/qiPaBJiFZN1j27LConEVOlVVdOzGQaX
	mBkbMfNicgfrXk06VsiQlj2f0MLOZ9/gYHa7IjFJzq6cAMXc1oFksXEYCJywEug+Q=
X-Received: by 2002:a05:6a00:2998:b0:82c:9897:70ef with SMTP id d2e1a72fcca58-834fdbd1668mr6648388b3a.27.1777608773485;
        Thu, 30 Apr 2026 21:12:53 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 9/9] pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvpipe_IRQ()
Date: Fri,  1 May 2026 09:41:48 +0530
Message-ID: <1174f60d0ae128e773dbefd11dd8d46d69e7f50e.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit

While at it let's also fix the similar style issue in
enable_hvpipe_IRQ() function. This also fixes a minor checkpatch warning
which I got due to an extra space before " ==".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 3688b2be0445..0c40bdde45e2 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -693,20 +693,19 @@ static int __init enable_hvpipe_IRQ(void)
 	struct device_node *np;
 
 	hvpipe_check_exception_token = rtas_function_token(RTAS_FN_CHECK_EXCEPTION);
-	if (hvpipe_check_exception_token  == RTAS_UNKNOWN_SERVICE)
+	if (hvpipe_check_exception_token == RTAS_UNKNOWN_SERVICE)
 		return -ENODEV;
 
 	/* hvpipe events */
 	np = of_find_node_by_path("/event-sources/ibm,hvpipe-msg-events");
-	if (np != NULL) {
-		request_event_sources_irqs(np, hvpipe_event_interrupt,
-					"HPIPE_EVENT");
-		of_node_put(np);
-	} else {
-		pr_err("Can not enable hvpipe event IRQ\n");
+	if (!np) {
+		pr_err("No device node found, could not enable hvpipe event IRQ\n");
 		return -ENODEV;
 	}
 
+	request_event_sources_irqs(np, hvpipe_event_interrupt, "HPIPE_EVENT");
+	of_node_put(np);
+
 	return 0;
 }
 
-- 
2.39.5


