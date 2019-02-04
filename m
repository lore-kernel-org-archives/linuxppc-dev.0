Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B449C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:20:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FA92082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3YwVgfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FA92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVGs3DD5zDqHj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:20:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s3YwVgfv"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVDw5P40zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:40 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id c123so10967pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Nmu8ICLLQtZZhOna6Husv88oHzZT9dSFXljp1SZRFBQ=;
 b=s3YwVgfvbgGs20wyAQUK3a4JxjQd403rzFp7ycBxc4ITZJGNeIj2hkf660PvtA7dMo
 8mFERulpGQ3dm9aLJO4F/lhZ8zvkRQwZ6CGsN+37GGAYx10mlKnDCFHgQuhbi8FxAJSL
 fqjL6U6kCBoq+pzMaP7Zon8nQrr7beK1xDH/6JqkbCTUk7WbMet+mJTARquNuJfZGHEv
 NEtHQQGiro/lItLZKuRk0LZtE0iFpAsyKZONbSCP9a+j90pzrXnvnxKGXj9yTuxup0HY
 HdcwQQW/uI1TTQy3eFKj/PvIi+P/wjbbocIS0hdqYyfGhjOarPRTdvo7syZ6f5ALsrY8
 CQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Nmu8ICLLQtZZhOna6Husv88oHzZT9dSFXljp1SZRFBQ=;
 b=tF0cqRm1AX/jEpPGve3KD8ruccNv5Up1arX6LyU4eX19ZZgIIuuLs04EO+8yOTrH8C
 U/4QLjSPEfDVL01yjdL9Bet56A8n3E5vtGPSVNK9S1GrKUXn3/DnE66Ia3ySO37zY4Sj
 S07a9+WvMbKWMXixFtAkkhAlogRWG+tCUzuR0UWhbNbdUTcLWXbaDpGw4B4kK3AYomIL
 8/prtAEwTaiIXJU0bkY/UTa0zfrY/M2KqP5RNcsoE8TRhEHzRB64P/QKlAciV5ZcKpOi
 BayAOmS82gozdaDxe+D3MgW5dpUKsmeJ8+KGLuzPIiwd+hXzSY0mcUm+fJI/xbXJOL5W
 5spg==
X-Gm-Message-State: AHQUAuaYC0IbZs+UliYfknDZo2yVf2GJ6NI/O0CIFxsD8veHN1+NYAum
 Uq2KvTbk03ojJy7gv8oS+2+meeMT
X-Google-Smtp-Source: AHgI3IYgthuPeEvuhuUmG11o+lOGOcE+Giu/oYMvZk/uDHq4Z9tTIPUVtPNncVZJ6NgS/JcF6BtzAw==
X-Received: by 2002:a63:2744:: with SMTP id n65mr13103929pgn.65.1549289917945; 
 Mon, 04 Feb 2019 06:18:37 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/17] powerpc/64s: tidy and gasify exception handler code,
 round 1
Date: Tue,  5 Feb 2019 00:18:11 +1000
Message-Id: <20190204141828.13043-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

My previous big patch was received about as well as can be expected.
That is to say I'll assume everybody loved it, so we have to get there
a bit more incrementally.

This first round of patches was verified each patch (with several
configs) to not change any generated code, to make a small step to
improving things.

The end result is that head-64.h is only used for fixed section
layout code, exeption-64s.h is only used for some paca layout and
speculation control sequences, and exception-64s.S contains all the
actual code for interrupt handlers in a bit nicer form.

There is quite a way to go yet, but hopefully this is a improvement
already, and the good thing about generated code not changing with
this series is that backports are easy to verify. Once we start code
changes, we'll want to minimise the number of releases they are
spread over.

Thanks,
Nick

Nicholas Piggin (17):
  powerpc/64s/exception: fix some line wrap and semicolon
    inconsistencies in macros
  powerpc/64s/exception: remove H concatenation for EXC_HV variants
  powerpc/64s/exception: consolidate EXCEPTION_PROLOG_2 with _NORI
    variant
  powerpc/64s/exception: move and tidy EXCEPTION_PROLOG_2 variants
  powerpc/64s/exception: remove the "extra" macro parameter
  powerpc/64s/exception: consolidate maskable and non-maskable prologs
  powerpc/64s/exception: merge KVM handler and skip variants
  powerpc/64s/exception: KVM handler can set the HSRR trap bit
  powerpc/64s/exception: Make EXCEPTION_PROLOG_0 a gas macro for
    consistency with others
  powerpc/64s/exception: Move EXCEPTION_COMMON handler and return
    branches into callers
  powerpc/64s/exception: Move EXCEPTION_COMMON additions into callers
  powerpc/64s/exception: unwind exception-64s.h macros
  powerpc/64s/exception: move EXCEPTION_PROLOG_2* to a more logical
    place
  powerpc/64s/exception: remove STD_EXCEPTION_COMMON variants
  powerpc/64s/exception: move KVM related code together
  powerpc/64s/exception: move exception-64s.h code to exception-64s.S
    where it is used
  powerpc/64s/exception: move head-64.h code to exception-64s.S where it
    is used

 arch/powerpc/include/asm/exception-64s.h | 585 +-------------
 arch/powerpc/include/asm/head-64.h       | 204 +----
 arch/powerpc/kernel/exceptions-64s.S     | 932 ++++++++++++++++++++---
 3 files changed, 822 insertions(+), 899 deletions(-)

-- 
2.18.0

