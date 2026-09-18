Return-Path: <linuxppc-dev+bounces-27718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632B6C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:21:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTDN6sMbz2ygK;
	Fri, 18 Sep 2026 20:21:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726868;
	cv=none; b=FyutYWsw5MsNuF4tIqJXkoObBEkojH6z2wfPsqvCQsuFte9ir34+17BiC/LnvytWV4JEMVlDbrUo8y3HZoeNKsW2AdjHMQoQd2WA8eUVvsU+Jpx+uCOXdV4ZsmBauZniDH7vhfxumd4QH63SmJAxaPCgsKVXUcLZQgk75fyvX1/9WuJk0a122KuUIiBgwKfVhvCFTDhp5JKU5KfEEb7EEWyx7G3Adrv/zDgMGnz/0IlQD8O2tsTN7luuxWBRtPj1YJmrkGpagOWIl21RnQBRo2DwKgwzYA1XxS+sX0BHWV3rX3wgrnKHapar5/5+cGAfarcFSwez8pIZ9hBwxSucDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726868; c=relaxed/relaxed;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXkdYwesmIR9ZjSLXh8RmJIHopMUjaA92w13A/cSDRKDoOuMpvaNqV9XMGCujqF+aIvtZKkvK/RoTYNp9za01ak66IISUX0clp+PgMRq+v7gyvLxDCKTtPIKwk0lSfvIqGjCIX22Q1cObnbCkhjMARuW5SdiSotJ42bGW+PPNnq+t21mZf+xOjPghCWhK8eLxOcx5DaNiQ8JWvX3suwKGNnrtkqTjm4wBLoYXUTbxHTnG0pv/vBmz8HQU591gCeUHJxUzt6sxAeBD69A636HUkSgjbXQP6EezfyonqOzS049AKqUcHq04p0AnbfmME9iFNkh7CJkgo611CV4NDnI7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbhnGqJb reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbhnGqJb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTDM647vz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:21:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AB4B043BDD;
	Fri, 18 Sep 2026 10:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D31F00893;
	Fri, 18 Sep 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726865;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbhnGqJbr+ybtK3Fnwjub4nxRMAkKMpEzatb5UyqR56xMFB6wzCkyGzg4dZWPmT3+
	 X+snAKFCSsw9hS3uDDtXyaV+a120iBx6doKN2SXy7kWsE6Ghr43NePclsslWz3X5jO
	 umM+Y1oZRe63NELb54DdiEkz9d+zMmZueH0FDcyiLWVV9cdWUYTG7WaCOZvG2X/7g/
	 a9oPJYB+Dy64zxGyUYebphSZ5ylo5LJpeevfZI8VBPaG8K99ZpvTAK5Kx+JWQnO/hy
	 0N1qcxBpGbuzeUsqKEcZ7LzQMrQi37y/VFurlQHxRKvV4Yc12NiNYAuI+ZMxmxdW8s
	 JCL5q8jJo+Sfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: leitao@debian.org, seanjc@google.com, kees@kernel.org,
	thuth@redhat.com, tglx@kernel.org, loongarch@lists.linux.dev,
	will@kernel.org, hbathini@linux.ibm.com, rppt@kernel.org,
	akpm@linux-foundation.org, chao.gao@intel.com, hpa@zytor.com,
	guodongtai@kylinos.cn, takahiro.akashi@linaro.org,
	maddy@linux.ibm.com, pratyush@kernel.org,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, zhangtianyang@loongson.cn,
	lizhengyu3@huawei.com, blum@kernel.org, x86@kernel.org,
	eric.devolder@oracle.com, catalin.marinas@arm.com,
	ruirui.yang@linux.dev, me@linux.beauty, adityag@linux.ibm.com,
	ruanjinjie@huawei.com, vishal.l.verma@intel.com,
	mark.rutland@arm.com, sourabhjain@linux.ibm.com,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	chenhuacai@kernel.org, pasha.tatashin@soleen.com,
	palmer@rivosinc.com, ritesh.list@gmail.com, kernel@xen0n.name,
	robh@kernel.org, dakr@kernel.org, james.morse@arm.com,
	mingo@redhat.com, tangyouling@kylinos.cn, mclapinski@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	jbouron@amazon.com, sshegde@linux.ibm.com, graf@amazon.com,
	bgwin@google.com, bp@alien8.de, linux-mm@kvack.org,
	chleroy@kernel.org, piliu@redhat.com, maqianga@uniontech.com,
	gshan@redhat.com, yeoreum.yun@arm.com, coxu@redhat.com,
	mpe@ellerman.id.au, dave.hansen@linux.intel.com, npiggin@gmail.com,
	baoquan.he@linux.dev, kas@ker, nel.org@lists.ozlabs.org,
	liukexin@kylinos.cn, ardb@kernel.org, driver-core@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-8-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:21:01 +0000
Message-Id: <20260918102102.482D31F00893@smtp.kernel.org>
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
> However, during a retry loop in efi_kexec_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D7


