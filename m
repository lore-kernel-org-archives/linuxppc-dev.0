Return-Path: <linuxppc-dev+bounces-19986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28007FAD3EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 02:38:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1Kz05KLDz2ygh;
	Thu, 23 Apr 2026 12:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776911916;
	cv=none; b=P3s1WbyLNkJDWCbzL4MAvGCJ0WJO+Bw46q2Bs4jBSjHhwRzCBMAxgLY8A133CZE9gKumrug8w0Okq4xzWR1iAmWRskC6CiiN0hbGcT3aVadN8m+C3a7YN3XIOGo3dOh0647b+fiZaU/f/PmlJeI6Uu8Zx12VqLFZvJyJ51GWHYefMDE362UW8sU51PTwa3ulYGkCJHzqWANr32/tKfXPnmAZ3teg/sTdjx+MIunHvI+TBIjc9h8/iJia0pt8MOooWDeBzDfrQ5reyLwlapgZRHcmb36Xcwvk6+ITk6mZ3Xu/xXNQf/uRTbFLzttZVd2JfiUJCzz7aUbd6nG9WHz+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776911916; c=relaxed/relaxed;
	bh=7HQSrbuMx/rshmSLfm00CK6rla06OEjtmcvJSRGnOjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y49YMVkAHrNiG7DpbQhJc6aXjzozcu67Qx0D0+Gi94mK1R6zBNdb9Vh4Qh4u0L/hxU19ZQo3p62EpPf5y2WtZTgAU5q8HHBMz0oTrI+PhdxMsU/xXjBk+cB5oOjjisJxF+VdWING4KZ2sHS0bO3Sj5scc7TyvcRbkF6ZvIQoOCYDCzd/92OJcBHi/LlL3gHm3pvhCRYnz1Oi1J6ijzzvVRG+Zt0uo1kMZPWvGdX1kg2jw8ycgFBs2F2w5e9bsZH2BAv4QDpGKfA/xq594cdI6Egyklc/todPwq0o1uRGn9SGYunpc/mOd3YvUPG3tiG2yqb3cxAGWwnejckeqC7ZpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=prvyABly; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=prvyABly;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1Kyz4fnhz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 12:38:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B01F60008;
	Thu, 23 Apr 2026 02:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B354C19425;
	Thu, 23 Apr 2026 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776911911;
	bh=7HQSrbuMx/rshmSLfm00CK6rla06OEjtmcvJSRGnOjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prvyABlyIBh76ipwT0Afooq3T3f6JlD/yCFjPoSCymJl3aylCSjP6Kgv6P+8HJVc9
	 7aGu7xLaYmd8MZUomu6ml+HSk0MZqBBwFhwGr6Ys73P8lChfUFlcP9g0h9xpIOyvmE
	 QOWO+F+sTBZVg7XnJOmb+wh2BQR/8m6Ry8iDoNT9Kcs4faHr9nOlsJIQj2Bai54J7h
	 VL89KdofK8lO10crs15R4zUBxqWmHokA3Fi+4ikMGqNxNLWnsOAULtv7ToMihHLvqR
	 WDzjNYdm3wHQ2ZG5wPZO5wA21ly8uYx6htZdQAgY7Zcon/Z4U60W2hPdf4RZfTXFGV
	 EZatCi46/sjuQ==
Date: Wed, 22 Apr 2026 19:38:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: davem@davemloft.net, openwrt-devel  <openwrt-devel@lists.openwrt.org>,
 Guy Ellis <guy@traverse.com.au>, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux@armlinux.org.uk, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com,
 jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
 kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
 rdunlap@infradead.org, akpm@linux-foundation.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <20260422193829.0b8539a3@kernel.org>
In-Reply-To: <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
References: <20260422041846.2035118-1-kuba@kernel.org>
	<accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 14:05:31 +0100 David Woodhouse wrote:
> On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:
> > =C2=A0=C2=A0 I'm still deleting the solos driver, chances are nobody us=
es it.
> > =C2=A0=C2=A0 Easy enough to revert back in since core is still around.
> > =C2=A0=C2=A0 The guiding principle is to keep USB modems and delete
> > =C2=A0=C2=A0 the rest as USB ADSL2+ CPEs were most popular historically=
. =20
>=20
> Still not entirely convinced; I worked on both USB ATM modems and on
> Solos, and the Solos is both the most modern and the only one I still
> actually have. And the only one we have native support for that could
> ever do full 24Mb/s ADSL2+, I believe.
>=20
> If we drop it, OpenWrt will need to drop support for these, which I
> think were quite popular at the time; there were a few UK resellers:
> https://openwrt.org/toh/traverse/geos1_1
>=20
> I still don't actually care *enough* to try to find an ADSL line I
> could plug one into for testing though... :)

I'm inversely unconvinced. The argument has the ring of "I still have
this HW lying around somewhere", which is usually what prevents us from
shedding all this dead weight code. I don't want to argue, so I'll keep it.
But if one "fix" arrives for this driver - it's going :(

