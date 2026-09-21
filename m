Return-Path: <linuxppc-dev+bounces-27837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4361EC982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:14:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHbt6wpHz2yft;
	Mon, 21 Sep 2026 19:14:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982058;
	cv=none; b=hnzor2FZAW6WI1Lq+z9vZV3ZFF9rVecrA3C/70+6GZIWbvNbUi4Pxgx+BuFN+73/3goPF4iRk8TVowfzRSFvztEf9S3R1RsTcjQXcg9FkWBjIEMzYktAIk6QOQ0WwTaSZstvD8ybl83aFE8R0t4+EQZ+XYwRmeznai/kbfDaeHSDWRCVtvsgF7vpHileNtka7EDq4BklMKOHfA9c8NFgc+8DZ0kB7RFuvxG+IYiBFTzXdYfn5QHbM3VqoZn3LRl7AN8Yx5zGRlfwpcpQ5HGkEP99gUrOKWozSFb1ooVCOResy9LFdGZJaIer9dL3dCj1HPbhipcHRa9jzGjlTplMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982058; c=relaxed/relaxed;
	bh=Ypk197u83QsJkKLOBorgGsgBYWL8I8pOcxYcooVQIRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPZcBXoNrYJyuJmsDKPKVMlGhX4kfn92DGbhb+DRlXKE1CCdYy8nTrHL4P43WI+6IA72O95C1NqL4I0nBsafI0UoAcPKh4ewhJfvEnVP7XYL8jdtzSgZFFT16qDyKH5lXTGYX1zQnVmjdpkPV2u3qxrcHa4x4Mhpy+caw4+OgnIAn/EsAHBkAf33+XOwsNsnpVftrPV0tnGe17ji2qIRpdLSwGKIc3GYXVSH87WYVLGbPQLrXNq/AhtKpFDDqBtKtc0AFxao3MUG4+SdlBQ5Xv/L/gF8gPVdOzflYN+I4KxNSM5yWX+Vj26ziyELSyhFK106Bx4tguoBQ4rhIO1IOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVRV5Ip6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVRV5Ip6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHbs6zDfz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:14:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EFE13601FB;
	Mon, 21 Sep 2026 09:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71221F00893;
	Mon, 21 Sep 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982055;
	bh=Ypk197u83QsJkKLOBorgGsgBYWL8I8pOcxYcooVQIRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVRV5Ip6eDfnma/w5Y/czw1VeMX630hiOe8uqSGXqsjooE2XeVRpukgHT2lEjnvWu
	 6fr7DPRbl1pT/tixy4qKPgbdfhGlYyRG8mVxxP2xFNh0JvBj5PDyfoXXUlBIFmZA4A
	 wfeqAXn7vlZ95v0+IozU1UxAIzm//WFXxIjRZk5wQ7PUdrDDUM00AjwNoSV4v7h67+
	 t6gcdL1zYAKxQ8SwXrjgniMvV5ehmJobw1qZvb6XreBmqT5M27b3dOBakHQLtTBGpL
	 7Qjs+OsKh7E9v3v5BGVIpCQ8aqce4Z1ksYxVuSAybhOUsiABwrrZkUDWyNB0hScgEj
	 Xg7AZ5lBqmQ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/14] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: james.morse@arm.com, thuth@redhat.com, me@linux.beauty, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, pasha.tatashin@soleen.com, sourabhjain@linux.ibm.com, baoquan.he@linux.dev, chao.gao@intel.com, akpm@linux-foundation.org, kai.huang@intel.com, mingo@redhat.com, kernel@xen0n.name, seanjc@google.com, piliu@redhat.com, mclapinski@google.com, palmer@rivosinc.com, linuxppc-dev@lists.ozlabs.org, bp@alien8.de, mpe@ellerman.id.au, driver-core@lists.linux.dev, kees@kernel.org, gregkh@linuxfoundation.org, hbathini@linux.ibm.com, chleroy@kernel.org, leitao@debian.org, will@kernel.org, x86@kernel.org, dakr@kernel.org, guodongtai@kylinos.cn, hpa@zytor.com, maddy@linux.ibm.com, takahiro.akashi@linaro.org, catalin.marinas@arm.com, sshegde@linux.ibm.com, loongarch@lists.linux.dev, zhangtianyang@loongson.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maqianga@uniontech.com, mark.rutland@arm.com, chenhuacai@kernel.org, tangyouling@kylinos.cn, eric.devolder@oracle.com, tglx@kernel.org, ruirui.yang@linux.dev, graf@amazon.com, bgwin@google.com, npiggin@gmail.com, pratyush@kernel.org, rafael@kernel.org, yeoreum.yun@arm.com, coxu@redhat.com, liukexin@kylinos.cn, dave.hansen@linux.intel.com, ritesh.list@gmail.com, rppt@kernel.org, jbouron@amazon.com, robh@kernel.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-8-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:14:12 +0000
Message-Id: <20260921091412.C71221F00893@smtp.kernel.org>
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

> If load_other_segments() fails after image->elf_headers is assigned,
> the memory lifecycle is safely managed by the global kimage object
> and will be freed in arch_kimage_file_post_load_cleanup().
>=20
> However, during a retry loop in efi_kexec_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
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
75-1-ruanjinjie@huawei.com?part=3D7


