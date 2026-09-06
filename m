Return-Path: <linuxppc-dev+bounces-26613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB12C79F8B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 03:26:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcwbn1Rxzz2y2S;
	Sun, 06 Sep 2026 13:26:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788665205;
	cv=none; b=hvjZg1VjSAI1s8Q+F8iNg8HAhUbVK30WARSUu7gcSTCRI/zFSvJ1rZpkwGkNtbB3jXf64VUkBe2JGWvJAIQ4vn9Wcd/9PAUnzzp0pVmi6tZjI9kX1NHbYhXhk6HgXLbXd0D1LyYnoqtLgLLH89AZgK/E5Nq5PXnP+dHUyrUDqR+AhHMeD/mP/VwH+jUVKEIVccnJ0BXnqnrY6alE/4bX+Ph11opHIE4RDSiAotZ+ZRGk5PIeGC/yhcxRsmTclAHt/LL19/MVgbd6I4fUeZw1DC59BAC03mO+tqObZNxbmFVPOoenujsJdxe5Gv4SGsfiz71lurae+VSlvNlRBCVsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788665205; c=relaxed/relaxed;
	bh=/astEwZjKiSMcP5MKwaCmRvqZ+Wy4x/f67q3s97iOn0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=E07UkAzDJmbdc9NMiUbdBaxQ5brwUtlAhuD7lXy+jamAG88mRMmt13/6RNZg4GFWkKCvkyR7U+cSNpQFz+63Eom+e/brObxX8e79P4dzGBGhikYRTyuDSW5/U5UpAr1bnAOOI4amsfKcYKP5S2OoZFwYKMTwBNDm6f3cSWfRsk1uiY1AEX5mvLYJ+LYDWvfU9HesH5Slx5ZiL+RTG1/KUjzvrCtXhVnZnDMZ7hJV5arx52wVRnNIvUk6YPHeuhssOg4RsSL2eNPUrDhQ283SAh0o4haSIaDxkIOX2HHssXilhwY43CIWh+xGR1sB6BtMtFH9xVmUFvoPZS7dQLDyZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g8IQx1oA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g8IQx1oA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcwbm11qWz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 13:26:43 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso2830278a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788665201; x=1789270001; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/astEwZjKiSMcP5MKwaCmRvqZ+Wy4x/f67q3s97iOn0=;
        b=g8IQx1oA2kDmCVZGgTJOX4MpNzBuagHFEa8TwTKKWLVtVHh/8W6qGBuIA62ztGlgbx
         LM3Y23MYJsm6irGON4pCotpEQV40C/l4gjmFofFqNLtR5DjaxNwWTlmpDitb8ZL1l2Kv
         Kg+Kf0FrwrfcQIQ2VyZfkK5sjmQmhg4P0ochkKhVhgw9wK+zpsZ16ih9UbnZ90LXnlJQ
         L5ujLup+jfIhnKaUHjqqTQMENs6br11Bx9iirncRp8NcSmYKFhYfTotJObPrS/hd+JbV
         DK54pQPjhFskRUy+VvHthTXChiKJwD/y2sPAg/kWC3rq5Q5WSJCvaB8dldmMmVAdrGlr
         Q2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788665201; x=1789270001;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/astEwZjKiSMcP5MKwaCmRvqZ+Wy4x/f67q3s97iOn0=;
        b=k2NZM26AOt+v8MBCiWpNVhp7NftPHLB0HB1miUsK8p08NgRnu3OqPJCjJi01GwselE
         XiRTC8lQjgEkG012R6MpCLOi+EE8MM+ObMNLM+G6BTg7Rx7AGTjOv+ACXtMU1eybUNZE
         lrK4dkLMjuZ8cT1GtTVWs1rO4fOF8HrOJUm8djYWc4wTp1sXcIzW4WdxYb769e3RS9ng
         vkHgyoX+DbCQ4vsVUzHsfUzTIJKyJoKO0EYjse5AdfQhQpWcWRfpouwfUrM44vUQOxR6
         +2BpEExoc0IzF4HISIPTGpIGi0bAMOQ0lJmgBhg/SLywdP0YK99ZhclJvxc+Kie4YOdI
         q7VA==
X-Forwarded-Encrypted: i=1; AKwUvBy7prIH1pD+iIMej3E0S1Ks+JNoIXHYRsYDugthUVe6M+w9Fd/z0kL4bT0q16DuwE0nMLu3p350fmzXuAI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++muAqsa0GTmCtqLt4M5SUQNUMJxhqKEKtP/9ldhUrF2yfmi6dKx
	ICMYRnudgXJcy62VVioAmQli19m7/tNB6NN93cDuIaOnaTObBGGCFTt9VC2bnA==
X-Gm-Gg: AYBFou0CYfB1r7Ws2AkhuSdIT2DSd7oLzg/ptWvfhHMPblTlV3EzoVSgpwpoTUDEPp3
	8m2QHsOzk1Q3xdf1PoD+8HS2Q+j5rroh1wtdzMmmp98WEH3ycB+uAvpVQaqOIECT7cogK9RmuU/
	fxEcUUKOrRQYDMTC2M7FaOJ88oufVcwJMINJP7fFJJEOzX5haxjcDFDR+oI4FB1u3BJqBoW+zVz
	gImqJIffORz9fBBDCzFGf+Y7V1aVSM3Jx6k84evH3Yxyrjhx1NAo+dsb528nXNR7IeAIcCFCJZO
	TwCrj5rBFSBz1jiOMUjs+c97r89bfFgd3eZdERvXFIBI84YWyUkT4dJpeFRgKSoG9oldztFFjyZ
	rOh1MGbp3FbGq22vt0ItJGSwxFeD9SwuHApB6ep3vyh1jj8r2wkXTeL7U3sD4CJQw6kf9SNiTFZ
	yYNvYEZCfQyFVjLb09EltOaaiAj3iybI0B1rD1Mm5gGUdxZ/7FfoSdbo1qfoBTMvyw1RxebzooR
	lpukbw6OdVgrcYvPz7ng7fRxuWT3DlJ0nkoAWReHvS5fwT96905/DKn
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39b2629926dmr24428059a91.24.1788665201498;
        Sat, 05 Sep 2026 20:26:41 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm27645816eec.16.2026.09.05.20.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:26:40 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Pavithra <pavrampu@linux.ibm.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, pavrampu@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: add papr_pseries test suite
In-Reply-To: <20260905182656.993870-1-pavrampu@linux.ibm.com>
Date: Sun, 06 Sep 2026 08:53:17 +0530
Message-ID: <pkyrxdui.ritesh.list@gmail.com>
References: <20260905182656.993870-1-pavrampu@linux.ibm.com>
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

Pavithra <pavrampu@linux.ibm.com> writes:

>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/dtl_test.c
>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/lparcfg_test.c
>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/papr_rtas_common_test.c
>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/pseries_energy_test.c
>  create mode 100644 tools/testing/selftests/powerpc/papr_pseries/utils.h

This also needs to be cc'd to +linuxppc-dev :)

-ritesh

