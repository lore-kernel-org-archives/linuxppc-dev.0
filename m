Return-Path: <linuxppc-dev+bounces-27722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478DFC982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:27:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTMb6p7Nz2yql;
	Fri, 18 Sep 2026 20:27:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727243;
	cv=none; b=FQjhTFwfb4dn9ChhZS4o1fZdX5po2LUMvcJMwYcZe20LDmQGey7iNXb7yaqfosrGfMoanzedLZNNhkd50QerjFs5UqmaYWCCD+EVjDjORiXKkC8IRh7+NorQbHTCeYs+HUVBqoUQ/J1eIo1bYFO+rkKSy2fIJF+V4ONEhkxAg5UnXSXDZvki5QrXhkAmD3zP3d+DYmbLhkWwQf/vYCjBo4PjGdsze/JWStluweVjlzGhPJgfcY6fmY2ws1E3OPAQEcS7y+sE0d8KOxxPZdb9gyGLUNBJw6l9BfB3nK3t7cPf/tGEOXCtuCLEtCg2Sq9a9ZJR5Us5wDv2pjhVjyosOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727243; c=relaxed/relaxed;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LooB8A5pAXJI1KBg5z50waiLX5p3vnugG1Swdv7Lp5UXzclsuwrf21MoSIGlXBCGz1WWVbipKFWI8njYjT27LXV2qvZZ0GeFzBBTJHeesQcaz0IVnwc3K2D4rw62iMsLGOvA1zgymVzvwDQSdiynqllJxPA+SmyLwIQoFMi5TagskWYwSLYamDOy6c8tUo0AQrhpohu3YRMmdSEPAAejTHJSJ5UXFulOJr7Ejs1Vjt1c/ZBAnwzmRIoifKjncPz24PjrmOkc/lq1WbQCeDG0MvkjQd2R9/4HJAuk1vbSCaQft6oUVfALgcXXTTuThRCf2gz/6XVH9grr/1X3Miixcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du4xoU7X reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du4xoU7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTMb2YlJz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:27:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4F5142E96;
	Fri, 18 Sep 2026 10:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789961F000FF;
	Fri, 18 Sep 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727241;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du4xoU7XjcM1TU6N/dTK544nfxc5Xy4BGBBLWmcwaBcwvbxAkfkHsVFrdqrAPsSNR
	 Snp5SQgQywMHtT1ZKAD43KdCSFT61Wt+I/i//Tba+e+t/o/RERKfZj8UnuqflMPSL5
	 ZmWlhVxdVtD7qwnw/a2BcP2WEBdw1L0n1RWhDgC0dZMVpk5r1PDqcihr9V0X5Zr8Be
	 O7jQ7y50yEdU+BmUnsJ/aCm5tAaCmg21Vg6fHxN3SuCeKnMkicaeMaKAlCbh1TiAVS
	 /bUGsZMlSdpCGcZHfnhBCEDyjCUSVrCSdPi1aHOlrHCZfjUtHuUzjSKPie2NGP+BB3
	 ZbhYbBud2KtTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] arm64: kexec_file: Simplify
 load_other_segments()
Reply-To: sashiko-reviews@lists.linux.dev
To: npiggin@gmail.com, vishal.l.verma@intel.com, kernel@xen0n.name,
	rafael@kernel.org, james.morse@arm.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, leitao@debian.org, coxu@redhat.com,
	palmer@rivosinc.com, linux-arm-kernel@lists.infradead.org,
	blum@kernel.org, baoquan.he@linux.dev, x86@kernel.org,
	jbouron@amazon.com, lizhengyu3@huawei.com, hbathini@linux.ibm.com,
	seanjc@google.com, dakr@kernel.org, sshegde@linux.ibm.com,
	pasha.tatashin@soleen.com, gshan@redhat.com, ritesh.list@gmail.com,
	piliu@redhat.com, chao.gao@intel.com, driver-core@lists.linux.dev,
	kees@kernel.org, kas@kernel.org, bp@alien8.de, mingo@redhat.com,
	bgwin@google.com, linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org, linux-fsdevel@vger.kernel.org,
	maqianga@uniontech.com, zhangtianyang@loongson.cn,
	catalin.marinas@arm.com, maddy@linux.ibm.com,
	akpm@linux-foundation.org, yeoreum.yun@arm.com,
	loongarch@lists.linux.dev, ruirui.yang@linux.dev, graf@amazon.com,
	takahiro.akashi@linaro.org, mpe@ellerman.id.au, g@lists.ozlabs.org,
	uodongtai@kylinos.cn, linux-mm@kvack.org, gregkh@linuxfoundation.org,
	pratyush@kernel.org, liukexin@kylinos.cn, robh@kernel.org,
	dave.hansen@linux.intel.com, "Jinjie  Ruan" <ruanjinjie@huawei.com>,
	rppt@kernel.org, ruanjinjie@huawei.com, mclapinski@google.com,
	thuth@redhat.com, adityag@linux.ibm.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, will@kernel.org,
	hpa@zytor.com, me@linux.beauty, ardb@kernel.org,
	eric.devolder@oracle.com, tglx@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-17-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-17-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:27:18 +0000
Message-Id: <20260918102718.789961F000FF@smtp.kernel.org>
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

> Use `kbuf` fields directly in crash_prepare_headers() to eliminate
> the local variables "headers" and "headers_sz"..
>=20
> Advance the assignment to image->elf_headers before
> calling kexec_add_buffer(). If kexec_add_buffer() fails, the explicit
> vfree() in the error path can be removed, as the global infrastructure
> in arch_kimage_file_post_load_cleanup() will handle the cleanup.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D16


