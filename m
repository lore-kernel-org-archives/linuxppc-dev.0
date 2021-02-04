Return-Path: <SRS0=TUcR=HG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D96C433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 17:51:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448DE64E0A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 17:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448DE64E0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DWmMc0nTkzDwkL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Feb 2021 04:51:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=PBBsyO6T; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DWmKN2JrqzDqnB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2021 04:49:59 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 88A88202029C;
 Thu,  4 Feb 2021 09:49:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88A88202029C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1612460996;
 bh=MWnuUzUB2546OxJT28g10L67ifCeNWzaEF9eQBT9L1M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PBBsyO6TTs1VsyPnYx3t8XDYQfLdvF5P0ppIrM7pV5dTNlA9IpJQrKUWd9lwrZ2eN
 41o0W6kCoRlDN2PdH2JXnJB6sH5xF/iqpqCobcBUGTPVPDmZR1fGXYA5QAODK1Neor
 KZjc8LQsuwfJg+bLvUnjQAO7IlTTW+UxXaarzchM=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, dmitry.kasatkin@gmail.com,
 ebiederm@xmission.com, gregkh@linuxfoundation.org, sashal@kernel.org,
 tyhicks@linux.microsoft.com
Subject: [PATCH v2 2/2] ima: Free IMA measurement buffer after kexec syscall
Date: Thu,  4 Feb 2021 09:49:51 -0800
Message-Id: <20210204174951.25771-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204174951.25771-1-nramas@linux.microsoft.com>
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

IMA allocates kernel virtual memory to carry forward the measurement
list, from the current kernel to the next kernel on kexec system call,
in ima_add_kexec_buffer() function.  This buffer is not freed before
completing the kexec system call resulting in memory leak.

Add ima_buffer field in "struct kimage" to store the virtual address
of the buffer allocated for the IMA measurement list.
Free the memory allocated for the IMA measurement list in
kimage_file_post_load_cleanup() function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
---
 include/linux/kexec.h              | 5 +++++
 kernel/kexec_file.c                | 5 +++++
 security/integrity/ima/ima_kexec.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..5f61389f5f36 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -300,6 +300,11 @@ struct kimage {
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
 #endif
+
+#ifdef CONFIG_IMA_KEXEC
+	/* Virtual address of IMA measurement buffer for kexec syscall */
+	void *ima_buffer;
+#endif
 };
 
 /* kexec interface functions */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b02086d70492..5c3447cf7ad5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -166,6 +166,11 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(pi->sechdrs);
 	pi->sechdrs = NULL;
 
+#ifdef CONFIG_IMA_KEXEC
+	vfree(image->ima_buffer);
+	image->ima_buffer = NULL;
+#endif /* CONFIG_IMA_KEXEC */
+
 	/* See if architecture has anything to cleanup post load */
 	arch_kimage_file_post_load_cleanup(image);
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 206ddcaa5c67..e29bea3dd4cc 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -129,6 +129,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
+	image->ima_buffer = kexec_buffer;
+
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
-- 
2.30.0

