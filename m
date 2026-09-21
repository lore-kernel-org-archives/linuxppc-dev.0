Return-Path: <linuxppc-dev+bounces-27834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717D8C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:13:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHZT02VRz2y71;
	Mon, 21 Sep 2026 19:13:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981984;
	cv=none; b=TsXVM3Jf4Rygp/tm1k/RNefJ3ziZW9sGZrjn4WNmMjHt0rWp6vFDPPZrSVjhUKm4rGVloLqn/+RWiaqfWsm8uaeILe2pMgZFUaaV+9knTuBbQHoBGf9pjtgSpu03dEQ4sU52aFcUoo6CR/QszPCjFC0SmmYBUshLhUt8hivg9T8M0EmVSPArnwWRKp2pVUlQD/0znzL2CzrDezrlp8QiK1DQlHPaZ5dACEQjVJ1u96pfuxuoqSBheewgJtJGV4Isg9/Uvs2NihH05Badczg7DKH+719lZE5TSw4GgPVoW/Ks0x3XNB5qhGjEdk34vdeGKfJ1WG1DUI1NZvvPdVCerg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981984; c=relaxed/relaxed;
	bh=/WfwSj0SUsP3uLadBypCB3UfgoCzQVYDLKWPCUa5wNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b379W2VvDYyl+y+90HliBZXzKhPeoUwc852Z4mHuUbO+3Og46nKcbW+WpLcdEPGeanMDNlEZ6A9K+KqlN6HjSnRDJdEt66z0ztdehnWHxR66Uti5wTCjwY77jBo9BBVESSyyxt3d0qfa6eXIds14rQ37u9/nvRmJzwafmR1SaWuG+Pr+nSR3yrKMy6cnLuvyqgvRBxxL/J9NEI2kf9Pds5/DTDtC/l2Oksmibh5phqDwaPP2t1WYa48XJ2wHvBRL2XIu4wu0zyoh6SRMIupA/0jAuiXNidWzIi3lf4mfN9Y/6myeg+xKLR9qyEZe8rEGHbRyaPw74naIWu7nSeufkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1I5zBeY reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1I5zBeY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHZS0lDwz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:13:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85213600D1;
	Mon, 21 Sep 2026 09:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE01F00893;
	Mon, 21 Sep 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981981;
	bh=/WfwSj0SUsP3uLadBypCB3UfgoCzQVYDLKWPCUa5wNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1I5zBeYLORpIuyWyUAUWC0Uh4n7bfpfDQAmO+S9O5D57CCdmuhZF6EHDQKvq/cvP
	 10Ma/TXixn8nltQYxWYicB+x3A+NX/4RaAo1K7Tx0Tjx1iSzhDndqP8qwl+cccnN/m
	 VUHXD5OXwJQ5Jm0HeG0etX2xLkzEPw0djSKWw++95ZnUnQnTc45gqQe36GKIoTpmuF
	 v//DReeWe2iedyVaignylzPCkPZ0it/t+3xsjyTinWBvdvSulYQ1WtQtZThfTYfS05
	 U5nZGjbVM8cX0R7Lh1TWDvzVTZbekKD/d0sm+/dQnWzMHFE+oITkFOBWsGfA/tHjUv
	 j7eilNaaRHp+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/14] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
Reply-To: sashiko-reviews@lists.linux.dev
To: kees@kernel.org, rafael@kernel.org, chao.gao@intel.com,
	pasha.tatashin@soleen.com, mclapinski@google.com, robh@kernel.org,
	will@kernel.org, bp@alien8.de, piliu@redhat.com,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	bgwin@google.com, linux-arm-kernel@lists.infradead.org,
	rppt@kernel.org, gregkh@linuxfoundation.org, yeoreum.yun@arm.com,
	hbathini@linux.ibm.com, coxu@redhat.com, chenhuacai@kernel.org,
	sshegde@linux.ibm.com, tangyouling@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org, pratyush@kernel.org, graf@amazon.com,
	mingo@redhat.com, driver-core@lists.linux.dev, thuth@redhat.com,
	kernel@xen0n.name, vishal.l.verma@intel.com,
	sourabhjain@linux.ibm.com, kai.huang@intel.com, chleroy@kernel.org,
	akpm@linux-foundation.org, hpa@zytor.com, guodongtai@kylinos.cn,
	james.morse@arm.com, eric.devolder@oracle.com, ritesh.list@gmail.com,
	takahiro.akashi@linaro.org, mark.rutland@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, tglx@kernel.org,
	ruirui.yang@linux.dev, leitao@debian.org, lin@lists.ozlabs.org,
	ux-kernel@vger.kernel.org, zhangtianyang@loongson.cn,
	me@linux.beauty, x86@kernel.org, seanjc@google.com,
	loongarch@lists.linux.dev, baoquan.he@linux.dev, npiggin@gmail.com,
	palmer@rivosinc.com, "Jinjie  Ruan" <ruanjinjie@huawei.com>,
	maqianga@uniontech.com, jbouron@amazon.com, liukexin@kylinos.cn,
	dakr@kernel.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-10-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:12:57 +0000
Message-Id: <20260921091258.5FEE01F00893@smtp.kernel.org>
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

> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
> 4KB page. However, the elfcorehdr segment can span several pages (up to
> hundreds of kilobytes).
>=20
> The original code blindly copies 'elfsz' bytes at once via
> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
> virtual addresses.
>=20
> Fix this by copying the new elfcorehdr page by page.
>=20
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%4=
0huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D9


