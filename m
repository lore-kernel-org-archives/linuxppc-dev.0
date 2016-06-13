Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT4Rp2K3nzDqcg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:40:53 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DKdIhv077652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:40:51 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23geqncpbj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:40:51 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 17:40:49 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5E0CB1DC0070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:40:39 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DKekQr10092926
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:40:46 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DKejp0003414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:40:46 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/8] kexec_file: Generalize kexec_add_buffer.
Date: Mon, 13 Jun 2016 17:40:43 -0300
In-Reply-To: <11831785.bAnhpkoBlL@hactar>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
 <11831785.bAnhpkoBlL@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1524764.qHvH6Mt1uV@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

Am Montag, 13 Juni 2016, 16:08:19 schrieb Thiago Jung Bauermann:
> Am Montag, 13 Juni 2016, 15:29:39 schrieb Dave Young:
> > On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> > > Allow architectures to specify different memory walking functions for
> > > kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> > > but PowerPC uses the memblock subsystem.
> > 
> > Can the crashk_res be inserted to iomem_resource so that only one
> > weak function for system ram is needed?
> 
> Sorry, it's not clear to me what you mean by inserting crashk_res into
> iomem_resource, but I can add a bool for_crashkernel to
> arch_walk_system_ram so that it can decide which kind of memory to
> traverse.

This is the patch implementing that idea. What do you think?
-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


    kexec_file: Generalize kexec_add_buffer.
    
    Allow architectures to specify different memory walking functions for
    kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
    but PowerPC uses the memblock subsystem.
    
    Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
    Cc: Eric Biederman <ebiederm@xmission.com>
    Cc: kexec@lists.infradead.org
    Cc: linux-kernel@vger.kernel.org

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b43dd9..be18cb80c14e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -315,6 +315,9 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
 					Elf_Shdr *sechdrs, unsigned int relsec);
 int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 					unsigned int relsec);
+int __weak arch_walk_system_ram(bool for_crashkernel, unsigned long start,
+				unsigned long end, bool top_down, void *data,
+				int (*func)(u64, u64, void *));
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b6eec7527e9f..5d0a6a20b12b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -428,6 +428,38 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+/**
+ * arch_walk_system_ram - call func(data) on free memory regions
+ * @for_crashkernel:	Is this for the crash kernel?
+ * @start:		Don't visit memory regions below this address.
+ * @end:		Don't visit memory regions above this address.
+ * @top_down:		Starts from the highest address?
+ * @data:		Argument to pass to @func.
+ * @func:		Function to call for each memory region.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_walk_system_ram(bool for_crashkernel, unsigned long start,
+				unsigned long end, bool top_down, void *data,
+				int (*func)(u64, u64, void *))
+{
+	int ret;
+
+	if (for_crashkernel)
+		ret = walk_iomem_res_desc(crashk_res.desc,
+					  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					  start, end, data, func);
+	else
+		ret = walk_system_ram_res(start, end, data, func);
+
+	if (ret != 1) {
+		/* A suitable memory range could not be found for buffer */
+		return -EADDRNOTAVAIL;
+	}
+
+	return 0;
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -473,17 +505,14 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
 	if (image->type == KEXEC_TYPE_CRASH)
-		ret = walk_iomem_res_desc(crashk_res.desc,
-				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-				crashk_res.start, crashk_res.end, kbuf,
-				locate_mem_hole_callback);
+		ret = arch_walk_system_ram(true, crashk_res.start,
+					   crashk_res.end, top_down, kbuf,
+					   locate_mem_hole_callback);
 	else
-		ret = walk_system_ram_res(0, -1, kbuf,
-					  locate_mem_hole_callback);
-	if (ret != 1) {
-		/* A suitable memory range could not be found for buffer */
-		return -EADDRNOTAVAIL;
-	}
+		ret = arch_walk_system_ram(false, 0, -1, top_down, kbuf,
+					   locate_mem_hole_callback);
+	if (ret)
+		return ret;
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
