Return-Path: <SRS0=3O72=4C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00938C35242
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 20:52:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638CD222C2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 20:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SarBqj+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638CD222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48K5DH5RYDzDqkR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Feb 2020 07:52:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=google header.b=SarBqj+o; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48K58n1gLczDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2020 07:49:26 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id m16so12437878wrx.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2020 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BG/k+1n242XmQ392+l/+QM8WpV3CVNW+mSgRrXUNaOk=;
 b=SarBqj+oUxptfwZyuPnoE9f5TdNLgDfCHQUMJ/hlsyT34Ix7OOciJH7CP+Ir3b2GzM
 9zb3YRPgjRMX5OrfVnsaU+NWX65BwvyfNy/jlvmnZvXwHmUhKJyKKN4i2ekuDyB+AUaN
 m0OvEgnVfVGPMiW73eqXyVcabZ6/knDSWdzPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BG/k+1n242XmQ392+l/+QM8WpV3CVNW+mSgRrXUNaOk=;
 b=VM2VhxaPvqQUvyDtqg1TEliw3xhWaRgowSjjd9qNINeJFrbPBEXI1peAz/7PPcl3PX
 VH4hg81P6FMhZ/HUOktGs41AFs7sdLzePdhGp6IOh26p/gMFclHVDz1NopxMVCZdgVBI
 lIB6+LDZQo4e49KVA6cmChXFf17sDcStXe4qvkEiyl6F1UaajU8zINgExuHmLGPfUd7Q
 9JErBxvbTelyTzLEZ0dugdgvs6T8qlnNNnXNMSGHsdhh9Exm7fXu5FJU0ua601bLVE0v
 O5yCafqcJDHvYiWE4gbcD+cjmAxEQ4lc4mGWazWuxtexnZUdKKEoSPvenyHTP/Pfzf/8
 MefA==
X-Gm-Message-State: APjAAAVQT3uqPvvuyg1DMPUpOUK5jtNbB7wWpYi4+diWBmLj4oFuy5XO
 JmtC6zxD5E7eq+w9ZLfuOwuzsQ==
X-Google-Smtp-Source: APXvYqxncTdduvArrIOwd2nDXfNPYclGCAutEyIXX9NPCJWgKiNMBPvLCR/gffpuMOaRVYxDiBFUkg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr6152109wrn.254.1581713361497; 
 Fri, 14 Feb 2020 12:49:21 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id r6sm8400054wrp.95.2020.02.14.12.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:49:20 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.9 003/141] soc: fsl: qe: change return type of
 cpm_muram_alloc() to s32
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20200214162122.19794-1-sashal@kernel.org>
 <20200214162122.19794-3-sashal@kernel.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a920b57f-ad9e-5c25-3981-0462febd952a@rasmusvillemoes.dk>
Date: Fri, 14 Feb 2020 21:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214162122.19794-3-sashal@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 14/02/2020 17.19, Sasha Levin wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> [ Upstream commit 800cd6fb76f0ec7711deb72a86c924db1ae42648 ]

Hmm. Please note that these two autosel patches were part of a giant
48-patch series. While not all depending on each other, there are
definitely some dependencies, and between 800cd6fb76f0 and 148587a59f6b
there is e.g. be2e9415f8b3 which changes the type used to store the
return value from cpm_muram_alloc(), and a whole lot of other
cpm_muram_alloc() refactorings and cleanups - one of which
(b6231ea2b3c6) caused a regression on ppc 8xx.

So I think taking just these two might not work as expected, but taking
even more from that series is quite error-prone. Unless someone speaks
up and explicitly points out and verifies some specific subset of the
patches for a specific stable tree, I think they should not be added to
any -stable kernel.

[FWIW, we use the whole series backported to 4.19.y on both arm and ppc
platforms, but as the b6231ea2b3c6 case showed, that doesn't really
prove there are no problems cherry-picking these].

Rasmus
