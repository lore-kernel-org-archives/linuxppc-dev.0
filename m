Return-Path: <linuxppc-dev+bounces-23563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7531CC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2026 15:58:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gswJG5C2gz2yRM;
	Sun, 05 Jul 2026 01:58:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.18.0.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783180686;
	cv=none; b=YAVs9o1DLulsfnKRgUjxuYTK7Bp1t6WxnrQ6yrzNkTwjd7HdI+X7GRdEgstBCPxBDhP+g0hGlqJ+wLhv/iWpcj5MirK+unB33fD/nmDNQLuJWKJRhre1T8O6yHDCf+G4CEkgsG5m2aGzNP5gdB3T6qqfKeADGZDwEiWBOHiGkMOQDD2jLd/vxkW11vEH0d7PM9plRVbUo8EkJI/vMk04KavgcYyHmcPKJbVXH+9lVshjb6E6JK7Vz+iGAIorZte9rp5q0acs3vqey7A67b/ZDmJUd1pswxiKYyax7F0p6cQvjDyelwsmvvK0/P0pM7wt0UyxN8yaXqvHY3RyvLn9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783180686; c=relaxed/relaxed;
	bh=XKvX5DPQrSUHYICcoTrV7xOdzNCIwyOltYffht6DPHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSCKr8B0PV/V9jmHxkdh4BJ1BMfX4FtUBXiY77Q0v2Gb1Vw9/Hh2z1PePqY1YeGU6LrAMn2lceKRx6gbOh/LH3NnClZNoH9PiUHaR/RLFHjGi8+Yon+6e98zsW2frQsFwsb1oQbb3n+XCfzWysTdnaOx0M1kFbWRwktUxH8+EnKPgwpJCv3Z0zaFmr2KduSgsV5ZjCDmwc28bIelIb+STnoIdq2TifmHbEmticQOwbNjMg3nkk7H5ROCLRv3Eh4CaVo/bneoJlSd24H6UmbV8pxm3lnDhQnj4HnBEELKZ/dQf7HaBpnOw8ya0NdCMRN/zup9QYttRP7HRYJFriOdTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=212.18.0.10; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.10; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 483 seconds by postgrey-1.37 at boromir; Sun, 05 Jul 2026 01:58:05 AEST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gswJF0rc8z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 01:58:04 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gsw6s0cxcz1sHQH;
	Sat,  4 Jul 2026 17:49:57 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gsw6l1FYTz1sHPZ;
	Sat,  4 Jul 2026 17:49:51 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gsw6k4wvjz1qqlR;
	Sat,  4 Jul 2026 17:49:50 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id R_Y3_Cc9lJ6V; Sat,  4 Jul 2026 17:49:46 +0200 (CEST)
X-Auth-Info: EFE9sk6gDFi3vH8HvqVovsJ6+NrN+qdzuX7oMCAWSGfdOJ88elpkdhPRZAIht4ol
Received: from igel.home (aftr-62-216-202-137.dynamic.mnet-online.de [62.216.202.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat,  4 Jul 2026 17:49:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id D83472C0AF4; Sat, 04 Jul 2026 17:49:45 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com,  mpe@ellerman.id.au,  npiggin@gmail.com,
  chleroy@kernel.org,  ryabinin.a.a@gmail.com,  glider@google.com,
  andreyknvl@gmail.com,  dvyukov@google.com,  vincenzo.frascino@arm.com,
  oleg@redhat.com,  kees@kernel.org,  luto@amacapital.net,
  wad@chromium.org,  mchauras@linux.ibm.com,  sshegde@linux.ibm.com,
  thuth@redhat.com,  ruanjinjie@huawei.com,  akpm@linux-foundation.org,
  macro@orcam.me.uk,  ldv@strace.io,  charlie@rivosinc.com,  deller@gmx.de,
  kevin.brodsky@arm.com,  ritesh.list@gmail.com,  yeoreum.yun@arm.com,
  agordeev@linux.ibm.com,  segher@kernel.crashing.org,
  mark.rutland@arm.com,  ryan.roberts@arm.com,  pmladek@suse.com,
  feng.tang@linux.alibaba.com,  peterz@infradead.org,
  kan.liang@linux.intel.com,  linuxppc-dev@lists.ozlabs.org,
  linux-kernel@vger.kernel.org,  kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
Date: Sat, 04 Jul 2026 17:49:45 +0200
Message-ID: <87wlvazrdy.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

This breaks booting on the PowerMac G5 (PowerMac7,3), there is a panic
somwhere in an irq.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

