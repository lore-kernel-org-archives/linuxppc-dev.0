Return-Path: <linuxppc-dev+bounces-27084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8ABC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:49:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Bv5z2Wz2yqx;
	Fri, 11 Sep 2026 14:49:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102167;
	cv=none; b=mPbsvcsLpRY1pf0T1/Vrqbml3MWWBJ3CIeG7bhkEKju6bCBLiriBugOouxCmX/xXRoYjZUbFZ6LHfRZblRtUohnFu2rfhRBjc+GU1I/B4SWZuYUPVDxM+6f26Ke9G783HnMSJ1Y6DElIMLma0fgMzJMGc0/KrBfMW0W0rtk/jnioG7gDL/tBsA2AzA1t/gLvfYtjAKoPFQBotYrH66V4Bp8JVbJLSIRZYsV7wsbk8TUahC9+QBo8V4eTVa9DDZW594qnITmMOgJcOLZoPQgds1ww//VbcMGrF6MeXXchhTky5A/Yb7igRt6KqrnW8mBvcGedpPOHY6Xwkiv0370G6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102167; c=relaxed/relaxed;
	bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fop2yXHbQdrsATDy+AYe8FTG2iYMJgKqKRygJb9gATrk22c4dPydEd6O69S3wsT9k2x8o4ywWlsAsdbzs1ysTFqhF2igAa1652aH3XkXSOsBhbsfohvlX1BUPaHuXKHcVNDD6MXccAflmomVpgDO2ZjFK3EQk3ZeER7k15HyG0x/RexYvmc57u3z8dX4d8lJg2Hb1SaRhv/9XfXp3k2FhmDk8VjKDkynrrj5cmTqVQgLIziFuP3C0weoU9s9SvNK2U9WBh7FMz0lQeL3dCMoWCmld8/bL7zeXDlonLKYpiUFtFyYzDx/l87kG2+WElbEqOmFxFocqH2N417qbYruJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sW4kReFG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sW4kReFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Bv0Htkz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:49:26 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso612726a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102165; x=1789706965; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=sW4kReFG4pc0Vp5lWeXQFZ9unPFHtU3/e7tkGC21etpYzq4Gl29LADFtQhZdbftEmR
         XLKK1qz/x+I0CpmWzYyn+pofAco0CgbClM04YCBNVjfjn2eIJiUJEuJTks5U8ayfMiY4
         ozmGaf2noqsRp8eCM5jejsfQwooXL/tkgIrS7GOApTwts180uCEGJhf/CF+Ftpkf6nZK
         c6ia8693AU7uW3yX2MtIqSb+c9f2hDfNSmv5F9AOQ9FXklFse8IZ6lJei9aQxWHrvtes
         eFMrgER4MSp3Il8cxGy7be9Gguv1HOoiIvl7tTBcY+3aJXPigTytyMd8kNcvUtm3Mll2
         VFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102165; x=1789706965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=XMCAMXVHcE5A1SgDhxe9lPDJVUdifd6nVCHOvkLotxcDOzPeO97gN2OgOVWQ495Gap
         bSsq6KgCtuEkOFkn+YEpQgsxf93m8pwjgZzKAqdDRybot0XeSU0Hh8vpikQHRJAzD/UD
         KZKx8c8bpDPY3Q8NJ1FDiukZU+74vk9p/i9vs60C162G0CL2LDD9I9uLBwOb2zfLfaQJ
         vigRv6BA8U2ZZCx5XoQFEsgQJyMGe4LEXnTg52ktpXR+teiIdvRGltXsRS+MIsAo6xKj
         2GGcN7qHGy6IVSZQF+8FzvGud9ShnfuNtZT4RRdlqRbq21Rl6LQoPk2+A8twqKpLseCh
         Kuiw==
X-Forwarded-Encrypted: i=1; AKwUvBwo7pRBesSSLVPqmfhG9+g07Bf8go+p8DgZVDMo+wjo/3P8iuWgaRf9gVeDTLLcHs8bmyc54iI5p8+jONA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k87TYgYZUHDVeqqGYTbaTr7s3u5n2rz/xXq4NTrJzU98YiGYlg
	HRo2hWKJ+zxNhyXlOLOrPnSsDQVxYUBnMiLPYbzocvvRLFXFYhgO1kzp
X-Gm-Gg: AYBFou03v5h+Np/L4izfTxU7KOmgMTNdRM/8g9ZkZD3mRgj/NN0YvBUKQrqP46RXxN6
	CzjiurR6qbRWfXwkJWsPO1HCDN5yvFtg7bIOmyS6lbXE2wlMbcKXvFwhRvHnw400mViycilenDp
	zmnTG3BV2i4KeJRQyVH0b+78Uhb1pyWMa6UBt2bGfVAx/FFp8un002t0eLUzo379t6y6TA/Z3Tu
	eAC/leF5OUnJC1oQc7oUez0jn2J1BgcrCF/uiMEiwyVPPC9+xCbp085POr72Q/undVikI+ne20n
	TISaFzOMDlayHq7pA/cLCQTqzM8TbV8h0NUkNe4BeJFi7YsxIuDfW9h+z67h8dbVErJ9lBAOvVI
	D+1zmcNkex8VoGaybOKQcIFFpiCBFfp2qANVh4IypwOrttdf7GBGNuQxiR8Xa/twyseklDlNQfv
	I+bKKHBM73/VPzRdSL9l5AG/hwP+PtZMs6UUs/puapjbjZfwuWVb3rdZp2d0fQrshYYDPUkSgok
	0hJgYxZM2UzgfdTr2Wmn10ezVJtlH0qM1/9Adm3rXjk+64z7AQeyrTCpUG4vV0=
X-Received: by 2002:a17:90b:384c:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39d9bed82a2mr3634401a91.11.1789102164649;
        Thu, 10 Sep 2026 21:49:24 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm2883077eec.22.2026.09.10.21.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:49:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 3/3] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Fri, 11 Sep 2026 10:18:54 +0530
Message-Id: <98cc49bb43ebc45c14cdfd596a4e64b07d2e1f08.1789097569.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789097569.git.ritesh.list@gmail.com>
References: <cover.1789097569.git.ritesh.list@gmail.com>
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

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Fixes: a049a377164c ("KVM: selftests: Enable dirty_log_test on s390x")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100

 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif

 #define TEST_DIRTY_RING_COUNT		65536

--
2.39.5


