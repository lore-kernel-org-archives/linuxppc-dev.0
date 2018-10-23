Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F297BC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:19:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BBC205F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 06:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2f88oRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BBC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fNXJ63XyzF35t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:19:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o2f88oRx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="o2f88oRx"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fNTM6nykzDrcQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 17:17:11 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id l17-v6so162482pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P0IT/oTRc0e1ExFBboLItnQV+gJEC8uwUOjbeLCzUZw=;
 b=o2f88oRx8tXgvy2XxU60zRnQGnt1UNf5PD4qWFdzbDMFZkDTl5AbKB7GVbd+ok/ILy
 RzPaed4ZoP0mSlquBcoj0jEsWXET/m3vfWD33R+uIeZJwEX89yMN1tO4Yd/zXeTEGC8R
 yC9P1Fky4zA1JF1tm7w8nJ9GWeQTCku72d+ZGiOlKjhw5QNKSQKW/TyKvEDmWDLOSGF/
 lSiiDvoC2wZ76FLxn8QjO73AjSxha3jFOGTFlDwO4I/fsnjC+qU/u6Q487joOOwnddfW
 nskIYk7nbWigOFKog2dMrlrZAU8uFfEnF01iqaYpb9Iek8L0AbcX97a+k4jwbNjbxp9/
 oHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=P0IT/oTRc0e1ExFBboLItnQV+gJEC8uwUOjbeLCzUZw=;
 b=GTMRrc743uTNPaQWsonWzKG6V4SYAMYlbp9ZEmYV1K+WRGDzpssWr/MhknuvdZjRJ3
 mtAdeWYJZSlJGK0sNGifXBCSORqFIsdhqaaBJ7jk3Vp+Qt4Mrm1HP8YCD3T7gXBL3yZ5
 sO2g6vlHZDoiANd1EOcKFIRm7glk+aDxBWUijIQYgfyepmVeR+S/HbDTJpgE11jJ6zhf
 A9ygo/a/INBnyFGbYQuVCJyl0LjNAGIdCCjQLsV4EupCFr7u29C4nxF1Ip4uO3Uojvhq
 YQUmTuszWRvkPtHzA7yFxpmPj3Qs4/6BayUxJZXC3g6ut7uEeCdpdcFEapLbKGupQ6G9
 rWvg==
X-Gm-Message-State: ABuFfojcoZIrm5ZsFS91NkjL0LuiJWf8yPzp3toRMvTsGBYjiBPsC/a2
 UZFqs/w24gARBh72JdoFnwY+jxZr
X-Google-Smtp-Source: ACcGV63BOQ14S5pIhppOEHQ/xp5/Rfasw8jvzGO9r8fjTfuSS/0d0tyItS3XJHE8+brXq/ZXac9kIw==
X-Received: by 2002:a63:4343:: with SMTP id
 q64-v6mr47066487pga.276.1540275429148; 
 Mon, 22 Oct 2018 23:17:09 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id h6-v6sm722548pgn.84.2018.10.22.23.17.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Oct 2018 23:17:08 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 23 Oct 2018 16:47:02 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] selftests: powerpc build fixes
Date: Tue, 23 Oct 2018 16:46:51 +1030
Message-Id: <20181023061657.18007-1-joel@jms.id.au>
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
Cc: linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series fixes issues I encountered building and running the
selftests on a Ubuntu Cosmic ppc64le system.

Joel Stanley (6):
  selftests: powerpc/ptrace: Make tests build
  selftests: powerpc/ptrace: Remove clean rule
  selftests: powerpc/ptrace: Fix linking against pthread
  selftests: powerpc/signal: Make tests build
  selftests: powerpc/signal: Fix signal_tm CFLAGS
  selftests: powerpc/pmu: Link ebb tests with -no-pie

 tools/testing/selftests/powerpc/pmu/ebb/Makefile |  3 +++
 tools/testing/selftests/powerpc/ptrace/Makefile  | 11 ++++-------
 tools/testing/selftests/powerpc/signal/Makefile  |  9 +++------
 3 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.19.1

