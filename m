Return-Path: <linuxppc-dev+bounces-23902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30419C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlyK4tXCz3c9k;
	Thu, 09 Jul 2026 16:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783579945;
	cv=none; b=IyMDAF0r2Tv0PEAWYQ3J57XR2VAEVBy1UXnxJ8vZok9TeNAPBTpXmVJLiyrcDNnUNkLgNtwAj1qCmJ/QBOJe2IyN+1A5kCxwqXw/BEP8uel+tT3DVlK+BmoHSK14Z/4QY0VIwAnwtA1u+0Qcb8/kvObiE1wQ4RYXYiv0zOC4d32IQx8hDOAVjGslwI+eNDMe/+miBBCfN9KLcZUSgp8VlCJn1I2StfWWaB4AsVK6rauRKe1+Kc6bq5lPDff+moYt3JhGxxorHLPaV8Z/5V5E40l1zQq9LFESL8wUlVpzE1eFObSi1HrWvS46cdnDJkA0Ju14oXt6lf9hQVMpEwPq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783579945; c=relaxed/relaxed;
	bh=kMyL2ueuaueC8L+l/ZwysBuIYsr03c+v5Ak7LkqH33M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KcQTFiAfj/cWanXP6KfsCMkOHmguxTVGMenvnSOz5rJohe51xMtOdYyGyj/TuDN/XfPQ0z4n4uxgyNVc/9IKjFuDN6dnzEPRIXxtDKk+t19XNoWsreYnyZIqCHLiIyv79gqvEod/iQS6hhZF2XCFsoUNG0rTxp1T8aYvEo8svKdmLC8wELR5lphoD2LrKgpf+E1mjzs84GUE9knnPhhDfvVrCM+eJE7JjX3hKA38bV18g2zrEWO3B6VjDgxZYzKp7JD7CZV8hpwiXpeL/v/JIFxsiXCSYNr5ZbbPNl1LfyB2HaXDOMEqXSQypOukSR+3OybFq8d528o+HHEuWI7a3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWO1xPzy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWO1xPzy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlyJ1x09z3c0H
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:52:23 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso897218a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783579936; x=1784184736; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kMyL2ueuaueC8L+l/ZwysBuIYsr03c+v5Ak7LkqH33M=;
        b=WWO1xPzyJk4z69FpWaQk8BhfHAi8VGbaRSzlJ7pDByyfLDjFrBLJ1yVymmJalcVUbk
         8j6tfkwNtSWHNB9VBzD6KQM85BT59RmHerUoSJLxoeonnQy/HDW1xcmVcTAeHkpfPMlD
         v0GqKyJlY0Gz02hSqgUBJZKnnK7oOQCcZ9q19/tkEG6PzQIj3xEJrnR6dPWS9Ip1hQeK
         fZjmXd5phiOHHA4xsX/JWr0F5F8OIi/42zrMNcLQ47FO+ZbPicP0ptl++Ej7mK1fDS6B
         rR9JMlWfO04JMYz9Z4cF0YxkxGY35FA438YlUOe1CbFD7uGM/y9PzI44oKRruwOpcrah
         B/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579936; x=1784184736;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMyL2ueuaueC8L+l/ZwysBuIYsr03c+v5Ak7LkqH33M=;
        b=L9ll7yQwn5e82smDEuf6lDYCwcZ9jlKwF5OjyasrZoYOCQ/nPez0/08oNJB8xk5phh
         Ywa+XUOugH8fKsPi5y71/Z/Zb0K9Wkl3zUA47g4WXAqwU+9KoS008M9G6RdS8PFWLXaU
         B995bOsNJQ4Rwhe6xXNdckYH8A2msvEjjhxRo1uUvlBlWMBHLY+dm0r870tFtTr8mev5
         /v4uR6Bop5e1sTyjy6ZaW+/rFcWqpuQH6IIBrCdbIEKUDVNGaUB4uLSLqD/HWraMHpS+
         ppvq5vAIAF0JffVaILa9TH2lT9qm10r+tfV9iMzL7uEUuh1U2x3ExDd6dSf7pR4tEGtn
         gc7Q==
X-Gm-Message-State: AOJu0YwfB1iNTp71tNqKehfZpwXGRQLPWiolXdwBk6OhHDyNFTKm/CsG
	SpzvfJ9/P0vjmnHokcZvGbZOIugo6fnOELfTBmT4yutaOf9+TKui/Ra7
X-Gm-Gg: AfdE7cnB2cc2aGfai7+6G1LHaVD73zxo16JKUIuQX4noLB2EmswrUhRaIFS3ieGY8Ah
	JUipdQXOZCLr03j8JmSicn92uuPLuI2azKOBRS2Zix1uNM8HiGD3UoCCULGQZR9kD9BVsGedE1Q
	2erIaV56FP5jAMdXsFfjsv7z1Lyc3XLYP1mDe0ONC/axwdNUy5ezSZtlAkHkI4bIoAoA+ocfOaF
	YK7AXv74V/Z16cHMhe+mZ5It31RFvjScLJFdSNA7QR8Y4bwZtw01HI9zugQ7SBzFaT7vRVp/AaM
	oQ7J9xF6F80I3jGrNAwFVpxRaDVkDVLk382F6h7FV8dhhb93C4mhjoGOX4LA67gXUanQyrAl8lK
	x/n+FRtjgcoTuP+lJLgMKJdpRavHILeQEfb09Rp06fCufZ/vTFA2ZBv0zAWESb0TPj6s2tKpcc6
	Cc8vHQWH3dycM=
X-Received: by 2002:a05:6a21:3992:b0:3bf:bde7:d679 with SMTP id adf61e73a8af0-3c0bcb7d873mr7374407637.40.1783579936226;
        Wed, 08 Jul 2026 23:52:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm23661245c88.6.2026.07.08.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:52:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Breeds <tony@bakeyournoodle.com>, Alistair Popple <alistair@popple.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH 1/3] powerpc/boot: Fix simpleboot CPU node lookup check
In-Reply-To: <20260702211554.56923-4-thorsten.blum@linux.dev>
Date: Thu, 09 Jul 2026 11:56:30 +0530
Message-ID: <cxwwwueh.ritesh.list@gmail.com>
References: <20260702211554.56923-4-thorsten.blum@linux.dev>
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
> Fixes: d2477b5cc8ca ("[POWERPC] bootwrapper: Add a firmware-independent simpleboot target.")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

yup, if it cannot find the node, then it should return a negative error
code, since cpu node is never the root node. The same thing was anyway
properly done for memory device node in the same function few lines
before...

	/* Find the memory range */
	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
					     "memory", sizeof("memory"));
	if (node < 0)
		fatal("Cannot find memory node\n");

...but for cpu node, it uses a wrong comparison check.

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> ---
>  arch/powerpc/boot/simpleboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
> index c80691d83880..27591df41e9e 100644
> --- a/arch/powerpc/boot/simpleboot.c
> +++ b/arch/powerpc/boot/simpleboot.c
> @@ -68,7 +68,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>  	/* finally, setup the timebase */
>  	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
>  					     "cpu", sizeof("cpu"));
> -	if (!node)
> +	if (node < 0)
>  		fatal("Cannot find cpu node\n");
>  	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
>  	if (timebase && (size == 4))

