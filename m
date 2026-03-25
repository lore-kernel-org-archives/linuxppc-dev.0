Return-Path: <linuxppc-dev+bounces-18781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD65109C02F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 15:58:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgs5F1M33z2yS4;
	Thu, 26 Mar 2026 02:58:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774454305;
	cv=none; b=fbcdCTusxHjL+udQl/JCWlKUHTuWRA73PTKqbyX7AHwqoRHBJF9qUi9AKy5/DnFoTmkLLg8GyqXFuYt/yntU6bUMq48N1iqxNfK82CiNwB4z0jZCWV56b9IvkK6jDjxA22mFOnjFUyrvzh7y0JnbO71IresfKPElyLIniiP9lDnA204COwRehIUXKtD4VddZ9BSAAZMcUY2296g6quPmYBtTOYEjhKAQpnk0jOZBngrn7bIOgHvPyuuryv5Q31LI5XU/tTyWPio4/BbNSyJ7c3GUtVKodGmIq3Y51gITb2LAbRcZ2a89TwWrUE0YAxNMysEuM36qibmQoEB/+muqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774454305; c=relaxed/relaxed;
	bh=m+c64TX9TAStG5n4QBbOwBHxDLYCJ+PjBNcVbNtGMx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws+J582kr1BE4byTe/2tLlUyFNqxnlqa1iacvotT7BYuXtLlZyFuuzGhBxA83ixI8xZFbUOamfvoWcuT1Wd0rwGfge7E8ncCix64HUhi72PQhiuHqykv6g7Y0X4OMzyuxpTxE+EvdoZHwoI35mrGjBTl33ukbJU2k+k6zM3MlTpNValx/O9zpzwkJv/mLvfN7xbE3JJPY/MbDVNoSjUVBV5iXNeUcKfJoc3Fp6mlsSxAx3i5HpaqutWmSd9KRyKKSmyIYqzamD+j6wsobstnvWbTHj0ZvzIAWIWv8OgcPzM2RbmVvuEos+CGWYt68rQlIkSVaHufXETEUl3mCB4MnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=RHklxLfi; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=RHklxLfi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgs5C3RsSz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 02:58:22 +1100 (AEDT)
Received: from [IPV6:2601:646:8081:9481:619:3ffd:957c:6748] ([IPv6:2601:646:8081:9481:619:3ffd:957c:6748])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 62PFE0CM3057644
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 25 Mar 2026 08:14:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 62PFE0CM3057644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1774451646;
	bh=m+c64TX9TAStG5n4QBbOwBHxDLYCJ+PjBNcVbNtGMx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RHklxLfiOlJf6ydmRmJruDGnJeWMZSbz2TgxABeLCgguQaUbYsc9vR9kpgjAtaRk6
	 D7BSdsEd+lvAoCQg+RbZcvgtOjl5ikAs97OdfN6AYdowAx+SkUCmf/8a7rxvIX1199
	 n1C53Bc4syiY0JVf3wcgOdQFaGlli8ZPulCYU+tqXHoikLbqaKaukH46nBwaABbmkR
	 FqzyBozoAq6ydYU475wWtUu9yg9VB2ezfO6KFROa2nbUotE425BtfRIaR4mJKhTxf8
	 dVWONsYwf/QQWCyfrPeHYwfZmG0pn9A7Kw7p2V6FDiyY1iJynsS0qMGEvvGfkQIYvu
	 dNPPZv5PxcbxQ==
Message-ID: <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com>
Date: Wed, 25 Mar 2026 08:13:55 -0700
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
Subject: Re: [PATCH 02/17] raid6: remove __KERNEL__ ifdefs
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <20260324064115.3217136-1-hch@lst.de>
 <20260324064115.3217136-3-hch@lst.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260324064115.3217136-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-23 23:40, Christoph Hellwig wrote:
> With the test code ported to kernel space, none of this is required.

I really *really* don't like this.

The ability of running in user space is really useful when it comes to
developing new code for new platforms, which happens often enough for this code.

	-hpa


