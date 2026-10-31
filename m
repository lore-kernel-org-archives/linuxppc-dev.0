Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Oct 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyym1Vjl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGqlp1JNFz2yD3;
	Sat, 31 Oct 2026 18:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793432774;
	cv=none; b=ErMnic+A68E1nUNf6byiR0NuX2FucvX2xrpdardMp5Yt1sk2h+UPR/zP2LTUJwRTqTy0FTq0EuE7nezKGP3zBbObzYe0KHvN21CHNK0iOJDU2fg2CVr37hwo5gI4h1y/ZfvBAeJPzPDt2x9Uhjrq4//rbICLVU59pZLzOJNwSAZX/Wej1FBCA+EWndGm/KTg7gwx6+XKNfPMURhGfFuNitzh0SHNlaws5WBT+An4o3u71VueOE8bI8t5aADIyI4fIB7ejld9HdXoNQ8TXojOWCTRuSoO9De2SNFAh4Y62tYEt6vJ+TWIc9J2mzgVRLfcnnUZk7lz8xNyddDztYxvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793432774; c=relaxed/relaxed;
	bh=Q+anSCD5u3UJDJHstH0CQ+hFvgotiSb9pTjA6yumXF4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Id2ZEos/kJ1oHzaRKOZ0gIvW65uKEmerJPrYDX7UNG61urGK3ZsrSbJE9WYjMY3j+TUPCRZW1banZe8/mwgMblFNoK9vZDShxh9v5IeluRvV05+5gJqPIUf5VBtipqF2OqhWJdCRIcys+WuLnQdtrmeNKa2IvISziHJoBeDf41Q7uGhUoqerSvP0sl44H9OB4El2io0JFfK3Rt6DayHFVZoDxKH1qjLU2GT1EyGo4dhNzGpJKo+0EREFzvEZYhX3ZKBoKGIUgkayX7959fxOeGwK7KAj3F9qaamiX2vfS1qQNpDz6t7rnFniZqXW1qEt4Kx7pJI4ZFve+ObwncfHjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyym1Vjl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyym1Vjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGqlm3Ntnz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 18:46:10 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36661f953e4so2238577eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793432768; x=1794037568; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q+anSCD5u3UJDJHstH0CQ+hFvgotiSb9pTjA6yumXF4=;
        b=nyym1VjlaDIcK+Nmeq9Pn6HXm/Wle1v2oswkG9Uh6bRQBPNM5A7dG2jpEZaiD7mgZ1
         myfMnHBjG7mq2dYU/08LjKyyChW1slGT4eEu59z2FBnzvx6zGbBzGYL9A6CFzW5vWVBB
         yWUt7f2+4OI8FAb4+NJ77Im2ozPouBgvULbpC3DAdMAm15gIaIjieHOcdyqInfH5LpKQ
         OjBidEsKC/WoHoWjIBfk/wRKlqTxRV/eZnHldfHVnQTDhNk/EoyZnPXNNs0Ldr+J04hg
         SjeBD+tOvgi5GhwBNbngEG2GBXIdzp0kPA+5ywh5eEjv+y/zAjoPyNQsRxv8s/jpmcLT
         PqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793432768; x=1794037568;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+anSCD5u3UJDJHstH0CQ+hFvgotiSb9pTjA6yumXF4=;
        b=NMK1t4jb45XNQHCkXpJFo88fcrxI9l9Ws0LdE4E5sa7EwD77eH/E6Gr+ukqKbAOvcd
         vHvdXlyr9zBM2KsxFGg+kAhgNpw3b1/D3HvWJBnjSaS0fa4lTSp4TjJF6AzRODzdIlf7
         czIZnquX7jN0aYMFhBDQ4qDsKUk6udfp46/C5eKKVRPyGPuT1h/v8crR5UJOSk0rRued
         McXUhiAPLRHEJIVqWhcEdCFVPcyaAsyt6EywUEgHQqVjtLDoPlh9/g+js2vfRJtb42cQ
         eQwfVQhyqzVFvc6fZeparZac3BMiJYcs38a5VRK7L6keoMStmMJdlYPQ5bIAoO+rAaP6
         14Lw==
X-Forwarded-Encrypted: i=1; AKwUvByLmHvaZ8TPeh1iTxSmcjpmfsojxYiUwiU+yMRx4MNWVnlWvz6r4VfzWDTQ/ah2bmiMGoYxab8sKyAhRWk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLUTwwo/SrmE0MYvPdZ9W+e4+hRa0I3cqa5jyz3JDm0Go1czP44
	uJSYEqLcg7Mhof2pnrsXQRSgXTGJt88+0DEftAaNTGJ3jBOcZ384u9KZ
X-Gm-Gg: AYBFou0uy47rGsgZw4+uRmQDQwhwMY+57LTO4xrC9P/5DCwxDGBdYgN4ZE6gioYLbyJ
	jy79BGaxIROkknhfYLZDJ864v1L0swTUOZL4zApNgwEt4epQpztWYDmh/eU7CAsdtdYb6bbBZJi
	L1YjU8/4mnQ3y9fHVzhSF4cI7RQKbIdry0D3z0vAijWgYpKQEVNw0Y1eXM7K13uVBeIW7wgHrmI
	R0ZzcaF1ZUt/lC8HBldYYA1h3RuNlnJErLCxSo2PtEzfjzjTEVY1bnel27UIQxSz32D4HmKaUBa
	2q7GsT4qTjM+RkC6L3JgVClrQGi4jF5fioNW4KrDCvUeOvaaqB9oYd3Vd5Q4duUVIaLCAAwUgPi
	wrUFEn3yInDwXzhlx3xIA+aUuOcjFLR5Fp8P9+/jmaH337lsTJppebHUF5+qseJg+YfcOABQKdQ
	mXqz88LUHUmRuzobM/z4toekOZVZO+WAnE9yPKToqThFc4a+/RdMKpXHSN94rbzXWkbBziiLFiw
	/lJ2Mmiml2+lDU3Zm++mjGyQziuYvAXWAhmIKt8M5c+jDCwpaLFn4f/zeGkfSn4wUW7s4MiPGYY
	mejrMYJOJMFtq7N23iCjGIh7aV0=
X-Received: by 2002:a05:7300:8251:b0:36a:1a65:ebd3 with SMTP id 5a478bee46e88-36a4237d4a7mr6361918eec.18.1793432767522;
        Sat, 31 Oct 2026 00:46:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm14780066eec.21.2026.10.31.00.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:46:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>
Subject: Re: [BUG] powerpc/code-patching: IPI with interrupts disabled on e500 SMP
In-Reply-To: <20261026195644.16384-1-pepe.schlehofer@gmail.com>
Date: Sat, 31 Oct 2026 12:47:50 +0530
Message-ID: <33tm72zl.ritesh.list@gmail.com>
References: <20261026195644.16384-1-pepe.schlehofer@gmail.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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


Hi Josef,

Josef Schlehofer <pepe.schlehofer@gmail.com> writes:

> Hi,
>
> On a P2020 (e500v2, two CPUs) running 7.3-rc1 with
> CONFIG_PROVE_LOCKING and CONFIG_STRICT_KERNEL_RWX, the BPF JIT
> triggers this warning at boot:
>
>   WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>   CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>   Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>   Call Trace:
>   [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>   [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>   [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>   [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>   [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>   ...
>   [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>   [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>   ...
>   hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
>
> patch_mem() and patch_instructions() disable interrupts and then call
> flush_tlb_kernel_range(). On nohash SMP that is
> smp_call_function(do_flush_tlb_mm_ipi, NULL, 1), which waits for the
> other CPU with interrupts off. If the other CPU is doing the same, both
> wait for each other.
>
> I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
> CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
> fine 9 of 9 times with jump labels off. The hang comes while static
> keys are patched and modules are loaded, nothing is printed and the
> watchdog resets the board. OpenWrt keeps jump labels off on these
> boards for now.

Thanks for the report and the analysis.

Looks like the problem existed from quite some time, but it must have
got exposed after you enabled the above configs. I guess some of these
configs are not default on - hence this might not have been caught so
far.

>
> The same problem in change_page_attr() was fixed in 2017 by commit
> 7c6a4f3b1641 ("powerpc/mm: Call flush_tlb_kernel_range with interrupts
> enabled").
>

I am not sure whether flushing the tlb after enabling interrupts is the
right fix here. Because once interrupts are restored, an interrupt or
preemption can run another patch instruction on the same cpu, where it
could use the previous stale TLB, which isn't flushed yet. Note that the
text_poke_area is per-cpu and the same address is reused by every patch
on that cpu.

So, maybe we can do local tlb flush since the text_poke_area is anyway
per-cpu and interrupts are also kept disabled for patching.

> I can test patches on the board.
>

Thanks! that will help. Can you give this diff a try please?


diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 44ff9f684bef..6351342fa5c3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
        return err;
 }

+/*
+ * The patch area is per-CPU and only used by its own CPU, with IRQs
+ * disabled, so only the local TLB can hold an entry for it.
+ *
+ * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
+ * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
+ * flush just the local kernel (PID 0) entry.
+ * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
+ */
+static void flush_patch_area(unsigned long addr)
+{
+       if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+       else
+               local_flush_tlb_page(NULL, addr);
+}
+
 static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
 {
        int err;
@@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
        err = __patch_mem(addr, val, patch_addr, is_dword);

        pte_clear(&init_mm, text_poke_addr, pte);
-       flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+       flush_patch_area(text_poke_addr);

        return err;
 }
@@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
        err = __patch_instructions(patch_addr, code, len, repeat_instr);

        pte_clear(&init_mm, text_poke_addr, pte);
-       flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+       flush_patch_area(text_poke_addr);

        return err;
 }


-ritesh

