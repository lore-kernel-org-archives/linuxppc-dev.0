Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFD606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bUc6D4y+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZyTW07zDz2y2h;
	Fri, 27 Nov 2026 00:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795700686;
	cv=none; b=BvF0Pt3foPF0pQybT0HuFOccHxK/2un7rwhhGRDRQipkUfqzHXKyuwz1yzQWfcHHe+VPDSjsQoAuR27yX5ef69FrWtehawgU77WhYIM/8VH87T/3qhVDQwSCMgIWY6IvISAPBq8ykAafeaXFYiIQswTaujPZjirbOQAujvFyMTTwOo225WNIxSwi5VxWvtr02oVZITwAGv5S3KpIX2kNsJp4qQ3hK9YHXKjf70rspOGsmgovmLzg7xvm+zCnzTe9nZzTWQRPRX962r45FgbwceLZGU0hD8fq6nhdl+X5Yfclz2jlPpKH10vPxsSU5iHW1JzR+9xT6UZ1MEjVTxEUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795700686; c=relaxed/relaxed;
	bh=FutE3Dt4WAYQzSyNTGkp0eGUi0NDw5s5dO55H2LHifs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=BAkC8uLDf7a2V0XQYHG+EGzhwkeqINWjYYwAg2bckCCRP48o4gdqmL0VqugOEKbCRhRT9atB7aZkgjCuSFGlsJNtx3nLAgmluIDcvvlc2jeLi3yX8KKyB9gW63pRHAnAZnGWJWJCONrx4wF7cNivfHm3DdXgXWFk12fw4FnipxSpeA6s0bM0UIEF+jVS71iW8yWar+Mn8jZ6jFpYsmxizX5bM5sTfy++PaOXYzgtpYB+UU/8SPGR5cj9lGkc2h4jm5dMxRwB6wOkjUpD1nGdLQSACq5wqMNFEyiyQ6j6bDx35sVGH84NPGOUNdze/cqtDI9AMIzd//dA8p/zVut/QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bUc6D4y+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bUc6D4y+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZyTT6988z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:44:45 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1b546061d58so16142688c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700683; x=1796305483; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FutE3Dt4WAYQzSyNTGkp0eGUi0NDw5s5dO55H2LHifs=;
        b=bUc6D4y+rfh4FbGB8yCxmKMP+Ai+CdpDs2vhA1jK/N/3+cwVbYWCTrBj0+4Ek0aURY
         Ypk5PRffk7T0AMwxLcIJ37w4Cp/yc3nw+PoEG6gEJbcjUj+zCkIyrgh1ri/DIfxQdJfY
         dIan/ML/56WbHPuI/rVesjj6plZS8VZfbJyRPzdicOPK/Ep7pgO/+YCQGH7D25wqe41V
         3rb6DJhr2GvsTpA1D4iMP4yU4L7k9ZpJ3SFZcZlH8XKIEOOwaxYopKEO08m1DJlkuuEJ
         ZXi49FwpchvNcrj6IzRNRos2jCeAB/TGBFLLO037wlLCOTo5SmwzEoKXsoC20Yaly2lf
         YiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700683; x=1796305483;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FutE3Dt4WAYQzSyNTGkp0eGUi0NDw5s5dO55H2LHifs=;
        b=XVylAB8PsF+tlOcllo7GMCiruIsZCHfwYwGWK8JHjQnA4V+eJlmzH00W+2ZUUiHjZS
         iJd4r+tqjU0ENr0g5Pzeg9+oY0SddT4hy9QywZxWOHiBqfpzYA0zY59UrLVdEXprcioW
         q0ORs8Dlny3DICf1u1KPNxfrwsHNu1Z2cj8DhCvehN2wJI74A/6hb91FGOlObsEE/8ie
         sgirCmy3DH18QqzN7nEy3906XKixRZh/XCIIPo6dN+si+m8eKBeTYlUwrhrjeBeT367o
         gmizA4J6E7iKoLGFqgadd1dMIiEh6k9u9GUoN2mKYqbvc64cG6xOHA1+EM0UBOEHrmHf
         g9iA==
X-Forwarded-Encrypted: i=1; AL+hErHv/88eB1UjilmD9Z6puFc2kDmz0x8AcE3zQvVGw8agK5D5EYWQYNW0NYThAQVMG0dbNNdfY8cJ+HGJgDI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Ju4Z+9WVE575UNVlnTMWBgsRZUitVXbW1s6IIUaHpljfLE+xl
	4MrH3XdcB1iXbznX4tR3CpwlQu1y/BUNC1sxgSTNTVH07RxSB4ZVRrXh
X-Gm-Gg: AZFdTZcLNPp4FwT2ETGbzl0E04FhH90YnK2hd0mM4zExu6ce43olylUiILwDd5FfekE
	Jp4BAiOb+ivEM6oDU4sIyFGp6AXyG9IzTWBlg12f/Ce2aBAajx3Dtc93WoKZm+wVlrn0FaF6Pbo
	beKzWifgHkOQ+FrJZvmsybSMB0bwTZLmPCUyWMxRWDhMB8K1NuT+0EH8d1rML4hzD9Ha6bVzYdJ
	cejLa37fjlwCur+k9aAttDe0upmCkwPbGaBj0VELIEiq3p8CK+cl5l++MBEtHx8EMxPnCqOXh2f
	XxNk1pLa7zimIBtN5P/wKq+BXSFnivSIQuc+XA7aowv5CbYIdcoDhbRfwp4Yxo/MSc8DD976vsf
	GDpc23zgdTW/9dIq3LiGgMXAmH+3YzN74towxs1RrklVuLWTeFFQSPdBu3FcNj6RvHMB1Hf+xEd
	gCK8J9ZggzY0v7a6/V9wSw9A3+7Cp9lzoG/MSOdy7q52ZWNpjialxniuB2bsSrmDjghVdOuMezB
	9kiYOTAcRNWqm+atr91AEruVJjlqFKZtGtkCgZ333W3q+gVOgq4N5TNcwEo28Njkz8u9QWIF44k
	FhQLYuGzzNzaoplYtFAA2bHNd8eZ708iH6MzdJkbnCGg0+DY
X-Received: by 2002:a05:701b:21cd:b0:1b5:e9d:c641 with SMTP id a92af1059eb24-1b5568bc08amr20788013c88.18.1795700682366;
        Thu, 26 Nov 2026 05:44:42 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm50563787c88.10.2026.11.26.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:44:41 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 2/4] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32 and 8xx
In-Reply-To: <d7633118-f091-487d-993e-38a03f9be58c@kernel.org>
Date: Thu, 26 Nov 2026 18:56:46 +0530
Message-ID: <ik1jk9k9.ritesh.list@gmail.com>
References: <cover.1795666663.git.ritesh.list@gmail.com> <e8f8d59f9a3c88f45f873c91a2ff94586b68d928.1795666663.git.ritesh.list@gmail.com> <d7633118-f091-487d-993e-38a03f9be58c@kernel.org>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 26/11/2026 à 05:26, Ritesh Harjani (IBM) a écrit :
>> On book3s/32, a kprobe on an instruction that can't be emulated and has
>> to be single stepped out of line, crashes the kernel. For e.g. with the
>> following cmds...
>>      ~> echo 9 > /proc/sys/kernel/printk
>>      ~> mount -t debugfs debugfs /sys/kernel/debug
>>      ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
>>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
>>      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>>      ~> ls
>> 
>> ...we can see the following crash:
>>      kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
>>      BUG: Unable to handle kernel instruction fetch
>>      Faulting instruction address: 0xc02b919c
>>      Vector: 400 (Instruction Access) at [f19a9d60]
>
> Unrelated to this patch, but shouldn't the above address [f19a9d60] be 
> identical to the one in the "kernel tried to execute exec-protected page 
> (f101a008)" ?
>

Actually this log is taken from xmon. So [f19a9d60] is not a fault
address. xmon prints the address of the exception frame (pt_regs) there,
i.e.

arch/powerpc/xmon/xmon.c
static void excprint(struct pt_regs *fp)
{
	unsigned long trap;

#ifdef CONFIG_SMP
	printf("cpu 0x%x: ", smp_processor_id());
#endif /* CONFIG_SMP */

	trap = TRAP(fp);
	printf("Vector: %lx %s at [%px]\n", fp->trap, getvecname(trap), fp);

    ^^^ it comes from this print here 

>>          pc: c02b919c: filldir64+0xb8/0x2dc
>>          lr: c02b9148: filldir64+0x64/0x2dc
>>          sp: f19a9e20
>>         msr: 10029032
>>        current = 0xc112e900
>>          pid   = 102, comm = ls
>>      enter ? for help
>>      [f19a9e20] c1a8d420 (unreliable)
>>      [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
>>      [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
>>      [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
>>      [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
>>      [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
>>      ---- Exception: c00 (System Call) at a7596164
>>      SP (af802310) is in userspace
>> 
>> This happens because on book3s/32 the exec permission is per segment
>> (256MB), not per page. The page tables have no hardware exec bit, only
>> the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
>> sets N on all the kernel segments except the ones of the modules area.
>> So nothing in the vmalloc area can be executed, even when the page is
>> mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
>> a software only bit there and the segment's N bit is what the MMU
>> enforces.
>> 
>> 8xx and 603 (which is book3s/32) have one more problem. Their ITLB miss
>> handlers walk only the current task's PGD, whose kernel entries are
>> copied from swapper_pg_dir in pgd_alloc(). Only kernel text and the
>> modules area are sure to be in that copy, the modules area because
>> prealloc_execmem_pgtable() creates its page tables at boot. Unlike the
>> DTLB path, nothing fixes up a missing entry on an ITLB miss. So an insn
>> page in a vmalloc area mapped after the task's PGD was allocated can't
>> be executed.
>> 
>> Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
>> allocations"), the kprobes insn pages came from module_alloc(). That
>> commit moved them to the whole of the vmalloc space, on the grounds that
>> kprobes use a breakpoint and don't need to be near the kernel text.
>> That is fine on platforms where the exec permission is per page,
>> as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
>> It is not on book3s/32 and 8xx, where the modules area is not only close to
>> the kernel text but is also the only page-mapped area whose segment is
>> left executable. So the insn pages must keep coming from there.
>> 
>> MODULES_VADDR is only defined on book3s/32 and 8xx, so use the modules
>> area for EXECMEM_KPROBES whenever it is defined.
>> 
>> Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
>> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>

Thanks Christophe for your reviews and suggestions!

-ritesh


