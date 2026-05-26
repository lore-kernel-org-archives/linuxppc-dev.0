Return-Path: <linuxppc-dev+bounces-21519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E2CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 13:14:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPtWz3z6tz2y8t;
	Tue, 26 May 2026 23:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779801295;
	cv=none; b=b7enXr0AS+N7G9OxI3Ce/tNlQ6B2rcwmZHD7n6AcvlyglU+dtB3xVigtMLz97pWAnzTtLkTrQiAEQEmCGEyKep0y/5QU6Wo39uTT0oz6qhWaVwYGlk+MdlpBT2rb8L33ux8d4s6r0QaLxXz/EfLrjWuSGzhs8okn0QMMoMJq2Yz5AG7ySgWWvQoj/23sqCeM/X/ihU5EFNOvV5DhE2diqrT4Vudo1YmS8l+XpMFghiG06kFY+eyLOa2LXJuFMfiD4g+EdHBpwxRs55sN984eSiuJyfameUb99vDoGDGTlfJnFQJ4aavJITHn1/6gtLc5jPJzp1aOfwVO+CqshxjQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779801295; c=relaxed/relaxed;
	bh=P15uXtg9HdllBQIu/ZsCrfbcDnCOaC1HB3obrbgjmNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0GOM+T+6yD+q8DxDI0SRrDGa9aS+FYEX5ps8Mi4tRGS8va9mBdB5eaOlOm3WTni2M5xzuZde6AnnxisHf66fVdZTFFU52sGyAY7dHmFl5owy37wAcVo9sJO2C/fAwD7A5f/tdpqxKJVl3dbcT7KGs3LPA+PHqJOWKBu8IdPkax3Vk5ShZTfPn7mw42UkKAqF3Jj30hmYtJ+OiJYSj9xcxDQgQ/2EA9Ka6WoHyp7t8az1tSBLUZI2Q76+VNeneQxa6qgJIQ74yTmuFB+fDqQo+k1TDnxJxRunIV+uBVWgEkXP5eqj3H2XlOhEMkifloxPkbkPcWBp971Zf3M8SsmnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JOffIFtw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JOffIFtw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPtWx4QdNz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 23:14:53 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so111324395e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779801290; x=1780406090; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P15uXtg9HdllBQIu/ZsCrfbcDnCOaC1HB3obrbgjmNc=;
        b=JOffIFtwZtQyb55n1HpAxxWnSjGrJu7/auH4qh6joGpa56RYYKHHGAirYkWYEiy5Km
         h/HtRbY1CqW5Z2OVUzYg5QQmpP7X9I7vWqXyz1twBZsEVCo0VOZzQDqIlN3uZ1pXg5+m
         sFnWlBNT8czPFYDPAxIgXq1LWJcjvJyZUeg5kUyoqlvVN0jYH/J8PvPpnnoS7/6IB7T1
         g0Lj1ts2qdFXg7DHo6epgm6KNKg9PutQGnCQTVjF3TMfJr8Yhe9AH59GLnjTUPiAwpF0
         ebiajObnU/BPtKClb14xcW5DLlAQrJBiANZ6xnjCVA383x/gXboeGP+D6Ux9UUSt/EAP
         BBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801290; x=1780406090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P15uXtg9HdllBQIu/ZsCrfbcDnCOaC1HB3obrbgjmNc=;
        b=aefwRPN5iOnQgDdxngMT7M2lVgyjJcrlUPOiaiu+/XX1bW76Y2vtqTqx6fBXZx4OGq
         RDaEYTUPFGS6TvVr5lZOi895rSOO/x6/A+h6Lzcwu2Zw8dTSQFEd2I7QqvCPAD04Qg/u
         7mvlo0Mwd2FW3PA4J3vI+S5Kwap/oYq44oKHSmPyivRYmGq+JNaEO3RtFTL4ncq6/RGR
         Fel0tifkD4psGiQlMKDhYhV8QarT1v12+i4x+EKJ+2B5VpGZOpe01wX7/aIozWBL/u/I
         Cmw2OMPjrqP2ldEgKVbOlVUl/PdxckIgVnnQsXOoBhlAvftEdse8eHYtw3spWs89Inbc
         AJxg==
X-Forwarded-Encrypted: i=1; AFNElJ+sSehN3ZYlThGCMAD5vS3RvttKEI67ZhgIyLA/LNHmOrUxyGWpkzwllJNfb20Fr3MEH9EhDv35TNojaXQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJAZyLLvwgTNDRbe90LzpxIzdS0BAxpQdVYsy8AoZ+A1K1pnbK
	Ff0Z9SlJXHhUhulweMvsDkMrvaKBmoBgiYZ6YetM8vSwI1w7gxgjiriMWuC2u/sTNLs=
X-Gm-Gg: Acq92OEqgVM2Qw2Wig8mIoj3LOOvrq6rxlBo5xBAm6TIzRYyz+j2VXAsocoLkEg09oM
	VXENRp8yUYZ9LutwP7MEhTyP/DzypHCdVV7o0WzXkSVZdE1SdiWjn96rLIhau3nedhO11/M8UZ/
	b/eiq1xeFv8yANHgpH2CKih4uxGNxuyLItneEtxiprsLsmtQQ5w37ZDAe/x8mgfvApP6DNi8Ra8
	2Vi8J3iUzGyj87HNuMu/5JNbdmpuAGSuwncnbhCe2QVfpshIW3gEY/4rwGzeSFRSZRSNrii8R8K
	Apeu+vkLVDx4e9vozTeWiXy0Jm3a7DVh8AyfptfIqdQJNYM9/YOYuwkB5mxvBGUvqsb59NNgzih
	qq/DjjfPc11d4yeV2nbETM8uM2czQ4UJA7tZ0l7g9AGMYvmirwdCPbH3M6xsg3TfB72dIDUv9l5
	/NDCVRyXTd9hpPHslMYTbenqnBzkOzRx11uIizl9/7ZUz7
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr91630705e9.23.1779801289895;
        Tue, 26 May 2026 06:14:49 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm34868452f8f.5.2026.05.26.06.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:14:49 -0700 (PDT)
Message-ID: <a050130e-d354-411a-bfcd-afcfde4cafdc@suse.com>
Date: Tue, 26 May 2026 15:14:47 +0200
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
Subject: Re: [PATCH v5 10/14] module: Prepare for additional module
 authentication mechanisms
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
 <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Reorganize the code to make it easier to add the new hash-based module
> authentication.
> 
> Also drop the now unnecessary stub for module_sig_check().
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

