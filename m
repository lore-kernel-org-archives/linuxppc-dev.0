Return-Path: <linuxppc-dev+bounces-18553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79916FC72AB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 05:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdlZt6vXBz2yY1;
	Sun, 22 Mar 2026 16:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774158198;
	cv=none; b=bx1f1pJxkxTRzd6VPG0/iKOl1XBHmBNiZhl/s+8t4SLUaPmfNoI1PKRFa+5zMeKL6uEsn4RbBHiDG2hwBeBSl9ziqH1I+YC3OLEWpTK3VgVrFD8mO57hbOzlQqkYW1FWVsq3nhh/oLkA7o2fiaUzvNuXMkso0EbbrZDdBvaoT59Pbl4LEc74xoXpzRsedE9Bs4//e5Mis3kiant1iaJSKIVbdC3OgQZB0d6ywjl7VKTJpV0CWg/6vEdCjmD0q1YCmnZu/20Wtw85ZI9gPDIPXKgSh9xrCdg/DHpCUT4aUQD+mh4gIGEtLW7OlUx/YK6dAyOm23wn/RD4UHbbzlUFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774158198; c=relaxed/relaxed;
	bh=vcHDXdXeHcBh7JcXxd/NIeUk+f66988A9WXmJh1lMtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gEdC4HpoREKB1Fel4VsT+6yZuCQcEW10bXkqPOXnX3IqrMNpjfzI9e4X+/K7LjNdK0uX//nZ7sEs538n61Q++sWDO1nW2SegiNjpJwY4+eqzoMjYJUX4urIyj5qMz2eO4XUjZ8rJctcMLSZLYzHhRjGUzV4kxY6nXvQ1Zd/OJgFG5RhMxogfUg+w+4GZs3unJe/FF4QhrBYQCFTuBHcOUxT3B7C+OanAvuOMMfHP+z/5meMHWmviECYo9WBQbzoZ1j56Ac5o0DG0UaNF7gU779t5wRIrtYsgcrdHBGCAi+pNJRfpNQmcdPPad6LjmnOa2+94vul3IRzQqpoUDnjE7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TZ372crv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3cig_aqykdmu352pymrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TZ372crv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3cig_aqykdmu352pymrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdlZs28Z8z2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 16:43:16 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2c0ba59a830so2046774eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158193; x=1774762993; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcHDXdXeHcBh7JcXxd/NIeUk+f66988A9WXmJh1lMtA=;
        b=TZ372crvP21shcyd6IFNy7B7LTug2jizAnUZ/OdCN3km+NX2o+S9NWAIWCltMd6U44
         uSEbYluXS7FbSFmko+TyENTJjt1dOkVBTGb0499yl0iBnC2c1xhm9q6IWXe8XoU31zbS
         hq8+mSR1EOGBEhlL5BSijCjXmaQTh2880MDhQsok3q5x2SBos11irscg7zZ/wLJu+S/k
         eMEdV8ffZrD/9+jLMo9fvTcofcfayaNEzJisPFDERYV82mjbfFpsEjLM2Z9OwZhDq1Wa
         NcISkkxcuu0KE/+lZidlntfI3Gjkd70/gF7kl7xiZ/1OYzQmj3f4LHOf0nGsJawjYNMe
         pWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158193; x=1774762993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcHDXdXeHcBh7JcXxd/NIeUk+f66988A9WXmJh1lMtA=;
        b=KVIBn9SgOVuziHiDco/Ax0t+y7oe4HRo1c2geN5p83qIPOYtJfUSAhVMlMxHR5abar
         2NVTvE9VyBvpDC2xDb54ob8Sua+GW08WY+AybpyJ7lqvRqYZbgUXB2NK2N5iv58Pfi57
         7+NCMO94JLUYuHCCTszUqDqAM6dmnTauad68XQtWofo69BBwHTT2mGRCr6Jr57cFVm+O
         Si0nIiL0bx23+pdNFJgtc2dUNNfvNmM0gXui52l9TQmcoKL0aML5MECf1R2fOSWXoRmf
         0wVk2FiplG3+28zpNDD2j9tO37yIUg7O76MBiBS+4ErTFg/lbpZuU6ep9TXCwGa2jkWv
         HTSA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qJZEpN42k2VyaYziKzHIF1YfvvbTlNVvctkjeoqHwJHuV/Bznpt1ZJDanDMhkAWXHLyNJGn4iKbr55s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFaOUiZ9u8OG52xUraiPZ1CW+1OZ9+G5Hvzb/g0KotI2vtZKZ/
	VI0eAlwTChYNu33rlGAtY4ej4AR+eH9r2TSQLn4k5y9lbf/isNj1cKOFlSFOoMmhFLLNP+3tXLX
	9VTVkRg==
X-Received: from dly25-n1.prod.google.com ([2002:a05:701b:2059:10b0:12a:7703:c328])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:490:b0:12a:6a64:81ef
 with SMTP id a92af1059eb24-12a7267d891mr3739492c88.9.1774158192658; Sat, 21
 Mar 2026 22:43:12 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:04 -0700
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
Message-ID: <20260322054309.898214-1-surenb@google.com>
Subject: [PATCH v4 0/4] Use killable vma write locking in most places
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

A cleanup patch is added in the beginning to make later changes more
readable. The second patch contains most of the changes. The third patch
is a small error handling fixup. The last patch contains the changes
associated with process_vma_walk_lock() error handling.

Changes since v3 [1]:
- rebased over mm-unstable
- added Reviewed-by, per Liam R. Howlett and Lorenzo Stoakes
- moved locking before vma_iter_prealloc in vma_shrink and in vma_link,
per Liam R. Howlett
- added a separate jump label for vma lock failure case in do_brk_flags(),
per Liam R. Howlett
- fixed cpusset -> cpuset, per Lorenzo Stoakes
- added comments explaining vma_start_write moves, per Lorenzo Stoakes
- amended patch description with explanation why vma_start_write moves
are safe, per Lorenzo Stoakes
- added comments listing EINTR as a new possible error code,
per Lorenzo Stoakes
- moved comments in mlock_fixup() and apply_mlockall_flags() to more
appropriate places, per Lorenzo Stoakes
- replaced check for EINTR with fatal_signal_pending() with a comment why
it is safe, per Lorenzo Stoakes
- fixed error check in mprotect_fixup(), per Lorenzo Stoakes
- moved vma_start_write_killable() before allocations inside __split_vma()
with a clarifying comment
- changed mmap_region() to set err for each failing case,
per Lorenzo Stoakes
- changed label names in expand_upwards() and expand_downwards(),
per Lorenzo Stoakes
- changed "if (err < 0)" to "if (err)" for consistency,
per Lorenzo Stoakes
- separated error checking fix for s390 into its own patch,
per Lorenzo Stoakes
- removed special handling for EINTR, per Lorenzo Stoakes
- dropped changes trying to propagate EINTR during vma merge,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260226070609.3072570-1-surenb@google.com/

Suren Baghdasaryan (4):
  mm/vma: cleanup error handling path in vma_expand()
  mm: replace vma_start_write() with vma_start_write_killable()
  KVM: s390: avoid kvm_s390_handle_pv() error overwrite
  mm: use vma_start_write_killable() in process_vma_walk_lock()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 arch/s390/kvm/kvm-s390.c           |   2 +
 fs/proc/task_mmu.c                 |   5 +-
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  13 ++-
 mm/mlock.c                         |  28 ++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   4 +-
 mm/pagewalk.c                      |  20 +++--
 mm/vma.c                           | 133 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 173 insertions(+), 59 deletions(-)


base-commit: 8c65073d94c8b7cc3170de31af38edc9f5d96f0e
-- 
2.53.0.1018.g2bb0e51243-goog


