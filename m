Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6145CC433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 22:27:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED42071B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 22:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nNo4Vy9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED42071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bh1sq1R2PzDqRW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--ndesaulniers.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3xspoxwwkdc8yopdlfwytpcdrzzrwp.nzxwtyfiaan-opgwtded.zkwlmd.zcr@flex--ndesaulniers.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=nNo4Vy9v; dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bh1qX2JHwzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 08:25:39 +1000 (AEST)
Received: by mail-qk1-x74a.google.com with SMTP id c191so2015347qkb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2020 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=8Cpt1ljRc5OUFvhttJIkywuliHVtTrKBkn67gE9JDjs=;
 b=nNo4Vy9va2+LZTqvDKpxwiSMCYKfhf2ERgp336ctF3JBDUsOPg+Y9R4xBuOvFzpqbb
 7bsr8zYEpC6m04ZiYGlNZj9fs4bp2HfQDMr92bKf3fRoWcglT9tA5zOrFC7nL4q229xt
 8nBfw+3DA4zhaNIc5yVoAEdYZbhcU3K3wjF5Jw6WvYS25TWQYnzAPbVrQQK+8SlS7qqx
 TA2vtd3iFV9EAGTsZUUApqRrrBcVvZQ0gqexY0Qp6jEgW9nRS3WDQuxltOk+WH4em8GQ
 cVOWTfLfbcjYWyPhj1yQW4xLtr/uxt+I5NYJi58hUfOhL/mYJoS0sKmVexYEXcnpW99W
 8Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=8Cpt1ljRc5OUFvhttJIkywuliHVtTrKBkn67gE9JDjs=;
 b=HHas7u224JLX+CK5R2IJ7FuyxmjpSuXYEB3tkDTrzOnmzxB2HpTZN1u8h1vouosGw5
 s8CJUuifAghJbJxTRlw/0DcdGKAXV7FbE2C8DcIfExu7WIAATnbuu1u/ZYrm7zQBSiqs
 bb9hMZ9H1/7gP6JmlKTrLzM1n0nV9wgT6z+D6u7ORvLxzzJr+815hPzjhhscPPjYDwAD
 OT8019VpNMJ+TiwpXf1D6i12N8g7g+3GFkObLpAySDMC+wnZXz/i6rpdSeq3KdRcdQGE
 hqHmS+BpDq4e7tFhjxs33slmSDtSdxEkQwlZ2sXfKYiTo4wH+za0QEBQKkhIXJB0lPAK
 FNHQ==
X-Gm-Message-State: AOAM5312z/XYlZKpcK/Dn0X6ONg8pi24iFpoWYEtHOTTWk9NNRye0rM2
 CY1rWJcgCCQAwiM5RNGqf8vH2ZnGIwWiMlpVtOw=
X-Google-Smtp-Source: ABdhPJw4pDP7L/8jSUUI60udN2zaLrmNYvzSnz3iTfjyKHES7GeqPrOawy43a3WEWoiGf2R3turAoULAtxPlbxsLVLY=
X-Received: from ndesaulniers1.mtv.corp.google.com
 ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:e8c9:: with SMTP id
 m9mr4288274qvo.51.1598999134297; Tue, 01 Sep 2020 15:25:34 -0700 (PDT)
Date: Tue,  1 Sep 2020 15:25:21 -0700
Message-Id: <20200901222523.1941988-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 0/2] link vdso with linker
From: Nick Desaulniers <ndesaulniers@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Joe Lawrence <joe.lawrence@redhat.com>, Kees Cook <keescook@chromium.org>,
 Fangrui Song <maskray@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kees Cook is working on series that adds --orphan-section=warn to arm,
arm64, and x86.  I noticed that ppc vdso were still using cc-ldoption
for these which I removed.  It seems this results in that flag being
silently dropped.

I'm very confident with the first patch, but the second needs closer
review around the error mentioned below the fold related to the .got
section.

Nick Desaulniers (2):
  powerpc/vdso64: link vdso64 with linker
  powerpc/vdso32: link vdso64 with linker

 arch/powerpc/include/asm/vdso.h         | 17 ++---------------
 arch/powerpc/kernel/vdso32/Makefile     |  7 +++++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  3 ++-
 arch/powerpc/kernel/vdso64/Makefile     |  8 ++++++--
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  1 -
 5 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

