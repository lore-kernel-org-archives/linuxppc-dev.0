Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ79q3yDbzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 08:13:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7MM8NN3096742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:13:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y0w62dug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:13:00 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 19:12:57 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 529591DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:12:46 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7MMCtJu4067552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:12:55 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7MMCs7m031869
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:12:55 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Date: Mon, 22 Aug 2016 19:12:52 -0300
In-Reply-To: <20160822033643.GA30937@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <3959832.c4ESAKX1ch@hactar>
 <20160822033643.GA30937@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <6265988.BPvmsBfJYJ@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 22 August 2016, 11:36:43 schrieb Dave Young:
> On 08/22/16 at 12:25am, Thiago Jung Bauermann wrote:
> > Am Montag, 22 August 2016, 11:17:45 schrieb Dave Young:
> > > On 08/18/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > > > Am Donnerstag, 18 August 2016, 17:03:30 schrieb Dave Young:
> > > > > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > > > > Adds checksum argument to kexec_add_buffer specifying whether
> > > > > > the
> > > > > > given
> > > > > > segment should be part of the checksum calculation.
> > > > > 
> > > > > Since it is used with add buffer, could it be added to kbuf as a
> > > > > new
> > > > > field?
> > > > 
> > > > I was on the fence about adding it as a new argument to
> > > > kexec_add_buffer
> > > > or as a new field to struct kexec_buf. Both alternatives make sense
> > > > to
> > > > me. I implemented your suggestion in the patch below, what do you
> > > > think?>
> > > > 
> > > > > Like kbuf.no_checksum, default value is 0 that means checksum is
> > > > > needed
> > > > > if it is 1 then no need a checksum.
> > > > 
> > > > It's an interesting idea and I implemented it that way, though in
> > > > practice all current users of struct kexec_buf put it on the stack
> > > > so
> > > > the field needs to be initialized explicitly.
> > > 
> > > No need to set it as false because it will be initialized to 0 by
> > > default?
> > 
> > As far as I know, variables on the stack are not initialized. Only
> > global
> > and static variables are.
> 
> But designated initializers will do it.

Here is the new version, relying on the default value for
kexec_buf.skip_checksum. A nice side effect is that I don't have to
cc the x86 maintainers anymore.

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


Subject: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation for
 some segments.

Add skip_checksum member to struct kexec_buf to specify whether the
corresponding segment should be part of the checksum calculation.

The next patch will add a way to update segments after a kimage is loaded.
Segments that will be updated in this way should not be checksummed,
otherwise they will cause the purgatory checksum verification to fail
when the machine is rebooted.

As a bonus, we don't need to special-case the purgatory segment anymore
to avoid checksumming it.

Places currently using struct kexec_buf will get false as the default
value for skip_checksum since they all use designated initializers.
Therefore, there will not be any behavior change with this patch and
their buffers will continue being checksummed.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 23 ++++++++++++++---------
 kernel/kexec_file.c   | 15 +++++++--------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4559a1a01b0a..e5b3d99cbe50 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -100,6 +100,9 @@ struct kexec_segment {
 	size_t bufsz;
 	unsigned long mem;
 	size_t memsz;
+
+	/* Whether this segment is ignored in the checksum calculation. */
+	bool skip_checksum;
 };
 
 #ifdef CONFIG_COMPAT
@@ -151,15 +154,16 @@ struct kexec_file_ops {
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
- * @image:	kexec image in which memory to search.
- * @buffer:	Contents which will be copied to the allocated memory.
- * @bufsz:	Size of @buffer.
- * @mem:	On return will have address of the buffer in memory.
- * @memsz:	Size for the buffer in memory.
- * @buf_align:	Minimum alignment needed.
- * @buf_min:	The buffer can't be placed below this address.
- * @buf_max:	The buffer can't be placed above this address.
- * @top_down:	Allocate from top of memory.
+ * @image:		kexec image in which memory to search.
+ * @buffer:		Contents which will be copied to the allocated memory.
+ * @bufsz:		Size of @buffer.
+ * @mem:		On return will have address of the buffer in memory.
+ * @memsz:		Size for the buffer in memory.
+ * @buf_align:		Minimum alignment needed.
+ * @buf_min:		The buffer can't be placed below this address.
+ * @buf_max:		The buffer can't be placed above this address.
+ * @top_down:		Allocate from top of memory.
+ * @skip_checksum:	Don't verify checksum for this buffer in purgatory.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -171,6 +175,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool skip_checksum;
 };
 
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c8418d62e2fc..f6e9958bf578 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -658,6 +658,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
+	ksegment->skip_checksum = kbuf->skip_checksum;
 	kbuf->image->nr_segments++;
 	return 0;
 }
@@ -672,7 +673,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	char *digest;
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
-	struct purgatory_info *pi = &image->purgatory_info;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
 	zero_buf_sz = PAGE_SIZE;
@@ -712,11 +712,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		/*
-		 * Skip purgatory as it will be modified once we put digest
-		 * info in purgatory.
-		 */
-		if (ksegment->kbuf == pi->purgatory_buf)
+		if (ksegment->skip_checksum)
 			continue;
 
 		ret = crypto_shash_update(desc, ksegment->kbuf,
@@ -788,7 +784,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	Elf_Shdr *sechdrs = NULL;
 	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
 				  .buf_min = min, .buf_max = max,
-				  .top_down = top_down };
+				  .top_down = top_down, .skip_checksum = true };
 
 	/*
 	 * sechdrs_c points to section headers in purgatory and are read
@@ -893,7 +889,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kbuf.buf_align < bss_align)
 		kbuf.buf_align = bss_align;
 
-	/* Add buffer to segment list */
+	/*
+	 * Add buffer to segment list. Don't checksum the segment as
+	 * it will be modified once we put digest info in purgatory.
+	 */
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out;
-- 
1.9.1
