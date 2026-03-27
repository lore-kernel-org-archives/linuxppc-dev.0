Return-Path: <linuxppc-dev+bounces-18938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA310F2872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 20:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCZg5xn0z2yfs;
	Sat, 28 Mar 2026 07:55:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774644907;
	cv=none; b=ZtHEle1UVVU7HF/6THAKVvdCcQlAxLX2sYMveGy8xSif5rYWzqI+88jkIKs9oRCdVq3XVLEUfdEKc8G79cYClQi4Vqkga7aXBq/cvHFgnCpYG2e6TYeOqWPGRp9MYM8GHSjKKkNQ6tBBurMaXWTkThFtR9m8o/cPhx6h43yeYI4dq61j/DKFhTYReNaqAfo76LpAQyOsnxanK30UgRC5ACsLFlFFBeA1WOIbbgpLZLrmmssQgZvtSOBvxCxslCLbSpyRVsZyBhWrwMf6VrdNEvmavS64YJ1TIOwOGDwU/PZqyb6O6OFdT71N9zDPc/l9bGwz2oHkrWFI5dman0+hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774644907; c=relaxed/relaxed;
	bh=xdmn94fDq5EabxgUHdZFE1PchWB5l0Hn00gGljt6mxc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PVWIr7Xwetd/5sGMUrf3RXH+T0tkVGInEfue3JRFMQAf0A2Xb+Czn9XecckT2YU8nsIFirZyouckzA3i0zanb4BBnMLIkZvGcIkKqr0UPabyZBudeV9JaPJsGFraoG79uvkWFSCKstNOZipIktrGtGsCddxXDVLSIxA4faPCm+kmJ5RAEwvU6oEX1HhXDq0rY0OWZHZamDIvajpPibg7TJdKxGT1kF4e454muk+qjpgnzeova9Z5IsjhV2USOpDFrmyCmHguT6T7ChhXMHQaJD4ZAPIb+BQoiXvflWDSlKJm/lyQ4HBEDPL3TrDkVv0PG96HxyzpHQzhUkWbVeYZmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dTU8G2gY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3pe7gaqykdpimolyhvaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dTU8G2gY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3pe7gaqykdpimolyhvaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCZf1khWz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 07:55:05 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so5482224eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644902; x=1775249702; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdmn94fDq5EabxgUHdZFE1PchWB5l0Hn00gGljt6mxc=;
        b=dTU8G2gY52FtCftFmFe5BpvvGbR9s7EyDqbvlWS5P4+E3Gc4w0k3lJ98LCzKU/B2qj
         StiXrFy5MJOPcmQW6pZqRQw14m3WQ/P3TzIRr7TMOngy78wShy1AyeperzU5UtmhCBDu
         nKbw9ZRmphd4JdXNB+8G6FBNtkzrii4lOpgxRdniWKAtAQKvypV7Ih8rWZDh2zvIFAL2
         O9lYEF7GbuOd0b3hCw5fEs59T1JGrRPZJ2wsJgzK2yll/F5aN4WpYhayLKCPKh/mT/al
         mTdfxJWa3B0olZpOukH7sg2ukg/8LMf511iKnJAVucOjc1R4s6RrYehagcrDV9YJIpxU
         brbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644902; x=1775249702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdmn94fDq5EabxgUHdZFE1PchWB5l0Hn00gGljt6mxc=;
        b=odjbIB/Zv6NAYyAeewPCR0pS2RU4jybsYD0DDPT883kllJDJyy8hCeT4RR9JmiS3oi
         +myS6BXBqKWLLota66ZNQIj3wuk0qoPu0f+WBYgWZ+5Cw5QNZTV81G+L3a23dno5sMus
         3Pjogiad4xeUQ/PjhPmjAf7hTuLLI+DYadMSRXLU21lewUcciDoCmE2x9VKX+BQnJZTK
         i6P38m3SjG1e/06Jc4hBZJsKdzH7lS5zbPj50VC1Jy8auuDGs8PmmWuQJtIV9CVbeQAY
         r1s9ivXWT9FaM4VqdWlb6IUKDuU75a8HStZAlKKra5zlR8dgyYxVHlRiFlXAzZTNFeSU
         KMMg==
X-Forwarded-Encrypted: i=1; AJvYcCVpRUfzNglTJfcG4tgBHvSczkwYZwbqTAZqosDS5muN8oLTNwfbjZQ+G0MibPJ0hrK9nNSkn7xObOdO5sc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzz4JKyg8NvzHI07cB0FfIP5cwJ9HtKMVr8bV49yJPm2zs1GrsO
	yHOzFUSr26ljfuS6NuybJPQRk1MXyVBq2SFg83q0oGOC7NtoeSmQD0fadPLXkg4pAAQXTxc+qxR
	A8inzuQ==
X-Received: from dybse8.prod.google.com ([2002:a05:7301:4908:b0:2be:77bc:5c34])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3113:b0:2c0:cff4:b456
 with SMTP id 5a478bee46e88-2c185e5a4e2mr2359718eec.29.1774644901334; Fri, 27
 Mar 2026 13:55:01 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:51 -0700
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
Message-ID: <20260327205457.604224-1-surenb@google.com>
Subject: [PATCH v6 0/6] Use killable vma write locking in most places
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
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

Changes since v5 [1]:
- Added Reviewed-by for unchanged patches, per Lorenzo Stoakes

Patch#2:
- Fixed locked_vm counter if mlock_vma_pages_range() fails in
mlock_fixup(), per Sashiko
- Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() and
mseal_apply() when vma_modify_XXX creates a new VMA as it will already be
locked. This prevents the possibility of incomplete operation if signal
happens after a successful vma_modify_XXX modified the vma tree,
per Sashiko
- Removed obsolete comment in madvise_update_vma() and mprotect_fixup()

Patch#4:
- Added clarifying comment for vma_start_write_killable() when locking a
detached VMA
- Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers from
falling back to a new VMA allocation, per Sashiko
- Added a note in the changelog about temporary workaround of using
ENOMEM to propagate the error in vma_merge_existing_range() and
vma_expand()

Patch#5:
- Added fatal_signal_pending() check in do_mbind() to detect
queue_pages_range() failures due to a pendig fatal signal, per Sashiko

[1] https://lore.kernel.org/all/20260326080836.695207-1-surenb@google.com/

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
 mm/madvise.c                       |  13 ++-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  21 +++-
 mm/mlock.c                         |  30 ++++--
 mm/mprotect.c                      |  25 +++--
 mm/mremap.c                        |   8 +-
 mm/mseal.c                         |  24 ++++-
 mm/pagewalk.c                      |  22 ++--
 mm/vma.c                           | 162 ++++++++++++++++++++++-------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 251 insertions(+), 84 deletions(-)


base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
-- 
2.53.0.1018.g2bb0e51243-goog


