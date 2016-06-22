Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZgsm0W0PzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 09:34:19 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MNJbXR005946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 19:34:17 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q703hwnw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 19:34:17 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 20:34:15 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A538C1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 19:34:05 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MNYCLr40829062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 20:34:12 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MNYCW9020982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 20:34:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Wed, 22 Jun 2016 20:34:10 -0300
In-Reply-To: <20160622101801.GB7752@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622101801.GB7752@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <5025034.R6Ttz76WZM@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 22 Juni 2016, 18:18:01 schrieb Dave Young:
> On 06/21/16 at 04:48pm, Thiago Jung Bauermann wrote:
> > +/**
> > + * kexec_locate_mem_hole - find free memory to load segment or use in
> > purgatory + * @image:	kexec image being updated.
> > + * @size:	Memory size.
> > + * @align:	Minimum alignment needed.
> > + * @min_addr:	Minimum starting address.
> > + * @max_addr:	Maximum end address.
> > + * @top_down	Find the highest free memory region?
> > + * @addr	On success, will have start address of the memory region
> > found.
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> > +			  unsigned long align, unsigned long min_addr,
> > +			  unsigned long max_addr, bool top_down,
> > +			  unsigned long *addr)
> > +{
> > +	int ret;
> > +	struct kexec_buf buf;
> > +
> > +	memset(&buf, 0, sizeof(struct kexec_buf));
> > +	buf.image = image;
> > +
> > +	buf.memsz = size;
> > +	buf.buf_align = align;
> > +	buf.buf_min = min_addr;
> > +	buf.buf_max = max_addr;
> > +	buf.top_down = top_down;
> 
> Since patch 2/9 moved kexec_buf from internal header file to kexec.h it
> will be natural to passing a kexec_buf pointer intead of passing all
> these arguments in kexec_locate_mem_hole.
> 
> kbuf.mem can be used for addr.

Ok. What about this version?
-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


Subject: [PATCH 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.

kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
implementation to find free memory for the purgatory stack.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/kexec.h | 12 +++++++++---
 kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3d91bcfc180d..e8b099da47f5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -147,9 +147,14 @@ struct kexec_file_ops {
 #endif
 };
 
-/*
- * Keeps track of buffer parameters as provided by caller for requesting
- * memory placement of buffer.
+/**
+ * struct kexec_buf - parameters for finding a place for a buffer in memory
+ * @image:	kexec image in which memory to search.
+ * @size:	Memory size for the buffer.
+ * @align:	Minimum alignment needed.
+ * @min_addr:	Minimum starting address.
+ * @max_addr:	Maximum end address.
+ * @top_down:	Find the highest free memory region?
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -163,6 +168,7 @@ struct kexec_buf {
 
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
+int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b1f1f6402518..445d66add8ca 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -449,6 +449,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
 
+/**
+ * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
+ * @kbuf:	Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	int ret;
+
+	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -493,11 +510,9 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	kbuf->top_down = top_down;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
-	if (ret != 1) {
-		/* A suitable memory range could not be found for buffer */
-		return -EADDRNOTAVAIL;
-	}
+	ret = kexec_locate_mem_hole(kbuf);
+	if (ret)
+		return ret;
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
-- 
1.9.1
