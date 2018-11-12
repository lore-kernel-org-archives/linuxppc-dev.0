Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A05AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:24:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DBE21527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1HdLUjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DBE21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42td1Y3y8NzF3M6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:24:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o1HdLUjz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="o1HdLUjz"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tcyh6XV4zF3Cv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:21:32 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id s5-v6so3650482plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 20:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N5qjw6CuQ5e2lq25QqVD+oGeRhNwxs80XW3IRlwgeLU=;
 b=o1HdLUjzFqvZtU4jSRoKydCuFebeDzUQFCGUgwZ9AXAs4lORQEhz+cIEtFfHGnD0Ue
 mMr3BPzr/GBk7gONJpjP0XKwV6TdkFEBs12yZBlkhESAk4EC2+1WiEslvZKOco80iAbL
 GB+QtTEp/R+I7/7V5h07vMvblwaLtiSi2vadpEMDdtQHMYiNdwQBifgMYTdrmXxDldpn
 4uYBjP70FJB1u5khP9RS1mC7JUvvPL+h5meI+VFpuuyWlqQQqjKMdSxirHEGxgsStppp
 TD7xuaWJjaglu7WGjk3IDrnGOwRbc4vIy23Qj2g7N58ND8M+heks3HHXI+VBp0dwcCVT
 cJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=N5qjw6CuQ5e2lq25QqVD+oGeRhNwxs80XW3IRlwgeLU=;
 b=iiCWOYqpXyTZetHXg7Nh0ymJP4WavO7s2lP4jgqZt+MYkrbosi/Wr6jLHxw2vNJqC5
 98vQtENcaO4wXb219tRMvTIZtXBXZLvG4v9GmPCC6sCZonrh2eZl6MxplZnlhLqo8/xr
 F8mSoKgV8lwwGZ0AfHbeycjYIjft9O4qYEijVTgKBslo5XE11XC3FUg8oLPgldOwQivF
 M/GhY96qCZNj+VFFV6o6ptBTshKSseCSzIBBxwYzcxxTA64liekD6gXowACmIxASOEz6
 Z4DF5MxdnqGF8akp8Bg7oDOCmJzN7t7W/CVrptt01zKMVTWiFUBLm7zrK7BK5kvGxK9x
 h/7w==
X-Gm-Message-State: AGRZ1gKOuok3ohF7zWsi7dxtepRL9uYUDEYhuRJAbBwHXhYHNgkHdIzV
 0KwB+TJhe7dbjzcJTfy7hGo=
X-Google-Smtp-Source: AJdET5cXkYwxp0ns2celIWIhHN1DWh5HBgcUElxlwxGUfpOEW/t0FxTKd89VzxBDhWTbVKaguUajNw==
X-Received: by 2002:a17:902:2863:: with SMTP id
 e90-v6mr17862946plb.244.1541996488823; 
 Sun, 11 Nov 2018 20:21:28 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id y9-v6sm15588958pfe.152.2018.11.11.20.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 20:21:27 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 12 Nov 2018 14:51:20 +1030
From: Joel Stanley <joel@jms.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 0/2] powerpc/boot: Fix cross compiling with clang
Date: Mon, 12 Nov 2018 14:51:14 +1030
Message-Id: <20181112042116.5271-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
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
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v2: rebase on "kbuild: consolidate Clang compiler flags"

These patches allow clang to cross-compile the powerpc boot wrapper.
The boot wrapper constructs it's own compiler flags as it may not be
built for the same arch as the kernel.

The powerpc64le kernel builds natively with clang and with this patch it
can cross compile too.

Joel Stanley (2):
  Makefile: Export clang toolchain variables
  powerpc/boot: Set target when cross-compiling for clang

 Makefile                   | 1 +
 arch/powerpc/boot/Makefile | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.19.1

