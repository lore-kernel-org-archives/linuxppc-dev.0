Return-Path: <linuxppc-dev+bounces-26297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CB5C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 14:09:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYW8X5VB8z2y2J;
	Tue, 01 Sep 2026 00:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788185388;
	cv=none; b=j/FjBdDDaMZDkIZef+eN/ze/avZW8GfeOVGVB6TyjIKle88AjbBwEtj+fhpqmAJoIV1uxj95n9RcCy6h96xPLMbzfXEa8PRUvy6hwMlatQtaK7Fec8uYklvUuOQbYDSHDfh38ZdA4J7dgMBTUOuLC6VAPfrnZNd3NaeNJM4CG8h4UQsADYL/08rXRHYXMsaQrYJEixaVotlH2b+orqU9PMBhbtHtoulSxKdfpAb3Q8AA1t7G41g+1UE2AXxslOGpS+8UYD6my/HY9WKmpBueZbiKaG5B5Cl3JSxsBE6Jxp6zRkuonTEXoOHhnjoivgV5THfA4dmveN/mKzFvLfkvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788185388; c=relaxed/relaxed;
	bh=L1mNt+t9t3Mp1gIJn7MX5n0Mz44VISN4VLwL6b799Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWLbSq/l0w/MiAq27TTs+/KZR3MjrLI2+cS24FkD4Tr+dp8vJ5n1Gg3JS+Ql4PsCcl1sn0OV2SBVwZ3ZaVVWFwi9op80HgQq3ftfHiFUSahwqmBzaHWjVQ3jfHe+yQA9BEHVv6N/n/eeR4gZmCr1GdZaX6guJUI4+MXH461Q6qgSDUYJvEo+62jhCu07bEdTMj8SWVQEAW6uLvR5VvQX0x2FN/GqGZzLbeEriJa+eH5RSuww+VngTa+XdtZ/hiJgJaFqpp3s49F1qP/PtSTABLJXhcpOIKR1MZCpkvha8cAguq37xuJXYiW8/w7/wCx6WWNmmM07bYtSQcaoeGKkyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxa9oF/s; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxa9oF/s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYW8W2bhdz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 00:09:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E58234403D
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5081F01558
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185384;
	bh=L1mNt+t9t3Mp1gIJn7MX5n0Mz44VISN4VLwL6b799Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vxa9oF/soWfIGx7X9eBymk6tUBTtSiGceTld0BHTg54XTE1uWopGPbiR5qAiDdjda
	 iaJ3uvNfpOPmsRf222g18ht0Km7pm/98QZ3tlJNQjiOp3SaGMmyhyw9p/XFbPew558
	 7tVYTzHuDm97oKg0HjVguFpsU2H9obvZ9W+/j6RGvcDs5jyZtgUqmkq8ESPWdMekxV
	 d3j0zvnb5rRn9HJxwu8ZTDe6GNqARHZsq8wRDUFaq7Cjd+jP3t4AjfNlQD+ricbfQY
	 t6b8GVYS/5XDQNQ+BqQfQROnn9n7hMkhuJImHAKQavStYE25THku2v1yfK8B7efNmp
	 4dNZYg3inseBw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2533d83e3bso582435166b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 07:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+BrwgzCxvnBJolyCTwpsA+5JInB2cHSncWICM2lbxMWS7y4IUwTf2n27mhtUePzBgJzUzyzw8penxbTs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ldqnSKd22gZY93Jag4PVQgfAbOrakbQm6p9sjpACVv5oVx6SvK
	cZe9kFgOFu9KKnXODEN0ukKNaF8wG21VzaV2We5C8X0XGIwMkm/hYyQFp/PlEBRNk9S7QqIooWJ
	EEY+BQPOnYklOtxcKE0J/0nztMDfFETo=
X-Received: by 2002:a17:906:4ed4:b0:c25:6c9a:88bc with SMTP id
 a640c23a62f3a-c25b3d8a1d8mr44713366b.19.1788185382598; Mon, 31 Aug 2026
 07:09:42 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260826092541.3905933-1-ruanjinjie@huawei.com> <20260826092541.3905933-6-ruanjinjie@huawei.com>
In-Reply-To: <20260826092541.3905933-6-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Aug 2026 22:09:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+dO2rnb4KxRvVo1w_Mx8Vfsdq7LAbkzPfNYrwUhEtfg@mail.gmail.com>
X-Gm-Features: AcwNN1UnFQ4mMXEBOHuSLr0Mu3pUPtp_q9Do6p0Tl3kncID1TuZivoGd1AqJPW4
Message-ID: <CAAhV-H7+dO2rnb4KxRvVo1w_Mx8Vfsdq7LAbkzPfNYrwUhEtfg@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] LoongArch: kexec: Fix CMA page leaks in segment
 placement retry loops
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	gshan@redhat.com, jic23@kernel.org, james.morse@arm.com, ardb@kernel.org, 
	leitao@debian.org, yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, 
	coxu@redhat.com, tangyouling@kylinos.cn, hbathini@linux.ibm.com, 
	adityag@linux.ibm.com, ionut.nechita@windriver.com, liaoyuanhong@vivo.com, 
	seanjc@google.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, 
	mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
	robh@kernel.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinjie,

Why does the ARM64 version of this patch use "kexec_file" in the
subject line but the LoongArch version uses "kexec"? It is better to
keep consistency.

Huacai

On Wed, Aug 26, 2026 at 5:25=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
>
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
> ---
>  arch/loongarch/kernel/kexec_efi.c          | 1 +
>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> index 5ee78ebb1546..15fd797ff3de 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -86,6 +86,7 @@ static void *efi_kexec_load(struct kimage *image,
>                  * We couldn't find space for the other segments; erase t=
he
>                  * kernel segment and try the next available hole.
>                  */
> +               kexec_free_segment_cma(image, kernel_segment_number);
>                 image->nr_segments -=3D 1;
>                 kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
>                 kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index 5412aa9f3568..62a5be102065 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>         return 0;
>
>  out_err:
> -       image->nr_segments =3D orig_segments;
> +       while (image->nr_segments > orig_segments) {
> +               kexec_free_segment_cma(image, image->nr_segments - 1);
> +               image->nr_segments--;
> +       }
> +
>         kfree(modified_cmdline);
>         return ret;
>  }
> --
> 2.34.1
>

