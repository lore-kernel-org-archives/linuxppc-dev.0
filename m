Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00BC56201
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:39:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4F52468D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GGDHAm3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4F52468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbyRp5yrZzDqcF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 09:39:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3r6g1xwukdmw469t6y66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=GGDHAm3c; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbyLz10GczDqbt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2020 09:35:31 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v13so4562397ybe.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=Miahan6m7tpW6fRqJTx6nONE/ESffi7QnD+KLWja0Ls=;
 b=GGDHAm3cU3+hkb8sL/HNLpy1LYwJv0QJznQ3rADbdarpHNeiTusvzlq28P20g5O7Mu
 KjbDDb/MTwy/hIaDLyOkOZA3bc/LT/Db8EVgBvZWdI200d7LMlUwSUDK3X+Od28FqRZr
 r0eKJMQPBjlbV4jzDjkpfVUxi/TozCUwewBL2kZmdmjMXHt7jVFu+y+NtdGyNKiD5r/U
 tBxVWlDC1Yx6ddpDpSvVU/zIYTqcrTOyxHvd3LgH0GYnsiBFlOTOLM6QKg6mDnVsQOIo
 D0nTx1+5P7MsTHVObFpVypx8z3C8yqEUU+E411z1YJdc18O4yg9i5x3w8Wf8JSxzrxdb
 V5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Miahan6m7tpW6fRqJTx6nONE/ESffi7QnD+KLWja0Ls=;
 b=anloM3G2qJfsVHClUMCxJ2Ga9ku6MX0LDzKk678HUE49yoxf3H11kLqg+IwlqMfoQ8
 iLW+ROpuQxpbry9SHHoRqpfzziQtuduh6FnfvzYETRcplrMdod8GnQ+2mgXmFGnOHYQb
 9eZeXZHiRlkQ5WKFjDqwST4fGJRDhOju4valL3sTjxQJruex8Idkf+9KHHAqUIWaknl1
 muY1Mp+C9N9+BUkMZQxedmByrmfSo4hbhlNjYglGgPMHFLxgHSodsCC4iZ8kTGnLPAKi
 9RqwGZ3300ROes7CSQziZwbNiqXO1r7m4rETZT2+EY7RKCKctEj16mGHSwcGrx48oGGe
 OlHA==
X-Gm-Message-State: AOAM5314Y+qI4zSMLaJbxVL7MwWf2exSfh0ZVcAF5PjXA93LMXE62JvH
 3G44VXklQz0bvOYJ/BwOcRl9EGMK
X-Google-Smtp-Source: ABdhPJztg46f3n7dIzCjap0ld6dzT0YAXEBB0yFO5ADsLNlXreMB+p72tJ6hjXA44INMgJra5EfyER+WrA==
X-Received: from fawn.svl.corp.google.com ([100.116.77.50]) (user=morbo
 job=sendgmr) by 2002:a25:c083:: with SMTP id
 c125mr12093154ybf.519.1605738927914; 
 Wed, 18 Nov 2020 14:35:27 -0800 (PST)
Date: Wed, 18 Nov 2020 14:35:10 -0800
In-Reply-To: <20201017004752.415054-3-morbo@google.com>
Message-Id: <20201118223513.2704722-1-morbo@google.com>
Mime-Version: 1.0
References: <20201017004752.415054-3-morbo@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 0/3] PPC: fixes for clang support
From: Bill Wendling <morbo@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series of patches include fixes for clang issues that arose. The
"powerpc/64s" patch was "inspired" by a similar patch for ARM:

eb7c11ee3c5ce arm64: alternative: Work around .inst assembler bugs

Bill Wendling (3):
  powerpc/wrapper: add "-z notext" flag to disable diagnostic
  powerpc/boot: Use clang when CC is clang
  powerpc/64s: feature: work around inline asm issues

 arch/powerpc/boot/Makefile                |  4 ++++
 arch/powerpc/boot/wrapper                 |  4 +++-
 arch/powerpc/include/asm/feature-fixups.h | 19 ++++++++++++++-----
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

