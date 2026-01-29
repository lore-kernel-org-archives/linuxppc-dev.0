Return-Path: <linuxppc-dev+bounces-16399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A185FD6101F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 14:42:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f220S6vsWz2xnh;
	Fri, 30 Jan 2026 01:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769697720;
	cv=none; b=lC+8GOa5ZoLDMXp70FPqoWiGxnDaEkhaXlA3uX2hSFQpE0E116yRazTMzakqk+nUPbCKoQFCl0M4/w1ILDVnFpTpXFADW24LY716tMILGoo4oZoY6qAMznLRMtX1mBXtA7u9VcPn3AYxuO/c832VcgkeyWwmUvRcWUObf2nI4DsZ+P2svG8u8Vvj7yrtJVzPmkyXJEwUO6HV1nThYWlcAX0Zr6p0+paX/1QQkJdwOI9lcyJOYy8eiHnvXZT9dBZuglwUIaHhvUSqQbklpA5tl3NEdOxBTpJLVf0Td8XQCLIdIgN9zImxNsj+EoUiyoPh3D6lYl90PVNW/F/hDEonUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769697720; c=relaxed/relaxed;
	bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK0XXP4shkbhxeQpKF7tXQrHO2lqRKPQN+r/rAzIOpY7g25fyZMAtzp0CM39vn37D/0dvB6MUJ6f4vXC9RNYtWjMY8mbTLo+ExgJfdLMghlwdKOysNgEY39n8zyg77L2/nQDcJWBJl3YGk++acDtqPmbMBAf3MNHd7ngiklRwvCN0IpfhXPi3ql2Oh+9Ik4s3rF2NA/Tvg51ntSFoJ6rs3AU4wyMK8IE1haw8zv4HkOWIWQP4YApznlfsBkhiUXLZ0oxXQWX3xMYKb3/bNTQj8ccJDWfM8tS5ZcA8/uwwTR0nxc7kK68mBldVW2igR8fYq6ZAPEKu7nBuu7iMy2bvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ogp4KETa; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ogp4KETa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f220M4Fccz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 01:41:54 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so8428185e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697706; x=1770302506; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=Ogp4KETaRlzp9BOjnwdLlxeCfmULhAqjOouteVOVQqYBEGsdm15aKtXy8Newi84uf7
         /iZvj0XKNAMIXZGQKCHdlsNaeQeQbs/VeJFuqbvqcr0Pu37o5fZO1GW0jsRIYssclHn+
         2/zS/pCtfSvmlnDHMDRwqy1JAlgxR43Ch02FNsyEyZsAXNM+1Z/el1WRMIQuP+Qayg6i
         Sra4/6CcDcrEIeUhmUkFBZxHwfcDGn3eNfjHQtlRaAIEdbAgi3YlPBKCax0ERNhaZr0p
         G6kCqeA1HS393m9tsNPJlqVmUYJa5NUaOtzO1PnQDiw0YsBGSm4fnj6FWpdczuUuMeO+
         ZtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697706; x=1770302506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=vZOsKOhlTn6qaUiWP/K1r1wAQ19VFPWRULUw9Dj3DpnRs4VueJjxZuZFulEdJurrJw
         kiocxvFIDQbH4fvSdnkyU8PqoDdv+/J2vFQpl7n6nj1BMbyEN/DddbC1clmdIXPp0536
         c2XdZ0633kH+7fyAp0u4Zitnp/Y+IIAyyGsJ8f0I8to7mH9W2f9EdZ7rCa6iz931w3vF
         HUlS6DMAXB6SIRn55rTuVB33mHD6XjL4T1IgIbh3RJdNNScOwXSyI5LXNDYChgTKAiiR
         XbTMOQtEIS/f66lFwPn23l52jtmBq42POxzH7M6ayy12A8K8RBBSNwRCFvRpXicbeXwY
         RKUg==
X-Forwarded-Encrypted: i=1; AJvYcCWbL/3uhuZL3Vj0d7qLk5s00QAeAX7PVp91lhhvoob5CAKjyGrVelNsILzO5zsEB4pkFcrYweoy9lAkZLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhT4NX/AdJUdj/36mdz71VxeSUUrmjnYpONoMWWlApZwuvGkEE
	he8xRMENPU5vsasjGDBX/9fhlVk6Ik6/jnxGTzsgZpK5DpLcgnsseB8CadA4dfjNV/s=
X-Gm-Gg: AZuq6aJiy4CcbM6NI9q4Woyh0SEldJzs29l2mVtUrIDFAWdSDyZVsvx9zgniruR5LHo
	wWhKJnmc166WRdYLODWbrXHfot93Ek+zq5FGt7Z7TTCotLDMVk/+JdD1XoNGR7tazOtvSQNm6aZ
	q5XUZirG8JQ4xncssMBI9goegUDl/7bxHFrXAxwXHjFKT8RYDFrAZzjEmJw/uEC1a9JH0rqgT37
	lBtx29cb6EP9tUIo74msfTqYXsQ3/dTjyuW6p7bmPESS2hPch5w0NDdKkP+i+A+RaMcqgvgggsi
	hQVZImaaQ3rrFhYl0fiYbWblU8qjiyEheNWZKrBZDMOXkJD8eeB+P5DWX02lq16piEN3fJLKjo7
	pu9H+FArCX8QsIX8Q7bFrdeXGvi7vfiuoPKqQTo1Mm2cCANRA7/QYHWRFEC8trb3sypn4u1JBCS
	NLibwQVtXY3jPiUQSr/Kw7+ggw9En9ow==
X-Received: by 2002:a05:600c:8b76:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48069c49d54mr120114805e9.24.1769697705735;
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm182396725e9.10.2026.01.29.06.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Message-ID: <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
Date: Thu, 29 Jan 2026 15:41:43 +0100
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
Subject: Re: [PATCH v4 12/17] module: Move signature splitting up
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
 <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The signature splitting will also be used by CONFIG_MODULE_HASHES.
> 
> Move it up the callchain, so the result can be reused.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c09b25c0166a..d65bc300a78c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
>  
>  static int module_integrity_check(struct load_info *info, int flags)
>  {
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	size_t sig_len;
> +	const u8 *sig;
>  	int err = 0;
>  
> +	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> +		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> +				    &sig_len, &sig, "module");
> +		if (err)
> +			return err;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_MODULE_SIG))
> -		err = module_sig_check(info, flags);
> +		err = module_sig_check(info, sig, sig_len);
>  
>  	if (err)
>  		return err;

I suggest moving the IS_ENABLED(CONFIG_MODULE_SIG) block under the
new IS_ENABLED(CONFIG_MODULE_SIG_POLICY) section. I realize that
CONFIG_MODULE_SIG implies CONFIG_MODULE_SIG_POLICY, but I believe this
change makes it more apparent that this it the case. Otherwise, one
might for example wonder if sig_len in the module_sig_check() call can
be undefined.

	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
		err = mod_split_sig(info->hdr, &info->len, mangled_module,
				    &sig_len, &sig, "module");
		if (err)
			return err;

		if (IS_ENABLED(CONFIG_MODULE_SIG))
			err = module_sig_check(info, sig, sig_len);
	}

-- 
Thanks,
Petr

