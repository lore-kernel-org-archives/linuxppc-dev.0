Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF8C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB6B2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiSU2W/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB6B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DHqy2h2XzDqnB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:31:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiSU2W/4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiSU2W/4"; 
 dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHmc0h8zzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:29:03 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id k8so5900550pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wsolr/BoEZyboWroSACAY9B4LsiVLasYDYA2akxxAjs=;
 b=aiSU2W/45r42N2qszl98h57eu8a3vdkfOVivvjJKGqTuU+g3oXL1+FAWK+MU+ELWwZ
 UrlN5ax+r3/ZVdf1BWXAJd1g7PJjsMql1SV1tn3xg7a0zXH0C4KlxqsuqBcJJ7jUCOgM
 wOssUZiM1WejiFq+eS6AWMvjQguIcumI6AQTey86FVrFIeg5/TEL3qYGsayQwN2gcSY/
 s6wrIEvTuoaIPeeTgNoz+1/zF5T1/OKrX1t8jOhyv+uHA8dTn5T7UhsigWmpQI2/xAgG
 J/FlN2mzakUZt1xJ0MrIN2c16oL4ePLuOfuk1oWfRDWEWdHQ3jsacaFVgIewUj1qRErX
 +iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wsolr/BoEZyboWroSACAY9B4LsiVLasYDYA2akxxAjs=;
 b=SUjsBV8Mou4rnzH8SEI3szvK4ZHRUwpDiawuQfRUqAE3FMlEEcr6BV/enrieSd9TVL
 fipLD5/E4tba/HIDal7xM3BVSzwmhZpvyTmwOe76xMx6I+mI3j62J2UnVx8feI8n6nq1
 xnmDPixxmpApDDOVQcP8Gf4edv1Ww7zbXhtlqB7nQ2LbvQHAwrJ5HLYTSnWSrmW7oLLw
 573I3dWgZwjXsa3mjirnGo3oIEPg7u1jide2Wh6tSusgC9lOwzBYOmfGNTnrRwmgeuIQ
 5vLIC5eD+YVpF/fQYFlc6jalTBLp57pKr6hKCQ1+vjxiRSnJ8ueqT08hxdp7a2AFwblj
 NMbQ==
X-Gm-Message-State: AA+aEWZFoYadQNx6eE+plhiAGziE0lfYxa/SASiFvHED6m9k+x6897ki
 Q+Np5P20YK9JToAf2iLsrPtOjz+T
X-Google-Smtp-Source: AFSGD/UYkC+mYPW69wlJhgRKYJLAZvX9uywE1eoqqWQd4YALwztx0ZfNVhrawdMNtPPvCXmTt2xOTg==
X-Received: by 2002:a17:902:6848:: with SMTP id
 f8mr13429924pln.300.1544480941517; 
 Mon, 10 Dec 2018 14:29:01 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id j6sm20143821pfg.126.2018.12.10.14.28.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:29:00 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 11 Dec 2018 08:58:55 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/3] powerpc: Add to linker script discards
Date: Tue, 11 Dec 2018 08:58:51 +1030
Message-Id: <20181210222854.21156-1-joel@jms.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v3 fixes up the splitting of the patches, moving the dynstr hunk from
patch 2 to patch 1.

v2 pulls in the branch_lt patch too. No changes to the first two
patches.

Joel Stanley (3):
  powerpc: Discard more sections in linker script
  powerpc: Discard dynsym section for !PPC32
  powerpc: Discard .branch_lt section

 arch/powerpc/kernel/vmlinux.lds.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.19.1

