Return-Path: <linuxppc-dev+bounces-27714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB3C982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:16:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT7Y1cJbz30MZ;
	Fri, 18 Sep 2026 20:16:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726617;
	cv=none; b=Mr2t1P4UvNrYY/m0j3dkjo9Y1PMhFQXViQ4lhp0pzaZsFc+ClZRy3V0DzHsAVTfTsnKRaf4Hubzm29MVTTgUSaNkFHrzF6duUT+rc4nAmP+GuufMFi/VVjpoiA7kXnYzzjbXR5yaKHP2+VuVfRh0y+wY9fIq6q4vgVhL/CSHr5X3JJAARzpylC+u91+ABE2pzh381e66lnsqA6ZsimpEcKbAUyfeXnipZZqUaAk/ArRPnl8PMTfu9lGPBdIA+jDN3gQlOyqsKET/abXGrN7GZlhfvIztV619356+JxZrZSAOS3cvA2sgS+LULwOvyauL1PHt8R0n5gWKF9qhaPCvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726617; c=relaxed/relaxed;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgpTyZP4Id1RGTic2eDyeIfsI63PLzSXQryJzvlFEpIyiffR0OCWdo2f0Cz0/AzqLHy5iJjhKjsQbwV8+aXIWqrDPIka0NBZmtNqwleUsE179uCnJee/A0NprgvLBZoUXygROVFGYyVsf5bXRylqBhE5oClf38pidCfpCPK8GmqSPP+uWggPY3GUEZBVQiT4XEf3GDfh3JFlCbNRH+D20TkXwwb/A+EuE0voXghAfBECrBEcgNFeCSAoUMUXBT2pTvYprGAeqVNV8wglkykDN7FNoEYfovMQuyhzs8LwZzu8wWUFKSFBEEwMi98kRQZnSUSVlDArcg6QlUFAvF0A5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9JXfNnK reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9JXfNnK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT7X0rqmz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:16:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DCF560A5F;
	Fri, 18 Sep 2026 10:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC741F000FF;
	Fri, 18 Sep 2026 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726613;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9JXfNnKptQjjq63WxDdIuBBUCCL146Poh1RSC+XdoWWB0Fy9dhH0a6kLZUmX1w+W
	 qF3REZ2mxGCNIiOaSwVwjNNaV6NjoRH0sNjvZWq3XRPs6dKW4AZDk1Yede6r8fqzyx
	 o80qLR6AMuSO9xrYinfK9dWCY6zzP/z7rF1NstRvN9oRwP7A4igRkbL4/CMivPIyT9
	 wnnCcsZ+tEz1MqTHyJ+d9y56CfkfVre+2Dy56b5WhLwcyAKGultFUGWzcdJ07WiKeU
	 rZjGFcwvdwgNrDGSmopMB7dJJ/e/9den7VyfEVj7fDrOGtONqMyz83JtmkWwNL2swS
	 Lx0epawLg3Kpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: maqianga@uniontech.com, dave.hansen@linux.intel.com,
	dakr@kernel.org, pratyush@kernel.org, vishal.l.verma@intel.com,
	mark.rutland@arm.com, hbathini@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, kernel@xen0n.name, mpe@ellerman.id.au,
	sourabhjain@linux.ibm.com, eric.devolder@oracle.com,
	linux-fsdevel@vger.kernel.org, gshan@redhat.com, x86@kernel.org,
	hpa@zytor.com, lizhengyu3@huawei.com, kees@kernel.org,
	adityag@linux.ibm.com, ruirui.yang@linux.dev, yeoreum.yun@arm.com,
	chao.gao@intel.com, ardb@kernel.org, piliu@redhat.com,
	graf@amazon.com, james.morse@arm.com, zhangtianyang@loongson.cn,
	tglx@kernel.org, will@kernel.org, rppt@kernel.org, rafael@kernel.org,
	pasha.tatashin@soleen.com, thuth@redhat.com,
	akpm@linux-foundation.org, blum@kernel.org, palmer@rivosinc.com,
	coxu@redhat.com, linux-arm-kernel@lists.infradead.org,
	chenhuacai@kernel.org, robh@kernel.org, seanjc@google.com,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	takahiro.akashi@linaro.org, bgwin@google.com, maddy@linux.ibm.c,
	om@lists.ozlabs.org, linux-mm@kvack.org, liukexin@kylinos.cn,
	catalin.marinas@arm.com, chleroy@kernel.org, mingo@redhat.com,
	ruanjinjie@huawei.com, tangyouling@kylinos.cn, jbouron@amazon.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, gregkh@linuxfoundation.org,
	leitao@debian.org, me@linux.beauty, baoquan.he@linux.dev,
	loongarch@lists.linux.dev, npiggin@gmail.com, kas@kernel.org,
	mclapinski@google.com, guodongtai@kylinos.cn,
	driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-6-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:50 +0000
Message-Id: <20260918101650.9FC741F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D5


