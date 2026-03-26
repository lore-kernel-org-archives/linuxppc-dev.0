Return-Path: <linuxppc-dev+bounces-18811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE84F106F2FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhGcw1nHnz2yTH;
	Thu, 26 Mar 2026 19:08:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1249"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774512528;
	cv=none; b=n2gsV+CUxW1wFlQs8x1b+Y8EOIY6+Og8tmmPW5D6GVLa7vDoHWMyhao5TABZIP91k6uBgzneZNzCrsdq8aUVK0mqLls7NeRvDZZ+77z+AR6jlVTaZl1Ff+Wx0O/7CWjVAv1tEBxcE+eIwE98ZN6Hc6N0S+I6zliQjEWu5Imr1fWJyGF1pylMmJcfTJR51dEJxzSjDAux2EVn5j4Rxx4wMuaYbPoOU1muFSF9DS03wAy4/07rJKyi77IRNBrME4L6nlN/+7Es5NraZ3QnMNWlgflVOHUprKI4xmKFSvzba03ZAf2PxnZOeWqSYpblZbo7lsU8Oizl0qaigDrtHefORw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774512528; c=relaxed/relaxed;
	bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S9SEM4/YPSDlmObx6nVM7kpgBoS/iCfYQFJmd8tsFbkLU1byik3qGg1omBOnluA6U+BBOU59esSD+d5n5lSCZVRkS3p+tmeLeL+HzK1cZ+TIGzLe784fkffENcmWSSTLxVEy60WDMnNI6YlzbAR1a3FcfGwgHt+EwAfZ5ggPUzW/mp6CMilT9hTmpxpXecGUZuAWhu6v8FqBYDYv+wlO0aZoxWoz2mIqtjJ1mX1A5PSiHZYYXfO+3mEi18buuICMqXKIIFIBzUdc76gU/A8ZrHvxd97zfnRHa3urYkfiRTIwgzjhT2zc5I2zlPutjsusSzfcDCo1zTXjz06BnnVNuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JhmQmNSB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3ieneaqykdmq241oxlqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JhmQmNSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3ieneaqykdmq241oxlqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com [IPv6:2607:f8b0:4864:20::1249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhGct1Whwz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 19:08:45 +1100 (AEDT)
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-126e8ee6227so701432c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512522; x=1775117322; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=JhmQmNSBIUXjmtVetm88un9rJIas1PnukiuP8wWjhjy3ifIpfe8YxA1nXduCAeFBkO
         26HAhZGuCqaXlVpgQ+ia9Wx/Mx5FTcX+RuF+W0vxawQ9wY/n0RfUafgatU99ieBpg+3R
         /UHj/Y86lZF8i/kvNzfUexylVIFcG99quYN+u9FgE7BiienzWmF2UHGyS6uC+FvBuJMp
         9CXaqHuZZsOuRyswsFwJkZX2tHml5ExYj+Mia1EPwi4L3WXdtz/6B5MhCeLtcOWQSjD5
         iKoh5pMejsbq4sAzU2xiek/W55wUZYpq7sQsPinK+T3E+Y4CMecbKdug6K3bPynX1X9A
         KcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512522; x=1775117322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=ZRkojchHtq8QEW/q34B2FcIdLiEjj4thyKxS5qvgrkd1iSvZJ6xoeEw+YXgpqQE+0W
         l6dC+L+0yvPFAgRc57LHxX+8fPfjBXBdmgWnQLzXn5nvrZrnBSwDl2TpgreSjZoVO7Q3
         FhdzWsbO+affLyoYCLFb4YNXHqZZCjN6Q8V4JKHQrgEo3DzHBn9pVJwpKlIbCn5UTZ9y
         PnAXj+X5xepwE6fKVv0ju7UsAmRQe8lTVH8Dhg6mMDRTRDZhMVBBSS5UaogaP9dDbfwd
         N+NXCcDihztXdxb05L8ZFTDezGD4XVYR3QECe8XJf9087sBOTniTSg/Bp3GDxpqDDkMb
         K9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUK/RfButIcP1HymjcgpB+4/RBYw25Dh8W71uWnNYVj9VKfWL/oqWrUCU7J1aXWse6yCR+JKAtAXyskllw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzD9FMw2Z/Se2INxveqN8KHda+uThzpkBALE2H5vOZoobcMY/rE
	9u/C77xpNziHiyGqf0MKTwhJuaj19+qlDlaCIchmeNxgh5JQxOopgvSVniXXeZ0ZrAperxMJEzB
	aSfNn8w==
X-Received: from dlbuy10.prod.google.com ([2002:a05:7022:1e0a:b0:12a:6d14:dfd9])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac3:b0:11b:b622:cad9
 with SMTP id a92af1059eb24-12a96eceb8emr2826837c88.21.1774512521385; Thu, 26
 Mar 2026 01:08:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:30 -0700
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-1-surenb@google.com>
Subject: [PATCH v5 0/6] Use killable vma write locking in most places
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Now that we have vma_start_write_killable() we can replace most of the
vma_start_write() calls with it, improving reaction time to the kill
signal.

There are several places which are left untouched by this patchset:

1. free_pgtables() because function should free page tables even if a
fatal signal is pending.

2. userfaultd code, where some paths calling vma_start_write() can
handle EINTR and some can't without a deeper code refactoring.

3. mpol_rebind_mm() which is used by cpusset controller for migrations
and operates on a remote mm. Incomplete operations here would result
in an inconsistent cgroup state.

4. vm_flags_{set|mod|clear} require refactoring that involves moving
vma_start_write() out of these functions and replacing it with
vma_assert_write_locked(), then callers of these functions should
lock the vma themselves using vma_start_write_killable() whenever
possible.

Changes since v4 [1]:
- added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the code
stayed the same)
- split patch 2 into 3 parts, per Lorenzo Stoakes
- converted vma_start_write() in mseal_apply(), per Sashiko
- changed vma_start_write_killable() error handling in
set_mempolicy_home_node(), per Lorenzo Stoakes
- added comment why mm->locked_vm is fine even when we exit early,
per Sashiko
- moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
and Lorenzo Stoakes
- set give_up_on_oom on error in vma_merge_existing_range() to propagate
the error, per Lorenzo Stoakes
- moved validate_mm() out of the error path in expand_upwards(),
per Lorenzo Stoakes
- dropped the patch changing S390 error handling, per Sashiko and
Lorenzo Stoakes
- reworked error handling in clear_refs_write(), per Lorenzo Stoakes
- uninlined process_vma_walk_lock() while changing its return type,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.com/

Suren Baghdasaryan (6):
  mm/vma: cleanup error handling path in vma_expand()
  mm: use vma_start_write_killable() in mm syscalls
  mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
  mm/vma: use vma_start_write_killable() in vma operations
  mm: use vma_start_write_killable() in process_vma_walk_lock()
  KVM: PPC: use vma_start_write_killable() in
    kvmppc_memslot_page_merge()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 fs/proc/task_mmu.c                 |  12 +--
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  12 ++-
 mm/mlock.c                         |  28 ++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   8 +-
 mm/mseal.c                         |   5 +-
 mm/pagewalk.c                      |  22 +++--
 mm/vma.c                           | 146 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 190 insertions(+), 70 deletions(-)


base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
-- 
2.53.0.1018.g2bb0e51243-goog


