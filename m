Return-Path: <linuxppc-dev+bounces-23907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52757C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:23:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmdq5xtMz3c9w;
	Thu, 09 Jul 2026 17:23:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783581791;
	cv=none; b=QDhSZvXbseEwZGTnTY3xNz7KJRYADJd227Pq7TlTE5TPWLl8KrUX3Tl6WvpMa0LFWXFW5vOfA48u0DF3OpQIl9NjTRqI0bmlf5k+CDXy1wqqUrXiRmL3VJGKlFnzmORnu2nxlKMRY+tA5AKQCkare5/1HkCsSF7tJx5B0DFphT5n+puHpkaHrhhADXb3a5so0E22+C1r8hUPgL3qgvIaRUzWrBEyy3ekrciFB5E3qhtVWpY1osBCRXn9JawWDZptdeIDKJbfZyvHTiibwKVNXDL4bexU80BNyS/PAi23p/r2UDmlYknpnUDH6lfJXAk+TDtyHPGJdQfIPfrdINSe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783581791; c=relaxed/relaxed;
	bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw7ALZDuYJjsuYTetayzyHQRP9DaPoHIx4gpeFv7rveSB4oem2T4bb1gldrZVnFeHSHsYGSI/uHW024ZZotBcbFnwjFxLdlM0JgkjNFKtWqkaaHuNVkAY4RmGC2UVFHsAXUlDR23rmoD5mRXAsIPKXuJARkdobv8qgySXwNvVTCWl/uH9d+nt48UsJU8EThKo2VWzzUM5mLzrMqlcyAqqewfOlaDXHHKlquuoGWEQrnVFB/p4I4bFk3dNfISYcem0iycsWAISCXRuO+H6R1bLUWkAnT8ridjqsjuh7DMxdb8Um/WSRROYF2weA1z7hxeGnExuFgpIVcXmG7wks2Olw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Of90BqH8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Of90BqH8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmdp372hz3c2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:23:09 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-47df6a5202bso216461f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783581787; x=1784186587; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
        b=Of90BqH8yrIwBNSIO5zIA3N6U1AlbCI9vayYsipKf7t1hlcq0C/+fowbDzW27rjWej
         afH59/FO1qHUAogmX6MDUhYhRCKsIXL6FGeKcw7aPglL36AkzadSHHg2IooJ2ksqE8t3
         vCAoyc4DrYFbVMtOl6DVTovQtmefEtnIRGYwYLz258QmTvXykb/qisYdO5S/BXAf3593
         iMj7enovZ93sBpbzpH0axDhVq3Lo1pfqS+6Lmaoy8CtiYpua39kfnpzKuWOpAu9aVQ8e
         yfE+XsMV1Ln/Wvuld49B4uZvTYKz+iyOkYITNr+9DuIT6zJtfvTbIPpEYvQ5rxKySacy
         UDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581787; x=1784186587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
        b=OQYsxhMAlfVG2EDTbP5y0AKA+WIiMu/jpxKyfFLVQSUq5I8LePiGIs1Ob9xoHLWQYP
         +vOmbMu23YsKOB+zwuSDHHdB67wezSVscXGJ0aUsxW/qIP7kD2HdgBG63j71h/NKrMD7
         RRXDUkCBs/864FtqxNKx9E9+2bpWvnzM7IHtztYlnYEkIqhrkn6P6NcIiPAzmb+AjflZ
         2otjUPbUHtJXWKRmdYg0aVpUztWgdGlLbgvwk4YM8Z9ddpfhitg+LtgZtZcLCdp0vdAl
         cTcSsLJ+KET2xnMwTmHo7HTdKSI9SsCYwVwNfRIaxyBx8XazX1AWqE86z4DRtjGuvSkv
         SCSA==
X-Forwarded-Encrypted: i=1; AHgh+RpYVvTY0KDpyvltUnMIJPsJSTskADUX7iiIO1F6xRz4daUlAQpavjNcrzNP5rZ9C9nRnzRbZXBmlPbrTbU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWKDU92r7LklH5yHl8OaLPhqAoRXYM91wujhx9PI+Ic1BSMQsT
	u3h1z4So6WTFfpqxGNpclN1J3AYQfJcJXbWWK2AC+sKwlk14tzXCBvbB
X-Gm-Gg: AfdE7cnF+Ho28U8HLCOjjQ9zToYY45/zss7IvUgqXUAUxPE+7DlVxmbJDcQKh2g9iGj
	Jo8p0rL7SfSho13zFWqLo/MYrautHUn4Q93GM/bEYiJ5ZEcmRZxnoFWUDhj34RiRz+h2Yuy/IGh
	/PzUEpz2DtxZAMFzR+7XPIOK9veG29x3w8Aa5mrc60+heEC1kdAgg140Prtkmn7P04ErlFPQ1PY
	6NiHvd1Ugo1Il5QclBW8Lkpk6baMzYrxM9Kb++8N18r/3DNQDNKZNZWCw721C06t/8PW79xLnLw
	n7VT8CcXus6eS+alfpKEdYBHtPhVHpEsnnvvR+iLgwaPeFSSK9+atAIdllth4OZ8y02WpSRV7TS
	E4OIwdoANyOWzPxvTgP+CLlww3QC+mKBwgz9jR/ILadBFZWPBJQ4xJ88EG9hrWhFdNbVDbRziIf
	DeaXvtihtaBjD+WybEDUgmU7djh9FYOENcX6rnqwHHtuH7IEBW/mqQdkp+wWJ7Ll2xwpThomyZb
	2CLG9WnbENqLUTVafBD9bqT6G2GUopWwcntRN8NDKkRLM/+ljTw/JWQb+p3FGfSs3O0KN84ALWZ
	4Uh04bVfFJmT3aWUcg==
X-Received: by 2002:a5d:5f89:0:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47df07a952cmr6389085f8f.2.1783581786635;
        Thu, 09 Jul 2026 00:23:06 -0700 (PDT)
Received: from z16 ([2400:adc5:134:ba00:f774:65ea:79e2:617b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm48213151f8f.28.2026.07.09.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:23:06 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: ritesh.list@gmail.com
Cc: chleroy@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	salman.farooq3310@gmail.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  9 Jul 2026 12:23:00 +0500
Message-ID: <20260709072300.46466-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8q7kwssv.ritesh.list@gmail.com>
References: <8q7kwssv.ritesh.list@gmail.com>
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

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Not sure what this will really get us and what is our maintainer take on
> such spelling mistake fixes. I definitely hope we won't churn out a lot
> of patches just to fix simple spell mistakes.
> But FWIW, the change looks good to me, so:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thank you for the review and for taking the time to look at it despite
the reservations, I really appreciate it as a first-time kernel contributor.

Salman

