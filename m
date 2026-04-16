Return-Path: <linuxppc-dev+bounces-19817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C5F8D773
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 19:32:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxSpX2292z2yYK;
	Fri, 17 Apr 2026 05:32:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776367972;
	cv=none; b=Q4wnlD8ofaWW+3q183o4wXbtQGMT9BdTY5BFzeIG1Agke4Q7CEKhkNXXwzYxn8n+Gg5br/VjH8/TwoMWiKLFniy6dGkzRZ1SDfC7DdoxT0H2ZoKJaERu9OWxK8XL0FoN1YbI8ebXVbsUncrch6DeO+sWqFqDUkKP2SOewoQFOykkomWFLtwHpK9wHy6qLJIAgRTE1rJonUun1Dfo41QMySjfS8hPiMNc9/raR77rSKXcsD1lGh9pIgwWDSsI0aJBrP2ZTGsWbrAnp74OgSLbOVuyJLWWop/7tj1+XLlLoWHO9NktgqALXaoMkRqxsytWZMH+5OgsdzOAUjBnbJVBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776367972; c=relaxed/relaxed;
	bh=92ERkl7IqZ3D3ZBskV2Dg9cLo0xCsyjyPbt0J7jJ1bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3eJ+If1TYGSRX9RU+yxBUX7LIx4BQYhJsGy7tKMD+W7XCt2+W0QMOxUgiHjygj4DZxRg94OKt8EyUAGMgL11JTas1xTAHNA71M6i1MFqoZecINYh3HKAovbpCT8XjpLI0QEUEui8t59f2cokhFQwmPrm1Beo6aqSx2s8Y97tD0isJVJUjJKKOZ4OcmpkBk+Xen0IGSGhqUFeXDBrUaxoauZAoziOLLIRbVk4lgqi17lzjTqHa770LE+l+PSToksuqWeEZDUuvrsAEexrQU69X5BfzePdz9f4myBi8C3cdUtrOPsDsPjM6RX03W1zLWPKZAgBYsekB/f51Yq3EHSJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rw1vIfWy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rw1vIfWy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxSpW4Rzqz2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 05:32:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4CDE860128;
	Thu, 16 Apr 2026 19:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E8AC2BCB0;
	Thu, 16 Apr 2026 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776367969;
	bh=92ERkl7IqZ3D3ZBskV2Dg9cLo0xCsyjyPbt0J7jJ1bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rw1vIfWy5g39RTrQBVfk7P8+0yZErGWNG5UA9/vEtpQjlFkvwDTSfy9DcHen7/CI1
	 yvB26rPsstyEixHeRP2kRFTYsbED9hoqdAx8pp9JCjVGtqsECj0BmLbEADz/j0Ea1z
	 cuKaCVwjWLvXDg/CryubhnWhKyfuiuUjmH8fhvqeL/w/0cvoWWHyuhgdCpeuqDPtkC
	 KhOKnJGX3lMBUei6zDvHwn/e429dg5HpUaKZZFagDf5a9Cwpgy1mEmtIvUBtm2UV8a
	 d3rsfZkg4WL5nt8ssrtLumcRxpUUuH7CR13mk1NCsH3yKQQbT7v7wh+ISgR1TJLd7z
	 vH5LnF1y8pygA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, Bernie Thompson
 <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso
 <tytso@mit.edu>, linux-ext4@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco
 Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
In-Reply-To: <0758843e-8f75-4c82-b9c0-25fab502e62f@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.045532623@kernel.org>
 <0758843e-8f75-4c82-b9c0-25fab502e62f@kernel.org>
Date: Thu, 16 Apr 2026 21:32:45 +0200
Message-ID: <87v7dqem5e.ffs@tglx>
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
Content-Type: text/plain

On Wed, Apr 15 2026 at 08:43, Christophe Leroy wrote:
>> -typedef unsigned long cycles_t;
>> -
>> -static inline cycles_t get_cycles(void)
>> +ostatic inline cycles_t get_cycles(void)
>
> What is 'ostatic' ?

That's a really good question :)

