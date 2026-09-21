Return-Path: <linuxppc-dev+bounces-27846-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81538C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHj31YCqz30W9;
	Mon, 21 Sep 2026 19:18:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982327;
	cv=none; b=adF4y+JkT/UH7YuCilamhwv/s3ZqwYMMZegkF/zXEgrqA4pSjHJmaigzvzDiCJvlxSusQDRk5W426uiHzmIZwWBkjI6IGjB++QKYnWkSTNmM9Tefww7H9nbWvxpBSMvzq4ZkDOoT6O8rjVN+qpyosRMfmghMf6qh1b9TQf8KAr+WKxh32721Cf1lQj5g9LfdvAd3vrVRv31MqQkD4hhTyAmepZk3AT5VBfIIsLA8ZddPQ95KK8FbA2joNf4PdcWPu+9Hb0SCpgd7DAQ2gHfa+BmCpvsCSnYZdrternhFyA8A6cvg97HlDvtRgGsoRkVxOIQjf0bQvamXkqJzL6+osw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982327; c=relaxed/relaxed;
	bh=i6sXuJju1VSKZUvWu8ItDIKa9ytfMiVRqIfIDXcBB7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPzHBFW1YKTba5m9vv6//gV+EXgLj9MjKcLJvrLl+0RNyGYVJNfJ/om6iFw/CJSDZkMQMm8v2vYaNoDP4hSJGrjqku93CbVrj0rtA+xdJvDxk01a73s+paVXh2PnOPKH81PrHGwi5wzO0Cq+bxXF8vbgYRlkOQdBl4/WSVa20GbkO/QwJzFvvjVAtmpo/5TaI0JJZe4jSiZLak33/IQPRECix0Sypq2NieIj8PjGtdWrC+blA9Z0yC4NlGRCGlFNtn7nm8yMFt9UpO9qEbQ0bz7J0yxnt2jND+ueibH8Djt+gPYJ+sLNoY45sH4smJOHsSHuWFOKamadD1vlW80Vuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMRtO3X; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMRtO3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHj22Hnrz30VX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:18:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECE2A601F0;
	Mon, 21 Sep 2026 09:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E51F000FF;
	Mon, 21 Sep 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982323;
	bh=i6sXuJju1VSKZUvWu8ItDIKa9ytfMiVRqIfIDXcBB7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpMRtO3XO2GapTLkFUCcMIQO2en5kmpXBA4JYaMPBwGnEJuTstZIo7j0l4PWritAn
	 9u4JDzqtwga5Ei3ZSZYEoAQSDyXHKw14UdRV5C4ajSkSzWY0Bf0LsUubpasTPxq29n
	 3DYgHM2BevLJFJt6UQT1E4bAlfEXvnYZDJYE1sb7WJAcQ0Zsy8OZ2EHBS9ZramShzy
	 ClIIKnDpNdguDyQrBNjMx7ocj55eUIakg+mQrcszOm8acgYOlzjGh++FFvu11XbImq
	 pm8VkovoNL1fLidqLycOZCPmnllepGBjda3TcVif4j1rNnCz+DvXxWXkOXw6+r3kcQ
	 xX+B0P6TasoHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/14] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: guodongtai@kylinos.cn, linux-arm-kernel@lists.infradead.org, yeoreum.yun@arm.com, mclapinski@google.com, ruirui.yang@linux.dev, eric.devolder@oracle.com, hbathini@linux.ibm.com, kernel@xen0n.name, piliu@redhat.com, thuth@redhat.com, ritesh.list@gmail.com, tglx@kernel.org, mpe@ellerman.id.au, x86@kernel.org, takahiro.akashi@linaro.org, akpm@linux-foundation.org, chenhuacai@kernel.org, rppt@kernel.org, catalin.marinas@arm.com, bp@alien8.de, pasha.tatashin@soleen.com, maddy@linux.ibm.com, driver-core@lists.linux.dev, dave.hansen@linux.intel.com, vishal.l.verma@intel.com, bgwin@google.com, npiggin@gmail.com, chleroy@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mark.rutland@arm.com, leitao@debian.org, james.morse@arm.com, maqianga@uniontech.com, rafael@kernel.org, sshegde@linux.ibm.com, jbouron@amazon.com, me@linux.beauty, pratyush@kernel.org, palmer@rivosinc.com, linux-kernel@vger.kernel.org, baoquan.he@linux.dev, gregkh@linuxfoundation.org, mingo@redhat.com, zhangtianyang@loongson.cn, hpa@zytor.com, chao.gao@intel.com, kai.huang@intel.com, tangyouling@kylinos.cn, coxu@redhat.com, dakr@kernel.org, kees@kernel.org, graf@amazon.com, linuxppc-dev@lists.ozlabs.org, robh@kernel.org, will@kernel.org, sourabhjain@linux.ibm.com, liukexin@kylinos.cn, seanjc@google.com, loongarch@lists.linux.dev
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-5-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:18:40 +0000
Message-Id: <20260921091840.C62E51F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: kexec_file_load infinite loop due to unconstrained CMA retry
--

commit 897e1cdce0bd14dc7b700f2043c1f14c66a40791
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arm64: kexec_file: Fix CMA page leaks in segment placement retry loops

This commit fixes a memory leak in the kexec image placement retry loop.
It explicitly releases the associated CMA buffers in the failure paths
before the segment count is reduced.

> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_im=
age.c
> index b70f4df15a1ae..ffcb7f9075e62 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -107,6 +107,7 @@ static void *image_load(struct kimage *image,
>  		 * We couldn't find space for the other segments; erase the
>  		 * kernel segment and try the next available hole.
>  		 */
> +		kexec_free_segment_cma(image, kernel_segment_number);
>  		image->nr_segments -=3D 1;
>  		kbuf.buf_min =3D kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;

[Severity: High]
Does freeing the CMA segment here create an infinite loop?

The loop updates kbuf.buf_min to search past the current kernel segment
expecting the next kexec_add_buffer() call to allocate from a new hole.

However, kexec_alloc_contig() allocates via CMA:

kernel/kexec_file.c:kexec_alloc_contig() {
    ...
    p =3D dma_alloc_from_contiguous(NULL, nr_pages,
                                  get_order(kbuf->buf_align), true);
    ...
}

The underlying CMA allocator completely ignores kbuf->buf_min and
kbuf->buf_max. Since the CMA block was just freed, the allocator will
repeatedly return the exact same physically contiguous block.=20

If load_other_segments() fails due to layout constraints (like dtb or
initrd placement), it will run again with the identical memory layout, fail
for the exact same reason, and loop infinitely causing a system hang.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D4

