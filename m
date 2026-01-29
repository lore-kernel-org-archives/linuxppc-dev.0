Return-Path: <linuxppc-dev+bounces-16400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54109D6101C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 14:44:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f223T6FvBz2xnh;
	Fri, 30 Jan 2026 01:44:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769697877;
	cv=none; b=VtGe8aJ8njJb4TaiSjwn3Z7Cvhoc92Zz9LA9tox5HfOgYHoCfm93ocWfXu2EWiuVDJzKED5bRguuEr8gtD9GZrHGDgSelDPaEe5FVnr3Y5dcsW2gTb0+mkLr6PH7VjAxWM+bAzxMgBc6xttpyZJO3qSaM2Feqp8LQc86k1ULRiVuolrF0Wv9wES16ECtduMgNOvgbEkt0wfIPltj94Bfu3jRLPo2YYU25ynWVhcqKC0i2VN8uILTVVLdvMclCVImIHg2Ss1bg0eUxxJ3aq1x/iLXbhFUI0vJ4x14NZZN8NsYy8wjEmQVGmLSUBX4pdQB3UCtM44x8gsvLjnc4Y6S5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769697877; c=relaxed/relaxed;
	bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQXBVSJNaHgiuha6Ki/zQY4XBS58wY/FpXp5YpLo5WkIdx/NLmpkXpZui/ARjC7FtZeRWLxR6eZ/Fmb0VbdLI14JaBxY6WGNjAv/9Wbpp2ACOsWyVG9VMIthpssizGhF2QZ88tsWnrDmr3I8WS70yvma3A9xhRa/g8EZfPIePY1uMOOZJgW2M4uJzstAZpNPxRGLrxJrMpvNNg0+mpehjV5w1bqKkUeaQVIcluI/tEWVglYUUEhIaPjfvHlnMk1ceF07khhbcDcENbCe0mjBx5+qnMdamSSZY1cYjcDOc0Oyv5CZuXP6GQpprk/PuFM44h9NEjj4e13v57YDU4UXSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QXYIwzEy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QXYIwzEy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f223S5YkBz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 01:44:36 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso9597255e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697873; x=1770302673; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=QXYIwzEyqDEHYZtJtYSYF2qVgTTE6Txm8234trXQ6Qu93gnQLzi8KPz6hD+caM6kYM
         u0Qt3D081hDkn5R1rJgiNrNI1h2/CD4SqKzcc2W0pBueT4iKdwCDtIGpyn2VDakw6HfK
         KJkJ/wM/nuUawP5XBrdQAthEquRXYZO5WwVCJG6ty3d+oHeGuaAQlsuWn7b+Vc0GcXmk
         XWk/p6NId/N57cjOp8VkHdduuojw8Fs1TcqD02bSQuU83yXjq9EuaZVhdzZlk+Mln4pX
         zB5IVANDS8rdeyaBrj4wQ86zRYf93qW1hlzs7X0E6NXfbmIGZAFZrmp6ZADusKIs5u0x
         7MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697873; x=1770302673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=B+kQnRUB3Z9nUpaX1ggPTeswG0avyH/Jgb1gNqWMlU8B0I/X1+odo9rr8bPbX+YwWN
         ib1Oac0mqG9kctGzJrGhN3YfrBvmrepBZrvO7jACNNCPAddKggyileFxEGxq9f6mm93v
         TG6S7BwMLkrK3dnTsA991b2qnRQkp6jYh8Y+PkaPIXXvBxTowKcLoJvfwa8y49wZQBFG
         75JYJmS9G06JDXUV73I11/srV8J8rvzfFB19eS1yE7Ub0IND+J0EjmiET2Gj6ua9VbX2
         fjLfpNAfrTrdaLK+2zVTpEngMmoVT22TVNomA/gjT11y+ZESiSFTeQE3psBcQtR8JS1j
         3TLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFXm9yOV68eR2i4z0nffr0AajVxKKIJIOpMtHSWM8NhONRK/EMqQOObeBjFcKbgPtquij/cJHdHQjhg8k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIJsTLZrBxZ58DEtGv+IxfCm+4eVYOSq7w8k1NDHsQMOKGfslf
	JgO4Hyu+1+z6/2rVB3PH6Kv57zqMibohD2a1vMxG4xuQkg2UaAojfPrBnyL/2HftXDg=
X-Gm-Gg: AZuq6aKi/2yaFb+Vxy/SlREwR3zzisCOo5P75MeirvE7uWz4ciWUfFXRdQYELxJhbHk
	wcTd3HkB4xjqu8br8AP5at++HOjP+B59TTwFWZsWPPd3epWEhqEYH2DeO1LEZryBh1i53yCCkIG
	n5en6bUCGD/CZZpSd6CwD0QuibgFLquxMumvt5pQ4jC25U/wIdevDO4wDb8N2Vx9D2+0xLSMOld
	eNtwXW5C0M9eLEPLq3U0Bc9Jj4Q+3TDVcO+aWp2EOCNdd4tmB3uq94bpAAOqLUgMWD6ujRnzIxl
	ovi2QfoEOEPv0+5LtgcVkxvtpL4kYkVPAo2H+hf+pyKXJkNHcmTNyFeq4EJ+AniKhEL0PyGDMKT
	AUZWdJ19kwqXffgVcPGEM+SllkCbRc/jAFpDoYNglw8/8vASH9KXun4gnhAnsxM5yZ7KStOxdMO
	ReUD81f7y0BTRaQQD2C2zVC1G/CD/SWg==
X-Received: by 2002:a05:600c:c8d:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-480828ad89emr46795915e9.11.1769697873050;
        Thu, 29 Jan 2026 06:44:33 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm166871115e9.5.2026.01.29.06.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:44:32 -0800 (PST)
Message-ID: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
Date: Thu, 29 Jan 2026 15:44:31 +0100
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
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> This needs to be handled by callers differently than PKCS7 signatures.
> 
> Report the signature type to the caller and let them verify it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d65bc300a78c..2a28a0ece809 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
>  {
>  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>  				       MODULE_INIT_IGNORE_VERMAGIC);
> +	enum pkey_id_type sig_type;
>  	size_t sig_len;
>  	const u8 *sig;
>  	int err = 0;
>  
>  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
>  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> -				    &sig_len, &sig, "module");
> +				    &sig_type, &sig_len, &sig, "module");
>  		if (err)
>  			return err;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
>  		err = module_sig_check(info, sig, sig_len);
> +	} else {
> +		pr_err("module: not signed with expected PKCS#7 message\n");
> +		err = -ENOPKG;
> +	}

The new else branch means that if the user chooses not to configure any
module integrity policy, they will no longer be able to load any
modules. I think this entire if-else part should be moved under the
IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
patch #12.

-- 
Thanks,
Petr

