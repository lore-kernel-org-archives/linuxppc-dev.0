Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1370606A8AA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRbxp832
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQxTY2l78z30Vm;
	Fri, 13 Nov 2026 23:32:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794573121;
	cv=none; b=LIz+gdcono0vOp9ZDQxF3EIUfr6Jsw/6IXr8a/sECSAU3opM/7xM/LUowweSH7oIH4BvmU/c8Dj1dEYKXeGfbaQInchfVZ+oGJdn1gFbe1Nhs8aO+cbxeaUI4bp/pp+Xipq4vMqOGuzJO/ghA4zPq+fkh6gUo+y9tuTuefVCwTTYFTexZCn0dj5ErzzVHth9gfnHzS0v3eIOg9YdOUsP42casMh3Nrf7HSNNPIPj9jRGsJLNq2Z5RO7YvQF2wlz08oM6jNkS2A/ny1Jn+Sue17vZYG3qg15+3tbDTkQLX17AXLVnASpWF8A4Ens7Ef5BAG90HP76pfKJQqppDhhhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794573121; c=relaxed/relaxed;
	bh=khvjomnGU8bEDjFqLljgS/oBqM+vVqEvr9qW8v1bN2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8ynoHWwogPp/ZCZiyby9Zht/Xlpe9uWiYo9TTh/uD3pyPzUJVOk/xEvxMuft3Nmg8AiXYjX2ssP2+MJU4wdZgu7k/Q/urAWsLK6LqxjpX2xUZz1McOBecBsJE/5CAB/o2Trc/r9VdMGkv9zFMcXcan/LnBbJDQcnsBs8VA4UDVQY4DQnx3gLckZ/LlCdl0CNvLT63nYQyJYsMkIbyUT1q84R3hnW/hB9EesUqhE58H6ustpeUf9eUhIcQh+585fuYET8KnAt+P02UuCm0EESJko8sP9/yBeclqMCWj4tHqUzeRQttAInE7dDiycQcodYoFQdf2Dz4mhcn3UttyXtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRbxp832; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRbxp832;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQxTX5j42z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:32:00 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1b3acec6677so993568c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794573118; x=1795177918; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khvjomnGU8bEDjFqLljgS/oBqM+vVqEvr9qW8v1bN2k=;
        b=PRbxp832ZshLja1yfR9hzzt2EpZWy4vL+adxqylfmKbHqfFPOsT3+dBEojlB6bgRJj
         V8bImBBbGprHXYFW3I5YgEYy0VPtlKlMdEBbIix/wrXzNbb2XpXXzmCJ19J2jij5mFTE
         DvlThqjBUlpgOCUXen5rnR3unn7SmBKzItKmil0nN/G/79BmUryxl1FqOOd2Y2s0+woR
         wcGpq+UcJ+c6q/lCXdAMysIfyGkNBCzR4VYMpEbrjPwH7+wIe52m7/gTQTA6Kwh3T0kF
         y/d8jBqG00qKpk3QEerHW6/xybnZGSo+P6OW7+czk9A/DtNxsDMgAGr+Anoq7wC1DkZ2
         pziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573118; x=1795177918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=khvjomnGU8bEDjFqLljgS/oBqM+vVqEvr9qW8v1bN2k=;
        b=kYrGTIzn4CE7zpsxQcJ+FmT3Ur34sVKxgDQViY7rOmFUl0jgjgnTR9Doygqcyvn1O2
         JFnXv6O2ulR/M+5bM3EOKNphYebOBdzQ+GCQOrHdDO/roNACJGR6Gw+HGSN/1/gpTNxS
         clVCqK4v5rnujql1VxboqEsLoIEOF4YYtT7iQrA46j4WmwzH+eju3GFU4eaKiPNy5Y5T
         Mg3D1YJbgRZyTAyg4qdn4jlZwGw6pO9SVT05z8hBadbj4XoqAQBSSHsTMe/SM7Eb+KZ4
         lXzLe1Ymrvu05WKwggQcaU7zUIAIZWB8df79o8UCO0bny9pm/ZPg8EVLco+HhJrYKD0u
         9Brw==
X-Gm-Message-State: APuU4Z/nztG1ds/VDT4MgJz3KKoD0Th9h00c6ZpKNrXXUfFJnuRtzko/
	ooBZtAqxGuJMZyxYHWnXS3o25rm99aH7h8S3A8VpbJ5kDpWYaHifVU+cYeEp0Q==
X-Gm-Gg: AYBFou1Bi05hdHU4DjAoNARoLc2IBFno0BKsVcxQ4ugmJ9X7i0kpBK86fdhpwm+EVnc
	nPRhgxzNonk5JlwOwKJVAnWemYhhQAqH0RR48weieRkAdoWy5SjtoWEIP/qqadu0xE3kW6PNnvE
	ze3k7CpDN5a0zzKy7SJlPOCgTtmUbazjIxAbeRvpAQwV1+X/w9YC+TFGxuGTxU+zA48Wkqf4THj
	q6+0UzIumaGKnfDiuL3G4xIV2RAdwQmHnzicerDlNoH4mBeSP728HOHcj0WsRcbwKq6NFX2AUEg
	rJ+1lG8K1n/9kVTudrST/ZAQ4d2RTlv4DtD/3qorZzjchEemhQzzBdZlIXFPdW7PzyMPS7XI1G7
	ggwwv+OpjkEzUgwB3a5bsZCd1QIXzIW9K21d8madZlrA3h/l33pGjqSITN1Jpq+u7OqtZtEneiA
	T4aiG6QamjQq8cKFUVRv2FErYnzIynT1N6kr8QjyC4uWK5Ql1abJhcRBNU5quwc5SK13fgO1nmy
	li3RUwTCJKP7XYE4WceVV7zFsuBoWBAvUoiP6F6NICF9vqmBmZ7CknohUoD9YFl+M0Tq3j466nn
	K7I79RvvRDaSq55mcglDijDvTG94fySa3jE=
X-Received: by 2002:a05:701b:2519:b0:1b2:373c:997 with SMTP id a92af1059eb24-1b5031128damr2279412c88.25.1794573117837;
        Fri, 13 Nov 2026 04:31:57 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm7215936eec.10.2026.11.13.04.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:31:57 -0800 (PST)
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
Subject: [PATCHv2 1/3] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
Date: Fri, 13 Nov 2026 18:01:36 +0530
Message-Id: <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com>
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

commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
CHECK_WX default STRICT_KERNEL_RWX.

Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
we can see the following warning splat at boot:

    powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
    WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
    NIP [c0000000000ac204] note_page+0x4dc/0x4fc
    LR [c0000000000ac200] note_page+0x4d8/0x4fc
    Call Trace:
     note_page+0x4d8/0x4fc (unreliable)
     ptdump_pte_entry+0x70/0x94
     walk_pte_range_inner+0x15c/0x260
     walk_pgd_range+0x6d8/0xd5c
     walk_page_range_debug+0xa4/0xf0
     ptdump_walk_pgd+0xec/0x304
     ptdump_check_wx+0xd8/0x154
     kernel_init+0x94/0x26c
     ret_from_kernel_user_thread+0x14/0x1c
    Checked W+X mappings: FAILED, 1 W+X pages found

This happens because CHECK_WX noted a writeable + executable mapping.

This happens because execmem_arch_setup(), checks for
struct_modules_rwx_enabled(), while kprobes depenency on modules was
earlier removed via commit:
    7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Since the insn slots are only written with patch_instruction(), which
does not need this mapping to be writable. This patch fixes it by
checking for strict_kernel_rwx_enabled() instead.

Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b617b69452cd..77b63b52d8f2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
 
 struct execmem_info __init *execmem_arch_setup(void)
 {
-	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
 	unsigned long fallback_start = 0, fallback_end = 0;
 	unsigned long start, end;
-- 
2.39.5


