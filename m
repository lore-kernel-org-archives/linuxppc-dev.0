Return-Path: <linuxppc-dev+bounces-18508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99681099B37
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 19:39:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fctDG2V0mz2ydq;
	Sat, 21 Mar 2026 06:39:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774035550;
	cv=none; b=okChGTb0r03j1XaqzmT22O0YIurprP5p7Cv+oHRe3iUPK9WS5dwzNnBIThCOIJBHPFD75ygKTo9MvGBKtEFWa7nHABK2wUz6Kiw13IIQSoi/6HU5Vm+L7nIlUS3AjxaOozyT54pCDmsC2Ir6N6nAvQNTILm65yF+VnspjSdUT51ETR8ibvRmtAphuTiR6E6okzwMyb9PY76Sys5Q3dp9V2hGkXLGVQCKxNPRwMDBxK/kaFfQx5s7sPcWuk4NtZpFrHRq4dLJa1pd0+7jLEByq7GmPW2bNU01Ah4lSyncRBcgEjyE3Fqr8ETTIRfgVRi6YWJKpZgRgFkk/WfdgkV3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774035550; c=relaxed/relaxed;
	bh=7Bh1w+z0JWOqUddQi7wko3Cw3Y50TUDCTLtrQm/GK+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGHixNyPPFK0lZP1bGmH6C22swojyC3+4dhXF0dw7JfGqHmQadatZhZB4ZJDqMN7gtAuTaD+OztmprqBZ3oFDhvHw44Wkt1Iz7GRSHmhbm6uj+eIy7MU9QKnGVvp8sZMBhT7FsRFS8XyHeOFYjbZKTpXnA+Dnvh3l3C7mC22TOL4k8Q029wPrJSIX6TSnLuZnR1GfGX7qXY13Q7dG6Pug679kwJrjqyaiFtphXW5Xu9ajhOuk/XUbPJh7It+Fg7YZjvrRHvCidBL2i3WueqYfi6t3QUpyp31+gPUlwWgRKgWQESpQsOuKij+IsBNu2AyLZ/u6/G9C+ll7PqZyKE1tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Uhu53cZC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Uhu53cZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fctDF3ycbz2yvH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 06:39:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A2A0840A5D;
	Fri, 20 Mar 2026 19:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0929DC2BCB0;
	Fri, 20 Mar 2026 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035547;
	bh=86x1e2KlqpteSaaM7lejP1Bl+dRpcwhLokvktrA9jqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uhu53cZC/i9jnIgNtZl9DHyCJPNP7M2+7D0KPd9H0fOR7q4bemzt8shuQyEUWwhgw
	 1ceG+HynjH/FwHZBb0jwxNV8M1Q8u6YMdqWyVhbOh8oWKDv5uQ4TGn6HzZegbrrAqH
	 4TZ1iaZ6kqLTGCKwcLPz/ya6pD3aVyEPJTuAeq1ihituF+qqu/HxmZnuwCKmTMcuKw
	 7SqEgTRKI6Q9dEnoOjZp4wk31l0zJ8YG/iHBXji2ff9HJpgBY20Q6q9JQccuLxQsOQ
	 hGqeIqAOlGLcNYOfBJ7exBVzVbmnejqpV+UXJ5zxhlED6Nvu0YgE/UA8CGIIK7x8cD
	 +7qbaWZY4pG/g==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 09/25] mm: unexport vm_brk_flags() and eliminate vm_flags parameter
Date: Fri, 20 Mar 2026 19:38:26 +0000
Message-ID: <7bada48ddf3f9dbd3e6c4fc50ec2f4de97706f52.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is only used by elf_load(), and that is a static function
that doesn't need an exported symbol to invoke an internal function, so
un-EXPORT_SYMBOLS() it.

Also, the vm_flags parameter is unnecessary, as we only ever set VM_EXEC,
so simply make this parameter a boolean.

While we're here, clean up the mm.h definitions for the various vm_xxx()
helpers so we actually specify parameter names and elide the redundant
extern's.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 fs/binfmt_elf.c    |  3 +--
 include/linux/mm.h | 12 ++++++------
 mm/mmap.c          |  8 ++------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb857faaf0d6..16a56b6b3f6c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -453,14 +453,13 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
 		zero_end = ELF_PAGEALIGN(zero_end);
 
 		error = vm_brk_flags(zero_start, zero_end - zero_start,
-				     prot & PROT_EXEC ? VM_EXEC : 0);
+				     prot & PROT_EXEC);
 		if (error)
 			map_addr = error;
 	}
 	return map_addr;
 }
 
-
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0c35423177bf..42d346684678 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4005,12 +4005,12 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
 /* This takes the mm semaphore itself */
-extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
-extern int vm_munmap(unsigned long, size_t);
-extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
-        unsigned long, unsigned long,
-        unsigned long, unsigned long);
-extern unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
+int __must_check vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec);
+int vm_munmap(unsigned long start, size_t len);
+unsigned long __must_check vm_mmap(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long prot,
+		unsigned long flag, unsigned long offset);
+unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
 		unsigned long len, unsigned long flags);
 
 struct vm_unmapped_area_info {
diff --git a/mm/mmap.c b/mm/mmap.c
index 79544d893411..2d2b814978bf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1201,8 +1201,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
+int vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec)
 {
+	const vm_flags_t vm_flags = is_exec ? VM_EXEC : 0;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	unsigned long len;
@@ -1217,10 +1218,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
 	if (!len)
 		return 0;
 
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((vm_flags & (~VM_EXEC)) != 0)
-		return -EINVAL;
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -1246,7 +1243,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
 	mmap_write_unlock(mm);
 	return ret;
 }
-EXPORT_SYMBOL(vm_brk_flags);
 
 static
 unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
-- 
2.53.0


