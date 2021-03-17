Return-Path: <SRS0=EYxI=IP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B0DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 09:05:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F864EEC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 09:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F864EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0kks4Lznz3bt1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 20:05:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Cm3JrRcv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::736;
 helo=mail-qk1-x736.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Cm3JrRcv; dkim-atps=neutral
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0kkK2PpDz2xZm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 20:04:39 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id n79so38136528qke.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V/QALeH7PgIqdJCNh1QudPBXuTGR62+LsmILJFDMTZU=;
 b=Cm3JrRcviowCEXj5d5PWA7VutLsPoeca2RGX192F6MIhPYz2pdfayBdfBoUNTJffEw
 OUg16s0Yv3AgeZ4G1uH4XIPDNUeQoRT+anTF8epJcFVt8APP9Tuap03GIX8Y26XKLGMq
 D7YvkgutQAmdHPPXIxOamPPgf8nPI+NCrvKU3kaOermzy9U0GHteC9aBWErpWfS2ijyP
 qqKKjtPZEke1zktT1qN5u2jxzROj6LpkK1iEQF6AVltQ7tkM3sGXsJhFgfYCvPtt4VQ+
 UBHYVNaa4uBeZ1oluy6bkpxXNMWDkm231v9FfdHa3f82kCRLoo1BEM6gfEbjJENjeNEa
 PX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V/QALeH7PgIqdJCNh1QudPBXuTGR62+LsmILJFDMTZU=;
 b=gRrz8gM9uMq5OAwOJRAmFAsQZ+ppE/wSS3zhzdUvPaSdmEBA0AHTu4BOGf+JioJNPU
 qRfIuCAoAf8JIDYjlyJcXMLD/T7WS5qFAhRJyzsOcxtbD3ej+mEK4wW1iF/ZCgb9lems
 XI44tFUuWX/s0RbDZHPOcsi6a6wYtxzfPdqPsXI42JbrzugyDYci6nM5rH06TsMsfgGu
 nZ1tXW7F1GrAuMYaeI3ww7+WaJkDddxO+SfCo5B7pfTy1mEqoT7hwdpozRTnwCuvVDAX
 ylj0VwsVFqj7nIKGhfxAoLDmYc2RC6ILqCy1soCZpt9m3zxFoYUYGu3lQoMlPJTTQ6oG
 AF1w==
X-Gm-Message-State: AOAM533ABuAGHHN+0m2R5Xe8GlhIiulXncqCr5HYvtD5QMilBW71yayK
 0rb43q5GXo4kZwGsxWU/OxM=
X-Google-Smtp-Source: ABdhPJzivtYEMadnDZYNb3ssdC1THxrgwqHVnF917hZwSRkhyIOSGGKk0xS3EV3eUopxGiwdV7HMQw==
X-Received: by 2002:a05:620a:13db:: with SMTP id
 g27mr3675187qkl.367.1615971876587; 
 Wed, 17 Mar 2021 02:04:36 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
 by smtp.gmail.com with ESMTPSA id z2sm17799618qkg.22.2021.03.17.02.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 02:04:36 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 jniethe5@gmail.com, unixbhaskar@gmail.com, alistair@popple.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kernel: Trivial typo fix in the file kgdb.c
Date: Wed, 17 Mar 2021 14:34:13 +0530
Message-Id: <20210317090413.120891-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: rdunlap@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 409080208a6c..7dd2ad3603ad 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -376,7 +376,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 }

 /*
- * This function does PowerPC specific procesing for interfacing to gdb.
+ * This function does PowerPC specific processing for interfacing to gdb.
  */
 int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 			       char *remcom_in_buffer, char *remcom_out_buffer,
--
2.30.2

