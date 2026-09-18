Return-Path: <linuxppc-dev+bounces-27711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A5C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:15:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT5p4BW2z2yhP;
	Fri, 18 Sep 2026 20:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726526;
	cv=none; b=Mj1dadM5/4eU/Wey/nD/dI9ZNSSEl+b3kHwD+zZ842unjXPiJxaKlTp1vZtd78fKiaIpShbykmXCK03QAjZrxf/1NAr+YoJpRdZUeYNj0YfVroXGMJtFvUxo9BcHIGGY9i4xdC4BlLyPfPpHCcDPmD9dUrpNXg3QXoKhd3zNiJ4rFFYqdNeOf+An8alwdRMxdXMA2ra1pR1T0AhpPTWK2wv8fT3d3ybhpp7Qqv2r4S7dYaRL5deijkCRfd0FsWY3H062LgMrXTzEwDoEgfU9JdfEdLXmU/3JlNek9iYpeoNjDMwbCc88IjJIn8Y47HyHLMIr6xmHR28Gz2qYSAO0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726526; c=relaxed/relaxed;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HS/SD5LCNWOyljH3/5RkP4HJTfGH9Te62xDT6ZzijW+hZOCLbmhz+ewbjozH3A3Y4CdmV8FUoPSYLCr5Lf+V8+Kj2prl1iL5wtQ+qFoTW6N10M5M95Pzxcd3JcWXL4afBUjRnmRvzD4pn98gsc5oX1e6JxR0msRbi2tkEZT6lF6s/vIXNI7ZHkJCeg0B9aSU7L2C4jBR8ThZua85MzGcdUOvS9u3i5llmEQdrw815AxXuJR4wE592mDRjcylZK3zDaeNQsEFZxHD3FW0ijcY00WMtVgvXGCTrGtiTg0ew6DeWa8hck6JdoqndFFtEYWawN+jQlyMYk0obK/rajAkCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYMe2VxQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYMe2VxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT5m6lRbz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:15:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C2E2F41B02;
	Fri, 18 Sep 2026 10:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48821F000FF;
	Fri, 18 Sep 2026 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726522;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYMe2VxQKqjM48Qh1JiWT2P3UEJVuCac8ysLzJ+dZag32Ft9bAVcpGOMZ4HScYKSA
	 LrzLpuhoEMI3GtAYTsLW4jh/gRtnUoW+N9rRyYlYOyTXKJIrjz1QkFNSAmTri9KxtQ
	 YgAizPYMs6Pk+zAZ7x1uzNN3yUFr4LYNxPNrUJBDLylaSStamwvu6mgyHmTx6JLyky
	 SPUYmfalqSRbW2mY7QLXGTOAMq7KZrFu0mnGpoTqq6Cjx1Umnw5Hk54MIt5dBLGeyO
	 rCce++XRc1mltvKKrrut+TtgQ5n+bH85UTxblml2GEicEU8TJBSTEJtZaIOC4yTjcM
	 xr7wJo3WI5ZMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: ruanjinjie@huawei.com, graf@amazon.com, gshan@redhat.com, pasha.tatashin@soleen.com, catalin.marinas@arm.com, tglx@kernel.org, pratyush@kernel.org, ruirui.yang@linux.dev, linux-arm-kernel@lists.infradead.org, bgwin@google.com, palmer@rivosinc.com, mpe@ellerman.id.au, hbathini@linux.ibm.com, hpa@zytor.com, sourabhjain@linux.ibm.com, robh@kernel.org, adityag@linux.ibm.com, zhangtianyang@loongson.cn, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, guodongtai@kylinos.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org, me@linux.beauty, x86@kernel.org, ritesh.list@gmail.com, eric.devolder@oracle.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, coxu@redhat.com, rafael@kernel.org, jbouron@amazon.com, rppt@kernel.org, tangyouling@kylinos.cn, maqianga@uniontech.com, sshegde@linux.ibm.com, kernel@xen0n.name, dakr@kernel.org, thuth@redhat.com, seanjc@google.com, npiggin@gmail.com, vishal.l.verma@intel.com, chao.gao@intel.com, liukexin@kylinos.cn, piliu@redhat.com, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, kees@kernel.org, baoquan.he@linux.dev, james.morse@arm.com, yeoreum.yun@arm.com, dave.hansen@linux.intel.com, driver-core@lists.linux.dev, ardb@kernel.org, gregkh@linuxfoundation.org, leitao@debian.org, chenhuacai@kernel.org, kas@kernel.org, loongarch@lists.linux.dev, mclapinski@google.com, bp@alien8.de, lizhengyu3@huawei.com, mingo@redhat.com, will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-5-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:15:18 +0000
Message-Id: <20260918101518.D48821F000FF@smtp.kernel.org>
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e4 ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D4


