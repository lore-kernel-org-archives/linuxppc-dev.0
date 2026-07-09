Return-Path: <linuxppc-dev+bounces-23904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3E3C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:53:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlzH41RHz3c9w;
	Thu, 09 Jul 2026 16:53:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783579995;
	cv=none; b=EXEND/P9mWst74c2l/2hpSV1dUAnxcYNSBVt45uFAHiIRGzJSqPbuothHuil+omSBO8cW3gs6rtTyH2GjIkYnyHL+qMcht+glDWuasgpXe29PDqvDZcWRAAhx1v8nd0H5X6tXzeS/fqQMjG1eImFW28THJ7sg6oevWRpHqDfBSCQa5BclYBUn9xCmAWPzVtNofrnHi4IydychNyVFltXsKmB1j66uNepwP+od83HzezAIIE3EErUYzd7aghL/bkgKKgPK/Ex4DMC92fb+vmB3f6EZXRDLtZ98vUZm8LbAWvSXBWHGWWYZsHwx4c0UVL2E15MUufHrwlTquB2CaQcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783579995; c=relaxed/relaxed;
	bh=H/iB0CTfSp9a9nTqlLe96q2zaF0MNosazIzO7zY5cfs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kAkBE+DiRS7y0eB/fMumFYOVF2EHlsj+yOfwa/mVofnE30/hjGktCjns6XV1ruCeLoc28M7pEdNEtYgO2/5I633uBoJXQvRaUtyK8l8iJIsBZL90/92Q80D0bf/hk2H1mJ8HrNG8E7MoMjAvOu6ETwSMaMWKirV83Yx8XF8m81w66eQRQQqzEap0zbmuLc2/cDeBDpDi651MkWtzsyZjLV64B8fu7BgU3fs+MfVbU+Ig2NKHQRTJtpjOBe1kda4WmJb7PieLufhr77NbQFvpy+MmWZ9fEDQ6xIBzuXFyS+AqamE6myQvTzT+KLVbjfU3oNVj90r/teyRvuvn6rt1Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=otmgfTAW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=otmgfTAW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlzG5vQCz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:53:14 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so906145a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783579993; x=1784184793; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H/iB0CTfSp9a9nTqlLe96q2zaF0MNosazIzO7zY5cfs=;
        b=otmgfTAWd+dJsC/MzpilrDRbWeUIvIBoQhRs5/Z9mn4sh+Cpgfhk7VqmrUq9o58XFy
         D3d6aiTCL+NMr5QqEh6rzzh3xD0XpDQpAOa0/CfQmdc9GyooiOaU4pbAEEqS1qsZpzAa
         4G2klQTmTNBd0YYUcz0QMOmKNLszr0td3YrUtKdXIIHVCEKdZR2ehQb4KCl+Fs5vHkGT
         cuGM0r/ozVJofwThkQQ7N29yvNvRxGC0vB0doKU0Dj37YvBfBs76fhAewbOL+hOqWq16
         vtBL3BnbA5XMrV78uQUIxpP+GegzhbxWzJLblOi3pBNexHXDF/lHM8ZKNaS2GIJMnTCI
         ztPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579993; x=1784184793;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/iB0CTfSp9a9nTqlLe96q2zaF0MNosazIzO7zY5cfs=;
        b=f7Np8GrRkLmWWcpp3Ti1351hDtmuWRHXJpUoaUUz8i2be2sBkwtMipQISDsGPCcTJE
         uP2zijPBqDQs7BFcK+aCvpdBAFGfZmiMKazG0NfaJSpOMb4bCguSRFcwg9Uxd/X8hTNu
         2BHgPSPznPdv1zPDoKhsBRhVznoefPmh1VjxUylUqszaP+mVxo763ALrVRn90cS9IYI9
         7qtCC6ST5WXPZFwDgheBMQzzqgHuK1K+Zeqej1YUEYOtzS/JVkB7g+zYU4gk6hnPQMou
         VFVOOXj7M/qnv/gxURqbmkwjExn4aZ9q4Wz0OnrbnRX75pFw0oQt/Kjm50/j7daTJ6Fj
         DpsA==
X-Gm-Message-State: AOJu0Yzsdx56G73uTjpKbkP1Jvc/FPm6hS9yPAb/qMuwToOtx0uZKORH
	vNEAJBNU68Cyh3TPkiFQA5DPwLEvz/O6k08gussKVHjAsiQJbjphdJfw
X-Gm-Gg: AfdE7ckr4+xuvNEmXVhA3YdHOq0VJg83F2d0rOQxtBLaJJZ5tRBzxXm1Q8mVrgNLuxc
	yj/NZCM84w1M6WByjdQrtflDaZuCjP+wL7qf1JEx9WyjPpsl5r/QkuLRjX7F6CNuDbrVfDwuYhG
	OSvxrKZ4vg28gd71lYdLphh1FnmsjBn0+yNMRJ1fKuuAFZY9qY0s2lRzlgloWRnHHFRFYO7zsEm
	9b1qqdHAaYWgG9H6LkCdB6Ff+0ru/z8zbX17uG+k4vBZcL0oX//wd5MBgKXEhFgn++76pJwArFh
	5a8i+cphyfGnGtr+KyjH0fNzhUON3ZRPD4iUkED+eNV2hG2uV7N2qareujp+gxQn5UDyqVITu5/
	9eNaqSbMTq0f1wPZDJNkA9ZCCcIPw4/smLNEMsrhVvi7S/fZG7v0KujBSDkysHXaUqTuhG679dT
	Lq8TRI+OedBQI=
X-Received: by 2002:a05:6a21:6b02:b0:3c0:9c19:65a4 with SMTP id adf61e73a8af0-3c0bd29275bmr7271216637.76.1783579993048;
        Wed, 08 Jul 2026 23:53:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm9457437eec.26.2026.07.08.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:53:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Breeds <tony@bakeyournoodle.com>, Alistair Popple <alistair@popple.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH 3/3] powerpc/boot: Fix treeboot-akebono CPU node lookup check
In-Reply-To: <20260702211554.56923-6-thorsten.blum@linux.dev>
Date: Thu, 09 Jul 2026 12:22:52 +0530
Message-ID: <a4s0wt6j.ritesh.list@gmail.com>
References: <20260702211554.56923-4-thorsten.blum@linux.dev> <20260702211554.56923-6-thorsten.blum@linux.dev>
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
> Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> ---
>  arch/powerpc/boot/treeboot-akebono.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/treeboot-akebono.c b/arch/powerpc/boot/treeboot-akebono.c
> index e3cc2599869c..1b529037480f 100644
> --- a/arch/powerpc/boot/treeboot-akebono.c
> +++ b/arch/powerpc/boot/treeboot-akebono.c
> @@ -146,7 +146,7 @@ void platform_init(char *userdata)
>  
>  	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
>  					     "cpu", sizeof("cpu"));
> -	if (!node)
> +	if (node < 0)
>  		fatal("Cannot find cpu node\n");
>  	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
>  	if (timebase && (size == 4))

