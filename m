Return-Path: <linuxppc-dev+bounces-21514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0508CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 11:58:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPrqx499vz2y8t;
	Tue, 26 May 2026 21:58:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779796717;
	cv=none; b=XvredAhdZDgpSlWUTzBZDd9flxyvnLH+C1UbcMkM2X2RPfydARGxtLYUygKQdcmH/IuNLP/qUZjUla9Uzgf2l4iTWtoQAy4bn+LBFnbQABGMq3A+AT0At168SIobrk1en6vDZmJapNZfk9xrHV9hMJhkXD3Ol5Kj22lIspJxcIPWKkI2muklpGtu+L54vND0f7vCcTTAgte1uNgfmE1IeL39cDhvUkLIgDBidBxzuNMgFWk1IDzhnyGm5K/fix/43swcWVFj4hMl3IjjmLnC4+UfD27e1MW9bW2gcKb6kO4ZF2mNQRRHGFavjNGo6QuTtW1CPxTwuChoQQb57hrSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779796717; c=relaxed/relaxed;
	bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtIYilaRX1Tg/6MXCSVIkFDvtcsjqmP0rJlSDVtMLI3HlBa33jBQcWnpL/zkW6DV6n+PSEbwkPt29A5A+m7pPR5W+7efZpEqmK0euscmjdkt2vADXYJdncCmdnRrs3jKachXtZTluBOml4AJqdDRZ7YK7OOzt1b56k96O00uwxJvY9MuH0V9uYW0ui4MI1a8FHD1pCzq2Q51ir4su79a3ZNrprHk/434ldqj2N5v9t8eXKPQc3aadf47oM5405zpPnZ7EA4DeKXdRGS6sTk4/cHLinGDOKHq+GGcTOcbCHbAYE7dyhoyzNHcgyQX9PV+elowP9FdKbnR7I8wWLiiqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KyqzI/YU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KyqzI/YU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPrqw20Wmz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 21:58:35 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43d734223e4so6637767f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779796711; x=1780401511; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=KyqzI/YU4SuTJjUQrz7BPfXLZkk184Tgls+AoXjeYuzliP+w3KM3DmE3gziOp48U5E
         kybtsE47bkt2eRXtxFa2R4ayM7ZBA7hYJzeEUnazYWjBqD85aPZjtAKa+W6rRsEjLo4j
         j89A3Xn8Me9foYPKyXXXusGCFoNKQZn75tKoLIxmEUvZ+sO44yTlt7FDp1RKIoRAikky
         zoetFORQJIIGcBXLg0EnEYinLDu6vk5fSadgSHZcWa5t4mZnCrliHyEFGwqWmfRpgRx3
         EKg6ea6/cojX3Dmn1A4/PN4X1jZpTSET4C6D1OsZq423Nq/qjrfmuguICnz+/o9JjMFP
         emwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796711; x=1780401511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=WGgh8EqV1PIg7umbI7wSdpwdz6kttmwMcUOQuxYuqmNhgvgQ1jgkMq/2FYL8Uqfvye
         DLC/3wWbujSGnoKK02rhDlAfiEtzZSt0wqZ6d8A2hjglvNTo3pyhm11+re7wkUpHnB/0
         O5cEX90rlh81IXN0St9LtV3FGuaDzBwe0/JFQf+bzGjPy+zPhu/ICo/lqPwva4tAyhAH
         5Z6k1nplfP8yxCXE8yrAYb5fJNwTtRvNNRIbp8ZDy5Xa/JabSCCVk5DQDYhQFPlyEaTG
         25oZHDTf/6pmT3+69sNNr1uZfMv7lXxndwFUtZne2QemKDH8uTwIGxGGxY5ryBl7qI8B
         36kA==
X-Forwarded-Encrypted: i=1; AFNElJ/KZJ3onz/HFQfeTBgTNAYaFN8P1Q8dSveP3W0q+1geDZMTzu/J8ub36lO7JHm7ye2iogIcdvV3UejSj+U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5md0N6qR7L5NA3EDh7wkc6mTfw0sJQjBzIJwb3vKAoEiI/Ypn
	/0N4H/FBYEYdzfbOXLzkrXynR90fWIHPKk+7V79wXaGApoQuHjEobr+3DBehh9RyjgM=
X-Gm-Gg: Acq92OHKrSGsrfVn/iG92a+mS/JqH1qSNLcu98EBgiel6jXQhJL+rkhpz7D3UAE9Jt+
	JsPopLWJmbZ2bZ+FzxKp1AlPoP6vHZ+13BKEp3DIVEzw7mreSdnrA6NjTmHtIzkK+hiRcNftSF2
	/4OP2V0JlNtU//j/Iz4WIUSeGwqo7Zu3F76DbyWEF0D3JRVOaHu0KIGjGazhpw73DQ9RdyRQ6Cs
	fbWEHQ39kLqXbJ7rvkyIrpd8lwpCSCI1y4M2gvrTkob6GeJjYnvW4w6neT/JCjPKXFkqe+sh+nE
	3Em3QLsCZeSw+YdNSj3k+mNYcfPL8kDTEgBojb3BpQ02n0tBdNL4+2oENqHTAeBezU5HIa3XR6L
	78Ciok6QhJ9w7tFmcsDKym3BDAfKew5GQ2MAXgnnO2ZWjrJ+kzvuIFdcTC1sRLjR8Bt5lRGgkoY
	cIEl1CXjiiF1/UF8cj1MPRcbCizIY+KZdBtm9fLaOCHpdUKxq/VITv1uCLQU5NCtmvp2zTq3t4Y
	8fmYdNq5ILZKTr3+2t7p2YFnHs7Mx7PJGiFv/rCshOtbjpHshIQAgFzMOoLAB17ZmLI+Q==
X-Received: by 2002:a05:6000:2888:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45eb30de822mr28814928f8f.5.1779796711490;
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm36462739f8f.22.2026.05.26.04.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Message-ID: <885a7940-3fcd-4fc4-b80e-cd82a817defd@suse.com>
Date: Tue, 26 May 2026 13:58:29 +0200
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
Subject: Re: [PATCH v5 08/14] module: Move authentication logic into dedicated
 new file
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
 <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> The module authentication functionality will also be used by the
> hash-based module authentication. To make it usable even if
> CONFIG_MODULE_SIG is disabled, move it to a new file.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/auth.c b/kernel/module/auth.c
> index 956ac63d9d33..831a13eb0c9b 100644
> --- a/kernel/module/auth.c
> +++ b/kernel/module/auth.c
> @@ -5,10 +5,16 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> +#include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/module_signature.h>
>  #include <linux/moduleparam.h>
> +#include <linux/security.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
> +#include <uapi/linux/module.h>
> +#include "internal.h"
>  
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX "module."
> @@ -30,3 +36,82 @@ void set_module_sig_enforced(void)
>  {
>  	sig_enforce = true;
>  }
> +
> +static int mod_verify_sig(const void *mod, struct load_info *info)
> +{
> +	struct module_signature ms;
> +	size_t sig_len, modlen = info->len;
> +	int ret;
> +
> +	if (modlen <= sizeof(ms))
> +		return -EBADMSG;
> +
> +	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> +
> +	ret = mod_check_sig(&ms, modlen, "module");
> +	if (ret)
> +		return ret;
> +
> +	sig_len = be32_to_cpu(ms.sig_len);
> +	modlen -= sig_len + sizeof(ms);
> +	info->len = modlen;
> +
> +	return module_sig_check(mod, modlen, mod + modlen, sig_len);
> +}
> +
> +int module_auth_check(struct load_info *info, int flags)
> +{
> +	int err = -ENODATA;
> +	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
> +	const char *reason;
> +	const void *mod = info->hdr;
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	/*
> +	 * Do not allow mangled modules as a module with version information
> +	 * removed is no longer the module that was signed.
> +	 */
> +	if (!mangled_module &&
> +	    info->len > markerlen &&
> +	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
> +		/* We truncate the module to discard the signature */
> +		info->len -= markerlen;
> +		err = mod_verify_sig(mod, info);
> +		if (!err) {
> +			info->auth_ok = true;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * We don't permit modules to be loaded into the trusted kernels
> +	 * without a valid signature on them, but if we're not enforcing,
> +	 * certain errors are non-fatal.
> +	 */
> +	switch (err) {
> +	case -ENODATA:
> +		reason = "unsigned module";
> +		break;
> +	case -ENOPKG:
> +		reason = "module with unsupported crypto";
> +		break;
> +	case -ENOKEY:
> +		reason = "module with unavailable key";
> +		break;
> +
> +	default:
> +		/*
> +		 * All other errors are fatal, including lack of memory,
> +		 * unparseable signatures, and signature check failures --
> +		 * even if signatures aren't required.
> +		 */
> +		return err;
> +	}
> +
> +	if (is_module_sig_enforced()) {
> +		pr_notice("Loading of %s is rejected\n", reason);
> +		return -EKEYREJECTED;
> +	}
> +
> +	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +}

The resulting call chain of the module authentication/signature
functions is as follows:

ima_read_modsig() -----------------------------,
                                               v
module_auth_check() -> mod_verify_sig() -> mod_check_sig()
                             |
                             |-> module_sig_check()
                             '-> module_hash_check()

I think this logic is quite hard to follow because mod_verify_sig(),
mod_check_sig() and module_sig_check() have very similar names.

The naming of module_auth_check(), module_sig_check() and
module_hash_check() looks good to me, but I would prefer to rename
mod_check_sig() and mod_verify_sig(). Perhaps mod_check_sig() could be
renamed to mod_check_sig_header(), and mod_verify_sig() to
mod_dispatch_auth_check()?

Otherwise, the patch looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

