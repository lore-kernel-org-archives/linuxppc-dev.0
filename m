Return-Path: <linuxppc-dev+bounces-27847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48BDC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:19:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHjs2LN5z30RN;
	Mon, 21 Sep 2026 19:19:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982369;
	cv=none; b=hW1W6VYQ8385/TtneNmA6G0vNvRD5+41D8xCg4cX37HTJBGKNSo2d5lZzBFK19tvo/1tzHUPVkVkLsby3C8hrr2N91nQfVRYn2o0dMHJ+OR5ne0NRsm6M/q+TUxeuNxjHprx1OzLbz8cuatReGrMF7tyOo36e44Q3mrVdefJJGNNlE6CM73shjNpjn0uCjoihIZuvaRipYxt8y/aidXCJ1PEVBzTZg00suBpsm9U/mJZPSY32jVJqCFScWTavzpW3xMhViGdtqt0+wotu1Sdm2OBhUnub02T92wmhaNR+ixknNf53aYIXevcgQBX4iZCw41m67aVUh1rT+0AseQyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982369; c=relaxed/relaxed;
	bh=R3VWhm5DK1BFR53HtMU+M8vTk1Nt5oNf8CDsE/3Y3vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QyJHXxmBGIVOw+rKvh6VHJv1eHg6J8a/y27fjNP7I2uTmuyoqilxnj1hhk2HQxBphlv5GVj8v+UPs3DobJIQKUWmGKeHx2MspxGW8Ji0ExfV5hTHV1EirMm5q+cinyLvbD6p0u0yOo0thUb6Ec2t/Ru89JAn6jb9vppcuEr+p/Nq+xNd/Iu3UNdee5TDppVWgjxPanzsoS7e+PuXkDqsT2CHPlPdTC/J7IUAwrG1bBP688qTEQUP1i9s2GQp1y1LfviLsFyN6+cpM6GgePIPlGrO4zDaNhjKmIxLOVr7fcSYwdjhQP8cZOuSMoiXoLLyeqxHht9E5eBaMHoPOrVAwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YI2jAtzT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YI2jAtzT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHjr4Qk0z30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:19:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99DEA600C8;
	Mon, 21 Sep 2026 09:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B91F000FF;
	Mon, 21 Sep 2026 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982366;
	bh=R3VWhm5DK1BFR53HtMU+M8vTk1Nt5oNf8CDsE/3Y3vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YI2jAtzThTRUXkLRo3VokSMs5LXJ3b+47X/wzjp2A9MQPJXtTVCJgeZMMH20BHsaB
	 euMHtjmsZbFr3gDTAo01ri5nLzp+TeSj/709aes7F8xnEyIftuq9ly0dTraeFNKm7J
	 0hlftxFkdl13WZQBqOdVwrPt0qOhy0ZUtWiu9DhhAFL+OxA9Qy7DqAdUPrjFGYMiDC
	 AR4OrQxYuq8Pyr2Dyv1AhLZ5nNp96h0XFxyxdmX0mtMCABbBR7MfmWvkLeNzO8TiWc
	 ship2/zQCSp5Lriz6Kmzn2p8d1YcvXMKV9qCHv3HvFRiqSHdDkkPXkMq1TJO/CXGmA
	 6EkmbF5tXmFLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/14] crash: Extract crash_get_memory_ranges()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: catalin.marinas@arm.com, hpa@zytor.com, bgwin@google.com, mpe@ellerman.id.au, vishal.l.verma@intel.com, takahiro.akashi@linaro.org, chleroy@kernel.org, baoquan.he@linux.dev, yeoreum.yun@arm.com, maddy@linux.ibm.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, rafael@kernel.org, coxu@redhat.com, loongarch@lists.linux.dev, leitao@debian.org, palmer@rivosinc.com, robh@kernel.org, rppt@kernel.org, jbouron@amazon.com, kees@kernel.org, james.morse@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mark.rutland@arm.com, npiggin@gmail.com, will@kernel.org, sourabhjain@linux.ibm.com, ritesh.list@gmail.com, pasha.tatashin@soleen.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, bp@alien8.de, thuth@redhat.com, chenhuacai@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, piliu@redhat.com, driver-core@lists.linux.dev, graf@amazon.com, me@linux.beauty, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, mclapinski@google.com, seanjc@google.com, maqianga@uniontech.com, chao.gao@intel.com, guodongtai@kylinos.cn, tangyouling@kylinos.cn, liukexin@kylinos.cn, dakr@kernel.org, x86@kernel.org, hbathini@linux.ibm.com, zhangtianyang@loongson.cn, tglx@kernel.org, kernel@xen0n.name, pratyush@kernel.org, eric.devolder@oracle.com, kai.huang@intel.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-11-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:19:23 +0000
Message-Id: <20260921091924.321B91F000FF@smtp.kernel.org>
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

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D10


