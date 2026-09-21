Return-Path: <linuxppc-dev+bounces-27839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6107FC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:15:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHcy6kFjz30RN;
	Mon, 21 Sep 2026 19:15:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982114;
	cv=none; b=hUZQ3jKWOuCuyVPyF3vw9QTYgmEyg014/HD4oFFkr0dfUbNQoxfdlBwa46uhHPWazIb0KT/urqdxk8JANAK7bFb7rXsQcdV6NzuiOUPkkjYy9sAxBoCkb7MirIzXAmX/JeGv+oGCI8Y28WjSaUa9NbKKQ2etJbEAC+c7tQu6ca4+t+sRyI6M5qTubgw6Afvra3Qw2t6mpgRnCpPyS828iShEdNsnzvWX4VgBRfuzLf9PJnREM9qGL2PSC306TsIOMw6iY5iTipxKqmfljNOpq76yPk6FVohXR28RVoABJV1aLXX5jrOKJwQd71oOPBBQGlba5jozPJOTgvONfg5wew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982114; c=relaxed/relaxed;
	bh=3ZanDre/sxM7yOn9EPACCus3LOsx6cj95+yc4nBcgzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lINLhKiUHcxr+P//kKFWfaZ0jltWyP3ohewy18hU9fR4ejUQCrir5zhvfBo1gHmtabVfue/Im30BiO3ZFoNTVXvw30+YmtzAe7dwM+5b8U4RUhPK8hauGM8k9JcfuliwMjM5jHB2oauS/4Yq44JFVpGUNlbvbuNL5s6yXOuKz6foN0EYOroVBPC+XNAVzLbuS0dUuDGFDo9vEhhoR+DFU9tyVqpKR7mLzLZDyEadOdWiExNEg3alRvw7Teqql+NS9gFHjAc/5R+rNycD793cdlNnRKxdk+w+uKurSKtD1rAFTCChVJ93C6x8OnFH9DUtKcYds2HkpKHqPS1yWkk6AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOEN+RoD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOEN+RoD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHcy1HWsz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:15:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 964354029A;
	Mon, 21 Sep 2026 09:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A930B1F000FF;
	Mon, 21 Sep 2026 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982112;
	bh=3ZanDre/sxM7yOn9EPACCus3LOsx6cj95+yc4nBcgzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOEN+RoDDK26gDP5B5Z9LlLZO1s1nCn5eg6mIuaCu6GgNZmdhLQxLNmwagQJw3jNZ
	 HSTQKCve+9oH2k8A8MzFqJ15CxKt8vEI7iKnmIVQDfJqq1n7HPsA2n8TLYeSCy0aiN
	 FpDbwb94QreklK9goP5shle0U5QXsF6FQ01poX7/gzwPVreCPhjjIvl7Uw9RSL93Iy
	 GF6JPlRgde+gm7ZRr0IwEGKaUN5B90anrRojkn+vTBJ4R+6PruEi9YQMY32D/IGpJo
	 29xGW3a7rZhzUio5PLTxY6Wlb6TkskdZxe2IUURQwsc33w61NyfOl8XPq/R3ZUEKk7
	 0Dcdsu9FyY3LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/14] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: kees@kernel.org, eric.devolder@oracle.com, yeoreum.yun@arm.com, driver-core@lists.linux.dev, hbathini@linux.ibm.com, me@linux.beauty, rppt@kernel.org, jbouron@amazon.com, hpa@zytor.com, linux-arm-kernel@lists.infradead.org, dakr@kernel.org, maddy@linux.ibm.com, tangyouling@kylinos.cn, will@kernel.org, mark.rutland@arm.com, dave.hansen@linux.intel.com, sourabhjain@linux.ibm.com, catalin.marinas@arm.com, leitao@debian.org, vishal.l.verma@intel.com, bp@alien8.de, guodongtai@kylinos.cn, zhangtianyang@loongson.cn, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, rafael@kernel.org, kai.huang@intel.com, mclapinski@google.com, piliu@redhat.com, sshegde@linux.ibm.com, thuth@redhat.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, coxu@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org, chenhuacai@kernel.org, chao.gao@intel.com, ruirui.yang@linux.dev, bgwin@google.com, takahiro.akashi@linaro.org, palmer@rivosinc.com, seanjc@google.com, chleroy@kernel.org, liukexin@kylinos.cn, pratyush@kernel.org, kernel@xen0n.name, james.morse@arm.com, maqianga@uniontech.com, npiggin@gmail.com, baoquan.he@linux.dev, gregkh@linuxfoundation.org, akpm@linux-foundation.org, ritesh.list@gmail.com, graf@amazon.com, tglx@kernel.org, mingo@redhat.com, robh@kernel.org, mpe@ellerman.id.au, pasha.tatashin@soleen.com
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-6-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:15:09 +0000
Message-Id: <20260921091509.A930B1F000FF@smtp.kernel.org>
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
> However, during a retry loop in image_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segm=
ents fails")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D5


