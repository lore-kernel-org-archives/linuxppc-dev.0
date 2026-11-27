Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08181606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qRhS3iLw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbTgN13jgz3bfP;
	Fri, 27 Nov 2026 21:10:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795774207;
	cv=none; b=FSav/2Kboeqx/EgjlUrcGV8RQFajVdy2XbTYfpPls7HO5zrZOdk7ZnJOQ8XEnKJhPw1I6fTtQvfDwXnQecephrvlLxKdg6nQ7DARO3GlKkXnKhUjkULvkgM3XKquec3j1s7Wca1ipQSJTKnTTOXgcXmBpAJO9GFAmJCYVcHMRsUE3i4Rka2NGu9Ske3PTslKIYdnYVSFYur+meKNJv/nZ6bBtgTBeVBOEormYRoYu2ITG+KIt40PYrw9Y4D5Q496tBLsQ4rCHDcqjZp4UlIEMZ0kq5Mp9YFZvRBi6oarfa9Pp1o+Ud1CuP5jzRvh2fl6ClqTeYYcQgLa5aoC+TMKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795774207; c=relaxed/relaxed;
	bh=GSvCD8YM1NLMl6gb9M0IUK1AOC5Amk2NGzrI5vOZULM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhQg3ocqzb/DN+n81aObeO8cPEXU3a1Cuiz+w3wXW8F/Hnow4x2iDCz5CJRjdyVQbppWHxE5dsxMQuVwi+gZPczBu9zLYDyDUZ4T8bUAYBV0y2v32tQln9XT+9TBEtp4j6YpdzCMSMdrXwxmsdu9V/rzRXB7VbI/TCEuthR8hMSiNG1d9afURjGZBOnW7hxfYtbl5ZS2xliGim/uR1/qqBNjbbGuzx/GuVpHc2ePFb+Zd+QH9ngWrYSl9FIqRHdHajFl+q4D8rWKM4L3kGTNuTSyn9+rYX5XfPl7erPIDX8D3ZqiwpKU48o38iXp1VqKEKCtfW3uQCeypQ0xBN/nvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qRhS3iLw; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qRhS3iLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbTgH6fR3z3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 21:10:03 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GSvCD8YM1NLMl6gb9M0IUK1AOC5Amk2NGzrI5vOZULM=;
	b=qRhS3iLw77pcE5v6L2S0WLGzpBeBzVWXExiJkMyzNJCYEpBE+EtOGk27PFt2SBZZhFexmjIYD
	5H4Zi9uy+ya9TotL4eNtKmplB15MYgEVVWVPEMya4TWg1l6ZAyMvGP2G9zQu+FxREVevZgrsYa1
	3aFC89g8Y2vZbsDorarGkdk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jbTds5K64zcb4H;
	Fri, 27 Nov 2026 18:08:49 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DD15840538;
	Fri, 27 Nov 2026 18:09:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ben@cressey.dev>, <leitao@debian.org>, <mpilaniy@redhat.com>,
	<yeoreum.yun@arm.com>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<prudo@redhat.com>, <bradley.morgan@linux.dev>, <sourabhjain@linux.ibm.com>,
	<blum@kernel.org>, <hbathini@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<arnd@arndb.de>, <tzimmermann@suse.de>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <mhklinux@outlook.com>, <piliu@redhat.com>,
	<shradhagupta@linux.microsoft.com>, <thuth@redhat.com>,
	<ebiggers@kernel.org>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <tangyouling@kylinos.cn>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 09/11] kexec: Add kexec_rollback_segments() helper
Date: Fri, 27 Nov 2026 18:09:23 +0800
Message-ID: <20261127100925.3019877-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100925.3019877-1-ruanjinjie@huawei.com>
References: <20261127100925.3019877-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A load attempt that cannot place all of its segments drops the segments
it added, but the CMA pages backing them become unreachable.

Add a helper that releases those pages and truncates nr_segments,
so the loaders do not have to open code it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  1 +
 kernel/kexec_file.c   | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3c030e478adf..bfcc0a362fc9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -259,6 +259,7 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 int kexec_add_initrd(struct kimage *image, struct kexec_buf *kbuf);
+void kexec_rollback_segments(struct kimage *image, unsigned long nr_segments);
 #ifdef CONFIG_CRASH_DUMP
 int kexec_prepare_elf_core_header(struct kimage *image, bool need_kernel_map,
 				  unsigned long *nr_ranges);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 66f389346c2b..d9ae97564a4a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1375,3 +1375,15 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
+
+/*
+ * Undo a partial load attempt: release the CMA pages backing
+ * the segments above @nr_segments and drop them from the image.
+ */
+void kexec_rollback_segments(struct kimage *image, unsigned long nr_segments)
+{
+	while (image->nr_segments > nr_segments) {
+		kexec_free_segment_cma(image, image->nr_segments - 1);
+		image->nr_segments--;
+	}
+}
-- 
2.34.1


