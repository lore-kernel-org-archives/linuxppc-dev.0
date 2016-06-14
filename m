Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXqZ33ZWzDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 00:59:38 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsXkF009747
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:35 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23je2k5xxu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:35 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 11:59:33 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 04EC01DC0071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:24 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EExUaq25755970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:59:30 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EExUlg017697
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:59:30 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2 1/9] kexec_file: Remove unused members from struct
 kexec_buf.
Date: Tue, 14 Jun 2016 11:59:01 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-2-git-send-email-bauerman@linux.vnet.ibm.com>
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

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Dave Young <dyoung@redhat.com>
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
