Return-Path: <linuxppc-dev+bounces-27719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCC2C982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:22:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTFw5xghz2ygK;
	Fri, 18 Sep 2026 20:22:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726948;
	cv=none; b=UmKyKIYlUEjvXt9US/m5uViafNHiv54NDnbFUByeCW0S0ScIbejRwY8Dx/RhNxRRtT+mJNB/UDaeBViPHjTfhX3FXcCZ2PA4o7Q5+M5H90lY8PV8vFx7UD3Kb/qhRtaFa4FWIk7Md11jQHxKmQWIA+cx0/RfKVwfz6g+p8UeUBzmQGwvX0pLJ9x1wm48xL9gZw9lPDTmuwGMHezdEcr1drnYOuunaTibu6J4U0yzY3D5zI5PGmDcxP6e1CY7UyDwQs4zJLyaqkuA/84urYz2Ednytf6kt+Hxo62vvk8vowT9jcBcz3A5Qigjoak0v5lU/pjYJ93fmukeN2j76JQgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726948; c=relaxed/relaxed;
	bh=sHYNy5wwK9fmryuUm9WuegCfsJ5nAR1Rndu3nKXnWCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Te5WzG4IazigbIJL/bt+gOiqHvBvZYdSqytBMxWgCmsGQ7XC/t2vXHzgT1ytgBIDOJ44pffU1uIR8Dt/iQftKS3SRBM5EoCOaAh0RK2hUTtaI2jAm9b+8kP2Q3t8o4PojwqIkmxFoOnBC4MiokwpgpWYB2Y1FL0jYw7nxWuizJYpmFL3kv2jXEgR3S0dHdiWDB//WM8RXZkcTRaOfFYOUpNsjUFrSSU0fAnTwaunEu7h7yggv591VoQKskCTpWv0QMEnZZoN0DAs19J6b6LJg/6wxfYtclagcyDh2RZrwSSNfhusnFnScUaTM1JD6vq6qVcT+IPlVYwmaj05HWkRBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc0rbtes reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc0rbtes;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTFv4djCz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:22:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 91C5960A59;
	Fri, 18 Sep 2026 10:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA691F000FF;
	Fri, 18 Sep 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726945;
	bh=sHYNy5wwK9fmryuUm9WuegCfsJ5nAR1Rndu3nKXnWCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc0rbtes9P5pCgieiV/VOaF4yxIo3bihzqlKgZzfBIMfnz2VHuU6zRiW4ajSUXtnm
	 uVE5FocXY1Yhiy4t8pnIJoR3/BnczzB9iCs51LhoCpGiksebj3Qt2pLRsukqoUpYEm
	 REf0NPHz8XkXAdp50l1exaR1wvGNu10DTsFYjcPy6aKz14s9a4O/je6de4IvC6GLg0
	 A1DaIKk9DyKxib5oxpK9DguKSuVOC9vs7GO3t+W6NbvNJEh57V+Ns6VoIsyvecixuE
	 bSGzwYp/Fe+PLbPTDSWWY8CwW7XXF44rEsII/FQ6ZPKK3hgeuSTBltWF4ZWzp1WTW9
	 X3l1tPtzei24Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] kexec: Fix CMA segment address translation
 with non-zero text_offset
Reply-To: sashiko-reviews@lists.linux.dev
To: loongarch@lists.linux.dev, pratyush@kernel.org, kas@kernel.org,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, kees@kernel.org,
	rppt@kernel.org, rafael@kernel.org, linux-mm@kvack.org,
	kernel@xen0n.name, dakr@kernel.org, maddy@linux.ibm.com,
	catalin.marinas@arm.com, robh@kernel.org, chleroy@kernel.org,
	ritesh.list@gmail.com, thuth@redhat.com, ruirui.yang@linux.dev,
	npiggin@gmail.com, mclapinski@google.com, graf@amazon.com,
	eric.devolder@oracle.com, vishal.l.verma@intel.com,
	leitao@debian.org, ardb@kernel.org, x86@kernel.org, bgwin@google.com,
	driver-core@lists.linux.dev, me@linux.beauty, mpe@ellerman.id.au,
	chenhuacai@kernel.org, takahiro.akashi@linaro.org,
	james.morse@arm.com, chao.gao@intel.com, liukexin@kylinos.cn,
	seanjc@google.com, palmer@rivosinc.com, pasha.tatashin@soleen.com,
	gshan@redhat.com, hbathini@linux.ibm.com, coxu@redhat.com,
	will@kernel.org, ruanjinjie@huawei.com, maqianga@uniontech.com,
	piliu@redhat.com, guodongtai@kylinos.cn, baoquan.he@linux.dev,
	sourabhjain@linux.ibm.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutl@lists.ozlabs.org,
	and@arm.com, mingo@redhat.com, yeoreum.yun@arm.com,
	akpm@linux-foundation.org, bp@alien8.de,
	linuxppc-dev@lists.ozlabs.org, adityag@linux.ibm.com, hpa@zytor.com,
	zhangtianyang@loongson.cn, dave.hansen@linux.intel.com,
	lizhengyu3@huawei.com, tangyouling@kylinos.cn, blum@kernel.org,
	tglx@kernel.org, jbouron@amazon.com,
	linux-arm-kernel@lists.infradead.org, sshegde@linux.ibm.com,
	gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-2-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:22:21 +0000
Message-Id: <20260918102222.0EA691F000FF@smtp.kernel.org>
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

> kimage_load_cma_segment() and kimage_map_segment() translate a CMA
> segment to a kernel virtual address with page_address(cma), ignoring
> segment->mem. But arm64's image_load() adds text_offset to segment->mem,
> so the kernel payload is copied to the wrong offset while image->start
> points past it, and kexec jumps into the middle of the kernel.
> kimage_map_segment() has the same problem for any CMA segment whose mem
> was moved.
>=20
> Add kimage_cma_vaddr() to translate a boot physical address inside a CMA
> segment to its virtual address, and use it in both places.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D1


