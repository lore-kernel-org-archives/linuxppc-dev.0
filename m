Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50459606A336
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4DXGQ09b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJjcV6TsVz2xMQ;
	Tue, 03 Nov 2026 20:16:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793697386;
	cv=none; b=iRykNpJCZF9TDXwk44XVleXNPGCE6AWxajyQjX8P9JJFFta24KPOqCBuPR/DPWDojGC9qJiYRdaXIfJt+r/VG/WYSfkHlWPx6MhDNtql+H/G5jVWUfGHbqxUQhffRy5tX4MA94PMYwMxo7cn5aTFHb7MUORTAI9TC3QSya7JVH6naTcxuQqUVU03w9zQfezjBd89YTp4SmP9BmPlKygl4wVtgKhOwqonadtHO1VBw5qQLX3IeQYBeOGaL9lx0c+PbkGS2zJQs2q2xND9JNENsnKwIJLSmqV39ozgLZD204QjPxjlYpkcOYfdtEEhp7ZPRNRJR+PxjgTSzC94Rw2L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793697386; c=relaxed/relaxed;
	bh=c/0hZKufvkH/OYW00aRP0EoGvS2iUIY4dlDmgt6M/Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KEukBeUjBJK7MXcTiw9qwhWbva7QE/5VEIlwQ0nOS9/MnUuaBJajLnhARuF4Ys1Htm4CXWtkEbl9ombhfydkApYkcRvxfKX9ztRwIrZgL//lnjNE2ZMt6tSs1ug4dItOrqZs0YdraGTBl6CH3vUKwqruFv4+kc/kR1Hab/R6huEQ8LSWR7aa8yBD3PPfsyzkK7keHIAIPMU+KuvF/CRCP2GFZZ/9Rnb7LtsXIaU8TNxjBwpys8qrz1/gtZcQLFYl3Jw8OqhxKWXuhul535O0+LM0hwfHoqgSeFS4NC9jbOgL5Esz5T2+0VMajqVbGMQtE6aghSoXJhcRlkCGZpzdEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4DXGQ09b; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4DXGQ09b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJjcT0b1Pz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:16:24 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c/0hZKufvkH/OYW00aRP0EoGvS2iUIY4dlDmgt6M/Mw=;
	b=4DXGQ09bqE2PEAJtjiuGEIxPkyR4WjwiC7ksDXHrbemdIxEQDHk6VaPRbtJElOvQBITMnTqnY
	srWuVrJKqwgvc1zcbqHERnrW2EJ6xbZjtycFl6KEG6RooII6hHAUnHUHO9DbyxyTM0ByJl5fvpa
	OfjJ7hHwPYGxreXazxTjPfg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jJjbp6kLMzcZxn;
	Tue,  3 Nov 2026 17:15:50 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CBADA40579;
	Tue,  3 Nov 2026 17:16:15 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 17:16:13 +0800
Message-ID: <9ef43c59-72b8-4ef8-96cd-0dfd133cde0f@huawei.com>
Date: Tue, 3 Nov 2026 17:16:13 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/15] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <sourabhjain@linux.ibm.com>,
	<kees@kernel.org>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-6-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261026075201.699550-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Will fix sashiko review issue in v8.

在 2026/10/26 15:51, Jinjie Ruan 写道:
> The retry loop drops nr_segments, leaking the CMA pages of the failed
> segments.  Release them first, and disable CMA for the retry: it
> ignores buf_min and would hand out the same region forever.
> 
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/kernel/kexec_efi.c          | 8 ++++++++
>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> index 5ee78ebb1546..d42711b895a2 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -86,6 +86,14 @@ static void *efi_kexec_load(struct kimage *image,
>  		 * We couldn't find space for the other segments; erase the
>  		 * kernel segment and try the next available hole.
>  		 */
> +		/*
> +		 * kexec_alloc_contig() ignores buf_min, so disable CMA to
> +		 * let the retry make progress.
> +		 */
> +		if (image->segment_cma[kernel_segment_number])
> +			image->no_cma = true;
> +
> +		kexec_free_segment_cma(image, kernel_segment_number);
>  		image->nr_segments -= 1;
>  		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index 5412aa9f3568..62a5be102065 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>  	return 0;
>  
>  out_err:
> -	image->nr_segments = orig_segments;
> +	while (image->nr_segments > orig_segments) {
> +		kexec_free_segment_cma(image, image->nr_segments - 1);
> +		image->nr_segments--;
> +	}
> +
>  	kfree(modified_cmdline);
>  	return ret;
>  }

-- 
Best regards,
Jinjie


