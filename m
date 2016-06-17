Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWXV01M01zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 06:51:20 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5HKmsTr053025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:51:18 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqskn3w4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:51:18 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 17:51:15 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 4C711352005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:50:56 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5HKpCOm3702798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 17:51:12 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5HKpCOj000550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 17:51:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Fri, 17 Jun 2016 17:51:09 -0300
In-Reply-To: <20160617073523.GA5091@dhcp-128-65.nay.redhat.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <16133071.BqvF7Se0c2@hactar>
 <20160617073523.GA5091@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <12025213.W8oVnaovm1@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 17 Juni 2016, 15:35:23 schrieb Dave Young:
> On 06/16/16 at 05:39pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 16 Juni 2016, 09:58:53 schrieb Dave Young:
> > > On 06/15/16 at 01:21pm, Thiago Jung Bauermann wrote:
> > > > +int __weak arch_kexec_walk_mem(unsigned int image_type, bool
> > > > top_down,
> > > > +			       void *data, int (*func)(u64, u64, void *))
> > > > +{
> > > 
> > > top_down is also not used?
> > 
> > It's unused in the default implementation, but the powerpc implementation
> > in patch 8 uses it:
> Well, arch_kexec_walk_mem use kbuf as "data", you can even drop
> "image_type" since kbuf has all you want kbuf->image->type, and
> kbuf->top_down
> 
> int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> 			       int (*func)(u64, u64, void *))

Sounds good to me, but I had to move struct kexec_buf from
kernel/kexec_internal.h to include/linux/kexec.h.

Here's the updated patch. What do you think?

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


    kexec_file: Generalize kexec_add_buffer.
    
    Allow architectures to specify different memory walking functions for
    kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
    but PowerPC uses the memblock subsystem.
    
    Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
    Cc: Eric Biederman <ebiederm@xmission.com>
    Cc: Dave Young <dyoung@redhat.com>
    Cc: kexec@lists.infradead.org
    Cc: linux-kernel@vger.kernel.org

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b43dd9..d8df01107ae2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -201,6 +201,20 @@ struct kimage {
 #endif
 };
 
+/*
+ * Keeps track of buffer parameters as provided by caller for requesting
+ * memory placement of buffer.
+ */
+struct kexec_buf {
+	struct kimage *image;
+	unsigned long mem;
+	unsigned long memsz;
+	unsigned long buf_align;
+	unsigned long buf_min;
+	unsigned long buf_max;
+	bool top_down;		/* allocate from top of memory hole */
+};
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
@@ -315,6 +329,8 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 					unsigned int relsec);
+int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			       int (*func)(u64, u64, void *));
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b6eec7527e9f..b1f1f6402518 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -428,6 +428,27 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+/**
+ * arch_kexec_walk_mem - call func(data) on free memory regions
+ * @kbuf:	Context info for the search. Also passed to @func.
+ * @func:	Function to call for each memory region.
+ *
+ * Return: The memory walk will stop when func returns a non-zero value
+ * and that value will be returned. If all free regions are visited without
+ * func returning non-zero, then zero will be returned.
+ */
+int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			       int (*func)(u64, u64, void *))
+{
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return walk_iomem_res_desc(crashk_res.desc,
+					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					   crashk_res.start, crashk_res.end,
+					   kbuf, func);
+	else
+		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -472,14 +493,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	kbuf->top_down = top_down;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	if (image->type == KEXEC_TYPE_CRASH)
-		ret = walk_iomem_res_desc(crashk_res.desc,
-				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-				crashk_res.start, crashk_res.end, kbuf,
-				locate_mem_hole_callback);
-	else
-		ret = walk_system_ram_res(0, -1, kbuf,
-					  locate_mem_hole_callback);
+	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 	if (ret != 1) {
 		/* A suitable memory range could not be found for buffer */
 		return -EADDRNOTAVAIL;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index eefd5bf960c2..4cef7e4706b0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -20,20 +20,6 @@ struct kexec_sha_region {
 	unsigned long len;
 };
 
-/*
- * Keeps track of buffer parameters as provided by caller for requesting
- * memory placement of buffer.
- */
-struct kexec_buf {
-	struct kimage *image;
-	unsigned long mem;
-	unsigned long memsz;
-	unsigned long buf_align;
-	unsigned long buf_min;
-	unsigned long buf_max;
-	bool top_down;		/* allocate from top of memory hole */
-};
-
 void kimage_file_post_load_cleanup(struct kimage *image);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
