Return-Path: <linuxppc-dev+bounces-27713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E4FC982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT7N6p7Wz2ypW;
	Fri, 18 Sep 2026 20:16:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726608;
	cv=none; b=Vpt+n5qpE2LpaaPfkx4zanl0lWEicmN6kwIeAmFDeCYh9Vge9/sUQ4QYrED0yNLkD0hoZjb68lT4pingCu/SPkPtHAh7E5zPn3cJaJt0kQQAa3Vngfh4wWqKxQmIjvUYNPMIbxRqA+LehVwI1fkBtUoRYPdBaAIlpob+ybuZc76JyuENSir/bxWiIeO4JF5HbuaN48OcexcRYA7HIuWZXzaTJFWGBiball4dDTe4xv8MO63qTjDEOTWiB9XhTbS/weYsI1p+ZdDi+F/1r74A4e4Kc+5ODNLodiix4MsQnAT7u2TUdHXiqzQIHjj/oNEvbxJgqq0+iwtUpyIj/yA4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726608; c=relaxed/relaxed;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iI1S93T5PYYAeJXOIu0zZL59K7MIgjIkXs8cefCLRe1GbS4Bd9KMRJOixeN6KefOj1iUFdPAS3rHkWofz8CB6wJIjHboCRctQ5/S3AglNQIGZVvuNQ+6yhhIib3QO5+xJM/xabMoCmOGxhJCbq5vKofm3V59LoAl344mJob2gwaCKo1cJqm2Gdm5hjc1ahoxyFT2lMOqtM369H0CHLHmLWMGMleIpS8e9rDosR9z3UIL95jQ6wcxPX4FV9ykux3W9TZAEOn2FKuaIUp7Tz97/R7PtYFmmfBOlAyTEjYHi1rE/kRL+/jGaV/Ed4ltidl5phREkhrS0nwL9nsxiWGIdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh+Pxjuh reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh+Pxjuh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT7N0CdXz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:16:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6584A60A5F;
	Fri, 18 Sep 2026 10:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27101F00898;
	Fri, 18 Sep 2026 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726605;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qh+PxjuhUYtQuTeeOL6D5uiL1736me4lgCC18Dyr540KpX1gn7g2viekAqDkINVeW
	 V16ZuYKknpyPGGG3APdOEwuMAA9Mi2X01p1YlM68ibSO/A8gHWKdpYguVle1KPxGUW
	 SwSHBlhTwmXypnGgRbnUrfbCkHZj8vLURNJsaxUScCCy2zq0L8WhG7YW/LanxlaQ30
	 Y9ixgrAUskPcxu43UTAsVmm1yKlQoJ86LJsqXWxWO2wBCStypE1LKZLL4qmNA3jhPT
	 N93ecpuLle22qWqJDfk1PgsNhWBnUkKlE/ktYVKnz6zp5EwRIw2pWOt96ZTKfbwF6+
	 Dj/abVCxxaFWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] kexec: Record allocated CMA pages to fix
 release size mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: gregkh@linuxfoundation.org, dakr@kernel.org, maddy@linux.ibm.com,
	mingo@redhat.com, bp@alien8.de, ruanjinjie@huawei.com,
	ardb@kernel.org, robh@kernel.org, vishal.l.verma@intel.com,
	me@linux.beauty, kas@kernel.org, bgwin@google.com,
	linux-kernel@vger.kernel.org, chleroy@kernel.org,
	baoquan.he@linux.dev, rppt@kernel.org, will@kernel.org,
	rafael@kernel.org, lizhengyu3@huawei.com, hpa@zytor.com,
	yeoreum.yun@arm.com, tangyouling@kylinos.cn, graf@amazon.com,
	eric.devolder@oracle.com, sshegde@linux.ibm.com, kernel@xen0n.name,
	loongarch@lists.linux.dev, gshan@redhat.com, thuth@redhat.com,
	linux-mm@kvack.org, sourabhjain@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com, mark.rutland@arm.com,
	adityag@linux.ibm.com, guodongtai@kylinos.cn,
	catalin.marinas@arm.com, maqianga@uniontech.com, seanjc@google.com,
	kees@kernel.org, dave.hansen@linux.intel.com, ruirui.yang@linux.dev,
	x86@kernel.org, palmer@rivosinc.com, piliu@redhat.com,
	pratyush@kernel.org, james.morse@arm.com, tglx@kerne,
	l.org@lists.ozlabs.org, jbouron@amazon.com,
	zhangtianyang@loongson.cn, driver-core@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, chao.gao@intel.com,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, liukexin@kylinos.cn,
	linux-fsdevel@vger.kernel.org, blum@kernel.org, npiggin@gmail.com,
	leitao@debian.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
	pasha.tatashin@soleen.com, mclapinski@google.com,
	chenhuacai@kernel.org, coxu@redhat.com, takahiro.akashi@linaro.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-3-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:41 +0000
Message-Id: <20260918101641.D27101F00898@smtp.kernel.org>
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

> The CMA pages allocated for a kexec segment are released using the
> segment's memsz to calculate the number of pages. However, some
> architecture loaders modify the segment's memsz after allocation
> (e.g. arm64 subtracts text_offset), causing the release function to
> free fewer pages than were originally allocated, leaking the remaining
> CMA pages.
>=20
> Add a per-segment `segment_cma_pages` array to store the number of
> pages actually allocated from CMA. Populate it during
> kexec_add_buffer() using the aligned memsz, and use it in
> kimage_free_cma() to accurately release all allocated pages.
>=20
> This avoids relying on the potentially modified segment->memsz and
> prevents silent CMA memory leaks.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Brian Mak <makb@juniper.net>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Li Chen <me@linux.beauty>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D2


