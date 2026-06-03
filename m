Return-Path: <linuxppc-dev+bounces-21930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519DCCD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 01:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVVr956Tbz2xg3;
	Wed, 03 Jun 2026 11:44:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780451097;
	cv=none; b=YRh4kOgw1Dl1mhAdL+wyFFGbMKsoqkHfmsNmWgeSoY/c1+D9URxN/nr2XGBaho/CvL5T+njafJgJXj+QlAFActaKj+4eePNRSyjytV1Q2DDDiZ8FkVWrESGQrqZn7D0Sx2oyVKnnuUrvGGijhB/W8ELHyVH1bhH6k1GzdxKDvo9VcQ/pCVYgR/iWw/qhDJqfkPQ53kC6eWmUT817GydoJ4LhNaDsvnNIN8kvhX7F8Ga4+EYtIIm6Hb2dcg2WxJINAOrG89gln15Vy/ZHlk8fnGHo7mLEqOPieLbfJLIydHuDTon+rfhFC/bOs4NSoNtKfRIXgxqDS9WSQwPqE7RH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780451097; c=relaxed/relaxed;
	bh=Lacip953XP38N5MCELHjfXIvYfPyP7yT4lfXMiE5OM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsbhAxt355zbC0jOVDFkw3Zj6JgzlfiyCEqb0fOdarjOda8Y3oGfCNwmyI+37ADOIAm+YmqXqoRbEXy1Ru5a3sgVPlJArEKoIkx6Ksbwxxdbi0llTSWguOsIPXg/LLseJowNIP6Wb8almQVITAE1MOBD8VvBInQ5Lu8UyAIlOrr1ukHhFh5Doo43DM0x8lUDrTizy6ZQu4TY2xMR9R1LDVhHoojUIj6MzUrawZLeZTBIwMcH8mQ82fienJRoaIwqkvBmRc/cjpI37MSkQOxOAEkLrKxjF/9XaVEnKl8L0hm2goQHVCHeig7aB2UN7B9t/LiiiB/apseIrjTOLUfgUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=surriel.com; dkim=pass (2048-bit key; unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=cuK/BFQX; dkim-atps=neutral; spf=pass (client-ip=96.67.55.147; helo=shelob.surriel.com; envelope-from=riel@surriel.com; receiver=lists.ozlabs.org) smtp.mailfrom=surriel.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=cuK/BFQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=surriel.com (client-ip=96.67.55.147; helo=shelob.surriel.com; envelope-from=riel@surriel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 448 seconds by postgrey-1.37 at boromir; Wed, 03 Jun 2026 11:44:55 AEST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVVr72zTXz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 11:44:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Lacip953XP38N5MCELHjfXIvYfPyP7yT4lfXMiE5OM8=; b=cuK/BFQXO76YbSLRdTPN1GL4aO
	bg/EXyiqpmw9ClbifPfiDaRZk84cdaPjk/XRTxvKegatIQJugFlnSB8SlrYHIeULDfZweNmBaHbSU
	i9GWuZT5NQgMN6HnAm/C33h0aBDCMr4D9wZcPTiw/QW0sDiXglY/z/SHJn5QziOPhxy9WTCm+Rh37
	VzhbNDLVIpluO6oVltagX1v2REwBYWiKEHG5rlz4bkgJu9XxfVfa0KkIasONMV9Qcskg0XES0a88x
	ISwaBjTIqwRlDmKoSxPWWW3DgZfgkX7uZCZddJ44yvYLku2zDb3pxnYsvBMKwlFheyaSyC9X4Cqk7
	TU1hFTzA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wUaXX-000000001Fo-1MhZ;
	Tue, 02 Jun 2026 21:37:03 -0400
Message-ID: <5d88d3b1bd02b6583d8b66eedd9bf1fd96e6e788.camel@surriel.com>
Subject: Re: [PATCH] smp: prevent soft lockup in smp_call_function_many_cond
From: Rik van Riel <riel@surriel.com>
To: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>, Madhavan Srinivasan
	 <maddy@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Jun 2026 21:37:03 -0400
In-Reply-To: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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

On Wed, 2026-05-27 at 15:16 +1200, Mark Tomlinson wrote:
> Using the PowerPC P2040 (e500mc) CPU, soft lockups can occasionally
> be
> seen in smp_call_function_many_cond(). The conclusion is that this
> CPU
> does not process the doorbell interrupt while in a data-storage (MMU)
> exception. If more than one CPU in a multi core environment is
> calling
> this function at the same time, it is possible for a deadlock to
> occur.

Does that mean if the CPU in question does not call
smp_call_function_many_cond() while in a data-storage
exception, the system might still hang?

Not that there's anything wrong with reducing the
frequency of what is (presumably) an already pretty
rare hang.

>=20
> The fix for this is to call flush_smp_call_function_queue() before
> waiting for responses from other CPUs. If there is something in the
> queue, this is a good time to process it before busy-waiting on other
> CPUs. On other architectures this call will quickly do nothing, as
> the
> queue will be empty.

Agreed, this does look completely harmless at worst,
and does look like it would at the very least improve
that e500mc issue.

>=20
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
>=20
Reviewed-by: Rik van Riel <riel@surriel.com>


--=20
All Rights Reversed.

