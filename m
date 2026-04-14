Return-Path: <linuxppc-dev+bounces-19744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB626F9D0C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 12:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw3xv0tdcz2xnj;
	Tue, 14 Apr 2026 22:49:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776170963;
	cv=none; b=ACB97r8TCqIYQ3Rq4sQNC5BS1bbnLIVr1lML7KfIYx6MMvWoxh9aSIdW1qAJ/40xA83z+oJgZzjDp90lN2k8H52VCD05Oy1oPBQ/GWauMz9CEiWvjHTSdEMf/LRnPWymNtXF3hGBfifXDeNQPTQad6hzJCya9S1qEzMGAg4RoOv8yGNVKDbZi3WDl6LWq8zWtQv16Q7zwIA+wV02+irHI8HGvAzbXWEwE03y0hLajea6Cy6HzClqiqmov4eW75cJRQvKYm+SrExi8lajHaFh66frv3SDm0wfe1tra8tfFgWzg/xA/PoNeKrpUw/OpwbQYT4PDdLj9cLZNzk4qw+MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776170963; c=relaxed/relaxed;
	bh=t+TkXeWEba/XrFX3yATqWZDjmT7vuDDsgvIBT65AAhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVZreNnk9L9LT7dmP2U78fjv8mv5xTHLqbAsIHZdpAf6jsp7GQsAxLriTO/Tc/hq6zqmYT0R8AAaUPxSwJBuM2EXiIeFEC43fQ0ZL9Fpb3xNQgShLk5NtzppcLjqrhqhuag2WsAOUgXLTJBYG4FFpc4QswAE+3peyUmz25LM755BzA3psJbo57ywHriUXEcWsZpnsZBiZNXVpfDX8LW7oK7lo2TkdeOorrvAOSnr6X9wTdxySbt4QBylPChvqDCGoQnsSXz4uYHIUYjTT/BEEm4Z8mF09MV3p7OU5DWh1Qkdj5OWNPdt3LSqx5b3oc7xmOWPE2XsaSCVS7M27lSasg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nj04nZ/Z; dkim-atps=neutral; spf=pass (client-ip=212.227.15.15; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nj04nZ/Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.15.15; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 379 seconds by postgrey-1.37 at boromir; Tue, 14 Apr 2026 22:49:19 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw3xq205dz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 22:49:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776170948; x=1776775748; i=deller@gmx.de;
	bh=t+TkXeWEba/XrFX3yATqWZDjmT7vuDDsgvIBT65AAhc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nj04nZ/Zp+jE99gkDYIQMbv6vd8EtGLwiEB3VOs9g+3Kz5BPEft5H6/ROSIPPRbh
	 8Qh/O46ZzbEQhh4dgSLQ7Akf0Z161Uwkd8R2/Zc2BRk1BMa0FnkPSBKPKhZKHLWz4
	 xCASQ//7cTGz7sVRmstaNPdmlTEeqLlKS7mpdx2cweavHAc8qzzqFFhfMdTRgcB6F
	 eg09wh9PeNULQr6/JUyJj82ZCCnutacgMnE6Ya32V4CAS/cB7BQJSEt30LWv7sBmf
	 zpCAd5z0JVc9fQRn52OiVC/0SsvSKr/kls/YREbKvcRN15Homzq3Bl9qT9rUtF1zS
	 3cgrdneeYhJd73w86g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1vnwIX2Vas-00YsyQ; Tue, 14
 Apr 2026 14:41:59 +0200
Message-ID: <f0731727-fae7-4582-ad5b-a5d95b0d78ec@gmx.de>
Date: Tue, 14 Apr 2026 14:41:52 +0200
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
Subject: Re: [patch 31/38] parisc: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <20260410120044.031381086@kernel.org>
 <20260410120319.658485572@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260410120319.658485572@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZqOPGpEpMYOOKnwdNEQ7I3XH33yrIj2uNRXsp2/NoY4YKTm37d
 cWruVun3i7Sk4GIlBSCYmCwwqcNjragvIKsBHFI3iLQKRhUmXElNimqdOrFj4qhSzGCrQz5
 4Nl2leWKLE/WJTA3v6zYwlGFukOTRBLg+lyk/SmoPVxTH7cptbFjBFi4OyiaN9y5NYZwXCM
 E/BuuquGn8nLMTRaoFkig==
UI-OutboundReport: notjunk:1;M01:P0:eTDpfqt7C/U=;bRopT+cncq9P7h2beCEszq6wtqM
 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
 VUKLGGh8Fev/XBsmxGF/eMDg==

On 4/10/26 14:21, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
>=20
> Switch parisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROP=
Y
> and providing random_get_entropy() in asm/random.h.
>=20
> Add 'asm/timex.h' includes to the relevant files, so the global include =
can
> be removed once all architectures are converted over.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> ---
>   arch/parisc/Kconfig              |    1 +
>   arch/parisc/include/asm/random.h |   12 ++++++++++++
>   arch/parisc/include/asm/timex.h  |    6 ------
>   arch/parisc/kernel/processor.c   |    1 +
>   arch/parisc/kernel/time.c        |    1 +
>   5 files changed, 15 insertions(+), 6 deletions(-)

I tested this series on parisc.
Works as expected.

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

