Return-Path: <linuxppc-dev+bounces-27484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DC2C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:10:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlLPp4cMwz2yfD;
	Thu, 17 Sep 2026 00:10:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789567822;
	cv=none; b=I+H/NdPh3w73ve93pPdEfQFZ+JZRugdtiOjVDk0Yrkl1g4xML8VQhXM4tIkSPs4BLvtCiWMq1h+LRwkD0nMgIj5WR9qhY6n+xqGExxC0JaDs99cJddQoJWPFwTAeXhw32pGgokNK73Dw9Tjbz41pyuTcLWsoLOeK/BjYOJm+7imgHfLUarBa2liUAIfcopDPUM0igARj9ajBFmaofdYTllxCxsE72KqzyshSjHJV5pdcZe9dFdNIxz5FTs4p4KHNCMJ2zVoxjJhIeSWuPIkpLUMu9972RWzzc5Qb7qBdYSKMz7P1nhT/69shBEdJtDIcpocdBg1nFTS+BO6akkfECw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789567822; c=relaxed/relaxed;
	bh=EdYQ0YYaqUpsIAwJStZVqjJMxlZSMLlpaDDdTzewgPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYiH3tbMRTKknWYzDq4ugErNizx0fQWlQVzS/4hkBnBi43hPu6B4BA51ua4KAsor31CXlD8Rd/uQteGKA6O1u+gMwqaeigP49fuUzNatO+7f6Siz0zUz98lf263AmExmFJbmS6ZEMAY8WNs71ziRaU2nFVNBaX/NklWBc56CXg56E67GY6ZmkTrhRFd38Re+AZQvmxnqdowdSK/FnO+ZALx7LUvvD+K7UIp3IdPRBdKDD6BMXnZqiuHrmzQYHo6CwqboT14VkLLxeMyXrE1hxZNbRaeso9zeZXGAQxKNPlG3cctee3znDeiweLu/aibK7t4lCsv6A9Pjn4I0dbfVLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=flapping.org; dkim=pass (2048-bit key; unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm3 header.b=V2Uyyhpm; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=KwMwH09r; dkim-atps=neutral; spf=pass (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=tomo@flapping.org; receiver=lists.ozlabs.org) smtp.mailfrom=flapping.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm3 header.b=V2Uyyhpm;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=KwMwH09r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flapping.org (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=tomo@flapping.org; receiver=lists.ozlabs.org)
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlLPn25mCz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 00:10:21 +1000 (AEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C618EC00FB;
	Wed, 16 Sep 2026 10:10:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 16 Sep 2026 10:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1789567817; x=1789654217; bh=EdYQ0YYaqUpsIAwJStZVq
	jJMxlZSMLlpaDDdTzewgPM=; b=V2UyyhpmDmW6qgz9cl7DPDXNxHK106XvYNtjy
	HnsOuWVCnJS352AFvmXWzQELSlMQnT+S5JS203xBsglnzWclWoxxS1rctrlY17p5
	4iYOUsg2M6kpejMEyAGxKCnVjfhllgLuV81ev9YLHyDExLNuZDtHh7fhE+p0HVQs
	r6Wv1T7pvCKX1STy6y4AmpNBUHVj0jtBHix1NuVvw7N3Rr0aWIvnUGqJgo3qbKT4
	ihB2fkUjgFRhNno5q0Hf4gxf61GfUXC8r2E7c7suLe5dBfkPvec5HU/3KYwkU7Y8
	ZoM0qFCFQQrZx36ACVIaCHM6lMXbfmtH8YuWvyV5j89bbEh2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789567817; x=1789654217; bh=EdYQ0YYaqUpsIAwJStZVqjJMxlZSMLlpaDD
	dTzewgPM=; b=KwMwH09rfCH4v+4qV0H47yLgYSv1I6FsryXeHYMvfbO5gIqFhyZ
	eK7KqnY2omK2aUKseLoKNokw9/VOBr+cyc0KuTjZkun35U9jezME8J36tUcI+KjV
	frLgHKTwohS0tq/J76vpkq6FlPXe4aBT4Nw1hdQcyibwg9kg0Ys1ZRmkYWSSu7vd
	hGFg/3xhTKbBMFwNxsKtkmdMzNX2ZA/yqQrX5W8ciH/dFeQu7sO3NGitjrF1KIiY
	qmYe79ntD5+8oP7Z7AqVtU5YG+X9HAxBOibmJPPL0PwKeTcTKCGyl6z5DLAhPVem
	Yu+I+0A6bDmLCFB+ap4IY7QXkcaPJj66PkQ==
X-ME-Sender: <xms:SaOqaphy_2A7LsS5KBWWuTaaG5tgvbltCNYPUV0A8DdEnJweYne1jw>
    <xme:SaOqanamPhMa_e_BFjbQW0S6jBhK-_4d4_5VpzPD7SmXcQ7PDZU-PmY4_xO7fWTuR
    QJ8Cwfv4kemDphr64aOkLnXLC_tMI-e8K9miVAv2v4xtyHIMPEVovbr>
X-ME-Received: <xmr:SaOqahkiAhQ5Z0J83rPxRkjKV4tv72KVEGh4yqtzABPdIgHNxTzBmqbiBWh15KHVZ5cs3BqAqB5e9yxPE-o>
X-ME-Proxy-Cause: dmFkZTFc4N2ADyMAP7+/AFGrGRnNhcF6kiD8BjDmJw2dX0DdaCh3jLG7cqhC1QJbxfAPR0
    BdfdqdSm+3ogDHX6Ano+E9D4kap94lD3cMIkdKrpjUtOfnUapi7kMO8EH2Vp9iKt+tlzmQ
    IWReQzVvrMrNm8S4NpKoqtJOfWsvsqhZlgFB1krDLiJ0g1g12pf1/7INBDP79Ut7Mh2EUV
    7FCJs6yRL5MPqrg2ixcKfLoWOMmw1aKuFcZLWupeiLRvZMt6ky2zfLbtBNN2to6eIn0bEE
    IWpbhRq2JIj4E1tSnwNJ4KTncoiQ/94EXMZk1sIMJPUXjVtFxWmB00BUp6gW8G1mIvblL0
    BrGST3az0sybcySgzoUqo4Fz9UKHPVsvdBG4RVXX1URxz1vzFZO2Q5l7NEa5yDQSsH1iMM
    sVkFFqXpmg48UTd9x6MCQRrtg2IL4s6vnC5Qy/Q+SBf0p2lOH4uRysWp+AdzyUsKEfm0Jp
    ABTG2IjgdJEInrAa6QZqGusvnTjFpMGcWwzqBw7QJB284zX1FgAIiw8uj3DBMecpd26/oD
    8EgfI948ThyqE7ql4QmPsEzCYtQDfUbHH8P0W5Y1v8vHwjr5kTU544DlMWRfe9EHIAua/j
    4AxWc46egBduoFjkazGfDvm9BvOzQNgxgzvHImIJivLqUQu5xW9s3Ee2wmqQ
X-ME-Proxy: <xmx:SaOqatx4z8jVRIoLAuBi2b3z7E-olt_7dp0pWaIv2aHcD2oPpAKraw>
    <xmx:SaOqan8jafgtS7OZ9E5Zt0pGY0xpmBgio8THjhcDG93B-Biqdf_Vhw>
    <xmx:SaOqagABPsPRJ3-_v3siZO9ufQ4ZFyAU8BHubeLFKB9Sd62_dvCyyQ>
    <xmx:SaOqamoPQnzwrBBrR9VAGQHMunzvDLp08Nk4fU7EDQOC3Qc2RJZwuQ>
    <xmx:SaOqaqkyqtiTeNnhbWbo-XL6VVBJ1o_BiJ6TqTAdQJ8xx5BFPdEp51Yi>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 10:10:13 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	lossin@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mkchauras@gmail.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: bug: add a KUnit test for warn_on!
Date: Wed, 16 Sep 2026 23:09:52 +0900
Message-ID: <20260916140952.3290924-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

The test runs warn_on!(false) and warn_on!(true) inside a KUnit warning
suppression block, then checks that one warning was counted. The counter
is incremented by the kernel warning path, not by warn_on! itself, so a
count of one means the warning was really reported.

warn_flags! has a different definition per architecture. The test does not
look at any of them, so it runs on every architecture that supports Rust.

The new CONFIG_RUST_BUG_KUNIT_TEST depends on BUG. With CONFIG_BUG=n,
warn_on! does nothing and no warning is counted.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/Kconfig.test | 11 +++++++++++
 rust/kernel/bug.rs       | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0..966b07872ba1 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -83,4 +83,15 @@ config RUST_BITFIELD_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_BUG_KUNIT_TEST
+	bool "KUnit tests for the Rust BUG/WARN functionality" if !KUNIT_ALL_TESTS
+	depends on BUG
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust BUG/WARN functionality.
+	  These are only for development and testing, not for regular
+	  kernel use cases.
+
+	  If unsure, say N.
+
 endif
diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 3566f0234ca4..17adb1b44fe2 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -152,3 +152,28 @@ macro_rules! warn_on {
         cond
     }};
 }
+
+#[cfg(CONFIG_RUST_BUG_KUNIT_TEST)]
+#[macros::kunit_tests(rust_kernel_bug)]
+mod tests {
+    // The counter is incremented by the kernel warning path, not by `warn_on!`
+    // itself. A count of one means the warning was really reported.
+    #[test]
+    fn test_warn_on() {
+        // SAFETY: `kunit_get_current_test()` is always safe to call (it has
+        // fallbacks for when no KUnit test is running).
+        let test = unsafe { bindings::kunit_get_current_test() };
+        // SAFETY: This function runs only as a KUnit test case, so `test` is a
+        // valid pointer to the running test.
+        let handle = unsafe { bindings::kunit_start_suppress_warning(test) };
+        assert!(!warn_on!(false));
+        assert!(warn_on!(true));
+        // SAFETY: `kunit_suppressed_warning_count()` accepts any value returned by
+        // `kunit_start_suppress_warning()`.
+        let suppressed_count = unsafe { bindings::kunit_suppressed_warning_count(handle) };
+        // SAFETY: `test` is valid as above. `kunit_end_suppress_warning()` accepts any
+        // value returned by `kunit_start_suppress_warning()`.
+        unsafe { bindings::kunit_end_suppress_warning(test, handle) };
+        assert_eq!(suppressed_count, 1);
+    }
+}

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.43.0


