Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E238CD1292
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2024 23:59:51 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PBv8xy6x;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9ds20qLXz3vZc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2024 10:59:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PBv8xy6x;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9dr52Zp6z3d2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2024 10:59:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712275139;
	bh=wxz1iF4ORS761UxYvf38/XE0YTpsZcHG13BX3FPg1SE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PBv8xy6x6U+tozk/3ZBB4B/IhowisYGZXGi+khtUJ5c8k2AtxDr3S+spZkCdpliLo
	 N0lzxnMITtTjMsEcMud8YG1kMegImVUNpVpBoePsKuT6XnfV+sVdf1hXATeivHCC90
	 soSoR0cQYq3EEcEB4GygMi8pcuQGu1+Ott3VcrNEUQRavstX8wltWC5PzCFVxki7hF
	 PE8dqgoCsVDEFoL+DzNSkOWHtmERiPbeUm3+nuC3UL7760bITg6GUUlIFxNPoZsxir
	 dSnHOn4Qf5vaMg3jFx+HLnERfEMfhlqmgCrZYPT/oSnD06Leay3ia3K7LqKwfWTOHX
	 jEhkzE1mI1PBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9dr335M9z4wc9;
	Fri,  5 Apr 2024 10:58:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring
 <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
In-Reply-To: <Zg0yTnTswS2je9VG@smile.fi.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
 <Zg0yTnTswS2je9VG@smile.fi.intel.com>
Date: Fri, 05 Apr 2024 10:58:55 +1100
Message-ID: <871q7k8ytc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anatolij Gustschin <agust@denx.de>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> On Wed, Mar 13, 2024 at 03:56:45PM +0200, Andy Shevchenko wrote:
>> of_gpio.h is deprecated and subject to remove.
>> The driver doesn't use it directly, replace it
>> with what is really being used.
>
> Any comments on this?

No comment :)

I'll take it for 6.10, or do you want me to sneak it in as a fix for 6.9?

cheers
