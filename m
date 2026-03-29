Return-Path: <linuxppc-dev+bounces-18967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D7A10D1491
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 02:01:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjyKy3vJJz2ygd;
	Sun, 29 Mar 2026 13:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774749702;
	cv=none; b=hwwGM0zLvz6TW+AAse6jCNVznvKFzn2axXVh4kDmTXruEM+LNyT+jmJLfIAkrknQw7xrI9QWJLrh2B+1lVzSNBixQIMOWsnOMBrPIV7RRTDfu86c0ZKn9eco+Ciiu83rydj7DQJI0eRnzonGlW6iQv6uP5/f1fVT9+Nt6MzaqkdFxtNdOvswBkCS7c5HBTn14RD2m5kq+yleZHuCYayTwIb1v3PDb90UI2gIMpa9fjAV14xIHiKofh4Vl8u/ohwBhJS7JKBm4gHouYYvv32fQzZkFznskq6tAdoqWtC1bM2P2Ynamtru8mjgsAMI4s+WgeHcW+R0bLGDrjJQDOAAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774749702; c=relaxed/relaxed;
	bh=L3BYXhp3fJO5t5tNaVFHJqKD7jmMm6du60VZ3sORTCo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=ImyfIthwRCQGvpAYzmbYipX/A/DbiSxMh5OP2yDIkEgFHdD8PQJIUhtxBm5vmmnfka+wawhh+7mfRIba0WajwzLs1hCY8ezm6R2RIPTfhh5y3h83FA0szl+lYJd6zUHZff2UGUmxLJS2YgnolnYlhHoIaljoEhC+brffYAzhVj2+yGOyIRLd+ltGAJ2tCOqc3ha2XZdNBk/4h8QJazZP5wOJPLZgsJBh1hvOR8KiQn3M6a9kbDBug/WYyqiweQoSaLRvU5xnTUqkoAw0XuFgZ4hZTFOlJWbm/q7rKQoCifHQIpbjM9u1/mcyiypGmZcaJRP3tRyf3b+2Z/2NULxptg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IlYcOoCh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IlYcOoCh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjyKx34lzz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 13:01:40 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2014681a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 19:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774749698; x=1775354498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3BYXhp3fJO5t5tNaVFHJqKD7jmMm6du60VZ3sORTCo=;
        b=IlYcOoCh+Ftrctu8gdWKke0yx8LV4sxz3CYItIcmBzK20aiPCnTIL2REhOp+nruKXO
         UH2gKGCM8Nyw3VJG0SoZyI1cZOMocuXja7R//Un7NW4naYTkjfzv1i2QP3gGYgjBGITc
         IwwFzA2cF2UgPeiWzNDguNEQapv9/7xsWbqFpMgfb5k24HoWTpmGrjhn/ASKjyNahjhH
         yDBm7EpR8lHV+l+39sa1Eck36PCbSHHZIFgrqhtnt9R36hwgkY6vpxRsWCIKO8jv7skK
         wXzRK6q9fptqzhn9/vWyHj7bpGFbS83IQrgbZhZv0nH0b1ioPVXfC6BI0ol/QxvpEw59
         7Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774749698; x=1775354498;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3BYXhp3fJO5t5tNaVFHJqKD7jmMm6du60VZ3sORTCo=;
        b=FhNWsC6dz6VXBfSrAyha9iO6pPOXhh0R5vQiGuiBp10zd45DBvWIOhV94FYcnsTVGR
         WwX0peLI/bmtf7GlbqOLOvecqqzt5gy9ZCE3YYeIClHOO9nyMR8lJIRSBmCEEaBlVnxX
         0fk4pdO1RM4+01wr+GHApMM0UCXvpWV0Tew5lKXgH3mQFfKuD0nEwN8BMHT1wJcprCj4
         pf3eVaJLfXTZTvciOiXXcMCakoy8E3z6bzTcCMbYf95rPsyKkEkKPcL696YTGdDVkWtG
         Di0ZsDjoDsrxeppI/s87uZLSrCIAFQiw3EuO8YZGLfHPlH/pCHDkpI7EDz3wUg4jaQ6O
         B5gg==
X-Forwarded-Encrypted: i=1; AJvYcCU63EEDzMwyMqFJfruKrdn/y4ob5eyE0eF37OOkNykumWtOiqUmJraRQzxQZOuzI7r4o6hStWfRJ7reUDY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1Wf6ElAlw6Igu0csdkk7TmJFnSxYaxOqNFRqx0fKAheIiDpAV
	Itb+WVDmwCks7XffMRZhGtrJkyQn2Q2EirlsPatsA7GyLEx33yjCDBzy
X-Gm-Gg: ATEYQzwkRkyoWfm9Pf2hoHz2dHpOABiyVekxcPaHu/DR3BzV5xy3dZKSz9a7VArmgmU
	dsjQqrr3B+Kc2m4xgwJfeiFH6Rt/ylIu16eIac8aStL8dTC/QnZN/XOZcyRXN2UlD0yV/pmsy0K
	7xnUKoEN4XdkUN2OyXb2LNKD6QfPeYXM2Jc5qLl0hletUhrFm0pcC6tS1ThT2Al4K7boVX1Yh8A
	AVYxzJW2Bc+btchGpwq1baUex7a/jnMqB1pvX83+97127/YmmnB0RHCCmBv9GQcMlITrxPWkzhY
	ABWmtnR9ygdY0rwgm2hgIDic2W0u+350b6KUxVgKWFZgtYz8piY0e6n/Z/FX0ux++BOYf1ngBkH
	TyWNTIQGKHJNesjQDzBPh4nOQUVjf5Z3uqVWmwIEEDAVP9ook2+lOqpPKYhxvRwLu9MV1LYUBJU
	Z4XuTN1rQG9dtBPKh7HZp3hY0s4CtLoKhG
X-Received: by 2002:a17:90b:46:b0:35d:9c43:57fe with SMTP id 98e67ed59e1d1-35d9c435b02mr1931772a91.13.1774749698386;
        Sat, 28 Mar 2026 19:01:38 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35da312de9bsm168185a91.14.2026.03.28.19.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 19:01:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
In-Reply-To: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
Date: Sun, 29 Mar 2026 07:26:55 +0530
Message-ID: <tstzmm8o.ritesh.list@gmail.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
>
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
>
> Update the entry to include the “.o” suffix so that KASAN
> instrumentation is properly disabled for this object file.
>
> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/

Nice catch. Indeed seems to be missed in the Fixes patch.

I think you might want to Cc: stable too, so that it is auto backported
to previous stable kernel releases too. The Fixes patch was added in
v5.19 kernel, maybe we weren't testing KASAN + Kdump, but it's worth
backporting to all stable kernel releases, IMO.

LGTM, please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


