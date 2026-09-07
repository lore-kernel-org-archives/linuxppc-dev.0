Return-Path: <linuxppc-dev+bounces-26700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD83AC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 01:46:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf6HJ3NfXz2xq0;
	Tue, 08 Sep 2026 11:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788818082;
	cv=none; b=dShGTC63wJR+38eYc2BWDGZzfLCKlpBDgON1oJJLdFId4OAzsI8WTUU8OPzkXS7jmYG7YJwFWWIIgbvH4oFY3J2TY8+JkaL3By7IB90oV8pF5s1BbdiXo4pHQgNhx07mcw1fht2e7oIxlAlAE2yx7j6LyOV3FvFO/5VsDZAY5FT9vpsZld80IC3yFNxvbc6wCIM8yWSY29xZyRXq9NZ/BaY1QvmSucoMiyz/wiPGwh9rDv044OVyWvqjzNmUtZOo9eGXgodfFLXUtyFlSwMhRAAxsPE40MRhPhYnryRcmusx0BsaFGSCG4r/wHPPPRFFwb4gIQyxNfRINhDzbdfzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788818082; c=relaxed/relaxed;
	bh=fRpckaKOwl0Kgs7K/gM2OB7RO7urUAj94CqnshB8/I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h09pLXY6dXowbG91tHTUYkI24Bhon+p7R9kFva4XJSvnrHNalb2bUHSVLwmOple5P53hZBz0i/U6Hp17JfsQ0RNX7kCGr7gjj3MPM1ISeWLkEj1b2zaLT+nbsnakGwPjm12IL1HkqHXTk/EJTkb7C6MeDCENnGZaYxtdjlgidcaKZ+wCsPaPOJJnnDBusDwUhW+/dJLtug4VhO+IFUSQKDcJgaYr/ibUbrWHjNtvCk2uQ0781tta24YdyL4O/nB9AOoefZNpTT51avlGL67szAMvfTItvnn75ToExPKM7/7Yr0fVHPdtjlLA9s8/YiKhvO1DCnkWgA5br7+CC7M22Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=kRu5icKf; dkim-atps=neutral; spf=pass (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=thibault.ferrante@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=kRu5icKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=thibault.ferrante@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf17h22vzz2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 07:54:38 +1000 (AEST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38ED73F1C4
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2026 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788818074;
	bh=fRpckaKOwl0Kgs7K/gM2OB7RO7urUAj94CqnshB8/I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=kRu5icKfUEUcmvwaKio7cmGGXWebNI9AbOdiVcfdEc3UeR4Hvbq/QCmhfLjI5J3Y1
	 7BhNDcg4dLCwQzoIVntelMxGictKU1hIg2ouclc1olE3y168lrQPy78R8faOl7kB00
	 y9MIS8bM6prt+jJBpChPHCQBDA3XzyIM2KefFXmXJcoUQ+xvIDf/3smoyEDItINtxT
	 DEjecywl0Y7ijg0gi59NlebztCgnbEP9RF6QhnDx7M/fvLhnKm+zsfatzIEhuuXshi
	 xh2dTgg5tPmA3/7tOb/be78LMtGonA+UKSDSJCLV+s+5UCjgPAEBQJ+iZit5d0kN24
	 mDTr9bwUs0c/aPOyTFj3CfRvAZd/scZbW6OT/w3qccAgiRo0FtrOtyAF11Oa0Pmrlq
	 Q+1rPhoKxmePEZPSt1p4MuiQ987Rj0hcP391N3DITApRl83kJs0kb9EseUWFbkyDhC
	 3unbhfNJsPmfOoNR/mlQDvmc3xdCdnIjZ/IksvMRAQyRDpd3xbPK8IWEOpUBK3wQ14
	 As0NXAWoc7Ic+DwqLokvCsr8Jop8NI2yUK4IVgFyh069MW5P4WvRsQXIO2RcC2V5PJ
	 VBkzNbhV/lvX0ERDXWzWYYfIUpU5x59anBAdn1jTbUfG2mHuUjDvIkGpDfpuKUpTjt
	 aCmfwM/rneWl3aRbec9rhkjI=
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-869553205a7so58577397b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818073; x=1789422873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRpckaKOwl0Kgs7K/gM2OB7RO7urUAj94CqnshB8/I4=;
        b=K4Wl1IGYzMQQCYms1wdtMY3qOI5zU3RP2veelMqtOp4nZAcRzv+X/rSnl78xqCKRoy
         ymco42v0uSe8T1NMtATcuIEgc6agNtB7Rk+b1gDziSu+BUS/1y9R3+Xn2Uu155k6vPUx
         zaqpnmT8TLCjyEAK6WwHWvrUvfFy7LZ37v4yF+GMZ4ewM9/tYVtUXCbvNfN161enSBwz
         0X7rnhUPERBDKLNfFt09yBQ0l0yfKqsum/I7o7HZHpQFcMIo11ofU5Rv/i8YnpxYMqLI
         VWKB+AbR2hV53a18qHb1vnA7Ok7DKxt2IOmbVkGmporXQ9NmaVkXqqKuUiJj0/Ul8Yvg
         ePrA==
X-Gm-Message-State: AFuF++meam3TLJOt4xHePXkQrtJzoXzR/hK2KsDawa95xI0KGnFr3LLn
	KcPhrOR6I0a/5ROffeIOSRAcuDV1pr6SmHcBYROqRuKlky37N9dWvsn1dWMSwzIRzJf5RmSHGhA
	a65lBr62dUlR+FlOyZfySy6wFyGnGp5l7erI9916tQchD6NS1gcdCajmRYwe4GF6Sr3z5LCUfI4
	g7S6+rtOKrOe3efuDfqA==
X-Gm-Gg: AYBFou1Ztp2+F2xXqWd+mNcncpbKfgqDD3hZVOu2fczB+wzYJ8/GSZHnPaZTz5nYgCb
	9OdzL/B9PGg8wvjDviSAf2CAbnO3KEViXgx+b9G5punTPmo0XiiBBGRmcwtCxeLyesU9+MtQNDu
	oLXlDYs2wUL0HOSnuXNrZLs3WjjQcCg/b/6tx0a02dbvwZOS+nqXtds567hj6EA1L8RzahZx4g8
	NyxfPcP2Qk3r2j9ACddIQqQ4oXBF9DOP9vMQE+25ZUr/T3NaLKFs222Tr6i6FsLdR//YAtTIKQ8
	0h2gn9Kqd4es+4RwFFFAtD9yDlHnNdnC6Ece2FNXI0mm2/OzcpAy6A0ZHYowobadz5Y6fSySfVH
	GNbgmx+V74fLwP+ARvBdseaKCUH1CUHy0hlTUD6LcSg==
X-Received: by 2002:a05:690e:2581:b0:66f:8797:8721 with SMTP id 956f58d0204a3-66fb591c4b0mr6436214d50.10.1788818072940;
        Mon, 07 Sep 2026 14:54:32 -0700 (PDT)
X-Received: by 2002:a05:690e:2581:b0:66f:8797:8721 with SMTP id 956f58d0204a3-66fb591c4b0mr6436205d50.10.1788818072556;
        Mon, 07 Sep 2026 14:54:32 -0700 (PDT)
Received: from Q58-sff ([2a00:5884:1118:0:ed91:74de:df2:6b36])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm8977708d50.2.2026.09.07.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:31 -0700 (PDT)
From: Thibault Ferrante <thibault.ferrante@canonical.com>
To: linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	shuah@kernel.org,
	chleroy@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value
Date: Mon,  7 Sep 2026 23:54:20 +0200
Message-ID: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
X-Mailer: git-send-email 2.55.0
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

tcheck() is used to check the current transaction state (active,
suspended, doomed) via the "tcheck" instruction, which writes its
result into CR field 0. The inline asm declared a GPR output operand
for this result but never actually moved the CR into it.

Every caller (tcheck_doomed(), tcheck_active(), tcheck_suspended(),
tcheck_transactional()) has effectively been testing bits of an unrelated,
arbitrary register value since this helper was introduced.
The "& 4" mask discards the TDOOMED and TS_lsb (suspended) bits before
they ever reach the callers, so tcheck_doomed() and tcheck_suspended()
can never return true, and tcheck_transactional() degrades to being
equivalent to tcheck_active().

Fix tcheck() to actually move CR into the output register with mfcr,
and widen the mask from "& 4" to "& 0xf" so the full CR0 nibble
(TDOOMED | TS_msb | TS_lsb | reserved) is preserved for the callers.

This bug has been present since tcheck() was introduced.

Link: https://bugs.launchpad.net/bugs/2107442
Fixes: 8e03bd4e70b6 ("selftests/powerpc: Add TM tcheck helpers in C")
Signed-off-by: Thibault Ferrante <thibault.ferrante@canonical.com>
---
 tools/testing/selftests/powerpc/tm/tm.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index c03c6e778876..6024ce4ba6ff 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -105,8 +105,12 @@ static inline bool failure_is_nesting(void)
 static inline int tcheck(void)
 {
 	long cr;
-	asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
-	return (cr >> 28) & 4;
+	asm volatile("tcheck 0;"
+		     "mfcr %0;"
+		     : "=r"(cr)
+		     :
+		     : "cr0");
+	return (cr >> 28) & 0xf;
 }
 
 static inline bool tcheck_doomed(void)
-- 
2.55.0


