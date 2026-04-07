Return-Path: <linuxppc-dev+bounces-19435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825AFEEF52
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYZ3jS6z2yZ3;
	Wed, 08 Apr 2026 00:32:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572322;
	cv=none; b=h+IWtuf1E5hbflw8c8Ik/bq2m2UrEbklITL0RJIpfbUvmXrQYK8tD1ogyYB/tVTtnYrOl2z7ykH2A9g26LJ4H/U2ALQqdsNb7O2QLavgE+HGh4gl2z9uPYMYH01CpMm2IoRv6Bh3T7vw0QekysV7eEsW/5pCEJpDyKf09RjleUQdSz/rLhdk/QJwlYGTa/My9N94AAIFyH0Hdyd/0Dg1HcNNKDqCx8nNQtQHK3WZdEamBizM3ooPyiBWb+7gtzvRfFJ7HvDp7R3Ib512jhHNgmUbXt+bjM39tiogZv1iwvzG6w1I6vgH+0rxcRUdFCCn2ikMwDUtRORU21oeQG53Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572322; c=relaxed/relaxed;
	bh=ABgqVLgM7qNtgzGuG2u8bFv72QSCAOPYsgYn7Ht6hJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP+MLnhM8+cM+1OmKDIcXG89u5mCgycKJJTsNC5J0G36ol9gVKyxp8DRYnMdQ0wLWAKWM/Z2Fp+d/JKmJUJUnRxpC9u33OZIO80Xp/5DtnrtZzt/8PLDhbn67X0sIPzPWelslPDOKrL8pcyH4m1Kjg8Xft0ORGVJS1QirWzZzRPmEth/asbCeGKR+zw3myU517OZsZb9SryfEg3sHpKcevHP5yBr/vziwT1UQYgM9+Vq1QqpZZDimdz/YtHNPrvPxmXTe4fcER7VHtRW7+exk2QSixBcHBK3sWy1eA+gBV9LQiRUanWYaGfLZfIA9/WUAvaRiqiV8vyFvsyovQ+bxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PomQC8e1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PomQC8e1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYY2zM3z2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:00 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35c1a131946so3428772a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572317; x=1776177117; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABgqVLgM7qNtgzGuG2u8bFv72QSCAOPYsgYn7Ht6hJs=;
        b=PomQC8e1Uuzaw7PCaTY3QHB0m67sR0CA+VbiFN8J9vbKZejoW+rCeM46sBXPgvweyz
         01ki3FeleI4Whj3/eTo9ib69pfsa8kskXlp9s4hwGN57vBxld47bNVUENLtNu8aGQ8jn
         Nimjo1RZ0ah99O+IdrzpCr/v1S1t/WKVJ4z6CDiOtDUr5KrqGKztrJs4ilcwDbu1RUMG
         97pqGuMbLKFyfROt+WY7YiDmTnq/fa0OYSC2JfJRd5A644TdxB/twlnD2jouj2zubVAf
         zOukdPttfHWtvbOSd9lBXgoWtQA6wTvYP7YNK75C8bdaIX+IiyKuJJehG9OhCuJV2uA4
         LEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572317; x=1776177117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABgqVLgM7qNtgzGuG2u8bFv72QSCAOPYsgYn7Ht6hJs=;
        b=DYDENL6y/CdU63Dj+Tozm2CMjAv1PRf1+Jhar/o7J4Km1coB119ZGaaRHs5zfLD599
         LcGSrIsI9NuXcSrQbmPPEn8EIOhwTIt9up4lt+r/JRu8cIhMDp6fNGGZYQfNCHQY2Iaw
         LeIlYfGmuMXIj+iiAWD3UKzvahG41YtTTd3xTW10SD3Ln5vwj+cjIdP8o0pIPCWc2jEo
         cIJUqxeOORPGzfi06LHTNsigUfGAYhyhxsjB9Xc9K+LIEp4xiUAL7NnO7BQtcSs5NF4+
         iD1zR6BLIESmdfJuZLMdO2601eKte8TnM8sMwt6aB68pU2Vazt8YX2hOOJ4/W3FSqd+I
         fxpQ==
X-Gm-Message-State: AOJu0Yw2EOb4e+3U1cYH1IkK9HIhcYmB7Byuqro7WLmmWkaNrQPL/ds6
	i6+2Qsv71yGfHLd83rkvKsAuXp43EXZXuBk3W0v7JcsV0lWmlYpVXo5Pqa9Mkw==
X-Gm-Gg: AeBDiev1s5eImV/FDDADt26NOYuAR2OoKLkt6j/lVWaDknT98LUPCefhQqpbY4ieTWu
	WyIj/So2MwmBksay9JE9xHEi642K6a+3Ze7ktgFmdH4US9YtxaAmjN9kc1AHsD0AR611zAtBuob
	8OWnff3Wm1kv5gvYZVZ2BVyNL2LQflQnmLOSuXILxYk5kbQ8NOFw0QMYbF9N2xod9ehHd5czf4H
	bQPok6MMWAtl5wODtN9G1+U+RCVQehKNhCdI1i+D5gpGPCL9meJ8/g5OB4yW8c/m9rP2SYvJSYj
	ZV1ViWbkz4qzd0+yaBoUvG1AwWYLgnKebXjinCs/43KcwB5PofaBSReXHHFg8QnzA+37lzKbPSQ
	wrgHCJEtdK2l8IkK1LX4+HfLqhd75vRuybekwOvYHkbJB1pnOy+S1VjlWuVFbvQhYRqBzl1o87H
	QnA33Hy3aSUraQmr4d5FI57m/r4koQk3oUPWpTdHrva/gtjEcJLw==
X-Received: by 2002:a17:903:b8e:b0:2b0:5450:a910 with SMTP id d9443c01a7336-2b28219df6emr170162585ad.17.1775572317096;
        Tue, 07 Apr 2026 07:31:57 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.31.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:31:56 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 0/6] pseries/papr-hvpipe: Fix and simplify papr-hvpipe
Date: Tue,  7 Apr 2026 20:01:34 +0530
Message-ID: <cover.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit

Haren reported a UAF / null ptr deref issue here [1]. While reviewing that and
going over papr-hvpipe code, I found couple of more issues around the usage of
copy_to_user() and few refactoring which simplifies the code.

This patch series is an attempt to that. Note that this is only compile tested
on pseries for now.

Haren, I will kindly need your help in verifying this please. Let me know if we
have a selftests or any other test framework for this, which I can utilize too.

[1]: https://lore.kernel.org/linuxppc-dev/20260317040444.2785741-1-haren@linux.ibm.com/


Ritesh Harjani (IBM) (6):
  pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle
  pseries/papr-hvpipe: Fix the usage of copy_to_user()
  pseries/papr-hvpipe: Simplify spin_unlock() usage in papr_hvpipe_handle_release
  pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
  pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
  pseries/papr-hvpipe: Simplify error handling in papr_hvpipe_init()

 arch/powerpc/platforms/pseries/papr-hvpipe.c | 135 +++++++++----------
 arch/powerpc/platforms/pseries/papr-hvpipe.h |   1 -
 2 files changed, 66 insertions(+), 70 deletions(-)

--
2.39.5


