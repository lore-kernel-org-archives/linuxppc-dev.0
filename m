Return-Path: <linuxppc-dev+bounces-23903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D58C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:52:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlyp39rpz3c9w;
	Thu, 09 Jul 2026 16:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783579970;
	cv=none; b=j2Xts61PaUsYbCZ0EMFtzs60vmuZaCTIhmnLvM6d8lkE6brPJoRq5GMx8pVfX1HIRziRpVhGjcZYwhjJyEBWDq1xAfgkl98qo1AlnG2CsbXlKZxGBYwOvn77SINO6j9harx+YFJeJGR9axRhLwDXWOppcLBIO3cB0NKH6saOzBtG/0QJehkm7d0v5aKo8PmyKQ9DEVWWRv3QlNbbWwIWU7wnbLN0lq2LBc/q9su6Lws0erz2xoPxbOX4kjw2Cbmg3I+TKDXFLOcb1mQM9byyMg7MZJcpTiUvIp1SAUu2/NOuj8JvHNj5mGKN6jwD+Fzjj+wV+yNNnGXZ5Y45tIyHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783579970; c=relaxed/relaxed;
	bh=UdnA/P7mCAyiVanyfsOozTh6jneyd7wup9/vb2CGq8A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=od8GQr/HjX0BMArYPToSVXV4NJxU3d3zkPeCFvNJzAzFarG8fdy70uSSV7y9c1iOhAQj5ok+5RJPvt3BvIPyoy2ivc01TPxWcTu0IpXNVWDQqQ43RScSSdYQC5d0vUpCFEEXw+fATTBWhILDULNwsH2d5UdOOTfoh8szEoM5kgD4Ia45zYXfOeK3Vl/bR+oIJh/dA15syuOWqPilzB26JIpZAdJN132pdyGKaUHJuMVzPv8lqOHs0y5Aofokj6vTnss0aUNCsCRDGSX8jBeYGi1fhltamqz5dSRh7M7WVeg1bWliIJueV62Pi3uuqhXfM1RX/2bu4Icd1Kv56NnMsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V12Fhwzi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V12Fhwzi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlyn5wmGz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:52:49 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cc73e322dbso14318565ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783579968; x=1784184768; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UdnA/P7mCAyiVanyfsOozTh6jneyd7wup9/vb2CGq8A=;
        b=V12Fhwzio9BRlZckmcwZWMthLbHvjOTI+a4EtcUhykoSOx7W9J290g7N71xodbSotQ
         IAHEmJ7I+ec1kkG0reTM5/uzmbGnrDtnQAaTzPka/rktwK4mZgvGq0ncgPI0f8wDwDO6
         6nrlv+7D2cCc1LHCHnX5iN7wkcsKUeI4OvyOmfE1D6Nsy3BMx8G3n70zgaAcnKVeN97G
         Vg3TVamOV/tc9Q/5MmdVfk7qP6yGOyetOSx9p3a8RkRC6kYC85VYHNjEc4upCfXpYAjP
         hy+ZarQUzYGWBJLISY3SG88tRYVxYM82+kJG2p8pIz6PIMSSeH05j5DP8NHa0vux1gvw
         WDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579968; x=1784184768;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdnA/P7mCAyiVanyfsOozTh6jneyd7wup9/vb2CGq8A=;
        b=NGRCQrwRRCc0GweA3FBApOsgtncaRU45RN41LVBcX2717cEFKOueoO9HiyO6ElXh9Z
         AOPtTYFsXnNEDPK9YV6AyYrXpV2avnoeS7cxt6cCc+rw52g2NUsr/iftMIel9MNLJtEw
         wLBzpaPMh1FYa12G5OAIz566SNtp+9k2nxKghwqxLpByxqBO9nL2KDLSxV5ATSrpb53f
         k7WtX1eU+HwmELSSsytRQi94u15jQIzmgRBIP5+fd/Vqrc86+hht0+ghbmxvuIkWT9vo
         1abMukmgKauZak3KBvDKf7yX5Sc6qLrnk6aqdJy4C1tixudMbvTom/0BiDnA6+s4gEs2
         rDqw==
X-Gm-Message-State: AOJu0YzqA1WTo+CCtOMoDQg+QKZw0z+4+4tmdXMuCMGeUmA49lf8Dozd
	A9UCgl8TWJtZ5hUt1JGhZrANGG1MmxhxW2iC83uwuCOdCXxhwEePtqZr
X-Gm-Gg: AfdE7clanLS+UPA5ZJJmzlw+dqj9O+em2PHPNSslY60AnPkj8lyQX0zydFw0+T5R/Mh
	qbtHj08bJDREW3ZqVrKYg4tfzMRksJm/+TEfTg6Asih4dyVrTBbac8JgjKLfhTHHhkf5sHn+prV
	ibrGghC47Np5cFTwNv+iDlxYZi8xhEBhNPyOIY1iNz+CqFTGMArkAcniQsGAmHPVIuRESlcJ9Ml
	YPRr7IM6p3ze9mqTKLPbjeKu+2xMYaNscni8zoC9x0q8ozbvfqHxM/nLAa4FLs9Qs7773c+GOzO
	VQ7rk5FMeBEVMke7Nj+SY6EtgXRu/8ZqMnBnWFyggI61ao4kZGE4WL3TZK2HTvKnlCtjLPGH0js
	emyJTzvxLUY/EqWV4YvEtHDSHyb4oOecMIaRvPAlpXIW7eoAmrjiw3UOyVkLfLuEVb/1jDin6gs
	/btX22nh5ZBD8=
X-Received: by 2002:a05:6a20:d708:b0:3bf:6c04:a813 with SMTP id adf61e73a8af0-3c0bd1595c4mr7398767637.52.1783579967832;
        Wed, 08 Jul 2026 23:52:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659666e7sm33453985c88.7.2026.07.08.23.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:52:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Breeds <tony@bakeyournoodle.com>, Alistair Popple <alistair@popple.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH 2/3] powerpc/boot: Fix treeboot-currituck CPU node lookup check
In-Reply-To: <20260702211554.56923-5-thorsten.blum@linux.dev>
Date: Thu, 09 Jul 2026 12:22:20 +0530
Message-ID: <bjcgwt7f.ritesh.list@gmail.com>
References: <20260702211554.56923-4-thorsten.blum@linux.dev> <20260702211554.56923-5-thorsten.blum@linux.dev>
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

Thorsten Blum <thorsten.blum@linux.dev> writes:

> fdt_node_offset_by_prop_value() returns a negative error code on
> failure - fix the check accordingly.
>
> Fixes: 228d55053397 ("powerpc/47x: Add support for the new IBM currituck platform")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> ---
>  arch/powerpc/boot/treeboot-currituck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/treeboot-currituck.c b/arch/powerpc/boot/treeboot-currituck.c
> index d53e8a592f81..5b5363b74f9f 100644
> --- a/arch/powerpc/boot/treeboot-currituck.c
> +++ b/arch/powerpc/boot/treeboot-currituck.c
> @@ -102,7 +102,7 @@ void platform_init(void)
>  
>  	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
>  	                                     "cpu", sizeof("cpu"));
> -	if (!node)
> +	if (node < 0)
>  		fatal("Cannot find cpu node\n");
>  	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
>  	if (timebase && (size == 4))

