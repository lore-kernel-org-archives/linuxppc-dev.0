Return-Path: <SRS0=QJlM=AF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C0DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:33:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6AE207FC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="j/kWNJMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6AE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sbxG079xzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:33:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--brendanhiggins.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3c77zxg4kalwdtgpfcpjkiikpuiqqing.eqo@flex--brendanhiggins.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=j/kWNJMp; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sb8q4MrqzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 06:58:29 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so3620213ybz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2020 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
 b=j/kWNJMpkLx+QCXq2SQxzFXE4HDX6KCmSJPXrZblzIllowutKkBsG1ud3ynRKeW8lJ
 MtI48a2Cpj4ziGJGkEDlnEQv6DyxH1ousx99m6BnZKWQj6+/LMpBSQfN3Z2bJMnOIIhA
 veEviOrcT/oF5/ldeqAc8VZut+QFQYvbmgweDJvMdfdtNxBA3C8QstHTAtCWJCFu/uEM
 g8XBJvmlW8ZgWrslgR4KbC9ZLSy7BQNUKbLrK1dtpNcacunnYBX6IN8LUDosSMZIIPFI
 SKEMPUUw5qzV4tY3UOeSc9MtEF27mtDWWzIJ/xKaLfYUcG1fAVOTQnmOwrBK/8eH1yD5
 LvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
 b=NsPYGWO9Of7ZtM+VIa6ZQhMJTFR9dBBvw3XreoqZuP4YeuKcgwGDjuSrJGHxI4e2BI
 V+Wu5NxwvbeATD8FoVQYT8YXC6/BQ2oV3lAkavnbDkJuY5U41ZiF8WNTevtm/5JVyzpR
 FDXa1ajxv9hTKvkIPcCkW3mmBAWeTvvZrLnbF4PLFXF+gEQrKCcUUcq2pPtLcc8d3b1q
 pReiAcrcRK/T6v3QQ/Dg9t1RHk8fs9raTYPsCThjQg5l8/9VgT9QsO90OpnghM9QLNtx
 hz6VOuE78/o698h0soy71/0nC0ehdPB858+0HVrkugqH6+lg9X2V3CNCNLoQWNpcTCAy
 Yh+g==
X-Gm-Message-State: AOAM532Kv3EZhgKtLmwQpdq5Z6lL8SQbzuFT3Can/93t8OnXkJCNmfIP
 tQx3BrGOFRLOygU0LJbKxeOu3SoOUxeCzexLQ7ymyA==
X-Google-Smtp-Source: ABdhPJyhpPPbZya9wx2VzaMGagNQNdOzG9SvfIE26+f96tSAZOYI00iBbgj44mO45Hc8tO4IzqRsiRZjGUUWMQvf7cudgg==
X-Received: by 2002:a5b:c8b:: with SMTP id i11mr45672710ybq.484.1593032307073; 
 Wed, 24 Jun 2020 13:58:27 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:55:49 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 10/11] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
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

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79a..e7d5eb7249e7f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2183,6 +2183,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.27.0.212.ge8ba1cc988-goog

