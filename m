Return-Path: <linuxppc-dev+bounces-16120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12352C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:41:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxY0V3xdwz2yFm;
	Thu, 22 Jan 2026 18:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769067690;
	cv=none; b=DKcN6+AdXjjvjK614iuxOV5dob6QLixOJKlrADuKJNl2hLiZYAnH6x4zNw3/CF5u3S+AmXVSYgiylz+ky87lV5ik3hHR8WgG7a+UV8TQOXKG+ksMK/KNpUFy4Fh8fzYvOT9tOX7Ad+0CHXmC8F+OgdkoDj3nA+gAhdi0084QKtE0Inf/9g/Z4ZUrnjAwqg30cgF1u6eYzU2Pf0BzDnO8ghnq1Qya5xsWDa9AVt5jXLDwI8szx6XyB5CjYqV3EjwyM1JP2KwC1pVG9obUFA2CmCdOjcnfZCeRa58ZEeZ9RdDlDAti+VN1od31FY6JWP2YxsXOmQxBUn92om/cATkxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769067690; c=relaxed/relaxed;
	bh=o+K1nz8y5Bf/1T6bqzkD9pfCGI1/67o8cFgj0q1TILA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chVfRUpCC/x+taJVEoQ7ikt7zqgY50GVGIx2cKhrpEFSL+Ml5+sF9C70kb8ghhtTm6d1R0dhnKLKOLdlr5Bh03At/XvDvY6Aeokx36TajdWtlad53NOMhmkFSzsyw6iGStxX6k7JiGEu2uJ1Q+sQXu3kUQQ3RaFrTFLJ0dURNOgooB9/0CrUpmWlGisI+BGM+SNEO1AV45X1ZZlEtZ2/MHvNxxF83O0JVXRQmBcXisfvRpWg1kVpx2UmkbbKpUq1JXbFNYezDFJ7WFgfiYCUsmcbPL0uirEcGeKl1y9YeNtFTmpd+2L4cgcarVkd3P8qjGwmEO06SC5t09gkxKSxxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=CKaSYs0M; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=CKaSYs0M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxY0S70BKz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 18:41:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=o+K1nz8y5Bf/1T6bqzkD9pfCGI1/67o8cFgj0q1TILA=; t=1769067689;
	x=1769672489; b=CKaSYs0M8rqbYjyDNVr3Si9n1DeKO6TnjsduCpTUrdqHibxlZDQGIhKU8nWes
	rbSYNw4Hfuvmha2Umz8ksPKopSjk0vY3jMRcJXPutJvoUyc9aNb5JKhFwJmoEvuvOtVoFFrSF2zEr
	B63xIaLmJC4IUajlYkfbko9ZItUQsZv8kC0J0pc7qx+lYW8j+V9RlqbIpuipz9EbQzX2dgTiIPfDk
	mFc1/RLDNXtTRSIRg1Y50UFwfAXppkcHocQa0mKrEYiWkMBtNqz4U/HVKjs6N3JV3sXgJnA5fP0e4
	0Gk786UtMn9vsFrMqYKXHnAvfM0ud1zS5GkP6kMPDO7fLkQd9w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vipJm-000000048P3-01nK; Thu, 22 Jan 2026 08:41:26 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vipJl-00000002E62-2uQy; Thu, 22 Jan 2026 08:41:25 +0100
Message-ID: <724d6382e2165caf71c457af39329a95f4ce96ad.camel@physik.fu-berlin.de>
Subject: Re: Github tracker for PowerPC issues
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Trupti <trupti@linux.ibm.com>
Cc: debian-powerpc <debian-powerpc@lists.debian.org>, linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>, gentoo-powerpc@lists.gentoo.org
Date: Thu, 22 Jan 2026 08:41:25 +0100
In-Reply-To: <7601fc49e07533b891609ec72e315db9@linux.ibm.com>
References: <f80cd9f9b91966862ece4bb270460198@linux.ibm.com>
	 <1534D914-DAFF-4008-87ED-E887BA0DC070@physik.fu-berlin.de>
	 <7601fc49e07533b891609ec72e315db9@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.95.41
X-ZEDAT-Hint: PO

Hi Trupti,

On Thu, 2026-01-22 at 12:44 +0530, Trupti wrote:
> On 2026-01-22 12:25, John Paul Adrian Glaubitz wrote:
> > But I=E2=80=99m not talking about Debian-specific issues. Tracking
> > Debian-specific issues happens in Debian.
> >=20
> > When I report an issue in the GHC Haskell compiler on PowerPC, it
> > belongs in the existing tracker. Doesn=E2=80=99t it?
> >=20
> > Adrian
>=20
> That makes sense, thanks for clarifying. I agree, we can use the=20
> existing issue tracker for this.

Thank you! Debian-specific issue will be reported in Debian.

I'm just tracking issues there that affect PowerPC in general.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

