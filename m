Return-Path: <linuxppc-dev+bounces-26631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E42C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:29:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdXcl4yXrz2yvX;
	Mon, 07 Sep 2026 13:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788751783;
	cv=none; b=muXztQJjxfZWPsTxAHDeS4fhsGKUT3skDid9UgPz/IKFvk+RJLx1buMC4jRHNiyGMoObkQNR8S2Vld3xrSXtHhUxO8ukAypH6GkH3MQjn0PLQ1hwAepbIHZ0qMstgJkPlu6igY40xjDjQDAf8Z/wa/dl9Y2V9PSESrcChTATbHKYCLgIEJk9EDkLEpJr/Ha/dGHarxpaMLyLjCjU9HatDqlFp3htyN18xaFtkK5WEqWdH4toTXzbC2+ln3uRnLtwfaF7jJzPP6AG9EDwHhnOalvYTKtec/bw/jk+Q/WboTpz8MLuJqU5YD01Tlvo8sAo+mT+fqSqOWRW180Cy07m3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788751783; c=relaxed/relaxed;
	bh=tp0aJukw+a3PhmBQFaWxFKW7LFV2YBDjGrDn04/gkFg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VDnetKfVeSLcQQ2feFopkn6TYRzQV+ScLG9L8aV7hvXzgR8kugrE6MmJYDuD3+5f62CmZL4JegGC8CvAHryyFZV4sd2JlzJtYRkWD9Z6g0FlU+hR6NVZRBRa/Kgf1pA8B6MuymMyMNbOHJbAQr1XSFog85t8Sf34aHkAH0tT2iBesc3F9rmYmMb+/rGg2nO6vSPUEbIYEfrfQHedzFvJZAkQdgoxMouR7lstzeBkHnigP6CGH8dphS7mVth4adhwGiiTXU43Ii22uYGFPQtC25+YmcB73oRTk10tKGbw8yqju9SM2+DNEYDggCabuGIJfnszl0xr0MgFmKsbfOhEfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OOHJ5jv0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OOHJ5jv0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdXck3THXz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:29:42 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2385010a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788751779; x=1789356579; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tp0aJukw+a3PhmBQFaWxFKW7LFV2YBDjGrDn04/gkFg=;
        b=OOHJ5jv0vgAoJ5tMyJyaQjsl6GRczJIPrDPiDwbPom5hqEzcs88mCBm/L9RfspZyBQ
         KclTLb2f3urnLeipcGma2gXNNDTQQYPyeyFad7lBxIQWnXC0cAuHA7W/GPw69/r2UTv0
         liZ1u3QbJ0s5QHSBcOtQC+WbLL4a0fIdR1d4a3w7alyAXCQchOdp3s7dNdM6PxYtSItX
         viofBoyei5VV8xHI9Zcurx2mjfSSOlzdnUCfOrdfv78EdXNIKGKQYoFrjnk+GJOrJiJ0
         sNYjJOssnTugOU314aj32vUTh/Njj4pRYJR6r7fznwLb56BBHjkC8DYoUCAu15nLe4CO
         tdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788751779; x=1789356579;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tp0aJukw+a3PhmBQFaWxFKW7LFV2YBDjGrDn04/gkFg=;
        b=Wd2AakFFFnI+Xld1Psf0fULsepqVzeMLY8i9V6q8xnxKQWskiCdPokQX8KJmKpddza
         y2EIxYy75pK3+2UqfX/OnZ165f1UA3laDGNhb/vgnWJ293BT0J984NJGDmzTTUdg9ZUv
         XHBp9IeQXYuRk+X+GfeR5uinI/QUV7YOoP54SY+EUnmX/HaD+0gN8hmW2R5V0Q184CTP
         6zUy5J1U9CmfBXuYore3ebwfqK3bPlOM28oPNlmt/fy7P/2yFlO7Hq2P8be1G7gw8qMv
         8q7OlA8sAd6nTispShrQU2cf3svIq8V5gjy/a6dGmla2dKXmSIMQV806FqQXQKuqXZrO
         1pgw==
X-Forwarded-Encrypted: i=1; AKwUvBzDBg2fM4C9NnsE6fMRii8li/Dyxq9BAmBXtQl8y6KYh6xCM8voF2LGPf0uZSiBIqsOnobujkI9PD97myc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mYua6o8talbRXiRu/FUPteEnTdi81VOHAIGUiCaa/VmG27XGQf
	oVKbDEnvhxcWgqwvEm/GM0Tc9dqhiWieNxoC5Eli6UxdTxfxD46ksJ10
X-Gm-Gg: AYBFou2TM9q3Q3wzBIKOtnCjFIPQPcpvRV4GCGSoGxO2Kbbt+DLGPdk25d5f/Ntxzfv
	o2njQBEQMBIhwsnpQSp992+yqLXg27fA7rThKse8kVvyUYjAnc5le9L5gtBKvrrYWnIF1aga1Tu
	YVMKOIoS8DnbA6MSQaPr9Jg464MrPPD6r/1ii8f/2iCsFC3JNr0q7dRuPIrOEpe8IrVLTk72sau
	UPgyl9NYu3rveu+3vuZG1EK+i86wKR9cGPeXUbrtSkSKGlgQ/tZZVBihrStJN3LBxRNzrVMhttq
	je3gC+BRzKED9Is5dGKeUStxuvpi1ZQh9C91Br4I73ZGSd4q8pJNSTSKOSfFl0R6HktjO1w+NYL
	TnbucU/zbhzRXmUdknrf65VcRYcxpxqAid8D2euFzTouVRTExZdLlkZyemsshGqH+TMVwIYSHmD
	cl1nmv0WfbZuN07AhSRXBAGhjbQaTrSSvhg3kBrMiJ167mhFtBwITkat245V0AxHg0iNg+90+hC
	P8UdboKFZvAC8Gilp+NfJyRYDFiitaKd0tuvM/e0Zfm+g==
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-39b26203f11mr32745749a91.16.1788751778701;
        Sun, 06 Sep 2026 20:29:38 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3369856a9f7sm6717453eec.5.2026.09.06.20.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:29:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Rosen Penev <rosenp@gmail.com>, linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: powernv_flash: fix kernel-doc for powernv_flash_release
In-Reply-To: <20260907004821.225576-1-rosenp@gmail.com>
Date: Mon, 07 Sep 2026 08:58:19 +0530
Message-ID: <ik4h210s.ritesh.list@gmail.com>
References: <20260907004821.225576-1-rosenp@gmail.com>
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

Rosen Penev <rosenp@gmail.com> writes:

> The function is powernv_flash_release, not op_release. Update the
> kernel-doc comment to match.
>
> Fixes W=1 warning:
>
> Warning: drivers/mtd/devices/powernv_flash.c:271 expecting prototype for op_release(). Prototype was for powernv_flash_release() instead
>
> Assisted-by: Opencode:BigPickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/mtd/devices/powernv_flash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


