Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54475C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:00:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B1821473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi8fI9J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B1821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dD9X5k1FzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:00:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pi8fI9J6"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zf5ZL6zDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:20:57 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id h4so15663828wre.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8npDl5MvhSEYpzdqiC318gysEK8vGb+L6cE6OpZoflY=;
 b=Pi8fI9J6g0pFSnVrx71sHRkdab7gQzNFkKefqrBDyMUmPiOCCctSg9Tl+T84dCTWOB
 Gz7vl+W+ZJDz85KiaQHhlvJg0VnNaM+LMp7wMO5vg7t+A7bKkp2g4/vcRoyLf6QA0QqG
 yzelFr4GMfaIjTnpXOWMbje7ux3HFG+9ChYHcnIg4s1PwKsVSwvFPTdT250UfrtlMIaG
 SHfKbNWdWZgszRCYkiWRd267Dt1RPmTIMgn7i/7S+uXCdFnmDmIgixwz9UMVXcDdfM7B
 x43D2BUZRdZDb1Rl08Wx/DikRs5wt7AM0lj0Wm83Mlbf8Yxy+bnsa7vnFr+xELWULsAO
 zm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8npDl5MvhSEYpzdqiC318gysEK8vGb+L6cE6OpZoflY=;
 b=pZvwQmXnpNtdEdAb8AytEjrPwtaPoRUc1lMpXUscqtGUe3SZn2Y7TwLsyPsKsM1Xei
 MIwDNSFD1BTq4Z7+NkvE6HbLKBVsxJ10QnLwlSGTMU2pjHhydV65a0pg+DHwFdWzeO+2
 jpWHFQ06AAAHxp0jOsc/QxqLVNfPO/76kRAj7d0fyr310oj//XXjHC3VQFb1v7f8ZTxN
 ZdFyKJ0yE+x+y0RSMAS2ouzQIMJXAWKjHXKYXMw6QApY9jbmsDLHRr/sCczsKX2KCbbB
 fBxAePldufpmrZTAOuMad59yibNa4tb+WdY3v5CbevPUkQUBnQ2OSf1vmETxpcqjT28D
 GPsA==
X-Gm-Message-State: APjAAAWmoJV0QP7d6Y9NdXgWG8Bj2rcU3Fm3HORWMtAkM+DqR2P4BxKC
 DgwQRUOHOwTpBh72vs+P8ho=
X-Google-Smtp-Source: APXvYqww/YqNEe8rj1tnvEFSr1ILh0E0vC1BEzR5JE3FBXVLjZpCPJ3GvCL/cU7ZIuj2/k+37547MQ==
X-Received: by 2002:adf:f110:: with SMTP id r16mr17330400wro.153.1554718852182; 
 Mon, 08 Apr 2019 03:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:51 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 0/6] clk: make register endianness a run-time property
Date: Mon,  8 Apr 2019 12:20:33 +0200
Message-Id: <20190408102039.6366-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
X-Mailman-Approved-At: Tue, 09 Apr 2019 00:55:08 +1000
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Paul Mackerras <paulus@samba.org>,
 Anatolij Gustschin <agust@denx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the endianness for register accesses of basic clocks if fixed
based on the architecture (BE for PowerPC, LE for everyone else). This
is inconvenient for architectures that support both.

To avoid adding more rules to the #ifdef, this patchset adds a new
generic flag to tag the registers as BE and makes the basic clocks
follow it, then converts the only PowerPC user to use it.

That way we can drop the special casing for PowerPC, and allow other BE
platforms/drivers to make use of the basic clocks.

RFC because I am unsure if this should be common flag or a per-clock
flag.

Technically it's the wrong place for the former, but having a different
flag for each basic clock looks a bit messy IMHO. This could also lead
to easy mistakes by using the "wrong" basic clock's flag, then having no
or unexpected effects due to the next free flag bit different for each
basic clock. This might be avoidable by using a free bit common to all,
e.g. the highest bit of the flag fields.

I don't have any strong feelings one way or the other. I just used this
way because I needed to start somewhere ;-).

RFT because I don't have a PowerPC device to test, and especially not a
512x one. I did compile test it though!

I looked really hard, and this is the only place I could find where a 
PowerPC platform (indirectly) used the clk accessors.

None of the regular drivers in clk/ were selected in any of the powerpc
defconfigs, and this was the only platform code that registered basic
clocks.

Jonas Gorski (6):
  clk: core: add support for generic big endian accesses
  clk: gate: make endian-aware
  clk: divider: make endian aware
  clk: mux: make endian aware
  powerpc/512x: mark clocks as big endian
  clk: core: remove powerpc special handling

 arch/powerpc/platforms/512x/clock-commonclk.c | 13 ++++++-----
 drivers/clk/clk-divider.c                     |  8 +++----
 drivers/clk/clk-gate.c                        |  6 +++---
 drivers/clk/clk-mux.c                         |  6 +++---
 drivers/clk/clk.c                             |  1 +
 include/linux/clk-provider.h                  | 31 ++++++++++++++++++---------
 6 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.13.2

