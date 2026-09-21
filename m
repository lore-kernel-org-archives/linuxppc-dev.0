Return-Path: <linuxppc-dev+bounces-27844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81497C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:18:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHhC1fqgz30Lw;
	Mon, 21 Sep 2026 19:18:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982283;
	cv=none; b=LSVprbwhZg1L4v/kKcdEa7kMpXR/N7qRVely87JqxWBUEjvqNMB7zj7G8w1fMF9oHnnpA2iO5HCWlfRPbspMKdNW/R+DRCFKbrCdFIpCmmB0FW1llg5PajTkvBj4eEGFvB26VoJkgIz4heUc/FB+BpJqf8FTd1SVLE0T84YUHINUeRn4V/RG/4d2J/GRCS0YLxkQnHwcrRsy+QOijduC2AjTLL8p9r4FLQ5DLeOATeDOk1BTdt3T2XAD+1sE+GXzPwPsak9aoHZIxviRbYRxy/0edu0yZJsk97t6K6GQXWIyERG+PwYBfIPptmAON8T0Arw6w351WLQNsyzpg7bkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982283; c=relaxed/relaxed;
	bh=9Ht9zG85Yv7vBKbBbu1CVPAY2kC2RSmX6uHImGsyNrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mtOpHTrkxDt9rGFXU8bPRtVAdiBIGyNqiOibJhmlE5FyNqCIJXTvRa16mlgPbbhR0cg/eB2H+h0UIITn1qb7l6eWOPtrLDMqwRrMzJJcx9aAmWkJrHv/0Br7oAAkejjfCIRjYh5CnSwjadBIAgtDNEa7J4ykBymPDTkbt29y4XGnf6MYOg7bq6TdIhzocwjUN3AsliF9Bj5arVMlZwDKcCWKiFBEXK30FKsYqpnjeJkNsn843u8qo3rHyQzQujztISeVC2rpHhA8YaYwUVjZcfIr0nLagc4+nJCnJM9fqHkKOUOarurZa+1HPLQrN2PoiFg0OIC7g0sm4q2hddsLdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TghQBBFF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TghQBBFF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHhB4Pynz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:18:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 120AD432D8;
	Mon, 21 Sep 2026 09:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E11F00893;
	Mon, 21 Sep 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982280;
	bh=9Ht9zG85Yv7vBKbBbu1CVPAY2kC2RSmX6uHImGsyNrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TghQBBFFrE9MMw0lPBqk6tyi+qI/Y2LCJDRdECrz3HZwpozy3VrRCMsZqQxxRXloA
	 la/b90SIj/gEF8SVQNZiet4H9/RAwxfX5JfsuQr6jUbwO+V/9RntTbYiEU0XBpYyG6
	 fM1Jwy7DhPFjeKy1KRcEEqkJvuGXeu6uWhku62y2olZtEAGlHEpBZrO4y7LgDMIQ+h
	 wsffgpzifRVDr/R4EeOrazNAaFqQpVpvSPUI5SbJbYkrBn3MlN1kwuDGiTh7ktfJqJ
	 fU1bCfpfjq8dBiihAxS2e//9bTsR1+Ui/rFuIyh6Cu2yL+wAeSY/NVh53byzGHsgmk
	 BgR4rNzd+3Dvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/14] kexec: Fix CMA segment address translation
 with non-zero text_offset
Reply-To: sashiko-reviews@lists.linux.dev
To: sourabhjain@linux.ibm.com, rppt@kernel.org, dave.hansen@linux.intel.com, mpe@ellerman.id.au, bgwin@google.com, kees@kernel.org, zhangtianyang@loongson.cn, chenhuacai@kernel.org, eric.devolder@oracle.com, akpm@linux-foundation.org, chleroy@kernel.org, sshegde@linux.ibm.com, chao.gao@intel.com, jbouron@amazon.com, mclapinski@google.com, tangyouling@kylinos.cn, mark.rutland@arm.com, seanjc@google.com, palmer@rivosinc.com, leitao@debian.org, yeoreum.yun@arm.com, x86@kernel.org, ritesh.list@gmail.com, maqianga@uniontech.com, kernel@xen0n.name, mingo@redhat.com, takahiro.akashi@linaro.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, bp@alien8.de, robh@kernel.org, pasha.tatashin@soleen.com, driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com, pratyush@kernel.org, guodongtai@kylinos.cn, graf@amazon.com, catalin.marinas@arm.com, kai.huang@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, npiggin@gmail.com, vishal.l.verma@intel.com, baoquan.he@linux.dev, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, me@linux.beauty, coxu@redhat.com, hbathini@linux.ibm.com, will@kernel.org, maddy@linux.ibm.com, liukexin@kylinos.cn, piliu@redhat.com, ruirui.yang@linux.dev, tglx@kernel.org, dakr@kernel.org, thuth@redhat.com, rafael@kernel.org, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-2-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:17:57 +0000
Message-Id: <20260921091758.110E11F00893@smtp.kernel.org>
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

> kimage_load_cma_segment() and kimage_map_segment() both translate
> a CMA segment using page_address(cma), which returns the CMA base
> address. This ignores segment->mem.
>=20
> On arm64, image_load() adds text_offset to segment->mem before the
> segment is loaded:
>=20
> 	kernel_segment->mem +=3D text_offset;
> 	kernel_segment->memsz -=3D text_offset;
> 	image->start =3D kernel_segment->mem;
>=20
> so segment->mem no longer matches the CMA base.  The kernel payload is
> therefore copied to the wrong offset, while image->start points past
> it, and kexec jumps into the middle of the kernel.
>=20
> [ ... ]
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D1


