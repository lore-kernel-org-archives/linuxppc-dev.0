Return-Path: <linuxppc-dev+bounces-18279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B15F30275
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 22:12:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZTqZ4WhSz2yZc;
	Tue, 17 Mar 2026 09:12:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773699178;
	cv=pass; b=Cp2+EDmsVjiLEe//PZHHBAT8OQw6BGVIzGvn7YSanINhcakEPR9wTuv18qM+/0f3Yn3MmaHj6AOsviYMO6LtGrqIB+7Q4qZ0qZbY+wbsIUBroc4nYTQtFQHP/WOyGhfVcSmm89/D3WDrrVvcJ5FJQylS6fgztsAdscdyoLZnfu1t3z9V4hamUr4EEjWiSYRXSwVRvMOL5tsugSinJF6zmSEJ1c7VZktkr6g/nJxVLPNl1s/5XqawHQcvcRJ7xNUsNN6dfvWut+p7/xXqStke88yTj1yryAZNgpEubiIIl9LxtMrpfAwriWgUNsvS6VKbztFPJ8OGAwgk8CBYFEKXTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773699178; c=relaxed/relaxed;
	bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLFdl9Wav4jvf9AbWykuSKuQQvMun6l8gEXAAJHUumTFdGn57lv8YSfEpbKTZU393Cj/lptMn8zv6x4fhG4RssWGeig2TBmiGulVcunKIEOjc7cGFWcbiIT2sBcCCIHJIzpMWBQxmSDhbDmKNqlmUr4sGSp3HdB6tnnSZ/qCmhui8fcQgnB1upS+0X6Xr7IaMQyrxXfqJwIJ4e3qO3F9xU6iWZqTEb1LH6tcrheQmcA92yVBmO4UMnkwUdONXYtIEdYuaSHiJH/96f6pPd4wIqvqSdvCtqP2OOh9Lsy2m2iAMwPPntaivQXfDZkVxudTlD/FM1+fQEZJUzqWWTdhGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Kg/+oyjG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Kg/+oyjG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZTqX6B6qz2ySB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 09:12:55 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so848981466b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 15:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699172; cv=none;
        d=google.com; s=arc-20240605;
        b=J93gObt+UHrx+lJbvP+1sDl1G8ttvDXAyoTnoG4PoFhUexgEirsDF7PDeXyosTGBmd
         TzQLmHZKnHaB0t+tTIqVccWHxWdCM8v2Z8DDGaJPv+LS5x0uFSPT5NK2bL3B8Mq4Mmi8
         csP0G0gvSvUI8LvI6iS0BCmoEN7lJYWWc5anYUfbiX3+RXnmDho+jhWbpqKbXAUWJvUE
         7Cmxl6rY/6veJcNeLnE/vM+9iljuIvP/bfTDaD8ahVpH5hE/d0k7b9dYzmkVSExSwlOS
         surKVhu9UwKx5HfzOox9pa2rbTRidSVy0ZWRYnCJIsOmsRZ8K2aA2Ng5oNMRkdVBBmzQ
         0eKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        fh=K9EUBUxx3jXMKwNrFOyGMgML4kTVMZd5M6ik3pQnnc0=;
        b=ENXn07WWKi2fUM1av4BaFWGXSnVtuOXhHuxkiq4w0/ufmsRDXwEZOwWv8ttxvxTDWv
         cLwLPBfP/WRdnj6mBWTm6haKITZkUXXHNLm8CDvmPGdITFv0UmUm9EtajQcIAJPO4IxD
         vWFKMCLBUB2278bXvINGaScg+TXa1eYEx+MJ7CIBIXQ0PnYemwTFcwqli+xFBXJOQBvD
         ScBKUPPsd9dIJIRQDjVJP1gas8vsyLsn1OpzsTtGcKp4gWDbLz5EqpeknGUkyYem4jrX
         74wFpuCh+vtIro+voyucJC+fk6nodf6Gb+s0F2woN4z0rMFIIVbpDCYnC1A+DBBSPgFk
         sVQA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699172; x=1774303972; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=Kg/+oyjGXAWUcfWg8sbsFDw/ckruMaa9atWqwjQTYpD7ODvhIkL3WCa0Zt4dOVC5s2
         KBoSuTF7TsYTvWHnVtiNAWAu29dfXyQIoul1Ajvomn9yhhySu+GigEOuBk2PFX95ttLv
         3gpo+LRLeb31ZqfjjFndSlqZklLHIPEFiqkVOe/+yY8UUBiBDGHK4mLgn9lcWCeTYHJV
         vIi/k+tA31ujVQQRD6z+w2RQo1FeilDiLoZrWRII6/GKzFte0K2u3gtlBSrXdBbFkNEJ
         OjV3g46tFaVlNDV/IhZW635n6SXMI0vfc9R6HN79M5G1Xq/SeJzV5pvFcJa/KloOPY1J
         uUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699172; x=1774303972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=QidE2aOpckoncvR3SMhpKeDvHUppKq+8cY4KOlqk8vI5kd1z1dLRzl9dd1HG5Q84bW
         RmSK6uxnuvKYbcVblKbO4GTzZXDmfdly64rcZA2aRuw77GQVOUJkdOvitLRv2feR5xsW
         l2lw8IZJryAPWpuLIAi37oV5Pm+/mI6C5zZJs8Vit67JFPgkFxBkstGmQQJ5SPARa3PZ
         lnxTigcng4fJBnfzAa6+x5TZoduqvskfoT485KXOOq7bBMHnjsPkOSjehPOQPMfT+eiZ
         JfVG8aF6Rk0FLJ18NHjMF/2jNZnT8qG0V83pDpomHNl51OhmJqWEuo4ZFT76/Nj8jBJC
         i3zg==
X-Forwarded-Encrypted: i=1; AJvYcCWWTnXWMZztgzWNchLdvKeIeBpxCKoqtMcbN4Uz+KkNNTh9jtZfHmCSqRKsYXwiXKx5Z/sjP6R2gwT5s2E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyldn7u6kDkaR/tDNE76N0MTUJ5vVjd8PfKXOk7aX2wpdpx+7UC
	5Bp9PBTjiw40FzlDcI2h+mlQEMPxGu29+eRl0Ne3YQQ5XD+DKGrM1S7Ma9GmPOXT/7pKA+gk2SA
	8aykAja4rqYjJKlnWukpOdVQgn7P6Xno=
X-Gm-Gg: ATEYQzwQbKJGZQmaNtXrwhZrlljRBZWTcg7RcpUeU9x5I3N4+dIx2+xzdyh45BdG1Pv
	rPQptOpJwB1GHLdsHuPRflBluCxf/PZaDGZeITmNlH7NPKp6gFpZxC6kFl9y29i4EkcxyHsT7e1
	5RDsssvEsBzKxkRQXoVO1i6UcLedpy2QEahUOK2jQbphSmUXpwilOhCpeJ6oKKswu5GDmq4Ryoz
	DcRcJLA+BAwMLz5/v7kyohBvs2U9EVDy7CZvCgDfCB4YQ9ATpbGKjybWzx3KvOSc/EPOD8jDy0N
	xGodjdNVYBvu7Z5/+D20voECQ1mji79l+xkq+Q7N
X-Received: by 2002:a17:907:1c0b:b0:b97:b515:31e with SMTP id
 a640c23a62f3a-b97b51509acmr346111966b.50.1773699172087; Mon, 16 Mar 2026
 15:12:52 -0700 (PDT)
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
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-11-hch@lst.de>
In-Reply-To: <20260311070416.972667-11-hch@lst.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Mar 2026 23:12:39 +0100
X-Gm-Features: AaiRm53MOL-S4iIRiZrnVZNNZCm-cfe6kMQGe2L4WL9TC_xpq_akeJ994p2lXMA
Message-ID: <CA+=Fv5QkJm8+ysx8W=ypr84oSR=rrikfk-iMMU6_xrtS1PsWvg@mail.gmail.com>
Subject: Re: [PATCH 10/27] alpha: move the XOR code to lib/raid/
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Move the optimized XOR code out of line into lib/raid.
>
> Note that the giant inline assembly block might be better off as a
> separate assembly source file now, but I'll leave that to the alpha
> maintainers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/xor.h | 853 +----------------------------------
>  lib/raid/xor/Makefile        |   2 +
>  lib/raid/xor/alpha/xor.c     | 849 ++++++++++++++++++++++++++++++++++
>  3 files changed, 855 insertions(+), 849 deletions(-)
>  create mode 100644 lib/raid/xor/alpha/xor.c
>

Hi,

I applied this patch and ran it on my UP2000+

The kernel builds and boots, and I verified the new lib/raid/xor/alpha
implementation using the XOR KUnit test, the test passed, see below:

[   25.705064]     KTAP version 1
[   25.705064]     # Subtest: xor
[   25.705064]     # module: xor_kunit
[   25.705064]     1..1
[   28.957992]     # xor_test: Test should be marked slow (runtime:
3.253413330s)
[   28.958969]     ok 1 xor_test

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

