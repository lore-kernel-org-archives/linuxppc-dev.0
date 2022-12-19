Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93164C4332F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Dec 2022 04:00:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nb5bG0yWCz3cBK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Dec 2022 15:00:42 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nb5Zd1TNcz3c34
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2022 15:00:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nb5Zb2vkbz4x3w;
	Mon, 19 Dec 2022 15:00:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221216125913.990972-1-mpe@ellerman.id.au>
References: <20221216125913.990972-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/code-patching: Fix oops with DEBUG_VM enabled
Message-Id: <167142239779.1486348.16847911791481464806.b4-ty@ellerman.id.au>
Date: Mon, 19 Dec 2022 14:59:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: nathan@kernel.org, npiggin@gmail.com, bgray@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Dec 2022 23:59:13 +1100, Michael Ellerman wrote:
> Nathan reported that the new per-cpu mm patching oopses if DEBUG_VM is
> enabled:
> 
>   ------------[ cut here ]------------
>   kernel BUG at arch/powerpc/mm/pgtable.c:333!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc2+ #1
>   Hardware name: IBM PowerNV (emulated by qemu) POWER9 0x4e1200 opal:v7.0 PowerNV
>   ...
>   NIP assert_pte_locked+0x180/0x1a0
>   LR  assert_pte_locked+0x170/0x1a0
>   Call Trace:
>     0x60000000 (unreliable)
>     patch_instruction+0x618/0x6d0
>     arch_prepare_kprobe+0xfc/0x2d0
>     register_kprobe+0x520/0x7c0
>     arch_init_kprobes+0x28/0x3c
>     init_kprobes+0x108/0x184
>     do_one_initcall+0x60/0x2e0
>     kernel_init_freeable+0x1f0/0x3e0
>     kernel_init+0x34/0x1d0
>     ret_from_kernel_thread+0x5c/0x64
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/code-patching: Fix oops with DEBUG_VM enabled
      https://git.kernel.org/powerpc/c/980411a4d1bb925d28cd9e8d8301dc982ece788d

cheers
