Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492EC65BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:34:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3278208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3278208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BBjb59TPzDrHj
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 23:34:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BBfC2D4fzDrgp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 23:31:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43BBfB6KK2z9s3Z; Fri,  7 Dec 2018 23:31:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43BBf96Qg7z9s1c;
 Fri,  7 Dec 2018 23:31:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf: fix overflow of bpf_jit_limit when PAGE_SIZE >= 64K
In-Reply-To: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
References: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
Date: Fri, 07 Dec 2018 23:31:13 +1100
Message-ID: <87pnudjz72.fsf@concordia.ellerman.id.au>
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
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
> JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
> and is adjusted again at init time if MODULES_VADDR is defined.
>
> For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with

But maybe it should be, I don't know why we don't define it.

> the compile-time default at boot-time, which is 0x9c400000 when
> using 64K page size. This overflows the signed 32-bit bpf_jit_limit
> value:
>
>   root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
>   -1673527296
>
> and can cause various unexpected failures throughout the network
> stack. In one case `strace dhclient eth0` reported:
>
>   setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=11, filter=0x105dd27f8}, 16) = -1 ENOTSUPP (Unknown error 524)
>
> and similar failures can be seen with tools like tcpdump. This doesn't
> always reproduce however, and I'm not sure why. The more consistent
> failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9 host
> would time out on systemd/netplan configuring a virtio-net NIC with no
> noticeable errors in the logs.
>
> Fix this by limiting the compile-time default for bpf_jit_limit to
> INT_MAX.

INT_MAX is a lot more than (4k * 40000), so I guess I'm not clear on
whether we should be using PAGE_SIZE here at all. I guess each BPF
program uses at least one page is the thinking?

Thanks for tracking this down. For some reason none of my ~10 test boxes
have hit this, perhaps I don't have new enough userspace?

You don't mention why you needed to add BPF_MIN(), I assume because the
kernel version of min() has gotten too complicated to work here?

Daniel I assume you'll merge this via your tree?

cheers

> Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allocations")
> Cc: linuxppc-dev@ozlabs.org
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  kernel/bpf/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b1a3545d0ec8..55de4746cdfd 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -365,7 +365,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>  }
>  
>  #ifdef CONFIG_BPF_JIT
> -# define BPF_JIT_LIMIT_DEFAULT	(PAGE_SIZE * 40000)
> +# define BPF_MIN(x, y) ((x) < (y) ? (x) : (y))
> +# define BPF_JIT_LIMIT_DEFAULT	BPF_MIN((PAGE_SIZE * 40000), INT_MAX)
>  
>  /* All BPF JIT sysctl knobs here. */
>  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
> -- 
> 2.17.1
