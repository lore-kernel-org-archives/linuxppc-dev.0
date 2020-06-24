Return-Path: <SRS0=QJlM=AF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150CEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:24:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B7A207FC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MyLNvjH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7A207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sbkn5gZkzDqcT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:24:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--brendanhiggins.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com;
 envelope-from=3ab7zxg4kalitjwfvsfzayyafkyggydw.uge@flex--brendanhiggins.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=MyLNvjH4; dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sb8b6jjHzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 06:58:20 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id z7so3619889ybz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2020 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
 b=MyLNvjH4BaSpMVt4m7OL8w8Kh4XLox5uMmU6/Z0ItdZP4yMrnH98CNwuV3QeifZL92
 3Y8tuGJwfcNuWZHxP1UkeqK/xJb1NRFlgtf+ZsZAZxk1HsrR1w7SdO7zb9wvBE1lihXo
 /gM/39u4cbejNpzreOPpLQs+1yfAKtUU1a9px0EyuTVEN0JzHssKb05XMKZvWoaTlB2G
 t5NtebZVftxPJvJkT4/iXrbXs6qVYFATI3eRi67iQDiHIAzrHfb/09cLTk76ga0CyglA
 oHFKXvdwJWazciq0ZtyNXvUR8S40GGOhq2T3LzC+e+3smItGPZh/hoBFWoC5eBtta1xc
 lXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
 b=bL1Cgh6wyFIa++iYz+rJ4rIgPoAuVX7eTQSFVJKvlEHK0wSyLqzEdoUltbVtUvAhVV
 C3ZApW20F4wxD7EEy494QI6Jg7d0NH+wUwHns0EhvT/TIcI/3v0wbhyZbLO77liHt5jF
 ekLpCtpNKoxoVVvPZZgtv9G+IIWgqMCtLKDz/vZNOpqEGmmq1LEEhaWUMlYWgtvQWl5+
 mLPu07PggWKFMJLyvB5PZf48AMULyuntRVBG9FX4z0P55XC8fYEQQYmGWRBqkB/m3ZDW
 yv2boDwvQ+tuA/Yy+R08IYtehpvLNkjLX5wzDn8qfFm6A2o8En1Y2bvqex87LLMGeJSz
 0taA==
X-Gm-Message-State: AOAM5310qvidr3B9TVzZiXpE7PznjqrzdJFrkkY50m7m1vv+mBzUFuB3
 ei1+vcfToLHV++QIWuRb++IwgQpWjMT9g7BQV7vimg==
X-Google-Smtp-Source: ABdhPJzg+Au4umwjyLRblCRE3PuIJNmc8kxElVJsT/B0YDcGaL41JkWSqA7GJtKTxCWTEEXd8EUt+BFhsEEeVgNcGl0dpQ==
X-Received: by 2002:a25:73c3:: with SMTP id
 o186mr43621885ybc.230.1593032297774; 
 Wed, 24 Jun 2020 13:58:17 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:55:44 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 05/11] arch: um: add linker section for KUnit test suites
From: Brendan Higgins <brendanhiggins@google.com>
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
 arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, 
 alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, 
 akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, 
 catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, 
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, 
 chris@zankel.net, jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2020 07:08:14 +1000
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-doc@vger.kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>,
 mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41bd..9a9c97f45694c 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.27.0.212.ge8ba1cc988-goog

