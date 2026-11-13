Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C85606A88E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmjWyU0p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQxTd5TrXz3bYf;
	Fri, 13 Nov 2026 23:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794573125;
	cv=none; b=ge+7zy1Fc3VDpswW9C3vuSQWUaF9tMrW8MosGj6FZBtbndeB7OyQmXrLpFGE16NalgCalt++Hw8snJg7DSsFiM8DQy3WX85FM2ZOgA+QZdFLwsB8utZnPH9G3zCD+Okpv03ZvMhB5fZszEasAK9BAbV8pfs3ODQL1qKSKfs/1tXhwpOovnbXexlYda7ztXNR0m1i8UfLaH0oXQcKE9ir06JFcoERjteqK47vbKF4gMg8dwPsk60xytMj67dvHzbWmvEnoPs3GDoYhOA1RgJNH1fLkzYNWlQIWtQYUgUuy43I8KPOoBbZLjQCDiajqeqvlfRASSZhfBcg4M8zKaSOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794573125; c=relaxed/relaxed;
	bh=1TRAHROLyPFOQPbURw5yPb6dBc0t0u89LYQ9L587dP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kItJfApg6FNIoxB53lkoDcC10U4M/Vs2FYk7xNpreCNhe8xVqCYPFrqnb6zhW4etW16M5sv+zUg8fp4xEOMyR/KosFrqPCjeqpCduVBmG52b/HmAHEsf5oQkcKJi+SPxLIDn95LbSN3ZnloyMVvr/SK6RZXW5lnlA+MTaDi5V0bC26PzSm84oPLodkFiLPX9LCMREg8mNZh1edo/Vm192Rjf6iziHGndTqxhlQWPw9RH5Q9aOd8L4PqNd54Ftqh+cri7c/ov9RCw0XzQT4z1z4X9WXpBeBauOn4SERqmE37DTj8jcdVopl44j+H8+VJuLTphb9mBR2r/QcDqCyn6dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmjWyU0p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmjWyU0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQxTd0Rsqz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:32:04 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-372bdb942dbso991862eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794573123; x=1795177923; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TRAHROLyPFOQPbURw5yPb6dBc0t0u89LYQ9L587dP8=;
        b=MmjWyU0pCFuFikKnaCEImcnZ3QgvXaGGzwf3Kp+tee9tGzfH0OO+w4C7Yr7vd4xZBu
         eyICblbHxpBuR3ty76KRkTGFx1Xyr6S3doGvnNsW76CoYKrywZjR0aMbDCXg7LpMZtXi
         WFPaVrVO73iXJKeGSmcg32z3qw/hvREFhtlQ4QeAlNqWxFIcyiHpqHnWWlhI36eVZ4Mh
         aANgCGvyASgEjnEzvQ/600OpB6cjVzMHeNMiGG9gmCeG+nL0+kynNdrmWderG0RhfrX/
         D83QTLvPVwtSb+goSGOPFeszDbqs6HHIsnwe07Q8dQjzKhNmlH+w42XUxWFcU5oF+G26
         M4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573123; x=1795177923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TRAHROLyPFOQPbURw5yPb6dBc0t0u89LYQ9L587dP8=;
        b=or8UFfCflAmUipTfRxWAY1/4vby04OYKT5VCEfs2d8UKN5iNSJz7HQRcmE7jSNDreT
         EqVgWBY+iB/idXMd8M6do5SlaRh0Yaze8dc9GqgWULNbOjqdKWnAjjypUSZHUsvYSD2q
         7ePNqNMckFd18PfzynRuFzPXTznPYqu4exqUurSBALhfCxo1obz7INn1XLAqf5oDC7V+
         UL9OzjTwEt2LvCSuQMKx8CB9NOVtUpX8S0TQnGlkNuCMEtb64i9659TzTe3ERhSYCUVt
         HrsjDXRZtrklDPEfy67InIreKSWluDLltCtP3FFC9KFtzfd+fnTIL/4yGJMdeDRxgpI6
         96LA==
X-Gm-Message-State: APuU4Z9ssyAVWE8esNigBHTysRM99cjFti/P6I+J9dfDD0ZB4tchgfEi
	kxTVeC+FXkgZj5ROs8Mqo25+LYX9j+Awa8svyMts+oOqwbkiQu8g2D7Pa/3Fdg==
X-Gm-Gg: AYBFou0vR1LqxwxbD2pYhpZAxOzDyXmeAylyqgVdMgopIBdDKi2jR/MqfQ1UQpmAA1P
	pcw8VGc65X8K/nbwrZeSJZ/3fUYMSI41f0XamK77KK/VUlrJZBs1FoKI1bcHmgEbrBLmqwi9oxC
	50iUG7Po1bPgLZVpjFvrbkUuty92HdQJEwyKOmwCSAqT+OaCcLPvJJyVvvzyVdbe2N0K+qEaiFS
	B894ZcJcDQrr1OFasEQC672I9eCSSp6rxAAdgL2Zz34Nte9yX7EctXs+vo8Br9vpEMKlPcZG9JV
	mjMTCatmhHyctPhZO+7t3gcc+7DTRXM9UoGh2dZyMokfnoJPSoU4Pn6ot1al0Z75f12IYNlu5zb
	X3m0KV+BYxXqaMaPdvf1CBDn36nZbTIfxRooTZp3O7Nlg19m+L1YyjITUsfQIpsg3ztY4g87l9s
	pM4c5vmDRMBWBSF3PistsApRtuGOWokNj2jooY5oAWXqQdmQ7n0a1vfCqhCkg0FJs3jJ8li34sU
	HYwAHzHiZZzLUyF51ctCAPsaOVsZMEFVSsja81kXLg09iL9gBWpwcbmTy7nwuvGhs9PGKanQoNB
	xEcEuiGr1Y3sxUoQSc6cHDsj3HU1LwcJ34OJQSc4vOTmJQFQKD6RiLA=
X-Received: by 2002:a05:7300:d40d:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-37966e3a7cfmr2139549eec.11.1794573122574;
        Fri, 13 Nov 2026 04:32:02 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm7215936eec.10.2026.11.13.04.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:32:01 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
Date: Fri, 13 Nov 2026 18:01:37 +0530
Message-Id: <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794572365.git.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On book3s/32, a kprobe on an instruction that can't be emulated and has
to be single stepped out of line, crashes the kernel. For e.g. with the
following cmds...
    ~> echo 9 > /proc/sys/kernel/printk
    ~> mount -t debugfs debugfs /sys/kernel/debug
    ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
    ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
    ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

...we can see the following crash:
    kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
    BUG: Unable to handle kernel instruction fetch
    Faulting instruction address: 0xc02b919c
    Vector: 400 (Instruction Access) at [f19a9d60]
        pc: c02b919c: filldir64+0xb8/0x2dc
        lr: c02b9148: filldir64+0x64/0x2dc
        sp: f19a9e20
       msr: 10029032
      current = 0xc112e900
        pid   = 102, comm = ls
    enter ? for help
    [f19a9e20] c1a8d420 (unreliable)
    [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
    [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
    [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
    [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
    [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
    ---- Exception: c00 (System Call) at a7596164
    SP (af802310) is in userspace

This happens because on book3s/32 the exec permission is per segment
(256MB), not per page. The page tables have no hardware exec bit, only
the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
sets N on all the kernel segments except the ones of the modules area.
So nothing in the vmalloc area can be executed, even when the page is
mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
a software only bit there and the segment's N bit is what the MMU
enforces.

Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
allocations"), the kprobes insn pages came from module_alloc(). That
commit moved them to the whole of the vmalloc space, on the grounds
that kprobes use a breakpoint and don't need to be near the kernel
text. That is fine on platforms where the exec permission is per page,
as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
It is not on book3s/32, where the modules area is not only close to
the kernel text but is also the only page-mapped area whose segment is
left executable. So the insn pages must keep coming from there.

Hence, use the modules area for EXECMEM_KPROBES on book3s/32.

Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/mem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 77b63b52d8f2..ae1bc7359353 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
 	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
 	unsigned long fallback_start = 0, fallback_end = 0;
+	unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
 	unsigned long start, end;

 	/*
@@ -410,6 +411,11 @@ struct execmem_info __init *execmem_arch_setup(void)
 	}

 	end = MODULES_END;
+
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
+		kprobes_start = MODULES_VADDR;
+		kprobes_end = MODULES_END;
+	}
 #else
 	start = VMALLOC_START;
 	end = VMALLOC_END;
@@ -428,8 +434,8 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.fallback_end	= fallback_end,
 			},
 			[EXECMEM_KPROBES] = {
-				.start	= VMALLOC_START,
-				.end	= VMALLOC_END,
+				.start	= kprobes_start,
+				.end	= kprobes_end,
 				.pgprot	= kprobes_prot,
 				.alignment = 1,
 			},
--
2.39.5


