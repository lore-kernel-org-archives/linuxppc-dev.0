Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DD606A33E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gXuszjPL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLwh2TWhz3bj7;
	Fri, 13 Nov 2026 00:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794490500;
	cv=none; b=e88a84knFhAbxqG+T6HbuIbj+bqMSDuH608qDKXjowjU1CwuF8jU2pycpA39rTnKK8AdlVwUbH9I5S/Vqn1Sc0Xy80E9ZtZewnRW8uN40WIbz53AZBnR7mSDo6nlaiRlmtbJm2oi5MSJAo4ne0GTlE4ZuVF/E4iwMPn53Pcj3X5dbg/El1AsA6vvCJvAShLp7HfbNc2sEjlggXdtVz1fnO/QxQ16LhaO9844PXALAq6pfX7qsKbFbnuOZNw/HppVTe80ov05n1Npyx9x30AyiAVlBPzC4pvvnQkJ/Ouxci3Cda+CHzQCt4IkfCTI7hTiZH0GD2xXcQqxTOJeBw/4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794490500; c=relaxed/relaxed;
	bh=HXZwplZ0vF5Tf/o82vz8o7qmhfOng55u6nvdXi6KYhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwY+N5DG78rnLjWnHDS3gkmKMbDbGpsFMhYo4XNG6vumtd+t1XnDM1oVhhhBW8R4kyLP32hCsK9YJqUedHYBI8TbN3TDZChv04vpaVXcg8ZCwvwtiCiTe/ky6P/AomoiTXh3ftUvxq/60ggQVAgB7NnydW+Dq1g454h9zjZsyEmJaChTdJHCNGRit4688FiE5vAkzspbD7+Q01VBlUzJEWkyM5jlOHWr3HVqTJUHkG8Zn3f+X8O4ro+kerA3aPqKXi6YYCH7AqnscLAtbd7D452dzewlTUSTFpGi/ATByVt3v+9/c3wIPuHq08HkKbVgJ6D2rcFjafTrBRhC0/Pr7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gXuszjPL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gXuszjPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLwY3HGPz30V6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:34:53 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HXZwplZ0vF5Tf/o82vz8o7qmhfOng55u6nvdXi6KYhI=;
	b=gXuszjPLgq8giJqNeLSAQhABF9nBjKLbVYDPqPtzBatej0bF4SdM23H1zXHwGaZf/tf5ne4IJ
	oLSNtWbGwdjsdeclqryTDvdafbFZCk/hal06vO34HMJ4DLqpNqtJ5AOEFlzeJi08/1mWCXmDk6I
	b+AyE7BTww2JGE76sMo/gJE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jQLvj2yjYzpT1B;
	Thu, 12 Nov 2026 21:34:09 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id ED94B40575;
	Thu, 12 Nov 2026 21:34:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 21:34:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruanjinjie@huawei.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <mpilaniy@redhat.com>, <robh@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@Red54.com>, <prudo@redhat.com>,
	<brads@mainlining.org>, <sourabhjain@linux.ibm.com>, <mkchauras@gmail.com>,
	<blum@kernel.org>, <adityag@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<richard.lyu@suse.com>, <arnd@arndb.de>, <tzimmermann@suse.de>,
	<rick.p.edgecombe@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<piliu@redhat.com>, <thuth@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <tangyouling@kylinos.cn>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v8 09/11] kexec: Add kexec_rollback_segments() helper
Date: Thu, 12 Nov 2026 21:34:16 +0800
Message-ID: <20261112133418.4044428-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112133418.4044428-1-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
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

The helper also invalidates the recorded elfcorehdr segment index when
the header is among the dropped segments, so that a retry does not leave
a stale index behind for crash hotplug.

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
index be7c827e8f7e..464ab4dd36b1 100644
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
index 25c9bef639d2..b4fe5c418842 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1419,3 +1419,15 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
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


