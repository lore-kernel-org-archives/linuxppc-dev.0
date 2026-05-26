Return-Path: <linuxppc-dev+bounces-21518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1CCD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 13:03:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPtHF6TXGz2y8t;
	Tue, 26 May 2026 23:03:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779800633;
	cv=none; b=Wc+67cZXSNhY9vyVmOdHSNH957ZQwAFrWiZP/pcDkLX67MF+QHNCVR+0zf4UXppWHC7zZ2SlYCIT3az0kJ4EjdNCJzb8rYMy7NMbzhStswI6oAdIbIHy5SLCnB3qifM6ZbUJY7cXjWW8o3hqi1s2PCdAks/6FprMJS3Anq/VjYnQDV3KF+Kh4S7dztCWccQLjA9Qb7DRA3Sicevab87q+Xpa64V6zLbY+Bx+UNgFw679mj6FkON64yA2tQF6sOAr6h4EOBTLs7v7Tu3foSeZpi+rcOifYihL9oheF1MPtPg2/SAUIWYj8fclxDde9+kjsZe3rSiI8B5sOo1BY6K4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779800633; c=relaxed/relaxed;
	bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uud83PTY42LmUjqjzpN097nZMeNHYMhYtUbxpiDK993br2E6NuKlnqtTuL+ABo9AKHAutWG3Zz53vlaHwt9l0BFe1PfrnQqGxrIsBBaU1HiT8P1oQCDfc+sw4GneJuxRprcjFm9+dFh/F/LXJmvRXcooYVCw1jMjC//aBo9sG7xfc9ycx7DlAOrFm9PL9Zypg2xSRBKl+vwX0bUKAJLbbiy5T+cyynmSwdBrb4KqxOL+Bjvgr/NnCK8Rw60cA7No45tOg/nwglvV0X0O25f4hvn3dToPHa1Zn1w1aLuNa95rrTMhqsJwYC6IwoEUK7/3i8vcINwhEE5a6ArpDRQfYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=XYVXpHDy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=XYVXpHDy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPtHD3GxGz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 23:03:51 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so50130845e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779800623; x=1780405423; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=XYVXpHDyUOm8aBJdHoxV/KOG9KK0bbRru1vgywIAMl1vdR76COwXE6UvYSvl+Uss5R
         SwmiNSdChhjsuHi+cTsOem7JXDSKPWvDeoVf5zCwCnlTLgoK5QJCgsirba2Ksg5DpUlq
         Ot9ielZdds6wQyScy/Bz8kBx2vCFQVumAYA2j/ILGE4Chhy0jWpYKefMZ4/WW93NTL5B
         drpivnJO+iPGTu/qFLznROnlKHUAWjrU6rlV6bByviqYl6MC9kMn8k7SXFGTAVqRYww8
         ZBw/45ZTvd7n/LxXWase1I4APCkBZyhy/EYCYMlOxsdec6XiLXCCBqC6YLIP1z+Hoc3n
         I0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800623; x=1780405423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=CuUckktug33w2P9IwPw12+LT8P+6hToWlzSSR7hiyo06uYOir4i546s1cBI7ciK1pi
         UQ7WMV4BZe6ZWluP7aeDYvVWOhjQeqwZ5pd844pHXqjKNylXZMou/AtZFin31kcKTPwT
         JKYqQQsAbbXNBZI69AgN1zMOYh17xv6mUqbhPGZOlN9SEBVmISrKXyBwqR4o+/4WWMUk
         xq13Tnkq3u3xW5WeQhpPZ9JV2iXYCRlA5DOZyWmbBm9D2y1IesKxNAc3ohfWYVsCDf+X
         8UjFkWODiOypnucLAZ/ZZxFUdtLY8UREyk4mox/2Aks5y9DL9F5PjaZ32dzlTr+U9jV8
         ARMg==
X-Forwarded-Encrypted: i=1; AFNElJ+gtTQGZoBJwwpxO+5An5JRj/zQrxQ17G+TYsKBO2eHsrBHpHIK1axFb0LFpPaG79tW89+AFVSLRoUGaec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIvi5b1U1hDUoSl/D2BTv4H5rLbkpjZogguxGHOkwoM6r86GTI
	L/U+9FwcLZ7Xx9VkJBM/Z69/YF87F4sBRqg+939w4lK1QNBHMQW8iJU+bbkuaSKYIWg=
X-Gm-Gg: Acq92OHWDJujrByZLoHiLxpgi+0vRKBO/QWpB8Bv8A8qbddXsGFYIzyYQ6TQmG+LC/t
	F8Ut64Jept3bgl0bM75JQ79rCn2X7NlOixRAWboHSuWTzPv460E9hBE9PBST6jiUKtucIqkhbAi
	HbQUjVP/F27PaFr7rJIkIfEQLGPJMTr3Yd9Lz0S54mDnzolGOOiuj7nlPclI1dZiXgkvycK/12W
	xSc1sO/V8OckkyYtm1nnjQiozC7qDjwbMa1qOXGxzzWhZQR3MTCEb2iIbxlBA/a5GolyzeaIoS3
	sxHh6hPiVGDuDuw2gXe7A3tFtBftVHleDTyk0gJcMeZtxLQ6+BfggtSCjfJR4XkoDeMZsFwjR4u
	r4T+cKz5hO+gK17tTYa5jzdYayO6TUkUdeYsLX9QzS8YrklG/72LhzqUcvKzjlLEw7GmY5BgJ0L
	aAszuR8tQtaLjVIgZ3cHggSOKLuvAFw/J00KDoYuFLfFmc
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr223327865e9.9.1779800622880;
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm318501285e9.10.2026.05.26.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Message-ID: <635fed3c-4e39-4357-acd1-13f1653f9e3d@suse.com>
Date: Tue, 26 May 2026 15:03:39 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Additional signature types are about to be added.
> As each caller of mod_check_sig() can have different support for these,
> move the type validation into the callers.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

