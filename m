Return-Path: <linuxppc-dev+bounces-27716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96AEC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:18:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT9r3m3zz2yqT;
	Fri, 18 Sep 2026 20:18:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726736;
	cv=none; b=mDE3b4s58DYivsqJh0EUCcuDHx5CGKLaEwTaMeT5BWwZXKXhPuX2e4xZsYcP7EwIY8bWVX9Z8DZcZVUUPx2o6wHHSZLlaoADkyZ/K7ptOYSaWETG4jdwx4uby7VCs4Np/3YoCec43BCPE2NrqP8sRZ9wYRcdFMPIsfZjyUfsIAdpB96dEpOSsOHmnbf+//Pzih3SShs033slqoqmGanhCMol8v5twVe5lsrA5jNn4pWNn1RJWTdaAaons/D9XJP8Xq2wUYPsG7lsj/+dwEF2cTrnpJHYAHXmF/RKNnXr1xAc+q4fLYAtL+8hh0dIWbayfqgOcaWyW6pa4InQ6/lAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726736; c=relaxed/relaxed;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HymzyvHX/iu32MS499mDSJX8Uged8OXIqtYWe1OW1pZZXd/3QUw9E3jOUEVN8q7BuQwjyiD+oKSr84kFpc5nLK65A2RsBJdfHlKf6bLITSmDQDFB9HOQfKlSx8LGsMLbzKHkaVfm1156Dp5zpmumNPKdVWixmAGWMc0LQPr1JuoT0TUMidkwK0LHBYo/q5WZ70u9EDwwt6hD3QJXn9zMsV4Vht6+55sl9PSpDHb+S2gO/MBnONOIMNe+8j4uRg81Q+WlnT8F2wCpI1+HUcGm4z/P2yO2Fn+ohbwfPw86oZ2FvouKYd+VRnwnFfiK99Q4XPz44iBYIld02CbcdiK4lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj1qm4nu reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj1qm4nu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT9q67Xkz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:18:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02C8C417C9;
	Fri, 18 Sep 2026 10:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1441F000FF;
	Fri, 18 Sep 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726733;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lj1qm4nuzvY02T7ZQm88v8594RzQxLp2GRkXbWgVVtVBvfJ+6goLRgyhIpzhTJXQZ
	 2pCDF8LvVM9fJ6fKY4+uc/wQedLYCLDrjQbRopgkTtwyv4NIZXDsJsBsWAeToGhILW
	 qd7/SMXEZaj32E8uUi5oBjPfqyGM9+5tnt3G7yuecWX/qsPGerXYb2JIpM5s946iF7
	 yX0r6HiqXBjOBn9Vf8OIhbAyKlBkfCZ5xjd2UdjefGRfUDGraENXigs62wTGvXo/Nl
	 LkzE83NwKAHUJdQRZdZ5u09Z6Rm8qLlOmfxoay4Us/G2o7l2JK4cU7+i/D/m+wP5MR
	 vk5oADV1Jc8tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org, me@linux.beauty, vishal.l.verma@intel.com,
	npiggin@gmail.com, sourabhjain@linux.ibm.com, lizhengyu3@huawei.com,
	dakr@kernel.org, blum@kernel.org, linux-mm@kvack.org,
	dave.hansen@linux.intel.com, eric.devolder@oracle.com,
	adityag@linux.ibm.com, akpm@linux-foundation.org, will@kernel.org,
	takahiro.akashi@linaro.org, bgwin@google.com,
	catalin.marinas@arm.com, coxu@redhat.com, zhangtianyang@loongson.cn,
	driver-core@lists.linux.dev, kernel@xen0n.name, kees@kernel.org,
	hpa@zytor.com, kas@kernel.org, seanjc@google.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev,
	jbouron@amazon.com, leitao@debian.org, tglx@kernel.org,
	chenhuacai@kernel.org, hbathini@linux.ibm.com, james.morse@arm.com,
	mclapinski@google.com, palmer@rivosinc.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	linux-fsdevel@vger.kernel.org, maqianga@uniontech.com,
	gshan@redhat.com, chleroy@kernel.org, liuk@lists.ozlabs.org,
	exin@kylinos.cn, "Jinjie  Ruan" <ruanjinjie@huawei.com>,
	mpe@ellerman.id.au, pratyush@kernel.org, ardb@kernel.org,
	piliu@redhat.com, maddy@linux.ibm.com, yeoreum.yun@arm.com,
	loongarch@lists.linux.dev, baoquan.he@linux.dev,
	mark.rutland@arm.com, rppt@kernel.org, linuxppc-dev@lists.ozlabs.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, chao.gao@intel.com,
	graf@amazon.com, thuth@redhat.com, guodongtai@kylinos.cn,
	bp@alien8.de, pasha.tatashin@soleen.com, tangyouling@kylinos.cn
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-4-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:49 +0000
Message-Id: <20260918101850.7E1441F000FF@smtp.kernel.org>
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

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
>=20
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D3


