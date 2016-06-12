Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rS1Bn6lB9zDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 13:10:57 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5C38w92086381
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:56 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf64vbfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:55 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Sun, 12 Jun 2016 00:10:53 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E16A01DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:44 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5C3ApFx32637392
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:10:51 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5C3ApsX029646
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:10:51 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/8] kexec_file: Remove unused members from struct kexec_buf.
Date: Sun, 12 Jun 2016 00:10:15 -0300
In-Reply-To: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465701022-11601-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_add_buffer uses kexec_buf.buffer and kexec_buf.bufsz to pass along
its own arguments buffer and bufsz, but since they aren't used anywhere
else, it's pointless.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/kexec_file.c     | 6 ++----
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 01ab82a40d22..b6eec7527e9f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,8 +464,6 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	memset(&buf, 0, sizeof(struct kexec_buf));
 	kbuf = &buf;
 	kbuf->image = image;
-	kbuf->buffer = buffer;
-	kbuf->bufsz = bufsz;
 
 	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
 	kbuf->buf_align = max(buf_align, PAGE_SIZE);
@@ -489,8 +487,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
-	ksegment->kbuf = kbuf->buffer;
-	ksegment->bufsz = kbuf->bufsz;
+	ksegment->kbuf = buffer;
+	ksegment->bufsz = bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
 	image->nr_segments++;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 0a52315d9c62..eefd5bf960c2 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -26,8 +26,6 @@ struct kexec_sha_region {
  */
 struct kexec_buf {
 	struct kimage *image;
-	char *buffer;
-	unsigned long bufsz;
 	unsigned long mem;
 	unsigned long memsz;
 	unsigned long buf_align;
-- 
1.9.1
