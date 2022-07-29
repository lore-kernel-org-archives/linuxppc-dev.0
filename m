Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306BEC00144
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:25:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvStP5M62z3fdg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:25:01 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSlx3g6jz3gFT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:19:25 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSlw50l5z4x1b;
	Fri, 29 Jul 2022 23:19:24 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, paulus@samba.org, tglx@linutronix.de, npiggin@gmail.com, Xiu Jianfeng <xiujianfeng@huawei.com>, christophe.leroy@csgroup.eu, mark.rutland@arm.com, benh@kernel.crashing.org
In-Reply-To: <20220701082435.126596-1-xiujianfeng@huawei.com>
References: <20220701082435.126596-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH -next v3 0/2] powerpc: add support for syscall stack randomization
Message-Id: <165909979124.253830.3036774942147857937.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:03:11 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 1 Jul 2022 16:24:33 +0800, Xiu Jianfeng wrote:
> This patchset adds support for syscall stack randomization for
> powerpc, which can make harder the various stack-based attacks that
> rely on deterministic stack structure.
> 
> Changes in v3:
>   -add a lead-up patch to move system_call_exception() to syscall.c to
>   avoid disabling stack protector for all functions in interrupt.c
> Changes in v2:
>   -move choose choose_random_kstack_offset() to the end of system_call_exception
>   -allow full 6 (10) bits of entropy
>   -disable stack-protector for interrupt.c
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Move system_call_exception() to syscall.c
      https://git.kernel.org/powerpc/c/1547db7d1f4481c1f3ec731f3edc724ef3026ede
[2/2] powerpc: add support for syscall stack randomization
      https://git.kernel.org/powerpc/c/f4a0318f278d98d9492916722e85f258c2221f88

cheers
