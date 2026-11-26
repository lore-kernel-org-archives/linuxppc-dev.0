Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337DB606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHbs7qQy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZk5J04gnz2ySc;
	Thu, 26 Nov 2026 15:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795667187;
	cv=none; b=bvqslm37uuVK5k3zcyCOZ7NWF1Gl0UJrKnvwOpeZyJcqP31DyUT4cgVByNEddr3+pID+BvmYWvWVeuLQdUNgh4eJJI6w+8abwuNUEXQtPga3GWHJTy+3ztGQerLYoc2fHrc5MKVUX/Rrhxhwgowl8/xiQXliJRmiFPjib8010gjTo0eFIXuikYVwwxcd0FfqecAXNHinv8PXzlDsN/AapUGi1qqsLkkp8RnkZ3ow87FKM+ckAj/UpfCGT37Fqe0xDFeuF41j2njgzeyqimKM5k098GxhZQWMp81BIgUVXcjeo/D5KnNQSzmYsKDaVGFfc0ru8tU+lEwSStPN7JJ7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795667187; c=relaxed/relaxed;
	bh=HoA80N2orfJ66rdg5nw/PZVM0UN3b4vM2UXwegzYYDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLkLSpjM99tdmt8LhlhnekDBL0gAULkAKfkZtsWzoSAmwe/uNObWp9P7VnLKijEPyn0TRt2QUQDyA9UoJCWjb7a7X2zTG4KWzlJg/tScdlk0wT5o5McCDG5857cdedVo7IV/QiWacGsjpvt/jeflIvl0gLDNiqKn41W+dk8rfZVTAr19LH08687nV1T+BkKEocj+UFteofwYkT2srW28aZalYsEhdJX12pX2A/gq/OvVP1GTCRjuU9umV5qUtrkQlYjExS4T1VfwHXBw6NXTds5ekdjDL/a997i/vjQpZ2V1tn6hn4V9HyW9nP39EpH/ym3ypeFN+GKvyl2EEoz/LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHbs7qQy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHbs7qQy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZk5H3Dtvz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:26:27 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-33fb4680717so1647372eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667185; x=1796271985; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoA80N2orfJ66rdg5nw/PZVM0UN3b4vM2UXwegzYYDE=;
        b=iHbs7qQy2vbSDJxRDgEZKPwc++nWbR6CgZeXVElMGB8sEyc58NHoWiV3TLI27cvWVg
         F8/TcBXi0jyhtAxUo20SdsyCtezHHGIdjFx7pUR2PxHN021yM4rQbDTHdnjSQ/pDc4AJ
         7rGUgShYzc62niI7p1X39AGa2F34eB0RxO0VUnTVkvnPcvVKww9IwqcAHrfNRpXqP0QT
         IojjqGm1oVr6pAGWSxaNKlmptWrFN/BYtfL4hqMk81eXiZUMmCbRn3z/K4JxsknqCtlX
         cNPWhA3YlcJNw0tU7+bTdEL0lPQaljl6mmDHRXoXq6LHGs1d2oxAHsxO9sWr3sL7cnqS
         iY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667185; x=1796271985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoA80N2orfJ66rdg5nw/PZVM0UN3b4vM2UXwegzYYDE=;
        b=RO/am+iRcpOu7fuya+3HKd6O8ugvvEHegyjil9cN9r3zL2e217NT5zhaR0dEyAHqOa
         mklaZwE3IiHxA97BeU+0M+nGJ/dX9CuU8+34UBpo6HpTQnM/CsyYHZBUcnoxsWghXp+y
         VWVJzz6H9oQKfVjnGNYo91QeJ81zoN+K+k2fIsg7ci5xVZcaq4TqxWY/YnENxpd7yWGj
         G00fHHI5RXqRMdaXR804VVv0VjbpTS/FhDSLE5zAGEOgGlm0TR8bPLVuf0m4dgPPAgaT
         E5EM6HIbx4RAbg88shncP6qajUVFTGFYliNdj9zlj+R+IU6wNDS8uKZrGKwiEZjcGSQ6
         6Kew==
X-Gm-Message-State: APuU4Z90ScCRcNdKlwAXdzmdS2fwlz+lKoohFnh8GZ0mA8W3+bsC5mTt
	JINm8VC/2fw2kQxFjPew2kkQ7TvrUBgY9q8wDHXN3P0AoewbZv3Esvb4HapUFg==
X-Gm-Gg: AZFdTZda7tAItaOlqL/7ndfe94+vAFWR03ACmIp8FSwuk03ypFAePMtJWWg7qQaZKU4
	rDdzZTrfZq9oIkV2mX1QxYzikTfIMW9hzXQJ8YmMjrxjgwhCRBmnriEToda6/94iBU+NXHgNFRx
	goei8nnrj78v44RC2LVLVai/BmiA+vl4HeXBnIMnROtFlIAMU0a5I5/S1Etd8AbnO2UUgJjMwB9
	nQSZ9z6jn3yTPi7JBsFlRtuedtNpNYOgrQbV7P271d92y7XcpE/wIP99VvlhidYdBpzTGy/BHUh
	ABRxG0low4x+IqIyAT+rREOoasb9uiFmx0B1zSRYZAH6A7B+gEQNpkKkJfEBZC8Ip2pfveIZv53
	UYTrMvoP6f3mw9OXoMYg0YorYNVVe7ffUHzDcznh/26pV/1UAVGwJmsDAFnpt5YBY9PCZgcHpso
	et76Jr8sUD92tP+bFejSV8wNXnQKPZ1KA3Rphdct3G8aTrYEw5YftAkF91iJT02w6D7PraTXmw1
	8ciElJAnEsyXfz8LZPeVnxlg2bKnvXTKkjgnKv872Frl2UyPnvt/APH55T0NdQ977AFcUs83RnQ
	xGL69KLedSRuFZuPC0Sa8GqMfkqYyfBEnw==
X-Received: by 2002:a05:7300:f498:b0:386:a716:916b with SMTP id 5a478bee46e88-386a7169544mr14198703eec.31.1795667185369;
        Wed, 25 Nov 2026 20:26:25 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54542185eec.7.2026.11.25.20.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:26:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v4 2/4] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32 and 8xx
Date: Thu, 26 Nov 2026 09:56:00 +0530
Message-Id: <e8f8d59f9a3c88f45f873c91a2ff94586b68d928.1795666663.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795666663.git.ritesh.list@gmail.com>
References: <cover.1795666663.git.ritesh.list@gmail.com>
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
    ~> ls

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

8xx and 603 (which is book3s/32) have one more problem. Their ITLB miss
handlers walk only the current task's PGD, whose kernel entries are
copied from swapper_pg_dir in pgd_alloc(). Only kernel text and the
modules area are sure to be in that copy, the modules area because
prealloc_execmem_pgtable() creates its page tables at boot. Unlike the
DTLB path, nothing fixes up a missing entry on an ITLB miss. So an insn
page in a vmalloc area mapped after the task's PGD was allocated can't
be executed.

Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
allocations"), the kprobes insn pages came from module_alloc(). That
commit moved them to the whole of the vmalloc space, on the grounds that
kprobes use a breakpoint and don't need to be near the kernel text.
That is fine on platforms where the exec permission is per page,
as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
It is not on book3s/32 and 8xx, where the modules area is not only close to
the kernel text but is also the only page-mapped area whose segment is
left executable. So the insn pages must keep coming from there.

MODULES_VADDR is only defined on book3s/32 and 8xx, so use the modules
area for EXECMEM_KPROBES whenever it is defined.

Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/mem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 77b63b52d8f2..8a0fdfd028dd 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
 	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
 	unsigned long fallback_start = 0, fallback_end = 0;
+	unsigned long kprobes_start, kprobes_end;
 	unsigned long start, end;

 	/*
@@ -410,9 +411,15 @@ struct execmem_info __init *execmem_arch_setup(void)
 	}

 	end = MODULES_END;
+
+	kprobes_start = MODULES_VADDR;
+	kprobes_end = MODULES_END;
 #else
 	start = VMALLOC_START;
 	end = VMALLOC_END;
+
+	kprobes_start = VMALLOC_START;
+	kprobes_end = VMALLOC_END;
 #endif

 	prealloc_execmem_pgtable();
@@ -428,8 +435,8 @@ struct execmem_info __init *execmem_arch_setup(void)
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


