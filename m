Return-Path: <linuxppc-dev+bounces-27841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758F4C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:16:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHdw06b6z30RN;
	Mon, 21 Sep 2026 19:16:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982163;
	cv=none; b=gTmipRxZXWmh20MpNYiQjghP0PtRzr7WvYOMkSWpBBuFIW3S3jZXCNQotk19+SRUhRYS1v0akYaoV9mypqEc2uqTBLl0oyxKCiOHBYTQ7T98rOd8dc0nVqM0+EyR1y0XvtFdWjD55HyiVJkcbsDx2NkJ11hULEghrpvLb6z7WxegRztMSCoyEjip3qO0zGzT4MjSKfuuD/rEITftWgc4yEMdqqnbwVvqc+o0ReXKJzoLVFUGrswIoqTkrc508W34r48pifsqmL0R1njRYXFsj+WoNun5mA3PC5GpveJ4Mp35vEyfPebsg4X2cYJrINkMI4h59GouMBt3l8rmEdm7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982163; c=relaxed/relaxed;
	bh=iKFnnUVgMFXCyMZXDC0Gp9g2hFUBByCOSHmRiQGpkGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VFmIWOgi8VFcojnyh815YvadFZkjWSZo9gJZOzl5xgnudktN+97rt7f9z0cydj+Bstbw4PDP/weNWcFPfjsHZlBLT0dZW4v6XaSlpIe4SS/4GmjL6TVQxJlW+xRh2ShwBBb5lepe90vR/8Dhw8sD1NTqqfnWC2+yVGyONTwx2wK9rIgXZRNrHbigpkQJNUirJigHzsoC1Q3pW1B3Hld3cXGRfM0LJoRqI4JpZPvfa9c8FqFJ24Ec9/fR5r2C0o73nYG0XrJRTBAnfO5AOic175ANp0E8fk1sLXa4Ce/qSZgKPCdL58mF07oSvzGwa8KCme/jb3tDUFtIrmR6Elr0TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHG0fA+G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHG0fA+G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHdv2Zkmz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:16:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6999B42004;
	Mon, 21 Sep 2026 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B4C1F00898;
	Mon, 21 Sep 2026 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982161;
	bh=iKFnnUVgMFXCyMZXDC0Gp9g2hFUBByCOSHmRiQGpkGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHG0fA+GVBiImiZzlsuxCmiW4QIyTR/aPZvoP9v5NylyTbUhwz4qciulTNW5LXkXq
	 K3WKoRW+fr226xkxw7R8r5SnsneEjP6Axshr6u75njSZGCXcCVluZnG9xDRpyDY6xs
	 EFriL5emiLA/XLPMxq58s20ogoBPHi1s/Ak8FZ6OgYDuj1unhLvxtbQY/CLkUuDL3Q
	 1ZwP/YXZpcRKGPEnhufv0pbrNo41MXu7WUOt6ucbymZFWiH5nhO2OL77j+WD7zsECf
	 0lyezSqj6JCNikhjuCaXKWXmVNvuRoNz090YaolbMqD14eT8wEpe3E1pvpPf0p4jC7
	 dKFuz1EbnrY7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/14] LoongArch: kexec_file: Fix a modified_cmdline
 leak
Reply-To: sashiko-reviews@lists.linux.dev
To: maqianga@uniontech.com, dakr@kernel.org, kees@kernel.org, mingo@redhat.com, seanjc@google.com, gregkh@linuxfoundation.org, mpe@ellerman.id.au, driver-core@lists.linux.dev, palmer@rivosinc.com, chleroy@kernel.org, coxu@redhat.com, akpm@linux-foundation.org, piliu@redhat.com, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, mclapinski@google.com, robh@kernel.org, maddy@linux.ibm.com, hpa@zytor.com, ruirui.yang@linux.dev, bgwin@google.com, leitao@debian.org, catalin.marinas@arm.com, jbouron@amazon.com, npiggin@gmail.com, guodongtai@kylinos.cn, kai.huang@intel.com, sourabhjain@linux.ibm.com, bp@alien8.de, baoquan.he@linux.dev, pratyush@kernel.org, pasha.tatashin@soleen.com, chenhuacai@kernel.org, zhangtianyang@loongson.cn, ritesh.list@gmail.com, vishal.l.verma@intel.com, thuth@redhat.com, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com, tglx@kernel.org, yeoreum.yun@arm.com, sshegde@linux.ibm.com, rppt@kernel.org, will@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, rafael@kernel.org, kernel@xen0n.name, me@linux.beauty, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, liukexin@kylinos.cn, graf@amazon.com, mark.rutland@arm.com, chao.gao@intel.com, takahiro.akashi@linaro.org, eric.devolder@oracle.com, tangyouling@kylinos.cn
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-9-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:15:57 +0000
Message-Id: <20260921091558.56B4C1F00898@smtp.kernel.org>
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

> load_other_segments() allocates modified_cmdline and stores it in
> image->arch.cmdline_ptr.  machine_kexec_prepare() then copies it to
> KEXEC_CMDLINE_ADDR and overwrites the pointer, so the heap buffer is
> leaked on every successful kexec_file_load().
>=20
> Free the buffer after the copy.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Kexin Liu <liukexin@kylinos.cn>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: stable@vger.kernel.org
> Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec=
_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D8


