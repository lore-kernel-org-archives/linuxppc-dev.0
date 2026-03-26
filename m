Return-Path: <linuxppc-dev+bounces-18790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4AC109E543
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 04:00:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fh96y1h2Hz2xlM;
	Thu, 26 Mar 2026 15:00:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774497658;
	cv=none; b=Ehx7iCh4MFlaJTvFY6evEQeOhJbNlz/KdLmCLoJqpPuvfKtOS3E6h6toNn236tReoXKlWtyXn0VfYePgzLPAFqP07yZcxsAkbNErg2XKWpAJ8rSGMpkQmF9Fwvn4CQZRh3paZETz0D0YYvN6KuX1h78JbshIKkjLtQPB0oGdiC2tkvczLBOP1DL8doRVX5rHp3Vh+v35oc3bqPRsVKVdv6iBpI6Ep6CL0LNihiY2pC1Wb6hYUQHpfNvgKmB5Wdr935KyiqOxYi0qLtoG3xdHRVHnn5+J/sYysCZvSVu4Q+jJyzkJnzrr21/qIgs538mEW58Jcfa4gGZYzcN971AlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774497658; c=relaxed/relaxed;
	bh=qniXyQQp8BhF/swyXeMAfDNlEpa6S16iQqUUNsxIcDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K3By3qKAj9ab/v3Yw4+u6xBj3qcjJX7VTs+1qEvuLkVEL6IyzxR5ZgPBKM3n7aZNh/Q+W5RVrkmakNu/s3SYnDFfMsmH320GpqNdoRK0M0d8BJhX6zYGb9AIDaB1kaauAp6+3kEZIfxg3osKprZH+vgb+NQHqLwg58hy1o/lgoRWqINrqcWuGTfFWMzk3kmAUkRYjckcnCthM7JEDkEiCMnNy5/H8nN9v0tqSrPSYOeyBVQchxQ0Lt062BP1x3n4DcYZKRCThH5GOPBEDmIBAAUf/wEI/RzmiTiqzI8vj1xNONA/2TXapBNdKUr2HlzsYt9cHQP7qwBd16XVKoX+LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=h2qifna9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=h2qifna9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fh96x0yHCz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 15:00:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CC7760053;
	Thu, 26 Mar 2026 04:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADB9C19424;
	Thu, 26 Mar 2026 04:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774497652;
	bh=a9nj8mR0F2lI5537jnvwaS2ZWg+dPzAdFfkxncY9zlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2qifna9aaXJnfak9+pSw26tlqsP2LAwzpD3dGgF05NQHoCHdNDKGEZMoI/Wk5xcR
	 KnLZv/LqxdRIns2Nlqb3FxRXxGoEPhC72JtyPQx0VyGaV3MLE4ojcsuotrtL3JM21n
	 PkhEdBR8W4hregCpzSCNr/8OKlRFhBrzKXyzsukU=
Date: Wed, 25 Mar 2026 21:00:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
 <ardb@kernel.org>, <leitao@debian.org>, <osandov@fb.com>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
 <kevin.brodsky@arm.com>, <samuel.holland@sifive.com>,
 <vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
 <liaoyuanhong@vivo.com>, <jbohac@suse.cz>, <fuqiang.wang@easystack.cn>,
 <guoren@kernel.org>, <chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
 <james.morse@arm.com>, <takahiro.akashi@linaro.org>,
 <lizhengyu3@huawei.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260325210049.28cca592a001e745954b3241@linux-foundation.org>
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 10:58:56 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

So who is patchmonkey for this.

>  .../admin-guide/kernel-parameters.txt         |  16 +--
>  arch/arm64/kernel/machine_kexec_file.c        |  39 ++-----
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  39 ++-----
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   7 +-
>  arch/powerpc/kexec/ranges.c                   | 101 +----------------
>  arch/riscv/kernel/machine_kexec_file.c        |  38 ++-----
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  89 ++-------------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |   9 ++
>  kernel/crash_core.c                           | 105 +++++++++++++++++-

Me, I guess, with as many arch acks as I can gather, please.

I'm seriously trying to slow things down now, but I guess I can make an
exception for non-MM material.

AI review asks a few questions:
	https://sashiko.dev/#/patchset/20260325025904.2811960-1-ruanjinjie@huawei.com

Can you please check these?  And I'm interested in learning how many of
these are valid.  Thanks.

