Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B6C32789
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:14:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F9F2082D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7KmUNoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F9F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pBTR6mcVzDrNV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 10:14:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n7KmUNoS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="n7KmUNoS"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pBQf1KWGzDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 10:11:54 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id p6-v6so3483235pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=isUog0aOf/hqVTaDw9wDJKRzU+HRJFqdS884BjUzvdM=;
 b=n7KmUNoSIB3R+Kzy+fwdZNA0HQAQR9N/M3rMckuxxAs/k7QL+lOhJ4oOWM0UiENzZ+
 f4VIQOD5OtOC0m7EVEvc7baDVOOuNvZmaINu6LSl4F0XOrhxqD01/TyMl0pjZKVGkIJp
 gcvS7f2WEsDSje5etPX6Y3yLoDb77xpEKDRxOUJYKX5N4cPKwyt3EK8yDfdHbVqcnBJm
 HxG0H80zi74YoiCyUvuJMLytcgxoa1NYHcnK3fHmTxvDd5Q9eRXe5RemjONsDHLJnUCy
 rru8+CVvFCM5JIHDdR1anuKPI39uWCpa1TIjQKOODOt2yrf2w1TNm0QINwFwperzCJ+q
 Ujbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=isUog0aOf/hqVTaDw9wDJKRzU+HRJFqdS884BjUzvdM=;
 b=tRTf3v+FC8gdH/7NmqIEmTVpZG0mR1D2UbQ3OpUSDvP6ei1qj8BAmi4RyG3AQpHKJB
 NQxA9bpJGgRKPaJ5UCcy0Dewgm1tM4vHh02bhUS5pXKLi1DgJmdY18OHlToYI76ZYEv2
 UkIDZSZ1EMIwKIh7w/SkB2Id9LFwzi455h2JuO+xEMxtV+Z+gPAGxYq9YSPHhDVeXgvx
 nPKdo9deui/L0bbbkniJa5s9i90y1EJH9s6aKwUYyEc8m62eIzVmS+00ZoFzIwufdQ+c
 3G+594jwOXyzEMUbGb7fQ1ioIdfd8z5OuSdy+G0gBNQwoGRDYVHH9j0eRdaooGfIXd/h
 0bXg==
X-Gm-Message-State: AGRZ1gJ0ARGjApHj6UeelzmicyiW2IQce6LtcnG7zoftRCIv0j4mTKlz
 nX6I6iClL+cyuLxwLiNv/sQ=
X-Google-Smtp-Source: AJdET5d04Fmp28MisJT5YH2XKIUUiMBJdW94MejxSqfUWmLvVoIre3gcfwDiVnWCOZfaZphM6mAQRQ==
X-Received: by 2002:a17:902:7784:: with SMTP id
 o4-v6mr13667048pll.292.1541373112030; 
 Sun, 04 Nov 2018 15:11:52 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au.
 [49.178.43.40])
 by smtp.gmail.com with ESMTPSA id e131-v6sm16390261pfc.122.2018.11.04.15.11.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 15:11:51 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 05 Nov 2018 09:41:40 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
Date: Mon,  5 Nov 2018 09:41:31 +1030
Message-Id: <20181104231133.30848-1-joel@jms.id.au>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

These patches allow clang to cross-compile the powerpc boot wrapper.
The boot wrapper constructs it's own compiler flags as it may not be
built for the same arch as the kernel.

The powerpc64le kernel builds natively with clang and with this patch it
can cross compile too.

Joel Stanley (2):
  Makefile: Export clang toolchain variables
  powerpc/boot: Set target when cross-compiling for clang

 Makefile                   | 3 +++
 arch/powerpc/boot/Makefile | 7 +++++++
 2 files changed, 10 insertions(+)

-- 
2.19.1

