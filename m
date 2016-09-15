Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZjgQ5k1BzDsY0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 01:55:46 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FFmL7x079804
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:55:44 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fk2wv69q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:55:44 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 12:55:41 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 54363352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:55:15 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FFtcjw20971750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:55:38 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FFtbj1001089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:55:38 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: kexec@lists.infradead.org, linux-ima-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the
 kexec image checksum.
Date: Thu, 15 Sep 2016 12:55:33 -0300
In-Reply-To: <20160915114308.19195f71@canb.auug.org.au>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160915114308.19195f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3000835.2VCEnkym2S@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Stephen,

Am Donnerstag, 15 September 2016, 11:43:08 schrieb Stephen Rothwell:
> Hi Thiago,
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2a1f0ce7c59a..dcd1679f3005 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1792,6 +1792,11 @@ config SECCOMP
> > 
> >  source kernel/Kconfig.hz
> > 
> > +# x86 needs to relocate the purgatory after the checksum is calculated,
> > +# therefore the purgatory cannot be part of the kexec image checksum.
> > +config ARCH_MODIFIES_KEXEC_PURGATORY
> > +	bool
> > +
> 
> The above should probably be in arch/Kconfig (with an appropriately
> changed comment) since it is used in generic code.

Here is the new version, with that change.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


Subject: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the kexec
 image checksum.

Currently, the purgatory segment is skipped from the kexec image checksum
because it is modified to include the calculated digest.

By putting the digest in a separate kexec segment, we can include the
purgatory segment in the kexec image verification since it won't need
to be modified anymore.

With this change, the only part of the kexec image that is not covered
by the checksum is the digest itself.

Even with the digest stored separately, x86 needs to leave the purgatory
segment out of the checksum calculation because it modifies the purgatory
code in relocate_kernel. We use CONFIG_ARCH_MODIFIES_KEXEC_PURGATORY to
allow the powerpc purgatory to be protected by the checksum while still
preserving x86 behavior.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/Kconfig                       |   8 +++
 arch/powerpc/purgatory/purgatory.c |   4 +-
 arch/x86/Kconfig                   |   1 +
 arch/x86/purgatory/purgatory.c     |   2 +-
 include/linux/kexec.h              |   6 +++
 kernel/kexec_file.c                | 100 +++++++++++++++++++++++++------------
 6 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index fd6e9712af81..b386d6c1d463 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -5,6 +5,14 @@
 config KEXEC_CORE
 	bool
 
+#
+# Architectures that need to modify the purgatory segment after the
+# checksum is calculated need to select this option so that it won't
+# be part of the kexec image checksum.
+#
+config ARCH_MODIFIES_KEXEC_PURGATORY
+	bool
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
diff --git a/arch/powerpc/purgatory/purgatory.c b/arch/powerpc/purgatory/purgatory.c
index 5b006d685cf2..f19ac3d5a7d5 100644
--- a/arch/powerpc/purgatory/purgatory.c
+++ b/arch/powerpc/purgatory/purgatory.c
@@ -17,7 +17,7 @@
 #include "kexec-sha256.h"
 
 struct kexec_sha_region sha_regions[SHA256_REGIONS] = {};
-u8 sha256_digest[SHA256_DIGEST_SIZE] = { 0 };
+u8 *sha256_digest = NULL;
 
 int verify_sha256_digest(void)
 {
@@ -40,7 +40,7 @@ int verify_sha256_digest(void)
 		printf("\n");
 
 		printf("sha256_digest: ");
-		for (i = 0; i < sizeof(sha256_digest); i++)
+		for (i = 0; i < SHA256_DIGEST_SIZE; i++)
 			printf("%hhx ", sha256_digest[i]);
 
 		printf("\n");
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2a1f0ce7c59a..4d34019f7479 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1812,6 +1812,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select ARCH_MODIFIES_KEXEC_PURGATORY
 	select BUILD_BIN2C
 	depends on X86_64
 	depends on CRYPTO=y
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 25e068ba3382..391c6a66cb03 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -22,7 +22,7 @@ unsigned long backup_dest = 0;
 unsigned long backup_src = 0;
 unsigned long backup_sz = 0;
 
-u8 sha256_digest[SHA256_DIGEST_SIZE] = { 0 };
+u8 *sha256_digest = NULL;
 
 struct sha_region sha_regions[16] = {};
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d419d0e51fe5..2a96292ee544 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -124,8 +124,14 @@ struct purgatory_info {
 	 */
 	void *purgatory_buf;
 
+	/* Digest of the contents of segments. */
+	void *digest_buf;
+
 	/* Address where purgatory is finally loaded and is executed from */
 	unsigned long purgatory_load_addr;
+
+	/* Address where the digest is loaded. */
+	unsigned long digest_load_addr;
 };
 
 typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c2df7f73792..6f7fa8901171 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -98,6 +98,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(pi->purgatory_buf);
 	pi->purgatory_buf = NULL;
 
+	kfree(pi->digest_buf);
+	pi->digest_buf = NULL;
+
 	vfree(pi->sechdrs);
 	pi->sechdrs = NULL;
 
@@ -527,7 +530,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	struct shash_desc *desc;
 	int ret = 0, i, j, zero_buf_sz, sha_region_sz;
 	size_t desc_size, nullsz;
-	char *digest;
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
@@ -553,6 +555,37 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	if (!sha_regions)
 		goto out_free_desc;
 
+	/*
+	 * Set sha_regions early so that we can write it to the purgatory
+	 * and include it in the checksum.
+	 */
+	for (j = i = 0; i < image->nr_segments; i++) {
+		struct kexec_segment *ksegment = &image->segment[i];
+
+		if (ksegment->kbuf == pi->digest_buf)
+			continue;
+
+		if (IS_ENABLED(CONFIG_ARCH_MODIFIES_KEXEC_PURGATORY) &&
+		    ksegment->kbuf == pi->purgatory_buf)
+			continue;
+
+		sha_regions[j].start = ksegment->mem;
+		sha_regions[j].len = ksegment->memsz;
+		j++;
+	}
+
+	ret = kexec_purgatory_get_set_symbol(image, "sha_regions", sha_regions,
+					     sha_region_sz, false);
+	if (ret)
+		goto out_free_sha_regions;
+
+	ret = kexec_purgatory_get_set_symbol(image, "sha256_digest",
+					     &pi->digest_load_addr,
+					     sizeof(pi->digest_load_addr),
+					     false);
+	if (ret)
+		goto out_free_sha_regions;
+
 	desc->tfm   = tfm;
 	desc->flags = 0;
 
@@ -560,21 +593,24 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	if (ret < 0)
 		goto out_free_sha_regions;
 
-	digest = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
-	if (!digest) {
-		ret = -ENOMEM;
-		goto out_free_sha_regions;
-	}
-
-	for (j = i = 0; i < image->nr_segments; i++) {
+	for (i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
 		/*
-		 * Skip purgatory as it will be modified once we put digest
-		 * info in purgatory.
+		 * Skip the digest segment as it will be modified with the
+		 * result of the checksum calculation.
 		 */
-		if (ksegment->kbuf == pi->purgatory_buf)
+		if (ksegment->kbuf == pi->digest_buf)
+			continue;
+
+		/*
+		 * Some architectures need to modify the purgatory before
+		 * jumping into it, so in those cases we need to skip the
+		 * purgatory from the checksum calculation.
+		 */
+		if (IS_ENABLED(CONFIG_ARCH_MODIFIES_KEXEC_PURGATORY) &&
+		    ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
 		ret = crypto_shash_update(desc, ksegment->kbuf,
@@ -600,29 +636,11 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 		if (ret)
 			break;
-
-		sha_regions[j].start = ksegment->mem;
-		sha_regions[j].len = ksegment->memsz;
-		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "sha_regions",
-						sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
-
-		ret = kexec_purgatory_get_set_symbol(image, "sha256_digest",
-						digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	if (!ret)
+		ret = crypto_shash_final(desc, pi->digest_buf);
 
-out_free_digest:
-	kfree(digest);
 out_free_sha_regions:
 	vfree(sha_regions);
 out_free_desc:
@@ -875,6 +893,10 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 			 unsigned long *load_addr)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
+	struct kexec_buf kbuf = { .image = image, .bufsz = SHA256_DIGEST_SIZE,
+				  .memsz = SHA256_DIGEST_SIZE, .buf_align = 1,
+				  .buf_min = min, .buf_max = max,
+				  .top_down = top_down };
 	int ret;
 
 	if (kexec_purgatory_size <= 0)
@@ -900,6 +922,22 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (ret)
 		return ret;
 
+	pi->digest_buf = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+	if (!pi->digest_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Add a separate segment for the digest so that we don't have to modify
+	 * the purgatory segment after we calculate the kexec image checksum.
+	 */
+	kbuf.buffer = pi->digest_buf;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out;
+	pi->digest_load_addr = kbuf.mem;
+
 	ret = kexec_apply_relocations(image);
 	if (ret)
 		goto out;
-- 
1.9.1
