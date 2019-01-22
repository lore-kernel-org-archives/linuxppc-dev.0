Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEDC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:48:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF69E20861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlwpiaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF69E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kJs55VPMzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 17:48:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIlwpiaQ"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kJqB04FCzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 17:46:29 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z11so10604373pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 22:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6Z5ywhMm9kQiGXwWZtHoMVg4XNY8zuMKP5eWkub81BM=;
 b=SIlwpiaQWl5iUtjnhS9/pdyAF3GqYQXjUX1lk9WDqjP2Kfz2onZVn1ibUZJiedilmU
 MArbEEg7j7B4HgKu4cdi8RCku1XFd6qpeJU4DkMLI935C8lRIwKl4RA2oS9ZLtFzKuXu
 ULiV8J+hSvi409ipaYIZuvMY8pjUrfVhD+cF6Deqd25F2F6Myoosjllc9gO5sG9JtO/1
 pdZWDWMO3WNZKzJsGv+iETP4ZHNAJBVVspZFEQwc/6UlkujLiUtsgLVLOqeqv0gsyLjQ
 wFIcv3ntQP5m089eTUC5mOv2wcKKQER2Rz2igXGFol6guaKgLct8ayxGL+XV2tIyeJfI
 OPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6Z5ywhMm9kQiGXwWZtHoMVg4XNY8zuMKP5eWkub81BM=;
 b=FG/7Iquj0oIVOwkVvD9/E8eW9Ups6lzM51Z/ATLLvH0FXLkmDj7zBMdUrrkcxsdadX
 QuPx/WxlPF+ycvyZ/uV3yXkfA9rQkibTRc21TeVkMRMyIxYIsFCiIllRze23CvUXx0m5
 aCZL9nfEnY9irpVpO/2vNdtO8cboDtJZZoiTKDFSoMouoFcVP1OxUzJM0Ze5mhZxfy2F
 6VJMwDDEVJGng+T7NE7EkgSho7LhcdN5F/XXotzF2htQ46hbn1iZhknxWvTYqxhxs0Vh
 t5/PD27FuXuJz9a5lngD0LPbI7cWRUTPEL2s75i9Fq63db7OQIa9p7Rhs6GXbf16bFEb
 /fIQ==
X-Gm-Message-State: AJcUukfZPTzf1ttpo6kTDTRscuBO7t+hAQl3rAapRwfMHxwswGUM8oZw
 Zt+DbyP8COCVvIOu1Y74pgdGxYdD
X-Google-Smtp-Source: ALg8bN40rHy2cH2DflfFKxw0yKWXKwfDJ15Z91v4Y9qHNKiU9/2h2GRRtaWB7+eZBxCS+7hrs0dRSg==
X-Received: by 2002:a63:d604:: with SMTP id q4mr30522443pgg.175.1548139587855; 
 Mon, 21 Jan 2019 22:46:27 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
 by smtp.gmail.com with ESMTPSA id v15sm18341830pfn.94.2019.01.21.22.46.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 22:46:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] Fixes for 3 separate NMI reentrancy bugs
Date: Tue, 22 Jan 2019 16:46:14 +1000
Message-Id: <20190122064618.1510-1-npiggin@gmail.com>
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

This series fixes several similar but unrelated bugs with NMIs
clobbering live registers and getting away with it because
MSR[RI] is set. Pretty rare bugs, but serious silent corruption
consequences.

For the most part these can be observed and tested quite easily
with the mambo simulator except that it does not seem to follow
the architecture wrt leaving MSR[RI] unchanged for HV interrupts.
Manually fixing that up in the sim environment can trigger that
case.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/64s: Fix HV NMI vs HV interrupt recoverability test
  powerpc/64s: system reset interrupt preserve HSRRs
  powerpc/64s: Prepare to handle data interrupts vs d-side MCE
    reentrancy
  powerpc/64s: Fix data interrupts vs d-side MCE reentrancy

 arch/powerpc/include/asm/nmi.h       |  2 +
 arch/powerpc/kernel/exceptions-64s.S | 76 +++++++++++++++++++-----
 arch/powerpc/kernel/mce.c            |  3 +
 arch/powerpc/kernel/traps.c          | 87 +++++++++++++++++++++++++++-
 4 files changed, 151 insertions(+), 17 deletions(-)

-- 
2.18.0

