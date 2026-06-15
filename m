Return-Path: <linuxppc-dev+bounces-22633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56304CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:44:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4wF0Lbvz3bsd;
	Mon, 15 Jun 2026 19:44:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516684;
	cv=none; b=TE2gJPaz7Yc8Hl1t0Nq8tPaBA05HQfmcrB5GYs8f93Efp0yVO8RWAgRYon/V06IW9LKdNG+d+rlf0AgylSiWQ4VS3EyouV4z13E55HYzYpZa2O8U63/uobIWbXVeNrLMjHdnXuNI9OwuIwTLvvudeCUA11LVcavfmMF//LjnwH786OIXISTmOUwIkrO/rXu99qjAL18ewmp/V2oJzydP/xVaTClMoAcmoVoS4Qn92gJa98NlEl3AW6VAfdY/8YWTCY/h7WRwu42GHpgCaxzG2ncRAZNT71R1M2vErSpinbfNc7yRsQ84Rcc7PLGj/GKW71U5gV0g72B/y6duOBIMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516684; c=relaxed/relaxed;
	bh=EloqPb/s3ZqQaHqbVsrN7RxmVooYUDp69yUIndFzvpE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GPzbygEi5jW4gut2014IAZNOUEmzbnX8A7APQtyCFESILh3+CV5MtlzwonUAMrmd9EJxXS/ZsY7/SwGVaWCe3HABfYUo9axrFtSBdI/md9zxjW2NNPhWiAywdSk979AJ0zXZIf5fw8t8Qm6sU1Z3twiMW1GN8MD7vFDSkI088hth8+65Slf8cvMSRhZV0gTtwaduCyCAY5bWsVGFdamm+9gDynNm/1TMBVKMhy8uTMbFKoeusZtqoA1nIUe3tSVXLlSCvfh6UAEPTQNCiHFXd1NgPIPU1lo5wl1D4GyQEABLyh87N1Q5s0j7iZVXhZtX6eHnDAoIxyXoTg9jaoLTEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAqoiCxr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAqoiCxr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4wD0bFXz3bsM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:44:43 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c2da7fa321so13152075ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516681; x=1782121481; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EloqPb/s3ZqQaHqbVsrN7RxmVooYUDp69yUIndFzvpE=;
        b=CAqoiCxriuNVjVZeNpZf34nryrsMUOMXC9RtBXzkVtrFoW4zgnl1Z9L6BRSYvg2YOa
         po1gv8vDfCCQXPE/dhYz6nytOjOZQO8nv1uBB/Qkakw8QkwgYgh5dGB8x7u/Jh8ocCMM
         fxLfrcMSrMAScoEm6p4IIpNSWq4fXt5SXWwk2kJmDfIDzcbtEYwvZ3dVW4dJGkPR1Bbv
         eYWIhLaDJDbfONevU5+XVpoG9uPais+reEvizo9jJf8ZUadcx0XttwzrB+Xc9lwASzRW
         7ocx8s1zJYFyT25I4qSz2kSalQ+8EKIe1pirECYPhBbG5fJYGbBM+k4HcX45o6TYKYsU
         V+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516681; x=1782121481;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EloqPb/s3ZqQaHqbVsrN7RxmVooYUDp69yUIndFzvpE=;
        b=e96ZyQksgdvI3kd0rzriNi/LQECHV4rCHp9nM7VANbxJo/4Vz+ki93jRpgZRAtLCzP
         C7DQsACRtmqvitsB+epegc4MxXgOw85cnZXrf4MoVqociQDG9YHlU2Q1XH/lnLZutdAW
         VasOdVxwCToRjBqHgzquu83ckast58s/KBll1NGSwHz2lKdxl4dkfLMnTLbZ6IboXg8i
         CUzH8n6z2dhFxndEZNleSsZV97SmOQdmaq/oZdh7WU3B3hSDpuPKFHZQb2/V0nLWKKG6
         70ttu9s85eePZR+8KlAodji9hHrvkgpcOzX5SfGL3swwMvN74egESnIoxsyXTGVZICyQ
         xXTg==
X-Forwarded-Encrypted: i=1; AFNElJ8D7IN0xq7bEiZUJfNUTGt0z0ZmTsuoOP8mDqIDNyS7oABXVycSp2aZQSm2GSTIM/nFE4q9l93rEt54UJs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQTl1mTT5DVqsU+RgEK15PdpzsneOUDO04bl0LRjTLDn/Ses0f
	WlSO89rrOdrTjSJsmttuUSLCzOfhPcaqeK8fAMUm/XMLH/WscZbA8Znn
X-Gm-Gg: Acq92OGiEGdja8BGCBc2lpitETAY067UTztJhm3v7Ll6BdcWLP/4CoSkHWjC5vCDHt9
	C2MYKVjQnb6maJ14/TqSAVkfXVbbDs2dr5/TTGZdGGcrST0mzmQBmWJcUKaFDVXBAZX7fx6VZGJ
	9wBTNLx3cvtNqowBgzvROv/SLwvKfOqaHjJ9zu/YFxqadDf7bv4HQbZdqfqfTPl4UDBFhxauJn6
	lNk8MSjAO9Fr7A65vYNHrSeLt2rcFnn8wJY9PHi8b6rChveGtYvB3lZ9xBt61r2KhzlmhcHTg8g
	pkA+nCY3v7QyaAivYtXeGXxtf+1+FExCkz1cRuYILrFFw1q5W+TqsmgZ6WHMe++QLeWhoj3sheo
	DOnPxqV/mwx/clfH0uXXu6ud+paLiB6ospJy6wzNszyrgiB/f8WPYlJSS/dxbzxzF11qZex3FfH
	PDYlypy16fTb7Cch778ESUGnQxkA==
X-Received: by 2002:a17:903:2984:b0:2c1:88a1:9830 with SMTP id d9443c01a7336-2c41255a929mr141771955ad.17.1781516681381;
        Mon, 15 Jun 2026 02:44:41 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm93203405ad.32.2026.06.15.02.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:44:40 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, Christophe Leroy <chleroy@kernel.org>, Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/fadump: define MIN_RMA in bytes value to fix overflow
In-Reply-To: <a9d56fe88218a7034296f1974568543a0ce2d973.1781265400.git.sayalip@linux.ibm.com>
Date: Mon, 15 Jun 2026 15:06:05 +0530
Message-ID: <eci8du2i.ritesh.list@gmail.com>
References: <a9d56fe88218a7034296f1974568543a0ce2d973.1781265400.git.sayalip@linux.ibm.com>
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

Sayali Patil <sayalip@linux.ibm.com> writes:

> The MIN_RMA size checks in fadump_setup_param_area() use
> (MIN_RMA * 1024 * 1024), which is evaluated in int and can
> overflow when MIN_RMA is increased to values such as SZ_2G.
> This triggers compiler warnings such as:
>
> warning: integer overflow in expression of type 'int'
> results in '0' [-Woverflow]
>
> Define MIN_RMA directly in bytes using SZ_1M and update the
> callers accordingly. This avoids repeated unit conversions and
> prevents integer overflow.
>
> Also convert MIN_RMA back to MB when populating the firmware
> architecture vector, since firmware expects the value in MB.
>
> Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory reservation for HASH MMU")

Since this is not a bug per-se, so we need not add a Fixes tag.
But while we are at it, we may correct the commit subject to...

    powerpc/fadump: Define MIN_RMA in bytes rather than MB

... since there is no overflow with it's current value.

With the above changes in place, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


