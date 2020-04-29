Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC49C83003
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 06:28:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7172072A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 06:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4YVSm3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7172072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BpVR2mTdzDr1r
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 16:28:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c4YVSm3r; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BpSC2L9RzDr2P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 16:26:19 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n11so548305pgl.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=156mAdtbXrAtQn8wRrvpCc5QWpHzVPBqsMEQGAzm00Y=;
 b=c4YVSm3rCGCqn7jDuEsJMmfOeCbxBuTNagOgNEG06YIogz8H9eZKQsv+vv9r22w1aL
 6/9P42arcoqQNC2hlnVOruwOAdDtF4IomysW2jVVAz62UFmChTAy+OrV35k2fJeE8Tn/
 wzQPaVvZyje/ZxzVvJvUe6pjgjWJn9F8c6U2n8+JoCrZR+dPDHnCx6Ggj/+r3OpgiXhc
 9HeoAdiewq3w8aFJaTps7Nuv3/YjvkdREs0F7z2an0PCm1Rj+xCBNjLFWVURzus+f1rl
 HqbgfUz684X79MSDX6E9qNqIswXO2lDC/wq91fTOzzYNu4aoHyi9eaVUldIUvghL5xfr
 ugJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=156mAdtbXrAtQn8wRrvpCc5QWpHzVPBqsMEQGAzm00Y=;
 b=cLsLs3/dU5FcJ2Epw0Pi526537iMrJvcp8wutNXR0+MYC4tS3O7rR0aq0O8z47VzEh
 EEwIlCub/VH3e6L2aShqi41eeslW2+Wbfw/J4UPiHZQAreLB5RM/+37xWcUNIZ9d8/ey
 R/KUHXtD5G3pbVKpPDxk1KQ5SopiL2boFG7IO56RaDmcQ0FsLL4jXsUSIKeTp6DTtDzw
 kTBZtuiyOTNkOFnbLJoV6FVehDkw1JOEdx+JKyWnNWV5sfcpCn9KcttxiuwvmWV0Xu0u
 IgoMbkwBaXNex2UdfC9D56k45XpPSHBgWUYtHs3Lu1L+v2D6z4DFzJG8ZP52SRIh5l63
 7P7g==
X-Gm-Message-State: AGi0PuYj0cZoY2Pn8nYKsjamVQG3tw+StYSDBFRY9+7r2qN4tIYHmvId
 Ad05e5fL3bGWpFGfkashi2LFyBbn
X-Google-Smtp-Source: APiQypJewL7nYgdAYq7CgP9z5hbPxYzSZ2f1bY7Qu9uLit6PrUdQ0AfH6WVcpd2mX5aMs3vBPYblAA==
X-Received: by 2002:aa7:9709:: with SMTP id a9mr35368666pfg.166.1588141575241; 
 Tue, 28 Apr 2020 23:26:15 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.220.177.17])
 by smtp.gmail.com with ESMTPSA id s76sm164373pgc.85.2020.04.28.23.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 23:26:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] assorted kuap fixes
Date: Wed, 29 Apr 2020 16:26:00 +1000
Message-Id: <20200429062607.1675792-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Here's a bunch of fixes I collected, and some that Aneesh needs for
his kuap on hash series.

Nicholas Piggin (6):
  powerpc/64/kuap: move kuap checks out of MSR[RI]=0 regions of exit
    code
  missing isync
  powerpc/64/kuap: interrupt exit kuap restore add missing isync,
    conditionally restore AMR
  rpc/64/kuap: restore AMR in system reset exception
  powerpc/64/kuap: restore AMR in fast_interrupt_return
  powerpc/64/kuap: conditionally restore AMR in kuap_restore_amr asm

 .../powerpc/include/asm/book3s/64/kup-radix.h | 45 ++++++++++++++++---
 arch/powerpc/kernel/entry_64.S                | 10 +++--
 arch/powerpc/kernel/exceptions-64s.S          |  3 +-
 arch/powerpc/kernel/syscall_64.c              | 26 +++++++----
 4 files changed, 63 insertions(+), 21 deletions(-)

-- 
2.23.0

