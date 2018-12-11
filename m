Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558CCC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CF520811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CF520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DgMz6zcrzDqvx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DgKk1x0XzDqvs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 00:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43DgKj69TBz9s3q; Wed, 12 Dec 2018 00:10:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43DgKj1hRlz9s3l;
 Wed, 12 Dec 2018 00:10:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf: fix overflow of bpf_jit_limit when PAGE_SIZE >= 64K
In-Reply-To: <428482af-6202-4ad7-0548-0bfdd4d4ce94@iogearbox.net>
References: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
 <87pnudjz72.fsf@concordia.ellerman.id.au>
 <154419700199.27049.4999726632209685368@sif>
 <428482af-6202-4ad7-0548-0bfdd4d4ce94@iogearbox.net>
Date: Wed, 12 Dec 2018 00:10:32 +1100
Message-ID: <874lbkxl87.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, Sandipan Das <sandipan@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Borkmann <daniel@iogearbox.net> writes:
< snip >
>
> I would actually just like to get rid of the BPF_JIT_LIMIT_DEFAULT
> define also given for 4.21 arm64 will have its own dedicated area for
> JIT allocations where neither the above limit nor the MODULES_END/
> MODULES_VADDR one would fit and I don't want to make this even more
> ugly with adding further cases into the core. Would the below variant
> work for you?

I haven't actually hit the bug so I won't ack/tested-by this, but it
looks fine to me.

cheers

> From da9daf462d41ce5506c6b6318a9fa3d6d8a64f6c Mon Sep 17 00:00:00 2001
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Mon, 10 Dec 2018 14:30:27 +0100
> Subject: [PATCH bpf] bpf: fix bpf_jit_limit knob for PAGE_SIZE >= 64K
>
> Michael and Sandipan report:
>
>   Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
>   JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
>   and is adjusted again at init time if MODULES_VADDR is defined.
>
>   For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with
>   the compile-time default at boot-time, which is 0x9c400000 when
>   using 64K page size. This overflows the signed 32-bit bpf_jit_limit
>   value:
>
>   root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
>   -1673527296
>
>   and can cause various unexpected failures throughout the network
>   stack. In one case `strace dhclient eth0` reported:
>
>   setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=11, filter=0x105dd27f8},
>              16) = -1 ENOTSUPP (Unknown error 524)
>
>   and similar failures can be seen with tools like tcpdump. This doesn't
>   always reproduce however, and I'm not sure why. The more consistent
>   failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9
>   host would time out on systemd/netplan configuring a virtio-net NIC
>   with no noticeable errors in the logs.
>
> Given this and also given that in near future some architectures like
> arm64 will have a custom area for BPF JIT image allocations we should
> get rid of the BPF_JIT_LIMIT_DEFAULT fallback / default entirely. For
> 4.21, we have an overridable bpf_jit_alloc_exec(), bpf_jit_free_exec()
> so therefore add another overridable bpf_jit_alloc_exec_limit() helper
> function which returns the possible size of the memory area for deriving
> the default heuristic in bpf_jit_charge_init().
>
> Like bpf_jit_alloc_exec() and bpf_jit_free_exec(), the new
> bpf_jit_alloc_exec_limit() assumes that module_alloc() is the default
> JIT memory provider, and therefore in case archs implement their custom
> module_alloc() we use MODULES_{END,_VADDR} for limits and otherwise for
> vmalloc_exec() cases like on ppc64 we use VMALLOC_{END,_START}.
>
> Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allocations")
> Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/core.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b1a3545..6c2332e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -365,13 +365,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>  }
>
>  #ifdef CONFIG_BPF_JIT
> -# define BPF_JIT_LIMIT_DEFAULT	(PAGE_SIZE * 40000)
> -
>  /* All BPF JIT sysctl knobs here. */
>  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
>  int bpf_jit_harden   __read_mostly;
>  int bpf_jit_kallsyms __read_mostly;
> -int bpf_jit_limit    __read_mostly = BPF_JIT_LIMIT_DEFAULT;
> +int bpf_jit_limit    __read_mostly;
>
>  static __always_inline void
>  bpf_get_prog_addr_region(const struct bpf_prog *prog,
> @@ -580,16 +578,27 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>
>  static atomic_long_t bpf_jit_current;
>
> +/* Can be overridden by an arch's JIT compiler if it has a custom,
> + * dedicated BPF backend memory area, or if neither of the two
> + * below apply.
> + */
> +u64 __weak bpf_jit_alloc_exec_limit(void)
> +{
>  #if defined(MODULES_VADDR)
> +	return MODULES_END - MODULES_VADDR;
> +#else
> +	return VMALLOC_END - VMALLOC_START;
> +#endif
> +}
> +
>  static int __init bpf_jit_charge_init(void)
>  {
>  	/* Only used as heuristic here to derive limit. */
> -	bpf_jit_limit = min_t(u64, round_up((MODULES_END - MODULES_VADDR) >> 2,
> +	bpf_jit_limit = min_t(u64, round_up(bpf_jit_alloc_exec_limit() >> 2,
>  					    PAGE_SIZE), INT_MAX);
>  	return 0;
>  }
>  pure_initcall(bpf_jit_charge_init);
> -#endif
>
>  static int bpf_jit_charge_modmem(u32 pages)
>  {
> -- 
> 2.9.5
