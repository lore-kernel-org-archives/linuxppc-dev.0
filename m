Return-Path: <linuxppc-dev+bounces-19617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2A8F45A10
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 03:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fszVq61Q3z2yTK;
	Sat, 11 Apr 2026 13:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775835136;
	cv=pass; b=mD7gjazMexWBiDJjFKf7Qf5upKvqVFSDU3MrxIpMdwtliFDq5Sm0wC4Zo4hnFrlch6rCw7R8X7XpXFWRZm7M8WvZZIOZhEs2p3Do+ue2qN5ah3ZdzgHubWgg5u0v04xnf8Y9bQyuoQOoXuI5zXLuiJjtCMdhM5VyziAbf34WJvyDrBYIL3LyW+/OZ6L/HyqRIk1/ywOHHmlRF13e9H1kl0W9sjqqE/uQnWUU1D4pUYclflwUaWPUiEoq58pY29uiBy6ysbmItegxmNHrCIhewLAf8fqc6wV4ObeiozMtQlVvwknjJhuytejODiyzgeVPmpp36Rzl0wxvV7uWbHfnqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775835136; c=relaxed/relaxed;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm+LOhQuLHGtUKQ2C+/EwoqdMreIid9jFqOQx733UGPJ3Q12TWQRCU8/mxMJYbrWPrIgSYvZO+5uPsjQRicEbDKYiCsy0V8R6UBXZNQsaT23WqA/la6KnoCgisFOs4hIpO5n93vYlJOHUuQfqhCR4bTPBgi1ngz4ed+OAeJbmbMKcGTh1RILAhjPCmND5EDdWGHrnCQIWevihjzu0X5oC5yBdEMaOKtXaFcBckPg4/72p4BIWi1hU2qX0aUSEPqIBTJMFKa+qlmj2SjJ9KkyjbBkQPtADfur5AV1oZU84PkaocltzSCaI6vPQHM4yj68byr+LL8UvIaAeoUyXrIo4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com; dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LpaVQFFH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org) smtp.mailfrom=0x0f.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LpaVQFFH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0x0f.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsglf12Cxz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 01:32:13 +1000 (AEST)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1271257ae53so9590767c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 08:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=CMLH5M36EaFvLkU78QvefAW8l0FbSdLz11NvB23SK0xJeO9c2HahKdQeo2xFXqm01o
         efEshKzTEo1xRHDbU6RNPnAKF1Bvfi+Qw5DePKJAkJFO7+Ac2zOHTzUt9pfLcHXjQkEZ
         LK3DlTL7xYqhCDmQDsaiBxHLRzZ8HWl+ZoB/K0/YeZk5+Ssl81sOlG7WXhSnHNEXbhPf
         L7BdhSCD5m7M1aj8VOW690XHporgWvmlNSVmIxz6eWmkoRe04xhcR5cFGKDZSQzqx4v2
         ITwbfx3RVDY28Qv4NOTJSpjfVGx1KvvBdrs9ZeUEoWK0+QuzR4Lhlgty5S+Q2nfN7A2P
         957w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=Kn6rdufe/Onocd+hy6jkMB+MJU0EGT7ZAONwf26+Yxw=;
        b=NNZk64WCz9XF6hCfbzXq0iwD4QLkfOAQK9zyzkfnBnidTMgYDTc37Eklg4EpQdHVGk
         p7bWNqouKqSWS4a3A/qZ9XO0FrjDKTU/1iQUyG3EYEj2EZamIJMWtzPLSrnkTBZT6V9O
         wRsBBUC2y/A7ctKXuc123R1GoLbt87K4y3uZL/V53wuQA+QmThF4JMV7eZY7vg0CMFGR
         WbYFSsImvnchAN5Xic3RRFcYupJZAkeWRQmlQNaZ6Nl2Rhtx6o9vwRuJBmeYgKHpK4d5
         UayW5tYXq9sPKNrOpCJBTEBTXW1V5z/uZUWtnIArSuaXBVrC640bzr9/NC6PijpvLSyn
         ut1w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=LpaVQFFHSDiR2dZ2EaphhEDE8BBOm9tUfxzDiJ/G+d+MCpSA30NHCy4XmE3q1vOUaL
         +nOYrIVNcGh4V0bjL04lBaLKLhPMWHgNukBHpo5KQ4VrTt9sKU+8KhYmaWLEPZCT4MAB
         UVjIKnEvJZW6qMA5i7Dvd5zj2wjAwUTOT+16U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=F87B8TOPrgW0563YmBsTMOPzXVCyWMhAhlhSKF612jeSe0o8u1fh/ww4UWYCFJjwuF
         lUuFzT95rvCzNf/bcmH0WKPOXRxxhtig/8XG1QUq6ZpF9Yw5fN1jH2eYZd7uueKROmYw
         e2eSA1P6TeXRzp2flPqVuOm1sYTUe+p6rwW4cqPVRNJm4BnM2Q3FvOOrmZFbCidnE8v0
         IGbyiaodPzzrTBpe0C2FixqZmvlQjlIWpcjtpQ+LxETHDymDFlW9Na+UrVF39zqqHx4t
         voDXLyo/YM1JEei0pfg+juzNDSRS/9zX/xzaRk8IYR8bNZrdQC4x2/G43glvuX3D89/2
         rZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaK16BwtfILXte43R1UY86Mvz9Bgpo1eUDgtXGIpHaj/v4cdX/HiOpjNsZKWVQosOMpOI0rptLeIzsdIw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBr1YXTMYcDYhQljKZeCLLthhmOMqIM8mzyzjBjCSgMGJny5CY
	i3doaFBEPesJOUh5BTQtMaSZpL+SOomh1u6AIQzALx3kshCKEiwTp/eJwiecIdMMXWJaa+kYQF4
	nwX3YQJ7eDIJPA8vEyNK2fGRUS1ni4GyJ/Krwpqkzsw==
X-Gm-Gg: AeBDiettlqilLuLRPU1MJXnZd+gkIj2sjXbC5oxvJgqCxVPVY19BWQYkf4yRkaxCn0g
	q0Wqxk7deg5IPuP9G5TlLlr6qTPr33rRt00PwILN082Eaiq2vsApLyWYaSj+0GH0YQGx/4Pc0pf
	/SEi9lH5okma17Y988cgbJ+MEy/E4bU6KgwtbNdO/FXZ30PvfQ6AjDUlPCcVmtXoJPQSSSOOVez
	yoqXg4HifKTg7oY1zyUXsOnJ3jDb6KqB/Y/SBDwopr8yYuozuuqjXlHLJvcseuSiKl1rVnuIvfr
	O+hO
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>

