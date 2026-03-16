Return-Path: <linuxppc-dev+bounces-18245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C35F506D1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFm067vlz2ypW;
	Tue, 17 Mar 2026 00:09:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773666544;
	cv=none; b=Zrde2uxCigG5hv0RkxeGuvj4bKBto8soWIYJxdH6os6jVVOfw/xiSNbkTq1sD2dX2AGK0fzoX/EcWEPkguoAJWH/wn/4j/KJcw9ekB3NGDH0x/iZEgpJgKpeyTA8HdZkk8laVEarrOBXELZ4KvWGGPEqnk3Q8+/rF6FDqfj5FtnRyrytS2OWWU0jmW+jCSNiQAVhDNINgWfneAS+RjnpxyzHCGObW49JUfqfWTfEYQkx3GO8V6r3TFaWTdQlIdNG2tD33YUDq71StGTvqGcZy46d/PWRJzOgUDG2w/AzjMw6xFLn48sVTKGzEaFyg9Ozu3UIHa50czqvYjfy7+0Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773666544; c=relaxed/relaxed;
	bh=qFO98x0xjvDv2m172P8M+3+Va2AChNusVU0e+ehXkTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVI1MxoEjRMex4s0m7CMeTYcEq6qLzHnAM9hL4QXCW7+V0+hT54aL56t2PrZ1LHyUjwctQP4+4s/6vTAbKlPKNPuoVIldPbrBtwUaiBmcROeP9fjnzyOYV59zQ8jDbYQ6G2TVKqxiRsYGqHy3F8/DuwD2y+OF73uTqrNBP1F/emxAg/yJcUNly4ZpRaVLaW9Gt2defbRBfagmAk/BcNDdNHli91iERv5p1UKfgKUpG04g1uw4ZCcz9pLvTtFjg5hpSQYhL1vVCpaqO8rtQeqlzoT0Ia07W0YhDQzfQEn7IfIwkXwwzIOjdycGDVhx7rF/pcV9tFBzqaVzZoi9exc1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bZ/0Uom5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bZ/0Uom5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFm014GRz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 00:09:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91483438FE;
	Mon, 16 Mar 2026 13:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0DDC19425;
	Mon, 16 Mar 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666542;
	bh=2bgwsSAPZtKZ4SCtldRI7sINolEwa6xcZ3YIHjNJ4Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ/0Uom5mgBQr1HgT+j40FYVRLhBQ0ojMjIytJU82DHtW+o9EqipX1MEMhvG0F9np
	 GF/Fs+2339hQWZx6ny71PjOl/3BZ9+oTiX0gHJkITvA2xFvTF5rWvO4DrpfcEGTP+S
	 0/8JIeNX/fbRbVoF9uMT79o0Ewtw/LJhYOM1Gd+q1Y0dB8a3F1zPh/tYb9hRTjFkiP
	 i7kLfqzmPA1xC7IgrzCgn48y1T9L3y3d3W3C8h9d5dZbryzynLkrwwobkjPLcqQDLc
	 92VXTBBcblJ2zMJWDy5yIr0JdLxBHfDsm5vU98N6BK/1bx0JuLHMNWrtGIvX5xiAL7
	 HPGXHogrINxmA==
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
Subject: [PATCH v2 03/23] mm/vma: add further vma_flags_t unions
Date: Mon, 16 Mar 2026 13:07:52 +0000
Message-ID: <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
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

In order to utilise the new vma_flags_t type, we currently place it in
union with legacy vm_flags fields of type vm_flags_t to make the transition
smoother.

Add vma_flags_t union entries for mm->def_flags and vmg->vm_flags -
mm->def_vma_flags and vmg->vma_flags respectively.

Once the conversion is complete, these will be replaced with vma_flags_t
entries alone.

Also update the VMA tests to reflect the change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm_types.h        | 6 +++++-
 mm/vma.h                        | 6 +++++-
 tools/testing/vma/include/dup.h | 5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ad414ff2d815..ea76821c01e3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1262,7 +1262,11 @@ struct mm_struct {
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 		unsigned long stack_vm;	   /* VM_STACK */
-		vm_flags_t def_flags;
+		union {
+			/* Temporary while VMA flags are being converted. */
+			vm_flags_t def_flags;
+			vma_flags_t def_vma_flags;
+		};
 
 		/**
 		 * @write_protect_seq: Locked when any thread is write
diff --git a/mm/vma.h b/mm/vma.h
index eba388c61ef4..cf8926558bf6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -98,7 +98,11 @@ struct vma_merge_struct {
 	unsigned long end;
 	pgoff_t pgoff;
 
-	vm_flags_t vm_flags;
+	union {
+		/* Temporary while VMA flags are being converted. */
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	struct file *file;
 	struct anon_vma *anon_vma;
 	struct mempolicy *policy;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 13c03bf247bc..e1ec818de239 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -33,7 +33,10 @@ struct mm_struct {
 	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 	unsigned long stack_vm;	   /* VM_STACK */
 
-	unsigned long def_flags;
+	union {
+		vm_flags_t def_flags;
+		vma_flags_t def_vma_flags;
+	};
 
 	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
 };
-- 
2.53.0


