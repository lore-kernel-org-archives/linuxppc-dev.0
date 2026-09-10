Return-Path: <linuxppc-dev+bounces-27005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E9C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 03:37:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgNdx2D7pz2xmh;
	Thu, 10 Sep 2026 13:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789011429;
	cv=none; b=cRcSDo+gWkEWL2/vfPaY5+ElydSJ4zkc4DjPJciYGUMlkM17iQLyd/wINozE0Dw9ZE5XWtqP3sKiB4kZOOmlzBDkUJFI3KKgC9tl2HxZ69JQRWJ+1PZMKMrzpUcd+XltyfF7bJdmdLYSnz1Ld+pI49Xb70bshr9Q41v4ZrHhLeCWwL9EjUUZbw6FftWcNLBe6htr9O7hnGJHIrjYAkAtJFLdMRl5/0qP/a5xuBRHeh6BJ0pcZj3jP6tgL0oQ0FbeVHTJ3rAzc0Cc3ka9v36BO67Ptp1T4ITb/cT9Zz2Lna5uYSiR/q7ADzJ4+ddCLlUFqHyrtGHq/Yc2C0MOP3gTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789011429; c=relaxed/relaxed;
	bh=C8ZWMEFHQbcH0tt4vDOyvt6b0NrgibIrdXJYwFIp6tM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/gup58dDgttPgL5kLgZL49+PoLrawy1IrDCf7gncnZoKY7vKbhCso/Dvzv6ueWrdoKP+cZ2bDr9pfp0NvC/0p4lylIr+4rklPWf09pJ172bXxL++xZANoZd0bxvzOECrUjLETxIPE5YeBQEvWj3PHYWsNX8lMuV2xGDUhUPtscTHzmI8rVKWiU/ZqRlri/BEYXUGmUNhRg13r/r2NQabcpiN4CtcXqUBpUvFF9SQUFmoKbwyVWIfPHz9WzXqQ3H1Wd0rw7N+HncRf2Fv9JJfmpOugHWL6s1Ssjh0Bied366nOOTK4sREaLYVmp/HtITa7mBlT2yKarjq+G2gEOWSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=khyn6Ffi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=khyn6Ffi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgNdv0bq7z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 13:37:05 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so4794036f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 20:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789011422; x=1789616222; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8ZWMEFHQbcH0tt4vDOyvt6b0NrgibIrdXJYwFIp6tM=;
        b=khyn6Ffi/D0MRDEGuxJbqOGtoLJxpEo4I0HbyOt41TckCKE2TQrjoNcHp1TjXMxwFZ
         U/4IclkOSPZ15kV5TOExv+yxnI+oFNrpAKb3EJQk+NV8+NJLmE5KBQogk0Xy1d6FTmFw
         UEZhiybZH0/Un6aP312oiBV+qprttpoEbBcUlP7OPGwPRkMaFBWU2QDXeZ69or3jjdOL
         NYWp2Aah2f+e5QViICsFpPLFyUV3anspwkHkDQiJGAQCoWWIJ2RGnWnSu/S968iO4FRU
         yMe5I4/9gpKtFNUnIwi9mr5xLbmRD/fexgNZSGwulXDkXe2YHdJW9beTDC4uFM0b63fM
         fSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011422; x=1789616222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8ZWMEFHQbcH0tt4vDOyvt6b0NrgibIrdXJYwFIp6tM=;
        b=qo8yte0qyU9br5QJvfiwXyNbf/uXm36mdaBtiR5wXtfUrOME7G7Ve9H1wMibGpLG/5
         cqB8hBx10lUi4/qSJgF09kzHv1oWE4l+qi9q9MnqaVN4BAlpHMNEoVTdbk9k0Psfhr6K
         7197jzFeHvASNk3xFINqotbMqXxOk0go2uRsWbQJcOwvutXvPmlDGhMdbUqhSRZOL40B
         rEqKQjBXN9Z9RDk6vwOA1GuIW42L1/LmPaYCwGoV3BCDudkaYGku8o0gFQqN1GSMRkYp
         SE5HMe6ExjaxJwBy66zaFbmHWlwws8tCOKAqUFEqj+SEfihshn0cyX28hv/MVVOiG3e9
         3jWw==
X-Forwarded-Encrypted: i=1; AKwUvBwuLeF+yik0Mv+wiML3hAaMz5fLqMmbgsLA0yMsarGq7BKmjJrzbQxHC3S9BRcQORTSZZ8cC38ilu43bCY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++leGEFsozn8GvdDDM+Q/GAYl0PEuyv5s6Svr8fppLuV5xdNBep3
	ibhD98JNWf3mMbXPNC64Mx3LFHPEp8scCJkgvz+h98251gTYK3BUet3w
X-Gm-Gg: AYBFou2lf/Jh7KgWNpsN0asTieEq2G1T63Qs5zSBl9e8WZXi0bRCQMWYvQFe+/l3zA6
	r6ROwdKzbv+6zEr2JWKxhUdZAmPYm1aDqdzzMdbVUBf/qh2MVIHiyXI+psVAoUb2+ZjSae/6816
	REfxlEXTonxMSr5WN0/SkcNg/JYQGXfAfw4H7KIZxY+bR7rsvqDOHDFIaAEE9BhBfmlSvNg1VwL
	PbDvB60GPOJrMYNNh+yZwV57Bf2f2++7E+6TLGipGqD6G50P1tkzLFXh6R/2i6F3OtDHjfz6FkU
	O8/okpLCq952mYyuYv02xjUFw1wYGqbhAJ86PhD4JtB0I4mxl3uplIfcVADBR9+3BMikvCg5C4Z
	IKEbe7lCLuOG7Dj6Rva2nhMF5XEXVi8odhmQDSjacm/q/Uzx5VL2OnDR2mYp1ui3T7+FLm9MRT0
	FKfQNo2UFsD8ghSJ+r7RPBnLLCWOGWmVMPdQ+FlCc0N5nu6YcZXkBihVoFUPv6i0TaSA6eGmC1w
	gDOAbgdGkmxVN8FaKcBNMfRctBEIYINVYgLX6hGuJ2pGr51JFJhe5qi/mZyjwSGU1N0I3K0zuLC
	D9VXOZsv9GA5Xcoey418qU9gDSGaXg3J9z6Mxhz/oLeqOI7h7XOgm2hq3j7cXQqovbuRG2Jp2gi
	NPECwgkIdNg==
X-Received: by 2002:a05:600c:4e16:b0:49c:fc6c:bdfc with SMTP id 5b1f17b1804b1-49cfc6cc01bmr341548035e9.19.1789011422051;
        Wed, 09 Sep 2026 20:37:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b3d9-b901-0402-5aad-0ef4-88ac.310.pool.telefonica.de. [2a02:3100:b3d9:b901:402:5aad:ef4:88ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b726f9sm34506475e9.0.2026.09.09.20.37.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:37:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jordan Niethe <jniethe5@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix guest state buffer kernel-doc names and parameters
Date: Thu, 10 Sep 2026 05:36:55 +0200
Message-Id: <20260910033655.16127-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Several guest state buffer comments use copied function or parameter
names. In particular, kvmppc_gsm_for_each() describes a parser and an
element argument, although it takes a message and yields IDs.
kvmppc_gsm_include_all() also describes an ID argument it does not take.

Match the headings and parameter descriptions to their declarations,
and describe the parser argument and vector output with their actual
roles.

Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/powerpc/include/asm/guest-state-buffer.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/guest-state-buffer.h b/arch/powerpc/include/asm/guest-state-buffer.h
index acd61eb36d59..95d50ec7f2a9 100644
--- a/arch/powerpc/include/asm/guest-state-buffer.h
+++ b/arch/powerpc/include/asm/guest-state-buffer.h
@@ -224,7 +224,7 @@ struct kvmppc_gs_buff_info {
 
 /**
  * struct kvmppc_gs_header - serialized guest state buffer header
- * @nelem: count of guest state elements in the buffer
+ * @nelems: count of guest state elements in the buffer
  * @data: start of the stream of elements in the buffer
  */
 struct kvmppc_gs_header {
@@ -779,6 +779,7 @@ static inline u64 kvmppc_gse_get_u64(const struct kvmppc_gs_elem *gse)
 /**
  * kvmppc_gse_get_vector128() - return the data of a vector element
  * @gse: guest state element
+ * @v: output vector in host endianness
  */
 static inline void kvmppc_gse_get_vector128(const struct kvmppc_gs_elem *gse,
 					    vector128 *v)
@@ -849,7 +850,7 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
 /**
  * kvmppc_gsp_for_each - iterate the <guest state IDs, guest state element>
  * pairs
- * @gsp: guest state buffer bitmap
+ * @gsp: guest state parser
  * @iden: current guest state ID
  * @gse: guest state element
  */
@@ -866,9 +867,8 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
 /**
  * kvmppc_gsm_for_each - iterate the guest state IDs included in a guest state
  * message
- * @gsp: guest state buffer bitmap
+ * @gsm: guest state message
  * @iden: current guest state ID
- * @gse: guest state element
  */
 #define kvmppc_gsm_for_each(gsm, iden)                            \
 	for (iden = kvmppc_gsbm_next(&gsm->bitmap, 0); iden != 0; \
@@ -908,10 +908,9 @@ static inline bool kvmppc_gsm_includes(struct kvmppc_gs_msg *gsm, u16 iden)
 }
 
 /**
- * kvmppc_gsm_includes - indicate all guest state IDs should be included when
+ * kvmppc_gsm_include_all - indicate all guest state IDs should be included when
  * serializing
  * @gsm: guest state message
- * @iden: guest state ID
  */
 static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
 {
@@ -919,7 +918,7 @@ static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
 }
 
 /**
- * kvmppc_gsm_include - clear the guest state IDs that should be included when
+ * kvmppc_gsm_reset - clear the guest state IDs that should be included when
  * serializing
  * @gsm: guest state message
  */
@@ -958,7 +957,7 @@ static inline int kvmppc_gsb_receive_data(struct kvmppc_gs_buff *gsb,
 }
 
 /**
- * kvmppc_gsb_recv - receive a single guest state ID
+ * kvmppc_gsb_receive_datum - receive a single guest state ID
  * @gsb: guest state buffer
  * @gsm: guest state message
  * @iden: guest state identity
@@ -998,7 +997,7 @@ static inline int kvmppc_gsb_send_data(struct kvmppc_gs_buff *gsb,
 }
 
 /**
- * kvmppc_gsb_recv - send a single guest state ID
+ * kvmppc_gsb_send_datum - send a single guest state ID
  * @gsb: guest state buffer
  * @gsm: guest state message
  * @iden: guest state identity

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.39.5 (Apple Git-154)


