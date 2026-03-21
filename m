Return-Path: <linuxppc-dev+bounces-18545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3499109446B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 11:31:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdHMZ0JyNz2yYq;
	Sat, 21 Mar 2026 22:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774092713;
	cv=none; b=CAryxfBTSpnyV6PwJA+p1gZFm5YQvWfH+1Wq3V//2KLjWTJkJf2RgsswsVISc/VoX1yr6vY5l9Uvk+kbQD/biXXAhf7dhBYEKF3DklHPgGE5f1JjLoBt7ohKqy6pUPqIzXCmpZhgx30qY2M/SXo3CULmYtVUcNzzcBabNXeFdj9rVt4s45/4QwPMQdtuNtkB/J+Hk8JMgB/dORxjLIMTGFcuvtHptDzpmOhUG8y0sORH+UM6ohM2TN372414Y7cp4L7s0NFz8iwyrURaw1PzaduedgET0f8wzs/VamfkjE3/pd6a7RJnvFa391oFd8ahLn9Po53eKSCDSA7GBbXqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774092713; c=relaxed/relaxed;
	bh=YYdBjs3g/NRwIzC77+RdwYjMCfy82DXerPQVEC+RqG4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OMX05q9rIrFiMDkPRfkfxkfHTkHPzV2/ugB53dAKPaY2kVZYuWYOEmP1IiO5QcUYo1uSy55p1ax5c4jHvQOnbQWmZMaGgzGG1wJmeB/s6uGSGdinFPFJEO0XXrR6S1pp5q6ov/xzofF6f6LU7/8CRj+La3PUk59/jSyRzGskLm/9/91kdKJ59bCadGLz+yV94Yzbet1c/EnU/nY2S1SUYJUqEiJ15p5Htrg7v1syr8FXDDbLxwhfWUeVBZFEcjI1edLBv4vP641ctlpLUpTLJkJLAnuBRIu42wzHUHahDJY1rtyQdGw6t0IK0guPdFpAA63yeroxDp6mKcAbZvwbmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JpilWE/D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JpilWE/D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdHMX3ycCz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:31:51 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-824c9da9928so2841391b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774092709; x=1774697509; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYdBjs3g/NRwIzC77+RdwYjMCfy82DXerPQVEC+RqG4=;
        b=JpilWE/DzcmC4n71zc81A8Wb7inSgrlfZBoSb1vkxk+NwICh9IzcTl8XDo5QjmgDf1
         92qh/ubdfZhC9pd41nlM03aZWOkquIPbFFiqQKllX8PbwqvnTfbFPOxjJ3rgxd7nPRw6
         E7r+ETcQwBHn3GrnPnkYik469UXzeRSkzwEV024mCoaDxB4qJ2ydEEPhRwQyWDRJSvf8
         83sgrGYTABV2nAYPT8zrs+4z09i/pHsHbw3ueOvdzvTzNxga9zgteMf+zsVxf4X8JLAa
         IHRj19YjOsjDWq+DD51VHSZhUBgugMFdBrcLk83Lc7w/aMRAOK6Mu3sUbuEblZINr5Qm
         wP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774092709; x=1774697509;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYdBjs3g/NRwIzC77+RdwYjMCfy82DXerPQVEC+RqG4=;
        b=MJ2vkVNIEW/6BnYbxRoOgxAtxhXNh4OTOHCmUTVr0MNRXeYlLShaUEHU/J1x8UrL8W
         6VDvH2/xZD5QRwa/rTU/CmhyBADSH3e+itGQ46kVG+SmjMjElQJPBF+n2EygxWX+FFJr
         nSXU8BSDIqKa0ApPC0cup0zPhU+w7x+KxmRO4MENkoXpKnq0E56bHBYcTQKBkPcGZ3BW
         qakU9oYafg2AdBOlHY9qkYl5CVrdKv4xYQQ6eQ/3d6xA6aSRYffZLLPJDl+NhMvrTllZ
         6w/bNJgu3r94wAnwwg746+yBy0SJVsj+q2XpSj3U988cqJSC6/7Y11HTjMFo3A340cBP
         3MAw==
X-Forwarded-Encrypted: i=1; AJvYcCXyU2t68+q/E13cKNEnA4mF9yh03x5RZxV8xgGzYMI9yzRafkRMXel6snuPKFay16E/75CvlELT43tnwog=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsfE7vLSqe8JD7MHO6Yo90zbehAyTpvHG95yVXKVnhMrpoxTpS
	RN2c6YECz1ECncHLWPnz1pc+fuG3sQSYMiYECMJDo/8fMchLQkNqilbq
X-Gm-Gg: ATEYQzyDaLkDEBlgFlG0tj1kRvlJRxP1hcGrcYMs53fGgNHVIY4ByBAbpJSomQAbCXD
	NFWNjqvup8fYBZCLdxUhle2NkHAwSFkYmxWodUiNRMzTMGBP1rAytIUVbxTZaEsp+WUXdFnrnta
	RLrQ5KkSfQUWq9vpQ6JvVqqSG/FyxE0aBm9t5FgJkUEH2c06cXHeyd6ssoe7wZPEB+IBk/fqsj6
	G/pOyK7rVBBqz0EuZ6aQCJNMV/6TY2x1FB+eBGBTGoyptE/utkfb+RTNaQVbuqEOX9ygHRvalC2
	Q2C51/qvoun3I7qxguybNKMLoz4vp+orNA3RrExCK9pZ0eH+R3uG+Htu64zZGzmWTPEf5jMPIkM
	e0/B6UV+cOg+O/iiljbLfP+lN28fbJtz+zO5pQ1zZxADi/uRgh03IixxWj5EZgniedbs8XW364b
	yGSkGmdXzUzILhujo2px27MQ==
X-Received: by 2002:aa7:9e8b:0:b0:82c:21af:a7bf with SMTP id d2e1a72fcca58-82c21afa908mr2465482b3a.13.1774092708761;
        Sat, 21 Mar 2026 04:31:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04220d9asm4159044b3a.60.2026.03.21.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 04:31:48 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 11:01:56 +0530
Message-ID: <bjghychf.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> This is a cleanup patchset to change all young flag check functions to
> return bool, as discussed with David in the previous thread[1]. Since
> callers only care about whether the young flag was set, returning bool
> makes the intention clearer. No functional changes intended.
>
> Ran mm selftests on Arm64 and x86 machines, and no issues were found.
>
> Note that I only CC'd the arch mailing lists to avoid disturbing too
> many people.
>
> [1] https://lore.kernel.org/all/d172d6bf-c60c-4cf5-9da9-f30de38cdfed@kernel.org/
>
> Baolin Wang (6):
>   mm: change to return bool for ptep_test_and_clear_young()
>   mm: change to return bool for
>     ptep_clear_flush_young()/clear_flush_young_ptes()
>   mm: change to return bool for pmdp_test_and_clear_young()
>   mm: change to return bool for pmdp_clear_flush_young()
>   mm: change to return bool for pudp_test_and_clear_young()
>   mm: change to return bool for the MMU notifier's young flag check
>
>  arch/arm64/include/asm/pgtable.h             | 29 ++++----
>  arch/arm64/mm/contpte.c                      |  8 +--
>  arch/microblaze/include/asm/pgtable.h        |  2 +-
>  arch/parisc/include/asm/pgtable.h            |  8 +--
>  arch/parisc/kernel/cache.c                   |  8 +--
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 26 +++----
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>  arch/powerpc/include/asm/nohash/pgtable.h    |  4 +-
>  arch/powerpc/mm/book3s64/pgtable.c           |  8 +--

I did compile and boot test on powerpc with various configs and overall
it looks good.

-ritesh

