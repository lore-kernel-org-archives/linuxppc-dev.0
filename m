Return-Path: <linuxppc-dev+bounces-28954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09F5CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:29:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZ82C61z30VQ;
	Tue, 06 Oct 2026 21:29:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282592;
	cv=none; b=iZaXtj8RVjCq4X9PnSrDDjHNERVBLjN64y6bxsuNkTfPUVJlQKRJVUbzSwMj18VcyLio5A2Sw0qmV82MyLR070Qe2WQnlBloT0L1RSzuWxwdvrfjSTT19cHp1mwgGLjTPr9hwZD01ovq9XiBJZygAfr9RUTFpg6LyPq+TuN2Phv47Ha+g+Zpai5AxcRES1mLXP2tXT1mB+Zu5UyriJfXt/O/0KcvoHf0+UZjIqThKuuQOLZbPNydpCESkyRMhEy5pSgtMoqxVPNkZ0ZWDZLyCAY/z5HStMlbjZLgNiQ1EiOUuK+97EgDwtkWBi99YXHwiVB+aD42Xj+FkgWD7WDf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282592; c=relaxed/relaxed;
	bh=bEjXEmlCAVQzsXstKVYkWam80HXGnlDzJrE3eDAdOhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXcvOJqprQID7CFgaoRNNHQY/vFIe7AtlWfL6bz/kThGvDw/+yI6RnxNuPurREaMw6TA3dxwPSWZ0D3exxVurEUq8rSYvX07NVSIza3ogAiTqA6SxJ9LICirTDN2EynASYgn70uEAnu7b4CO4uoU9+HTYj9uPGUpjAYz54pKX7ManVLrDdzFfcfjJu8d+YlTJ9BPF4SuyRt+k5jxJAYn1LNi6MorfNjXA6Ob5z5I1z483JJGXoMYBNxZjIYp7dBmICK4oNs3d23MJ7H8t3EHlppJwSJxzjhTCzRDVRgABZ7Gxx02xa0GhneBCb9A9r6VCvN1V+s8vY1CwnjeNuxo7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h4hl9+RK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h4hl9+RK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZ73N58z2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:29:51 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-31490970b97so646775eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282588; x=1791887388; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEjXEmlCAVQzsXstKVYkWam80HXGnlDzJrE3eDAdOhc=;
        b=h4hl9+RKgzUngjRypAqJj0PPfyvQUfNVC8EDl6uu7ESBFdqjnwhKHv8BU02ncyiUjN
         u/c6Gp0ayxuSGGM9HfaMQDgnA0zGGAartjymNQU4YD7ZG8rIM6EJWocu2yqj13T6E3K5
         JB3zyKkqvQOASEeovxwmME5uxTV3ztbqfftMzeROxLmwwOczJ98jzBkm90swKjyZZsxk
         Z11g9dvS7sqMdPG2mCXEAF3dNbOtsEfou0QTfrPfkYysELf3GBsPo8ulDVtlQuA4yTw3
         Hfv7/gTFpxp6reuA5XNDZ/U60qK/7rR8quacUm1z5w0vwwDtUm2/4B7l6lS2+80eNPnM
         loTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282588; x=1791887388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEjXEmlCAVQzsXstKVYkWam80HXGnlDzJrE3eDAdOhc=;
        b=MOy367/S7k49WsOebWQd4AvvcXyLWITjgV12T+0Uw/vpG28GoYzNswCpR5vPZ7figz
         PI1tRkf1OdWoHpqkwVw+UgMnmLkGBnv1/QPA5KsinnLYlqX3eHnc+9qkS7tzMMRO6dp2
         jv29BoLj3Y5koGDhilyRSuD/6jUtT8mGK+CFN3BqoOXQK4r1plu6Rx63gHIAcUNA7H9j
         xXOcZ8Az9Drs2ZcLUN77mO11tZ3MTdf4i4GE8GBG6VZSZ2CQgYSP8PHuRGuFzMW5a+Mw
         kDLtr++XzMiQzKzzmUzlZTRna5UwCTjUxm6x5gokwAb8qlbHzGAeZwBq5lF+AnMa4vpX
         Q/sg==
X-Forwarded-Encrypted: i=1; AKwUvBy0NN0+iQ28dUUbH8acJ5BOR7cfKqamoYBMayUzuYUTeERa/rjSW5P2DG39tj/psj4UnfTdGNnrZzAyeS8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIl8wpX8c6SrQcREmCvNZ55SkzkShfk20TfJnZSYZ2s9HJOuSE0
	9dyuHTzBys6+F+rs2RCX8wgoDV+j69EUYZIPo/H3Sg5PI45qhrzDc7lG
X-Gm-Gg: AYBFou14lUdAAFB8XgHRoSx/CFp+XiS3sd2ITJRUaTRfEAMXbpZYiyyzDrOoDXBag8J
	vRnUULoRyZoEvraceTrOU4PMT/NEX5ouFQO2Aqx0lZTwiUsh5ZE326W6PrQMxrlu1L4R1c5elPz
	ZlT7WKB8bwr8UqkJH2ekZhOyxrZlH2/7xfh9GjrmR8H1jRCCy5IoiTUA+rwbgo6P9vJW3SZSSVf
	c5Tv2oQwoLs4zCW8dMQl65BrxjjJZu4hBiybfZwGXYlv4DiZmR6r8xtvPo6QII7PgpXs+70d5zd
	EZBQf0iYih2CTu9I8quhj/QCzQp3KCLJeYwBR5ze3JvjncrBrqYCJJVwLWlps2uAorYvoA7Y8iQ
	Um5AcOjpW/7Hm0PQCnadVEjIloeeUE/u9xZigLOQY1dV+yJPeqeRRBeBXvyHGHk3IUEYhI8yZ4Y
	Lp6/xd3/Te+E0tOfCN+JIyJFYgno5L0QEeqyJihOyJ7P8bDds4rXUxVA23to1DdDBnZyYdaXZAq
	EljbQUuyH48/dbzLKbBrvcZ9eayImJww/thJjhanzhqvYSOLYaNJz2NIgZT
X-Received: by 2002:a05:7300:ec97:b0:351:1f66:469b with SMTP id 5a478bee46e88-3514dcbd7e7mr1038255eec.2.1791282588308;
        Tue, 06 Oct 2026 03:29:48 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:47 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 1/8] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Tue,  6 Oct 2026 15:58:35 +0530
Message-Id: <63c900860b5f7e49cfa7258602e94b58b3de73b3.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
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


