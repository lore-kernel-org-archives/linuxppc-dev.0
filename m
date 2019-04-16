Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CDC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 14:05:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28802223C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUvt/fc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28802223C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k6b61xfGzDqHm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 00:05:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WUvt/fc8"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k6Xf1vtGzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 00:03:29 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id t21so10477573pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=VoCge1zxoq0LWPQmc6JunEZt9p/ILjPmwwgbcM0AAFE=;
 b=WUvt/fc80aspGvsgdB269dJdr2kWBVnjaB8IUxbBjvAQzwh6MjcE0qwPFg0heIZciA
 zNHP+uedJMk2akIW/iI+zfDdSRqqPJ0pIcFNwv/54BbGSG5nEppMjioohh/xz0mpVn97
 loaKEauM5KmZccQuP2df7EJ67QnVJQB/TBBxVtRrLN0Uq2iCTFUBg/Ad6/x6tkxw20YJ
 wpCeHbh1anoTDV9nSbSy8jMqfDZe8grO6L2yLxoD/nEGHASuV/Co1XZMQweILWYtIaPp
 qtPnFIy6eGaaVl7n+OhsBP3qPxl0+brqHkSLaCS+y3Obtl7c6LHJ/YKXBCthKepABv6t
 OjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=VoCge1zxoq0LWPQmc6JunEZt9p/ILjPmwwgbcM0AAFE=;
 b=QKA0ySjRsGsq3v042kLtUiFlrfJBKZVDvVFf7cQSEe0jC3gVZRCj+pRbvNckD0oQtt
 JjInFmu7+0G5+ai/PDYazdK268ImYK/r6DHv8hZUPXhuADg05c6Su0uKqzSFNDN2uy0C
 5pV075mtczGp39W+ZI9KI/+zfsT07TKoer0vGwioo2OCj3zZwUGRWDtAl0UzhDFoqjvF
 romgsAEG3ryiwCoCRGBIN0uaDtk4Cs5WxJh4v2+TrtNUm9ht/RvDnYpUXqqvMwuvyJjD
 lf4yLoV+Q6jpa/9g8gtnqNeTPpNloQPYeO6ha18x6/39QIaJveDUXuMISMjnmABQ4gRp
 wjqQ==
X-Gm-Message-State: APjAAAUZH6lXnK3z2WiLVgig35dB4QqObfsVhZeEbPuchkEs+knWZMgk
 Ow3KKdhiQkK7aQEyVnvUvj8=
X-Google-Smtp-Source: APXvYqwqH8TKdYi+NPb+XypgkYBeat9jJGp2bz3VkNeQJlCDrlIl5j6fpKVPPi5vvzuq32XQFXmeHQ==
X-Received: by 2002:aa7:8b4c:: with SMTP id i12mr76593283pfd.189.1555423406838; 
 Tue, 16 Apr 2019 07:03:26 -0700 (PDT)
Received: from localhost (61-68-62-84.tpgi.com.au. [61.68.62.84])
 by smtp.gmail.com with ESMTPSA id k79sm76856371pfj.28.2019.04.16.07.03.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Apr 2019 07:03:25 -0700 (PDT)
Date: Wed, 17 Apr 2019 00:03:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 7/8] powerpc/mm: Consolidate radix and hash address map
 details
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au,
 paulus@samba.org
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
 <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555422365.eio3zgx55b.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aneesh Kumar K.V's on April 16, 2019 8:07 pm:
> We now have
>=20
> 4K page size config
>=20
>  kernel_region_map_size =3D 16TB
>  kernel vmalloc start   =3D 0xc000100000000000
>  kernel IO start        =3D 0xc000200000000000
>  kernel vmemmap start   =3D 0xc000300000000000
>=20
> with 64K page size config:
>=20
>  kernel_region_map_size =3D 512TB
>  kernel vmalloc start   =3D 0xc008000000000000
>  kernel IO start        =3D 0xc00a000000000000
>  kernel vmemmap start   =3D 0xc00c000000000000

Hey Aneesh,

I like the series, I like consolidating the address spaces into 0xc,
and making the layouts match or similar isn't a bad thing. I don't
see any real reason to force limitations on one layout or another --
you could make the argument that 4k radix should match 64k radix
as much as matching 4k hash IMO.

I wouldn't like to tie them too strongly to the same base defines
that force them to stay in sync.

Can we drop this patch? Or at least keep the users of the H_ and R_
defines and set them to the same thing in map.h?


> diff --git a/arch/powerpc/include/asm/book3s/64/map.h b/arch/powerpc/incl=
ude/asm/book3s/64/map.h
> new file mode 100644
> index 000000000000..5c01f8c18d61
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/map.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_BOOK3S_64_MAP_H_
> +#define _ASM_POWERPC_BOOK3S_64_MAP_H_
> +
> +/*
> + * We use MAX_EA_BITS_PER_CONTEXT (hash specific) here just to make sure=
 we pick
> + * the same value for hash and radix.
> + */
> +#ifdef CONFIG_PPC_64K_PAGES
> +
> +/*
> + * Each context is 512TB size. SLB miss for first context/default contex=
t
> + * is handled in the hotpath.

Now everything is handled in the slowpath :P I guess that's a copy
paste of the comment which my SLB miss patch should have fixed it.

Thanks,
Nick
=
