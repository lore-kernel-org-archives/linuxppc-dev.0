Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAE606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jO+4yYD+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZk5C4mLnz2yPR;
	Thu, 26 Nov 2026 15:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795667183;
	cv=none; b=QpehbqNyrlxzyvXYv/t0Wd30GBi8MtNwjmFvWDtwL2SLGobxsn6RFTGeikvtk3suKEYMYZyevmT+JxZN0wLxKZQOyPzvHxw/bratxnmGOXiUMON9Kg/YNT34vsPWQuj7WWeiYwZ9GM0kEjI7KqDLwO2cE0zIm0lLJlKif/3h+NTLA0xSuY2uac2RwycECz+VckP+Ba1nzxuGW0XydZafBsSgLNNE4TWNohfZo3FXD8njdyP2I+koFi6QYXYfyConya4ItjpKIFt4eGq8qQmhwuouO+28/m9qOreJyV0iUpo61Qhf7TX6Q856R29WYC9Z8ZfJc3YziVRNoznNomE5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795667183; c=relaxed/relaxed;
	bh=lJvM+nq+p5HjlHwyukxS01vay+/sKiGIEUqvf5Org7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAtBueorc23B4fC6EZ1zf2zJUABxXbtPiyBQR9RpsASRcFuZCraHh6tQAErVp/U2ZqPYhAfUt7GWA+C1bb61iia79u1HImtsLgzZ3QLOf6dQHtlVubNH7jnjdnhOov2Z+ETTTZAnCNYMd/N9jJqOWxHd+YrNrng1Z8lwrPmyJw9L2Zvduwkp6ehatXrFYGWrEbm/i4Yc4jtT0jjM+ebCYrHV96FqBjG5umuwFF4h4v3kgqDXPdIA2fyQq6A1EIZcf7+ZO8i6UI7DhiVoMONvLEdA+cVrsXuxetvdJyYPDwToPK+E1C2C5EpLftDHMiJQlFTbABEblp0pFLWhUq/eyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jO+4yYD+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jO+4yYD+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZk5B6FtBz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:26:22 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-38692f62b22so8125799eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667181; x=1796271981; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJvM+nq+p5HjlHwyukxS01vay+/sKiGIEUqvf5Org7E=;
        b=jO+4yYD+K8sNhgR2u59/oCr8bJjic5y04NdQ5pCSEqJX5rwjcmfkcQqFIgRcdN+Mui
         zxri2190ZXvpMsOLetvSJKhdwPoKXhaxTJET3NXNVqfTwGpTiGbL5giXrvPx3SkVgKcG
         9UWkhl+pOTo7Q5rbMyLyr/lrTsws3qNhJEoc/U1qNulI3AYAfqssHFd5zFINRmDJ92L0
         N/538kYVKJhKqO3lhO/H7ZrzC/BOhuqexBulejVBBRUpnLSiDcPisteRsqpNOtPUCFzO
         tGcxEdkVdehx0A+Qsxat4J07BCvB8Kkv2a/yaW+Bsb+g+kxBY2aFn3a2Pxi8aqgrPSxO
         e9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667181; x=1796271981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJvM+nq+p5HjlHwyukxS01vay+/sKiGIEUqvf5Org7E=;
        b=sSYLSjfCyzA+sko8OgqZ7DwAQar5mHnZQUVsWkjqlrJ9fpZobRfWcj+XC3ISmUuYJE
         XAEbW6UVVsM2r7NXkT9ihFaXWy0H4Jq3wSstkDBojsBeHeZGv10gGdbiDnPo7pFzCwZ4
         tQqBeH2SGqwNgCyaxihrgItfjVLpdK17GvvnNQgzRo+Nz+JfOmQAMHg5ucAp2BZ9+avX
         q3Yx7yIs8UAdWU2gpTIWf+TguBL8fT2nZ/WaL/ZGQxmVhqjy95znWqbby4mcUW9RV4Ml
         7UwoJ/yMAHVouxkkRFMyIqapN+3iD30j4MgIHhZxf3tzrV6lJv2+hIYDqqd5Hln6kxAl
         wAPg==
X-Gm-Message-State: APuU4Z/qSdcZsQ49XvXRq7HAALal0TbmsN+3Ote9wmLQDsNRSBdp3sYy
	1zknEmFffhMb+iPmr4EEcxS9nRQJRyrEtuO+7jlOPo6BGT0k91xsnU5M5uurUA==
X-Gm-Gg: AZFdTZfBIXRKS3KbUfuzdNvo6JlL1Ke1RjxielxDjXiVmieiEi/E/bZc6WdmAKw4vcC
	kuZeDqh77kQMH4MEvE8Wh7So42hW4mH1XIHgusgSB02ZFd/6V3bQnEjUipyLDBO21EgnOyT0YNN
	94zBv8sn9Y8KsB1iZNwmpzVYjqcVu/tj9zoHib2W4y7QcRDrPK/kDF84VwLznOVcYHScoofF4bh
	n1+ryOTvIhx5oC+D6GAisSOhpGotjYvE8NbnmphDGc0+hgDkL+UcyKs7Z6f+/XDbnLJuyTAYKQz
	WiNzjxLSgkOisvOm2Zy369goppKaDBojQd8cBAc19cMqpVbFeSdwAA3oj9QDxExJeSIlcMVxrxM
	MvbzQAFdXWxafY51zL8fJIaddMB2KiSsaVDJL6X0G+uSKPk8Q1rVunMrAMc/8GfA89bEcje6g12
	H2+V2bO7/yDjmLMGbbavgJMLLZ8Bejf79tn6XAwrBBrwVlq0rx7xBQIcNBuvuMN0kA+RWbNmksm
	ymfhQabBVsg/pKO/NHJisUwjAt4C8AUBlYfCKVkEsZbK47ufq8kdZmp7fqbgiwqLjrd/4rFfGb0
	lrbAJT6zq19nJRCljxh/vhbh0l+t24V3kQ==
X-Received: by 2002:a05:7300:d0af:b0:386:a3fe:4503 with SMTP id 5a478bee46e88-386a3fe46b5mr13976085eec.41.1795667180999;
        Wed, 25 Nov 2026 20:26:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54542185eec.7.2026.11.25.20.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:26:20 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 1/4] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
Date: Thu, 26 Nov 2026 09:55:59 +0530
Message-Id: <449cd0ade2cf4f04d378cf34209e9f3cd7cdce9f.1795666663.git.ritesh.list@gmail.com>
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
struct_modules_rwx_enabled(), while kprobes depenency on modules was earlier
removed via commit 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Since the insn slots are only written with patch_instruction(), which does not
need this mapping to be writable. This patch fixes it by checking for
strict_kernel_rwx_enabled() instead.

Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
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


