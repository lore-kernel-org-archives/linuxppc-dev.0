Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D62606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX9vlv/j
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQj20fvxz2yRC;
	Thu, 26 Nov 2026 03:52:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625574;
	cv=none; b=RziYZWtaOnZ2F/MU+FKQ+xeE43ZGJEXAF1XZMuU3VKa5RM3L5WIEDufxISbtEgaulvdYzzT5I55KphTDrYnoKPMitDjGF61enoUjBrw02oYnaSfwPyteakWivTrbtM8M5dukvZ9MrcNIuQSc7F5Bfw1YwlKYqI6xp5z18l3nXWG6BaHEcYfuLm/lhgc8/x74E/MxSONkkEoMWLAat8CFNXUa90IhMTxUd4aSUna3vUKbv5LDR+cS+o2RH2BoOsrfpvCALskKiHVwi0psYK3GQ/XDJ3G26IU9Av+gbpajzO3j6MhoS+9vYYbTmCuak5n/quyWNmDDRt+78asGnsKLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625574; c=relaxed/relaxed;
	bh=+h8/JWqvHXnTrakvtQCV9/1JAI1KduPnktbk/z9Pmlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5iU0PQ36zsnJlE73uio8aDRKinUAZUZxB77tBApK+XWmsB/UTnzygBAL05dJcoTEfxhLZKSJt45JlSnL+JCzgfoUpMixZvuh8hU8CEooZc9+Qsm81v7SsBcz5fB0PglIo/6AzrxvMoHcZZuLxKxLDTshXSfI4ll+FAU9G/NKorTEUdMGGXQFeoUZOpbqr/oJbhpacO4MBycT7Md8v8h4+ql7IzwyirlX6d9ez4TbMpmek9SybmtWumwm3navhk3hc/Jp/j/hXhw9pu4oKzALZ7R/689I/oyVz4Hh+rNCK9eADlDtl2L4JmEHXp0WSz0imnbp+Ey3Vy9m7Mt0pzxXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX9vlv/j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX9vlv/j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQj13RZKz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:52:53 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3866a784546so8109558eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625571; x=1796230371; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+h8/JWqvHXnTrakvtQCV9/1JAI1KduPnktbk/z9Pmlw=;
        b=FX9vlv/jTHX72FQbteo9YKgN76O8VscDgXUVCULtQHCbvN20lUfrxoKdTkffYjb6Zd
         qwrhyZWaq7HFfydxiQfRlK0mIZLlU3ppROAm3lWqhk0YmVg3mM0KqerpQuPDHzOo6TKm
         Mr4ypX7FCTcA+bbpL1rhw6b7DNwtS2irxPauYDhWZP+tyGkx0eg4cGbFsq/GTHBQoLoJ
         ks7o3dPM/LzG1nRXbc32l7dcSk4svNbaa6GokgOWiCAUuPLOXak08w5BFAFIo7mGleh1
         prjxuuVDcBQZUMRL+GMlM2NseHfVEVvCGK2wd2cxOpTdLcQu3sKJxkey+pysRgcocmVF
         KCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625571; x=1796230371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+h8/JWqvHXnTrakvtQCV9/1JAI1KduPnktbk/z9Pmlw=;
        b=DnmLl9btHdeUt6WiZNWYXhMxhgiYgGkzbfjFXDIZnA65r89KBfQ1UT+F6g+YUwI6J3
         8r/0iqXk4GNxrp8W0vh6xXnNvfOTVwVrAfGLlzHLu/q7MIkqTsqfYX2fXOxbWxqhaJEq
         DkeYayn99bL6e3+L5CNGUDUIePxXSxfJIbZOnk0MI5+V8yPz9aWrTi2HgSmuno2sXheo
         jts2L61WY4lmTzGvxMaRlmJD8trYDQUcSmC4gK1j6cqyU35F8o7y80qkNhRsHIfqpcBA
         DKv0zMFrLE4JurJtHe5AsKT0Ewy012VxzMlSsh7RTWhULtF8DvAA5cA3+Rq0AktSnadz
         BTsQ==
X-Gm-Message-State: APuU4Z/grgFEDHM0XiweiNRGvc3n2ej06QPqXZJhM6Pl9ry6rnPV1kvM
	BkWv3JHlRT/pxqGbjofs7/B6NKJQpBqN8bMd6KcAKzMzvjCUH+yS0fgaon9c1A==
X-Gm-Gg: AZFdTZc5DFadTn7RRCIjcfEEkmfayb4ObbcyFnYls0S8iL9k4rljN/7H2wsWWqmMVcd
	M35Cp3vGvtLoIy/zLesu3Ft1BY4qe+oIyqy2jIB2Kqf+53VUPyCckGvD8BDHXcNQ3LiuhK7Dh9C
	zkUUfr5/vD5zlHh4HaLlTMuwhOs9GN7E1YeEol8kQBXqVBgZaxRsOkF80FhIJ1R0KjWPZNxEF+H
	tLRQ5H7MHqMjy2NWrDZE+06JkASVRbkuWBxOrWDAqfE9dRsKzpy32MSDJKjJDx9irCV6gEaeP4z
	y+jMUfT85LaxIc6stfvteftsATOJZwQjMrRnK0mC9gTs6Jn5lGhRINlBhjoO3VVEB5/AxQRu2vL
	5jX1Zp84fuNSnC8T02JKmh5LnJN4hBjDPBzG3f0U4hF/XEH3glvWW4BbV06LrrKSvsf7YndkU6r
	1juV8N6qkz5P9atAO0iOFJx8H8ToctU8U3EzNC6okqQ81skmsC87C0J/CgxnmhJKRDfAh6K+GRh
	OPMpOEALI+9xjd2qgZ70cR5bbQeCqkDbdxj3+lZ/1I2MJ63B7H2tCmGvo/BgPS9HBziDhy/KcFM
	pyNXI6EoVXvMmh/6jRGmkYJPcnfZV+kUvA==
X-Received: by 2002:a05:7301:787:b0:386:c6f9:b56d with SMTP id 5a478bee46e88-386c6f9b68cmr4498467eec.16.1795625571242;
        Wed, 25 Nov 2026 08:52:51 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98545358eec.3.2026.11.25.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:52:50 -0800 (PST)
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
Subject: [PATCHv3 2/4] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
Date: Wed, 25 Nov 2026 22:22:31 +0530
Message-Id: <128398ae7491112604572d94778c938bf1e306c3.1795625038.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795625038.git.ritesh.list@gmail.com>
References: <cover.1795625038.git.ritesh.list@gmail.com>
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


