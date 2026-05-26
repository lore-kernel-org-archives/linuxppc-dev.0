Return-Path: <linuxppc-dev+bounces-21509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F60CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 10:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPqNn5ClPz2y8t;
	Tue, 26 May 2026 20:53:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779792809;
	cv=none; b=WaakTXLzL1FMQb6k5ic6CuweMJF5HIBAd36h81hQTz/3vRup057Antq7u99Wm8/I1vRC+6WCrPplxM2sQqq0xnzbSYy6j6xr0PAlHuOaXhc3hA7Vg8udaCNqooAieA7gtHauWMf9lbWIwhyxe570x7zw07iehu8XZeNFjs4iBXWwAUOeMOu+WI4iTeY/dkTxG8cNvUQo+Iu1ljyJm+gkq5TXWgsVW9THVQj2wnPNXOFaljycwEessukn4OvwEAUqbLIs4YlxvIK3j1pq9hJSZ4QD8hhQNYgbrJA4OyM0OKCjE4+LhRqJ+5rW5AtacmIAlOP0jTKM9d1SIXiEn06sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779792809; c=relaxed/relaxed;
	bh=ankQ6/0PQUNDJRsfxZkkDwmN1Szk45mZhdmBSOH36Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bx6jZuaRf3UHsmcOgZNFDMYhTVlbhjlIFUaEPk9D6SkyRj14kqpZcFCIIjJMMm/M6Wi8fypxpzm/ftb+HTjk63iRxuJi433CcfT0jeCl6/q42InBuZHP7FQm/ItRwp7gUM56LeZWIp2/PPDAxVbJyBM+82edbK6mtWviC0W9/gPSVlOwVNnX/PuApnEhkKu21P9TpPju41YaVLw3fT5nUNeI4L+GQr64pSE3QAF6TdhQEr6G+hhQI3VRoF+t1O6Bi7yv9XVYeCcnvrLy7fU7m7Wzmk5FZQpOYHYvGTn6XO/tkUQMxQWAUJKqmz5pdgMem2M3q4j87t2m/nQiOjGIsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PN0VvQJI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PN0VvQJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPqNm40hTz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 20:53:27 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-459bf19e87bso6132339f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779792804; x=1780397604; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ankQ6/0PQUNDJRsfxZkkDwmN1Szk45mZhdmBSOH36Gk=;
        b=PN0VvQJIBTWAG88muvarIyzjiQfxrq6uT1K9F9bip79JkReYISAT3C1Yls9hrLYF9O
         /5rY8rjHaavqmxo7t7dm5yjmnUAsTULpGEEznSIBvYO5X9yVEn2fL+Nw3gd7yh1DCH3r
         +4M+4Oi+bmV022x+GwIwekJ2oc9ZSvEryLliYSd9p7n6Cy3r3lBc7RHY2wW4K1AZMdXU
         ZM5+P6LRXZLWDdzMm7jfMjjhNB2FAmK9hEEEwETH/1h474C/9uf1oYAx0RnNR4K8LWIk
         6RqO3QqFThF7WBFUXDcIhhN76AvAeDX5S9IOOUkIfP2aSXmKz9dJ9RzwkaBzYCO+zzsi
         sXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792804; x=1780397604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ankQ6/0PQUNDJRsfxZkkDwmN1Szk45mZhdmBSOH36Gk=;
        b=SymiSJ7RJ971/7Hh9WIJcmWk0cdeIh5YSpVbqtOeORWsgkF+CtLzv8cR+xgQqGewrn
         iKFjYKgceV6f7XuCAvP+CXIs57QJLPY2AgXHLWERILRtpgftEdT7h6qQghIUe9oiPd/a
         kuoEZEh3gLq+t086xqfy2v01eXI2/W1lTSKZxBC9BvYJrLDiwxfpQBf9cDZbQtqytwtT
         TV+ad6V29Cblw8aEiZxMeyfNgMG8vHITq92q6hlCGM1SIgDvTB9J00YD+4o4S4AaTHVj
         qhEMSKwHLrznyxhX1z2/EWftU0MfkbGA4z0xAbUIekTXeXyn0uPTrr0dAzmUiHi0yofa
         P+Gw==
X-Forwarded-Encrypted: i=1; AFNElJ9bTMyNYu0urNKNv3/TuMiFBWo/YOrmuaR6A9/tas5jirenE/OCxnTFXsyeBAcsRKAs3rfNBrr/C/RUMxo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRf/W7whfG/VNAGN095sjX2egwqfjvybMdk/37bwRlqpRnZmjG
	HH6jI9+NYVXbH4bJ/cwGpKazf85ibKoBux4VNS0OZLzL0xjmCSlzU1FC+R7qtuxxZrM=
X-Gm-Gg: Acq92OH5OGDMXqo9hvMvGedBcRpdxZXKofFgbpa8eh7biwqDzIQtbMhZHgpZ9u3EIQF
	w8v+WnWpJpe21SHmMZ6OAfYflIbhGUJ4qaTqqwmH/aVXwtcw194stGmdYoxNvbGYFYhECDOZRMm
	pAu4ABGhLYEBJ++65rPFswECrPV+P+PkbR27nqLRFcHQCSgKWGv1O5kjrePxQ2c0CdPz3kV1D9F
	zIvYxUt0eZ2s+zvSqXDL1dl5YTSTiYUjHhAkyJN1sEirBytQcdXwMSSxrro0KSppLAMcA8SNMRy
	rXrEkvI6ic1bJTQN+0Ry14zNAyJ0oaWj7eXJz7FnqgcKTbRs6DlCw/gM9hRSlr2XxMch9QaVMZo
	+y10sV2oUaCWxIzne6EP6UVRRcJw+qww+WoimOrJMwTCmtyur9mXsYhn439lPxYl6PvWpFyvgX0
	e2QZEXHllscxDLqm1RvE2cBTQw6pHGtKk5UDAyTgH0v6pODDpGLjmsuW0OZKlb4Qd96iIcFFxqe
	9rpZusKmcB5nCayQcdX0j0X7UJ6cUd/RLpWjxaj3NzOtAtk0h/vGUoEqDL2UERfuzR6Fg==
X-Received: by 2002:a05:6000:2889:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-45eb38c5259mr30630897f8f.26.1779792804025;
        Tue, 26 May 2026 03:53:24 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6bc5479sm36850849f8f.0.2026.05.26.03.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:53:23 -0700 (PDT)
Message-ID: <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
Date: Tue, 26 May 2026 12:53:22 +0200
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
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
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
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> The module authentication functionality will also be used by the
> hash-based module authentication. Split it out from CONFIG_MODULE_SIG
> so it is usable by both.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> [...]
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index f535181e0d98..84297da666ff 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -271,9 +271,12 @@ config MODULE_SIG
>  	  debuginfo strip done by some packagers (such as rpmbuild) and
>  	  inclusion into an initramfs that wants the module size reduced.
>  
> +config MODULE_AUTH
> +	def_bool MODULE_SIG
> +
>  config MODULE_SIG_FORCE
>  	bool "Require modules to be validly signed"
> -	depends on MODULE_SIG
> +	depends on MODULE_AUTH
>  	help
>  	  Reject unsigned modules or signed modules for which we don't have a
>  	  key.  Without this, such modules will simply taint the kernel.

Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
renaming the sig_enforce functionality in kernel/module/auth.c to
auth_enforce?

-- 
Thanks,
Petr

