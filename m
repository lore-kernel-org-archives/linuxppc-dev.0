Return-Path: <linuxppc-dev+bounces-28839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC489CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:37:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxrsC2l2wz30Tf;
	Sun, 04 Oct 2026 03:37:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791045423;
	cv=none; b=ktkDp8DwX6Cm4WnqpnqjLbAV8/00TYqHz82FeW9Trkp7hOYU3RVBJivWshfzRDrCeqd5Ckylo7HTDe6umvNr2U/kHgOTQa5qhMKQV/BVICu1SWMwxSUJDLGoO6cgOxQcvDL/AAZhcWLBI0aYnVr69ZhItFu8OfsKhKJAQNVGasQ8HzyhbLeCCDBoFQ51DoS1D8NHKtGCJWo55fy8O73zuDa7Y1G3aqs3NrA+vv0B2rn49tXpKi/+lwiVrvDnkg18YULT/9GdlG7WiHadNFfj6ISbFN/wZnCPhoXtK3cl0wnrGiFR+vBNe87eEF1wO9ImusSWr1XdNMEo4eU88tW3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791045423; c=relaxed/relaxed;
	bh=qivR91Lb5/7S8p3yp1PCCxRNqvAnmMyhYSRWXpH7C6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmXZUJFuOmUcwnWDxLk9/lCl+PEe5iPeGuHd3H1ho4SlqifYsVFLfzWNJUW5SIRIxjXMjF3Hqfzzw6xrMtOMBA16DniaVQXj9RNpf9kMOn3OSZjh9NRHfptHhwBYef8NfgyKGzMpQy0OJE3B5FpUZT18K/qHkhV9Yrn5lOjouQMT1cdAZeVNqS5akh7dY5hlTPMgtWYtSts8m1AKOZ9X/gKAwGXGhbNWm7unSiCNNjnwVbvrauLkaEKbR+bFgAWnsdn5pNkqGXwjfWHwjQ13gWhJa/cg3OAnhueNcfzrStaS9bkzrkh0+zeP25VVrJ2NdGSJ4THsPPQ1sUn2JhpcYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bca19C20; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bca19C20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxrsB3zhCz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 03:37:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 940B660D9B;
	Sat,  3 Oct 2026 16:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891FE1F0089C;
	Sat,  3 Oct 2026 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045420;
	bh=qivR91Lb5/7S8p3yp1PCCxRNqvAnmMyhYSRWXpH7C6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bca19C20hMcQuuGpr7oNxus8s2tM1TWsYQRABbJAGygQDQpr8u2qnkPVbdDlgQIWk
	 CaAfQbGuboW/f76aCpWpfMRGDCw/fGfCFf0v64A8PxopJ+FM3VWuVNann6gp4cpykj
	 /yuDMAasTPSA153fcZRo65wsu4SqFtjE5cBMl2d5WnRtyvfnm7gsHuPtyrpyavkdCo
	 H5ieUQLlZWa876iLq5qQrX2eaH8A2DGehBUJ1pgBTqpDPBSJ+NL4Uve/x8gITv3wvl
	 XiqgDICXX0BCgvrmvTmhHf56TBwkBXcnlcd32nt1+GcZQkXo28JsW9aF07mU5Dk0UP
	 7a1iAOZnhbOgg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 03 Oct 2026 17:32:42 +0100
Subject: [PATCH v4 11/38] selinux: reject writable opens of policy file,
 drop mmap shared/write check
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-11-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=ljs@kernel.org;
 h=from:subject:message-id; bh=X46vXp5xg8nLI6IG+V/Ab12M7pEZi9uJqKdEh54QAaM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIO6mk80Dy+k31hpEalsuvR2Mmvo4/sv+5fYaw5g5W/9
 d2+L4/cO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRp+cZ/ifP+/BlJqfM3crl
 k5Ry0pdcPFP+/N5P0V4lxZcelSvtjU4yMix59KFiM8+L8P1uvzzddr3T6HyqFte/K1P1N9txGWX
 NWYwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The policy file has no write method and is exposed read-only (S_IRUGO in
selinux_files[]), yet sel_open_policy() performs no open mode check, so a
CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, as
kernfs does.

The file can then never be mapped with FMODE_WRITE, so do_mmap() always
clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARED
check in sel_mmap_policy() cannot be reached. Remove it.

This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that is
neither a PFN map nor a mixed map, ahead of the core enforcing that only
such mappings may do so.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 security/selinux/selinuxfs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c7d91476971c..545a6f89f9e7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -340,6 +340,9 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
+	if (filp->f_mode & FMODE_WRITE)
+		return -EACCES;
+
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
@@ -424,14 +427,6 @@ static const struct vm_operations_struct sel_mmap_policy_ops = {
 
 static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & VM_SHARED) {
-		/* do not allow mprotect to make mapping writable */
-		vm_flags_clear(vma, VM_MAYWRITE);
-
-		if (vma->vm_flags & VM_WRITE)
-			return -EACCES;
-	}
-
 	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &sel_mmap_policy_ops;
 

-- 
2.55.0


