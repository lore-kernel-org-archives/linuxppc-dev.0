Return-Path: <linuxppc-dev+bounces-27838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21214C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:14:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHcW4n8yz2y71;
	Mon, 21 Sep 2026 19:14:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982091;
	cv=none; b=eHDhwKiFdtawSMVKWrQZWDQHByCZmZXDxe/yU1gHM4dugWqf7qCaviCHGQ5uwwpjSbGJFVElhk+bkqUMMqCCopMBg6WvYKgBmNT4p1UrhZZlef83z0l0Rxn6YOrEDmRN7GO1xvgcwwPm39oaWswUTBhAr11zca8LfpAGu5G8bRtoSWyw0iZgi8ZSizzHZL47n1+FtAe9OIEp48t2adxLUavVfEhT+xEbZWANO3AVMJ40fCVhferYKU14tFGpGxo7uDTDHXXS9J4ekzjpFMc4STU+AAcHtVnR049rnaSsKBlNM6INWzD9vNWbaNLIpgNG57uYx0bBX8gt/YsKuxSXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982091; c=relaxed/relaxed;
	bh=Zko84IbjSpSVbu6MJAXmtfMpiKo1YS8MUshdlf8j2Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Azr0ZJ1SrBo27u4ZKof9pLXdGk5xKvcI7M51p+2zJVlmtWZeOJuBfrYh1yYbcYPrzE85K+W4ZpkbgLejFhCynGCv/awgB6EePMcP34cvENXu8kDi+2zMm05O8Soy9tYwB6FSENO3AFzd33ArwOB1bAaTThOQpEVW80xZVfMaFe/FklLLL67kZ+4Ep9HZVyS9vrngB3dHob46eWnx1G7xdM3gbWMHz1wAAX+j/PRnJOL0okGOe9vkDTvp/YHL2HNa2CcPH/KckwTbuSwS/E+vkbILizf4OAdwOKJOrP1ARLjwpeeW0I20nogAVUZnmGbgC6QfJEJWVsHiMu1kEMKM1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbmDc19p; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbmDc19p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHcV68d2z2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:14:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37C2341ABC;
	Mon, 21 Sep 2026 09:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2761F00893;
	Mon, 21 Sep 2026 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982089;
	bh=Zko84IbjSpSVbu6MJAXmtfMpiKo1YS8MUshdlf8j2Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbmDc19pVl41nW9kuv93uhEHlhM/v+WaAWJ9m4SLnKvh1aNqKldO2WFZ8RlKUoo8K
	 ja8gNwEoFhEQED3ytCk8w6m78nujcqwmcNnvwUN937QUOBieV6pzw66CaVyATAvKWv
	 Wov7dlZAhGobnHj2/fsSFSgUeP9eDxTIivOPU6PyMvkjZtz42Nc7pgA+fy+Z5zOxjL
	 3F8jNT0HdjMOArL/aDzdaJBnTUsvZBBPGyGt6/T8i6E6yRBo/gjXO3LQeVxXqh1+pb
	 FzpD5+KAnowSeF0962ABOLblenxsOgdlhBPpVmj4XHZhZC/ZMAr3p1bAAlQTOh6y9b
	 E7cZo208OqNHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/14] kexec: Record allocated CMA pages to fix
 release size mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: rafael@kernel.org, eric.devolder@oracle.com, chao.gao@intel.com, ritesh.list@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, leitao@debian.org, sshegde@linux.ibm.com, kees@kernel.org, robh@kernel.org, loongarch@lists.linux.dev, chleroy@kernel.org, liukexin@kylinos.cn, x86@kernel.org, hbathini@linux.ibm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, guodongtai@kylinos.cn, mclapinski@google.com, gregkh@linuxfoundation.org, me@linux.beauty, pratyush@kernel.org, palmer@rivosinc.com, hpa@zytor.com, bp@alien8.de, vishal.l.verma@intel.com, bgwin@google.com, takahiro.akashi@linaro.org, chenhuacai@kernel.org, seanjc@google.com, dave.hansen@linux.intel.com, tglx@kernel.org, yeoreum.yun@arm.com, akpm@linux-foundation.org, sourabhjain@linux.ibm.com, driver-core@lists.linux.dev, mpe@ellerman.id.au, will@kernel.org, tangyouling@kylinos.cn, dakr@kernel.org, baoquan.he@linux.dev, graf@amazon.com, kai.huang@intel.com, pasha.tatashin@soleen.com, jbouron@amazon.com, mingo@redhat.com, ruirui.yang@linux.dev, rppt@kernel.org, kernel@xen0n.name, thuth@redhat.com, coxu@redhat.com, catalin.marinas@arm.com, npiggin@gmail.com, linux-arm-kernel@lists.infradead.org, maqianga@uniontech.com, piliu@redhat.com, linuxppc-dev@lists.ozlabs.org, james.morse@arm.com, zhangtianyang@loongson.cn
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-3-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:14:45 +0000
Message-Id: <20260921091446.3F2761F00893@smtp.kernel.org>
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
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D2


