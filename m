Return-Path: <linuxppc-dev+bounces-27715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A4C982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:17:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT7c5lmFz30WQ;
	Fri, 18 Sep 2026 20:17:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726620;
	cv=none; b=W6GE/KePzkNKWdz7DjE0EyQt5tEpdd2O1ksj0owPVZXoC81avZ6srWPyTbgeqa/0W45YN1blx97i0YfBsmPfGjdbxRiTCtc2YOi2ZppHjXYHE3S1NNK7zYgG/sQO6kuYAeOEvl8eJUb5i/37D1duIavqqiAN8g0Ud7siKa70zPjiKXIoCyiWfCYsX3Jr1dB/7b3cMXjlJFypwA4sMRZ5Kki8hmBeWgvuY4kKS3fsDfxBBa97V5YCDygxqecPXRD+0WsMXv59LGwIq26WVNR64swXznMHv753ttBful3ikDO7O44gnPjZxV9QCZKdNZHvcvck0C+zLJWfbE08VV4CKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726620; c=relaxed/relaxed;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEXy/xuezLk/v3H8OQDnXSVma/w+NtqcLyvcFpGfpcVg6HuedKam+R5TJn5YWZZs5QbKCc0gBaxUrzPds5eDaq57iOwUdhjXXQR3h8Z4hv2XE4nH2dBowxZpcfSbrhJ/1V/lqPFQttPFths+IpCd9D+a/hDsWRnuh88XlhtqpR/NogEvJId/w+WUO1GloPVkNh7o9tqW/LjTeE1eZh81xRbC6x2qqjuiHZ3lDDb0yp3ZHzSbyaBHYax1l62OInAcBdv3iw/i/E2skHzkW/Z75VIuFZp5FW9iM4f8NxoPMpIN5TVP0cd7jK9fb128Z4daCt6gKwveQr6WqejAG5h3ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMj01Alh reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMj01Alh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT7b6ZL5z30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:16:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B9FF843CCC;
	Fri, 18 Sep 2026 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667AE1F00899;
	Fri, 18 Sep 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726617;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMj01AlhbDDpoLoXxwn9PPhookstPQzvNzHcu3cfhmO/Vm1xskm1uSEn1VcRtOM63
	 v4FbuEGxl6N6K4hGy9mp3VPfdcYEi9Lt7ZAbiZrOOZJ0H76sH7Yfj41EFFY4kifUUJ
	 U1nyr9h3Wc6OFP7bzybInQVTbPMdB7n385RxAbDMpf0E0z2qmIOuSmMJLA0mzCgRn0
	 REbqAaRoOj6TTCGDA3UVM3ORDYou5nsQBAirRmO25yhfVyCRZefWSTyLWDBVZMDXh7
	 ivKDTJnqkoWlyNwdABc2086K40l/8qfUK9FEg1TIu4WwHLNY/RUoSJ/8Qc7TZFokWg
	 jmShFPclYOnug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: maqianga@uniontech.com, mpe@ellerman.id.au, akpm@linux-foundation.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, graf@amazon.com, vishal.l.verma@intel.com, me@linux.beauty, mclapinski@google.com, hpa@zytor.com, sshegde@linux.ibm.com, yeoreum.yun@arm.com, pratyush@kernel.org, eric.devolder@oracle.com, gshan@redhat.com, bgwin@google.com, guodongtai@kylinos.cn, ruirui.yang@linux.dev, ruanjinjie@huawei.com, kernel@xen0n.name, piliu@redhat.com, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, lizhengyu3@huawei.com, james.morse@arm.com, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, robh@kernel.org, npiggin@gmail.com, dakr@kernel.org, ritesh.list@gmail.com, takahiro.akashi@linaro.org, thuth@redhat.com, linux-mm@kvack.org, liukexin@kylinos.cn, palmer@rivosinc.com, rppt@kernel.org, x86@kernel.org, coxu@redhat.com, loongarch@lists.linux.dev, bp@alien8.
 de, ardb@kernel.org, zhangtianyang@loongson.cn, chleroy@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, blum@kernel.org, seanjc@google.com, gregkh@linuxfoundation.org, baoquan.he@linux.dev, pasha.tatashin@soleen.com, rafael@kernel.org, tglx@kernel.org, kas@kernel.org, hbathini@linux.ibm.com, tangyouling@kylinos.cn, jbouron@amazon.com, kees@kernel.org, will@kernel.org, leitao@debian.org, mingo@redhat.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-7-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:54 +0000
Message-Id: <20260918101654.667AE1F00899@smtp.kernel.org>
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
135-1-ruanjinjie@huawei.com?part=3D6


