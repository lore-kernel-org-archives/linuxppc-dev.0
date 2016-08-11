Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9NrK00gGzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:04:32 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN4LeX094856
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:30 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9wwry5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:30 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:04:28 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 683001DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:04:16 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BN4PIA4771976
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:04:25 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BN4NET019223
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:04:25 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] kexec: add dtb info to struct kimage
Date: Thu, 11 Aug 2016 20:03:57 -0300
In-Reply-To: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch adds dtb buffer information to struct kimage.
When users don't specify dtb explicitly and the one used for the current
kernel can be re-used, this change will be good enough for implementing
kexec_file_load feature.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec_file.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d7437777baaa..4f85d284ed0b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -192,6 +192,9 @@ struct kimage {
 	char *cmdline_buf;
 	unsigned long cmdline_buf_len;
 
+	void *dtb_buf;
+	unsigned long dtb_buf_len;
+
 	/* File operations provided by image loader */
 	struct kexec_file_ops *fops;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 503bc2d348e5..113af2f219b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -92,6 +92,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->initrd_buf);
 	image->initrd_buf = NULL;
 
+	vfree(image->dtb_buf);
+	image->dtb_buf = NULL;
+
 	kfree(image->cmdline_buf);
 	image->cmdline_buf = NULL;
 
-- 
1.9.1
