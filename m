Return-Path: <linuxppc-dev+bounces-21505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3163CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 09:47:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPnwP6KWlz2y8t;
	Tue, 26 May 2026 19:47:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779788837;
	cv=none; b=VdYcHLlRNgj7cCytvTbmw5mT713PbOLqc+Il0uFHEWoDZKFWSch6WWTXI7nkSitQMqe5ZqOKwy6irvcVjb6GnvQKf7dE5zZ0lZBMlbwlHTiRbykyVS1ZnlPom7NA3mm4KgaKM0LeWriE54XRKywfgGva+ETnvHHl+ml5Z/krdrTBk6AwiiVLN26h2vup2ABobRqBmDq/05JTuSmcpSy5mO92gbUKgmCpPLM9B6jLiAMDfJg+kVTEPNPvkpDZ/ro6B2pVfMB+6yVIDepLpP5LnLxTQaBPkYO3S2M1I3VQbd1pD3veIhu/g27t98sfHR2GWuLTcRQqkm/RXMHKkuOYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779788837; c=relaxed/relaxed;
	bh=R17d81rZFtdCmrvPdq6FOwdkUs8CSvLL3BM8+TQqKKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt2O8Bz0jTrdJawhlCbCLlK6nLCefa77reyYW8RgzjELXbIx8CzsTpaGvDvfIiROtRMz173ij9YCm8PJLI/l1o/4OOuC67GRfPm673IA+MY2ncBgQTiVJBp6Gu0FT9CyBv+QNPqoqShhijsaBy1+Cdt+23IDlJ5NViEgk8ViEcZ6ZoFIAWCXU+q+SjUB3HXAc89L6M5icW+w4yhu8Oh/YIEEl1k6P6kJCmuDs3M5wC/dxS6iEeu/ao/KFY78CDUiAmRk+jsQisdpG8lOCsV42kqfyIm6O9K7ZwGRexnCfexMiTqQv31cnpDvSzhubyoWZlMQN6uqKHkiM1183s4sqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EvRFiuAq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EvRFiuAq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPnwN3n9xz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 19:47:15 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-490426d72f7so36691935e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779788832; x=1780393632; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R17d81rZFtdCmrvPdq6FOwdkUs8CSvLL3BM8+TQqKKA=;
        b=EvRFiuAqe7EOMGQYYhXNugkvo/iXRmrX0exTgbawmujVyH0eWJDIwIe3PGkiRA3vHb
         QAi5ljmyVOV1cV1Io5T1+Mo/3/K2qzftzcEwZ+7mKrs/urEixpkC984zTBCiBe5TFyCS
         EKHbycI7VfrQF4Gk/AKGP2HGmaD8Z1pb4eNW/PwmUm0oeidBk2mySiJMU+2OIfMP5foM
         OqaWS619FRZ2JZ++JZu0K1U5fsj6KnBunfZ+T95LV5/v7VF+3MVA7d806Q90WLulXss1
         G9ynuw+wpMaYucR6ANN9FALve6vfEZ4WQ4XC1mya1zb/lJXMrHW1kDK5jl8tAATRAT5G
         9Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788832; x=1780393632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R17d81rZFtdCmrvPdq6FOwdkUs8CSvLL3BM8+TQqKKA=;
        b=kNW6Ru+Q5xQEUcfhAAx0VZS1w3qkc7oSGj5lLrJSSj95uZALrJXC/dttlB+N5QdO7/
         0Adh+u6yVzzCOTNFVejFiWWiwCPd/8fGNBrI/m6jk8R8AWaRhtVla4fg2duWhodoBWAn
         tNl3y4p0/kswz/JRK4gsgbVf1R2y4PfcxpDGBn7JTNfEpOHaDR4H0brpy5WUlcZgOMct
         VnSV3x5UyalxlwSg/230P/Zcr5HjDS8eCr14amVLjl2mLqv+8NNC8IoYijVGqljWg/zM
         7yjeHszJqqUaHQx/L07sOT1CxOe6D2gCVZ2zDcED7LNMc0GcASdpgG39T4Fs562Iqps3
         BGzg==
X-Forwarded-Encrypted: i=1; AFNElJ9ECrbn+ZXtAu4v8sPsDq0qi/p6EEQH/lEmx7yGNkcDrYv5LvM++BzEWZyND6D5fe0k/y/OGeLXO0m3h0A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw46pIyJxWjv+Esdep/10OpwHCUokrDqMV/TIXJiRJzHh+WrMoi
	RN//88FxSN49wVNc5Z8iU/qt0l78euSG5/moTh5KTTYKIrGhm6GdfVFFa6xIu4iPKy0=
X-Gm-Gg: Acq92OGn3qbhRWjSj+8N6iBppKLCa+bG8M1cT+D2NcGzlxpPb4nkKcLm4ibk0c/zZJx
	YrlKCcvbC1vctPdUF+YLvZNCVOtoVJ/Jrw+XMu8PlnKifPaBSnpA+HkqC8HO8zBC1YVHj52gaP7
	3nC4f+BglwGs+btcUK92g3CTZ7SiUcIHpt8u68+ho7IK1Au46BtXV0z0WNFiqvvZmVeSWT4tYkc
	HhV0UWdLZqt/qFbJsdwdQumDlCaSYr6xjh0lV51Pi7H4iMlV/F9ngY2ZO9JVbz60Y4EcDqxcyoU
	eSuEQCdQnkUq5Gfk48K93Hl1r8dsENPLW0IdJEVOuLa93smoYhPHfINsBJs/da5Ghtodf9W/xpd
	ggVQpgqknwynKGXV0Ikxj33WpUeNlr0sIBRD/fdBNzSsxI8wMXRcZd/a5PWKcfUJwD9+nM+V4Ep
	h8KHKc66cuy82yWRDtUJLgnH9fg7X7UkXE56ZgtPHeI/g8WmToU0g5XOQxL73bnXoX8QseECz/c
	dOnjGVBE1FyKnDZ08X4Lc6UNDDCGYE1g8q7fuL7uQnoR2ubRKXq9rVawePLeYOpzwXMRXZerSmn
	xUTR
X-Received: by 2002:a05:600c:6209:b0:490:601f:d776 with SMTP id 5b1f17b1804b1-490601fd9admr168561055e9.3.1779788832071;
        Tue, 26 May 2026 02:47:12 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm307921735e9.11.2026.05.26.02.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 02:47:11 -0700 (PDT)
Message-ID: <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>
Date: Tue, 26 May 2026 11:47:09 +0200
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
Subject: Re: [PATCH v5 06/14] module: Switch load_info::len to size_t
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
 <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Switching the types will make some later changes cleaner.

Since the updated version drops the patch "module: Deduplicate signature
extraction", I believe this change is no longer necessary.

> size_t is also the semantically correct type for this field.
> 
> As both 'size_t' and 'unsigned long' are always the same size, this
> should be risk-free.

The module 'len' would now start in init_module() as 'unsigned long',
then change in copy_module_from_user() to size_t, and then back to
'unsigned long' when calling copy_chunked_from_user(). The current code
is more consistent and mostly uses 'unsigned long', matching the syscall
interface.

-- 
Thanks,
Petr

