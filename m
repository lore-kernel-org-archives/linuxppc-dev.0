Return-Path: <linuxppc-dev+bounces-22584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4BCD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 19:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcTzT68LLz2ytJ;
	Sat, 13 Jun 2026 05:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781292421;
	cv=none; b=NdIBBqDpIkXqzEy1t9PG+LyiGzXTYAPeD+d/4I91F7Nkdt1427LWNfZ5aiSxk9jwyh5AvvkTVjiX/gWU+6oXAMZe82T0SLE5dAuoXEZ/xPiQZcS7QaqHrw+P4g5dqQ/QNYdoeDSoyZg4N5+yXuSb4+yRnQxzv233crrXCpjgpPEBFpltgvzvleBjjxjaFV7gjcoZvRPRi8KArrX0WRvrVgTNQmbU+WdtBYKj2ZkT1484U44RH0sBeyOOE562C86Gz2Bo+LVHt4xQ3HLK6BXOKA29DsWSYjT7XnP4ojh4cvtn4dFRYLWvGeTxxzaKwJZuIBpy2zAvVqKwHDIHnq1oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781292421; c=relaxed/relaxed;
	bh=HH2moNpZWt+XN8tXRSKqJX51PwUlhD/ypigBEwKqVGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2FcKjQ8m9pUF1suaTuY9zcY1216SL2/XEvcKzmrwFDlyhX9bBP7OVRsO4XCzrP1N9rAmMI+O8lRgPAbTbkh1x8mAeHLjGcM369awylQmbT0c3XqZ7xclPNrlAKb00HH6OKgijdzK7rRqqsmCx9UJL9m0nrBZvfXpFab2ZIZY9octWFVr2+0OqPN02ft2sObPbfrpwS8CcWetN8P6AZi+9BjpCEkPet2a0TjVPvGzX8qYpcq0t0rsFk/LDP7iDnsF9C3Xwiuirtw/nktb3uRp7ODkR8DUcHZbwPyCMEUqQ/1I1Jd7VcHuUaFVFyiblRwCH4J/BfL6b+lf0AA1VjKqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net; dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=B50uc+n8; dkim-atps=neutral; spf=pass (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org) smtp.mailfrom=lwn.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=B50uc+n8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 578 seconds by postgrey-1.37 at boromir; Sat, 13 Jun 2026 05:26:59 AEST
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcTzR5Vfwz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 05:26:59 +1000 (AEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A346640430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1781291835; bh=HH2moNpZWt+XN8tXRSKqJX51PwUlhD/ypigBEwKqVGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B50uc+n8SBBYjg70I3kRVsmnmUKcnKuIrmrZCYuEnV3ObcFO5GSJqKiwUjw+b9NZ/
	 MYYeaKnItIe4jFDsrzZRiitkI4duonYB0L/MFQ+NKKZhD/P8vVuDH1Evmp7kPiWpRx
	 z+eJ0zrEtOKFZUpGe1ifoAqueR1sWKsRFU6pxlWfXd2f8NNJK/WiDeFcJtCQAgQt59
	 OlU0HBB9M/QY4VXufYDWDqtngGEYtwcRJK+60SVzbpF5DhDJ0nFfgVzQ2fav/4jvQa
	 cJtNDppeMCYjSGOl+QiCeQiz9W2C2arD5leaSg1eN5b/PCtgWv/nmQZ0TwouTRAgbh
	 1MkpAqIRQry+Q==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A346640430;
	Fri, 12 Jun 2026 19:17:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebner@mailbox.org>, Vineet Gupta
 <vgupta@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE"
 <linux-snps-arc@lists.infradead.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, "open list:ARM/SAMSUNG S3C, S5P
 AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH] v2 Documentation: arch: fix brackets
In-Reply-To: <20260612095432.177759-2-manuelebner@mailbox.org>
References: <20260612095432.177759-2-manuelebner@mailbox.org>
Date: Fri, 12 Jun 2026 13:17:14 -0600
Message-ID: <87qzmb7emd.fsf@trenco.lwn.net>
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

Manuel Ebner <manuelebner@mailbox.org> writes:

> Add missing and remove needless parentheses, brackets and curly braces.
> Fix typos.
>
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> [v1] -> [v2]
> "(i.e cache geometries)" -> "(e.g., cache geometries)"
> "Excer[t" -> "Excerpt"
> add Reviewed-by: Randy Dunlap
> fixed my own typos.
> ---
>  Documentation/arch/arc/arc.rst                 |  2 +-
>  .../arm/samsung/clksrc-change-registers.awk    |  2 +-
>  Documentation/arch/arm/vlocks.rst              |  4 ++--
>  .../arch/arm64/memory-tagging-extension.rst    |  2 +-
>  Documentation/arch/powerpc/vas-api.rst         |  2 +-
>  Documentation/arch/sparc/oradax/dax-hv-api.txt | 18 +++++++++---------
>  Documentation/arch/sparc/oradax/oracle-dax.rst |  2 +-
>  Documentation/arch/x86/x86_64/fsgs.rst         |  4 ++--
>  8 files changed, 18 insertions(+), 18 deletions(-)

As Krzysztof pointed out, you formatted the subject incorrectly, meaning
that the maintainer has to clean it up for you.  I have applied the
patch and done that this time, but please pay attention to the
formatting in the future.

Thanks,

jon

