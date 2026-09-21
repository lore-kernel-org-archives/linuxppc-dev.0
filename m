Return-Path: <linuxppc-dev+bounces-27836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6540DC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:13:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHb26gFKz2yvy;
	Mon, 21 Sep 2026 19:13:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982014;
	cv=none; b=DwVpHJLVb1q9+hP1u8RhvLpJGvF4QMuGWOV0GdT2mC1nuRfEJvLeNlHyQpIt6wpzt5ccjOycIfL7pQMtdGePXJXfk4FulI2qG1tGrfl/crASXvrwlmvbdXDjMT8roD76XF7xlYdmQAjIhdcxWWfY8axq1JzN9q6+H0fB0HgTSTQdogc1H9QO0AGi4ZaCcCh30EMRYLZvZBiV/48sLo1zzWt2WCp4QU+hA3/Ej99JmhEyJBSqvldsqZ5pZeuKWuhKH39h6W04dWtzhR0qm0SnvrQ8TgYr5mPQor0vpeVhZYsUihr4bT3oRkFMzydunKTcy2eIAbKhaJepwnmKQnjBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982014; c=relaxed/relaxed;
	bh=ci45NQJUg16aZt0y5PeWLAJ6VMj1xm674PK6gI0wb/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LwJtbfTQkebS75SQ8wlNM/Q74wMywgRyypjgI7E+bT3Cfb4W/zWNAXDLCsNAZ5G0x71n8bK+dLQdFwPGWDmGXLX0YN2QXzKvCKVP5hbq72ygS5xoaURwOxz5AqpSog7q3FlBqsY0M/8hN/PnC3FjMq+rMGfRRgms9lwy/LPBRZSnXpHfCabjm4zvO9VdcZHLMMWB6FvYJcRqMwLvzmjif+j2zueLy9eJ5FkIkNCIlc5BEMzxjrTdbaNo1oLDz+30Y4/4z8Hurw7yY0TzXpwpM1RN7gN1x/oWcjBdqVNVIp4j/9ET64NtyrvF3nEwjJEn7sNm9Xv7PWF/5gtilGNSBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQm7ODC9 reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQm7ODC9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHb21jHMz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:13:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D7ED42A4E;
	Mon, 21 Sep 2026 09:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7991F000FF;
	Mon, 21 Sep 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982012;
	bh=ci45NQJUg16aZt0y5PeWLAJ6VMj1xm674PK6gI0wb/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQm7ODC9zYGHKV67q4Nfd43WItBUGZ+KMMxaKTqYb5AhTE8ADj41mMaTjg3RxBvWI
	 glxoDGBTc459VqLuYagv74owIjybea8BCkEyHEdwCmH/VGab6tEu/+hGad9cF4E+ue
	 xDuvLwRpwfVs5i/zBUDnnOntEVtA5B9SkCoPsl4itcUYjcAYbm9Hf9Rp7M8PO1dSc/
	 KFDzRwjifRSqZchkKanhAtrLnZM5sa5GozgtkNjqy+1fiUofkSE87lzR6WP99e4rDC
	 04xzaQbnncwm12YgbDEScupqgAvEzFrU8YDNxRun5O3k9l5kAvSR6W5ZWdMEB6okYN
	 1cZfCEFxPvvyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/14] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
Reply-To: sashiko-reviews@lists.linux.dev
To: dakr@kernel.org, hbathini@linux.ibm.com, npiggin@gmail.com,
	maqianga@uniontech.com, vishal.l.verma@intel.com,
	baoquan.he@linux.dev, piliu@redhat.com, ruirui.yang@linux.dev,
	linuxppc-dev@lists.ozlabs.org, pratyush@kernel.org,
	maddy@linux.ibm.com, bgwin@google.com, robh@kernel.org,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, mingo@redhat.com,
	me@linux.beauty, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, takahiro.akashi@linaro.org,
	james.morse@arm.com, yeoreum.yun@arm.com, mark.rutland@arm.com,
	eric.devolder@oracle.com, coxu@redhat.com, chao.gao@intel.com,
	ritesh.list@gmail.com, kees@kernel.org, liukexin@kylinos.cn,
	leitao@debian.org, sourabhjain@linux.ibm.com, tglx@kernel.org,
	kernel@xen0n.name, bp@alien8.de, loongarch@lists.linux.dev,
	rafael@kernel.org, seanjc@google.com, dave.hansen@linux.intel.com,
	palmer@rivosinc.com, pasha.tatashin@soleen.com, rppt@kernel.org,
	driver-core@lists.linux.dev, kai.huang@intel.com, graf@amazon.com,
	jbouron@amazon.com, guodongtai@kylinos.cn, thuth@redhat.com,
	chenhuacai@kernel.org, linux-arm-kernel@lists.infradead.org,
	hpa@zytor.com, gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	sshegde@linux.ibm.com, will@kernel.org, x86@kernel.org,
	mpe@ellerman.id.au, chleroy@kernel.org, mclapinski@google.com,
	tangyouling@kylinos.cn, zha@lists.ozlabs.org, ngtianyang@loongson.cn
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-4-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:13:29 +0000
Message-Id: <20260921091330.2D7991F000FF@smtp.kernel.org>
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
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D3


