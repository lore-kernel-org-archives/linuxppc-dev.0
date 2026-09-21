Return-Path: <linuxppc-dev+bounces-27835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF279C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHZd3VB6z2xk7;
	Mon, 21 Sep 2026 19:13:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981993;
	cv=none; b=mCFbGtebZOBzJiSCkFRzfLpXhPqQcuawtWtSucOd6YzKwraSZ4E3/gujHTBkuq/7WilPu8Km01IH+s3RYxydLUp13TOwXhBRVbdU0s11Ca5Yqwm9KmrJZbopE7uungt5ybQihQJLyrU4YLai2locsooS0K7fzMHvMuqL0M8rZnYmysXesHApMESaHLThwzEdQGLmNCUoJZAIBlmBPZgMiiSG5Gw/hxfNt5Zs9vXZ3e8LGkNtplEo8YHIIrBEkAfMeA4GPUxbncZ26HcdDmPR83GjOnbh9xdnT3iP8o/7w0Xpp7Vodr9E1kAVt5MvfDuil6Jsh/d130bxdSX9XLnK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981993; c=relaxed/relaxed;
	bh=P6ZIStLe13F9+IEhFgWAmfeV8KvN9bBmU0oNpKNZKz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D574gO1U+rY7HaVh0oEJ4GHSfuRV9fCXuKYHsMtAdInxaBmTni5GWrOPShph4eiu1zRtRElQ7RHqnx0z6A4bQlRo87izJlRPy36inqm1RXJfQgoO0JJVESNaydwzsLX2u2wD+1kyl9Dj9gJQkcPktgl0n7V+BU7gikeHezWry2RHXKDWOQ6Y/ckBA83S8mfeTWtjsBQP7zj/OC/cMgv/77RZSObhbWI4Sd1xermqnkYpMwjMpSlTiNhTSCL/XMQqWnXiFETu83FUS3cxthm0RV3U3y6xL3vhaNCRAjk1ZLE3XLyLmGWSg1c/lx1wJxn3ZE1PWHZK+gr1l7Oqo1Bxlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PppuWxQJ reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PppuWxQJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHZc4TgYz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:13:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C55B0447BF;
	Mon, 21 Sep 2026 09:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0A81F00899;
	Mon, 21 Sep 2026 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981989;
	bh=P6ZIStLe13F9+IEhFgWAmfeV8KvN9bBmU0oNpKNZKz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PppuWxQJKHoapfcOZ30hzQM6stx9pvdYb0iP5RCVos4bWWyMp2tUc+UKk78wNflkr
	 mAcR+1udALmuvYeXt3XZ68KLQruIJp5QseLO8HmvvZRjI50jC3vPIw76Z9/rQ1BdL7
	 Tv7UqqrkClXkDZgXM27TcTKF74zd419tu0rkSqQKNbbOXP5lyJXxkwhYciODTmZqoP
	 dRuKoxXt/D0AtemjRV1cM6kg3SBzTbtbGCqWys71V/5YyBHFWj9t1EWpxhCEAjNwUg
	 OfFRkvzI3+0ZHWw0TJjJ9X3syCl+J3H2W+X5qUE6Mf95lC+mJKuoe1BZvZWZqJb654
	 G4GynZC1CxzKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/14] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: npiggin@gmail.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	piliu@redhat.com, guodongtai@kylinos.cn, will@kernel.org,
	eric.devolder@oracle.com, vishal.l.verma@intel.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, bp@alien8.de,
	kai.huang@intel.com, chao.gao@intel.com, robh@kernel.org,
	seanjc@google.com, dakr@kernel.org, pasha.tatashin@soleen.com,
	kernel@xen0n.name, rppt@kernel.org, zhangtianyang@loongson.cn,
	hbathini@linux.ibm.com, baoquan.he@linux.dev, james.morse@arm.com,
	thuth@redhat.com, loongarch@lists.linux.dev, yeoreum.yun@arm.com,
	coxu@redhat.com, chenhuacai@kernel.org, akpm@linux-foundation.org,
	kees@kernel.org, jbouron@amazon.com, pratyush@kernel.org,
	me@linux.beauty, mark.rutland@arm.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, sourabhjain@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, graf@amazon.com,
	gregkh@linuxfoundation.org, liukexin@kylinos.cn, x86@kernel.org,
	mclapinski@google.com, ruirui.yang@linux.dev,
	takahiro.akashi@linaro.org, hpa@zytor.c, om@lists.ozlabs.org,
	rafael@kernel.org, palmer@rivosinc.com, dave.hansen@linux.intel.com,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, maqianga@uniontech.com,
	tangyouling@kylinos.cn, bgwin@google.com,
	driver-core@lists.linux.dev, catalin.marinas@arm.com,
	tglx@kernel.org, mingo@redhat.com, leitao@debian.org,
	linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-7-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:13:06 +0000
Message-Id: <20260921091306.BE0A81F00899@smtp.kernel.org>
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

> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>=20
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>=20
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D6


