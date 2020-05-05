Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE6C47247
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 10:34:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8C4206A4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 10:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5S+O90V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8C4206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GbhG759qzDqZL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 20:34:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9f099bf5d86be6f06a65+6099+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=T5S+O90V; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GbCZ4yHTzDqcJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 20:13:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pf+8UbD/8jsz87XgA7eBkoAI8lHWNvd/TrPDgE8g/Q8=; b=T5S+O90V8jpK1jZDT4Xxt2bEyq
 vNENKGjTiapnYjdG+K+97VkW5vlrUBUMBrFYjM0CMTbcepQtRLcsfp+IEyEOCd2PuvKyeAiOIchRw
 oz5akyY7rTAXJOXrp5gSEO0kYh70TTzn1a1PeT3/yZkafIsSqgOAh7NJa8qAcNWNj4lt+jfPIBfQr
 35EzNTljJDykJnsLc50D1RB0lmLhFGnwsrp8Dl2CqiLvv2woKfnVoPuOvRoJw/eOkXMhFqInMtaUw
 v1WjxeIsQD3j9MDW0PouPbgRi0aop/eiOL0wEdpg1hJmBr9TEWZpmQutpYxq6KhMWLTj6bfuYwfwb
 TWIDtd4g==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVuZi-0006wy-Kb; Tue, 05 May 2020 10:13:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 7/7] binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in
 elf_fdpic_core_dump
Date: Tue,  5 May 2020 12:12:56 +0200
Message-Id: <20200505101256.3121270-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
References: <20200505101256.3121270-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 "Eric W . Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is no logic in elf_fdpic_core_dump itself or in the various arch
helpers called from it which use uaccess routines on kernel pointers
except for the file writes thate are nicely encapsulated by using
__kernel_write in dump_emit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf_fdpic.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f666635437..d9501a86cec97 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1549,7 +1549,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 {
 #define	NUM_NOTES	6
 	int has_dumped = 0;
-	mm_segment_t fs;
 	int segs;
 	int i;
 	struct vm_area_struct *vma;
@@ -1589,31 +1588,31 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
 	if (!elf)
-		goto cleanup;
+		goto end_coredump;
 	prstatus = kzalloc(sizeof(*prstatus), GFP_KERNEL);
 	if (!prstatus)
-		goto cleanup;
+		goto end_coredump;
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
-		goto cleanup;
+		goto end_coredump;
 	notes = kmalloc_array(NUM_NOTES, sizeof(struct memelfnote),
 			      GFP_KERNEL);
 	if (!notes)
-		goto cleanup;
+		goto end_coredump;
 	fpu = kmalloc(sizeof(*fpu), GFP_KERNEL);
 	if (!fpu)
-		goto cleanup;
+		goto end_coredump;
 #ifdef ELF_CORE_COPY_XFPREGS
 	xfpu = kmalloc(sizeof(*xfpu), GFP_KERNEL);
 	if (!xfpu)
-		goto cleanup;
+		goto end_coredump;
 #endif
 
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 		if (!tmp)
-			goto cleanup;
+			goto end_coredump;
 
 		tmp->thread = ct->task;
 		list_add(&tmp->list, &thread_list);
@@ -1678,9 +1677,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
 #endif
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(*elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -1788,9 +1784,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	}
 
 end_coredump:
-	set_fs(fs);
-
-cleanup:
 	while (!list_empty(&thread_list)) {
 		struct list_head *tmp = thread_list.next;
 		list_del(tmp);
-- 
2.26.2

