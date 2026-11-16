Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68867606A334
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WJ92mhax
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSgJ817vlz2y7p;
	Mon, 16 Nov 2026 18:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794815992;
	cv=none; b=Cg7eqUriVPZ3WWY46djedusLxYFMe3lh/IXbHfIPBE2WzFyomRuZlgc0zdJKyrSymMADUo+qmCt4/CqYp+chAa2q7bSWGc7OlcIX7sVKN5/Ig+3JcQ4WKZQOK/d2yEHMfKfxy9dia+AIxRNYB8/Ut+SYEW6VPEaJRnnD9oHxdX5SK7IVnX+GIrzUP/gGU4fofR41b9oJHDVEsf0uyTDRW47dh8S4N/QIDEfA6E8rKMIB3CaKQSh/cpvv04q5pjKEszXW8ez8X0iDaQbTPbzrp5NSoTCKnMZByzVikco5tQt5IganfRTmSBF1qNBOnqGF5PRbS83au0yxreGSDp+Nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794815992; c=relaxed/relaxed;
	bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecgk5abzDi/OeiofzJmOuIVlAzYvT5BqW6R2wr2g2aclFcnaAY2BQV8x+7JJ2AtN8ZvFFd1UVAkRmkN5WbpTp9aKrCHPqtnMY2osWRHBiqIaACZGwcy6DINaSik3ApmvV3tkijIVM/HlSzhl2BfCeIaywhfQ7u0sjDdAYuh2noXCDZMTb1Ce+4GryA7zlsmE2LAApV7TnUHm1fgg1kwNDUKP1DZIXKmYHTKLwDRp3M6cwmdZvWv8ttmBtiBBMrckTa8SEM4N2OpTB8ELJ7OZeYnFCLmdkBfPdExEb/yTDcFK9aDqI0Mj7UtU4aOCywPEKjzCM6HYkSQYtqQDDQ51BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WJ92mhax; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WJ92mhax;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSgJ71Tg0z2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:59:51 +1100 (AEDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-48dee593f18so3296512f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 23:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815987; x=1795420787; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
        b=WJ92mhaxC2tZE2m84yWo5+2bPxBf3JWNj8xqJJDYLlkMia0IziqtI/T+iitaYtTJE1
         vVryVX+Re+wp+S6eBTV1q0M2NBbDJb42gW+VxOHw0pLZt4o3/bbwUfAY/kR3bT/X3vMJ
         pVdjERLHt35DOVJLMJGx7PapoD9xa6oYHILtVBpEOor6VGIgTLgyPbwlkFlHPLxmSROQ
         CvhYGAbkGnLt7pM76WPEj8ib6Cy3UU4v7DraWqzLezLNvZIHzM073RkNP3WgP1N1VDpB
         /swnGo3m2Unqp1fkic4c5DZp5fSna9skj9bZOXDogWnwk8DNmjjnLj91xBlN/lokJaTJ
         2/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815987; x=1795420787;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcuJSSxZnzgSbNJLicY5YRDK+dG26RVtPhpOzcEjiSU=;
        b=qlurp+ONzwPpMKtIY7TD2b57n7W1vrURe8CK6U+3nXHfKh/Z5PyDEp4uEapyJwE2RE
         bH/hKnVvux7Z26nS/B8DzfyQV+5mrXcanPgPK6TTPmInynsoWqGvUdb4849kIM53nLs0
         FxHHUQDymRvWxYeuYD3a268Xo4TdMna5mLCxLk/7dNPOwOCGYSeKsT6nEfaySKNNQfk1
         8fJbg9/pLDB4Uq2fLh1pb+Fn/oMe4Ob8pZLlTaz5pOFnwguwBsgRC9BKLC79MSJjQsFk
         V8XcjEsho/+r5Be7YqDai5ZsmhqTb+5yEN4wSos7Kk9CSQ+K00zv1KO5yKHZYo2V2zPa
         rrMA==
X-Forwarded-Encrypted: i=1; AL+hErG3g6u5ToCrL+eC9IGcg0jVnpSmXo9CpE7OQQJAOZrxz8zp/E04qKQTzMlFJg7eal1x3bjw1CJhnrljNdw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9eyoNH4qI2264aDu4+QQV5fPFoKi1MHnw/Mo8a85eVF5/38t/A
	OWunAE6esCwZA6qbQz2jssA4YQ0ciZ0IwUSyRg6eRmX0JP4RJhUGFoZUZCP/kUixpSQP
X-Gm-Gg: AYBFou2gdq+0qCv2jXHKswKjf6ZERhqJq/TBKZIjF9BalhjhX7w+P6E3oBafXSV4ZQB
	w6NlTgdHRI3+uoT4B5E9OEDQweWyIkKaTtV1qrNzSm4WgC9NThOuGXY8K5xpzuwQ46J9kU7la95
	sQ3tHRNUNHegvb64igKdWoSa3d3SW8TnzPvTBEU9LI7WoFv+eMpqzzptGwB/WfSrtLTRyXJF10H
	X9rst48popVyKsSjPciO+Ce8gnw/KYuNSb5zudz8rYBmSojEsyaKdSDu45ORLk8J6s95btGW5ln
	PSwKjqYmMazbWtUcAr1DC0NSdqoghFrZNLjUckDJyusHz5my64jPifoXOI8hXoD5tReMECNwgoc
	IR1EG0ajL2mzeNLUxMYt3q/ke818qyYkMZmbF9NkaeZeWYoFmHKDwGArO3PqeMbxHKLSl3RL/JV
	bwXNGjvwheRbjuosOPqaTUh2qLhsTB9+sj9nePeYE5qdCbcfuDBJJLEQlIZpGeEdp5ajPapife5
	oSCsrRWvzuGOVTJuW26UrnPuRdocOLIwGC83FGlYrbYH41+nNLkIxOrDxiKq3vZIzs/4BYgoqbM
	QZhiqvjSlWMHh70eoXeXBGmy9jBPsCB9pmNoUbsh5ruHEjKljGv7Ccsqzhm0meRT4BARXlZ7Zks
	NMlH+hXyf
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr20349731f8f.12.1794815987554;
        Sun, 15 Nov 2026 23:59:47 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm15766858f8f.50.2026.11.15.23.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:59:47 -0800 (PST)
Message-ID: <832e0f9ce4e81ee31a6bcde01591a56aac36e976.camel@amutable.com>
Subject: Re: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:59:45 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel, and that
> memory
> may well have uncorrectable errors. That is after all what the first
> kernel often died of. Every architecture that maps a page of the old
> kernel and copies it out does so with copy_to_iter(), and a machine
> check in that copy takes the capture kernel down.
>=20
> On x86 a machine check in the kernel is only recovered from if the
> instruction that took it has a machine check safe exception table
> entry
> or copies from userspace (cf. error_context()). The copy of an old
> page
> is neither. Its source is kernel memory, whether it goes to the
> buffer
> of a read() or, since commit 4a22fd20379c ("vmcore: convert
> __read_vmcore to use an iov_iter"), into a kernel page for splice(),
> sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
> into a poisoned page panics the capture kernel, and so do vmcore's
> own
> reads of the ELF headers and notes. Breno sees the result on a fleet:
> the first kernel dies of a machine check and the capture kernel
> produces
> no usable vmcore at all (cf. [1]).
>=20
> On book3s64 a machine check in the kernel is recovered from if the
> instruction that took it has an exception table entry (cf.
> mce_common_process_ue()). The user copy has them, so a read() comes
> up
> short there and read_from_oldmem() returns -EFAULT. The copies into
> kernel pages have none and panic the same way. Other powerpc
> platforms
> don't recover from a machine check in such a copy at all.
>=20
> Copy with _copy_mc_to_iter() instead. x86_64 and PPC64 select
> ARCH_HAS_COPY_MC, and on x86_64 and book3s64 the machine check safe
> copy
> turns the machine check into a short copy, which read_from_oldmem()
> turns into -EFAULT like any other short copy. On x86 that holds for
> the
> fragile and the enhanced fast string variant, a CPU with neither gets
> the plain copy it has today. Everywhere else _copy_mc_to_iter() is
> _copy_to_iter(). Put the call into a helper, copy_oldmem_to_iter(),
> so
> that the copy of a page of the old kernel lives in one place and an
> architecture that gains a machine check safe copy later gets this for
> free. The helper does the same check_copy_size() as copy_to_iter(),
> so
> hardened usercopy keeps checking the copy.
>=20
> With a v7.4-rc1 capture kernel reading /proc/vmcore and a machine
> check
> injected into the copy of an old page the capture kernel is gone. A
> machine check panic prints no trace of its own, this one comes from
> panic_sys_info=3Dall_bt:
>=20
> [=C2=A0=C2=A0=C2=A0 0.580568] mce: [Hardware Error]: CPU 0: Machine Check=
 Exception:
> 7 Bank 1: bd80000000000134
> [=C2=A0=C2=A0=C2=A0 0.580574] mce: [Hardware Error]: RIP 10:<ffffffff8190=
9b11>
> {_copy_to_iter+0x81/0x850}
> [=C2=A0=C2=A0=C2=A0 0.580584] mce: [Hardware Error]: TSC 202f2117f ADDR 1=
0000000
> MISC 8c
> [=C2=A0=C2=A0=C2=A0 0.580587] mce: [Hardware Error]: PROCESSOR 2:aa0f02 T=
IME
> 1794493617 SOCKET 0 APIC 0 microcode aa0021c
> [=C2=A0=C2=A0=C2=A0 0.580589] mce: [Hardware Error]: Machine check: Uncor=
rected
> unrecoverable error in kernel context
> [=C2=A0=C2=A0=C2=A0 0.580591] Kernel panic - not syncing: Fatal local mac=
hine check
> [=C2=A0=C2=A0=C2=A0 0.582587] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted=
 7.4.0-rc1-
> g6628e7d4c6b2 #1 PREEMPT(lazy)
> [=C2=A0=C2=A0=C2=A0 0.583101] Call Trace:
> [=C2=A0=C2=A0=C2=A0 0.583198]=C2=A0 <#MC>
> [=C2=A0=C2=A0=C2=A0 0.583279]=C2=A0 dump_stack_lvl+0x4d/0x70
> [=C2=A0=C2=A0=C2=A0 0.583419]=C2=A0 nmi_cpu_backtrace.cold+0x18/0x6e
> [=C2=A0=C2=A0=C2=A0 0.583584]=C2=A0 ? __pfx_nmi_raise_cpu_backtrace+0x10/=
0x10
> [=C2=A0=C2=A0=C2=A0 0.583772]=C2=A0 nmi_trigger_cpumask_backtrace+0xba/0x=
f0
> [=C2=A0=C2=A0=C2=A0 0.583955]=C2=A0 sys_info+0x83/0xb0
> [=C2=A0=C2=A0=C2=A0 0.584075]=C2=A0 vpanic+0x1b4/0x303
> [=C2=A0=C2=A0=C2=A0 0.584197]=C2=A0 panic+0x66/0x70
> [=C2=A0=C2=A0=C2=A0 0.584488]=C2=A0 mce_panic+0x19e/0x290
> [=C2=A0=C2=A0=C2=A0 0.584799]=C2=A0 do_machine_check+0x627/0x9a0
> [=C2=A0=C2=A0=C2=A0 0.584953]=C2=A0 ? _copy_to_iter+0x81/0x850
> [=C2=A0=C2=A0=C2=A0 0.585099]=C2=A0 exc_machine_check+0x68/0xb0
> [=C2=A0=C2=A0=C2=A0 0.585246]=C2=A0 asm_exc_machine_check+0x1e/0x40
> [=C2=A0=C2=A0=C2=A0 0.587747]=C2=A0 </#MC>
> [=C2=A0=C2=A0=C2=A0 0.587831]=C2=A0 <TASK>
> [=C2=A0=C2=A0=C2=A0 0.588092]=C2=A0 ? iomem_map_sanity_check+0x98/0xb0
> [=C2=A0=C2=A0=C2=A0 0.588430]=C2=A0 ? __ioremap_caller.isra.0+0x1a9/0x300
> [=C2=A0=C2=A0=C2=A0 0.588604]=C2=A0 ? __copy_oldmem_page+0x3d/0xb0
> [=C2=A0=C2=A0=C2=A0 0.588928]=C2=A0 __copy_oldmem_page+0x5e/0xb0
> [=C2=A0=C2=A0=C2=A0 0.589079]=C2=A0 read_from_oldmem.part.0+0xe3/0x140
> [=C2=A0=C2=A0=C2=A0 0.589247]=C2=A0 read_vmcore+0x137/0x280
> [=C2=A0=C2=A0=C2=A0 0.589381]=C2=A0 proc_reg_read_iter+0x49/0x90
> [=C2=A0=C2=A0=C2=A0 0.589533]=C2=A0 vfs_read+0x348/0x490
> [=C2=A0=C2=A0=C2=A0 0.589666]=C2=A0 ksys_read+0x76/0x100
> [=C2=A0=C2=A0=C2=A0 0.589792]=C2=A0 do_syscall_64+0xde/0x4b0
> [=C2=A0=C2=A0=C2=A0 0.590103]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0=
x7f
>=20
> With this patch the same injection ends the read() with -EFAULT, the
> capture kernel logs the machine check and keeps running.
>=20
> [1]: https://lore.kernel.org/all/avRXzzCSzT9Qj2FC@gmail.com/
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Breno Leitao <leitao@debian.org>
> Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an
> iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c |=C2=A0 4 ++--
> =C2=A0arch/x86/kernel/crash_dump_64.c=C2=A0 |=C2=A0 2 +-
> =C2=A0include/linux/crash_dump.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22=
 ++++++++++++++++++++++
> =C2=A03 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 1543917bd3e1d..f784fc5cb0030 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -83,12 +83,12 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0
> =C2=A0	if (memblock_is_region_memory(paddr, csize)) {
> =C2=A0		vaddr =3D __va(paddr);
> -		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +		csize =3D copy_oldmem_to_iter(vaddr + offset, csize,
> iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> =C2=A0		if (!vaddr)
> =C2=A0			return -ENOMEM;
> -		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +		csize =3D copy_oldmem_to_iter(vaddr + offset, csize,
> iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}
> =C2=A0
> diff --git a/arch/x86/kernel/crash_dump_64.c
> b/arch/x86/kernel/crash_dump_64.c
> index 32d710f7eb84c..e10dada855b70 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -29,7 +29,7 @@ static ssize_t __copy_oldmem_page(struct iov_iter
> *iter, unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap((void __iomem *)vaddr);
> =C2=A0	return csize;
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 8315270e27b7a..12aeaa40c1c94 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/proc_fs.h>
> =C2=A0#include <linux/elf.h>
> =C2=A0#include <linux/pgtable.h>
> +#include <linux/uio.h>
> =C2=A0#include <uapi/linux/vmcore.h>
> =C2=A0
> =C2=A0/* For IS_ENABLED(CONFIG_CRASH_DUMP) */
> @@ -33,6 +34,27 @@ ssize_t copy_oldmem_page(struct iov_iter *i,
> unsigned long pfn, size_t csize,
> =C2=A0ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned
> long pfn,
> =C2=A0				=C2=A0=C2=A0 size_t csize, unsigned long
> offset);
> =C2=A0
> +/**
> + * copy_oldmem_to_iter - copy from the crashed kernel's memory
> + * @src: where in the mapped page of the crashed kernel to copy from
> + * @count: how many bytes to copy
> + * @iter: where to copy them
> + *
> + * The memory of the crashed kernel may well have uncorrectable
> errors.
> + * Where the architecture has a machine check safe copy a machine
> check
> + * in the copy ends it short, like a fault would, instead of taking
> the
> + * capture kernel down. Everywhere else this is copy_to_iter().
> + *
> + * Return: the number of bytes copied, like copy_to_iter().
> + */
> +static inline size_t copy_oldmem_to_iter(const void *src, size_t
> count,
> +					 struct iov_iter *iter)
> +{
> +	if (check_copy_size(src, count, true))
> +		return _copy_mc_to_iter(src, count, iter);
> +	return 0;
> +}
> +
> =C2=A0void vmcore_cleanup(void);
> =C2=A0
> =C2=A0/* Architecture code defines this if there are other possible ELF

