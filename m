Return-Path: <linuxppc-dev+bounces-21347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91573CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 02:33:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gM8TS02s4z2xSN;
	Fri, 22 May 2026 12:33:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779417195;
	cv=none; b=bK0E6aA1+FdKMcs04LrxYm2Ck5c+fwM734fiFg0DHFs32rnAuXwQBqaKGoVybHbamd00RFzkOyBkH5jcFki9twvYfnfdfOwSqHZGcoRwRE2YoPQ7T9QQkQRdzSUA43an7CqhFPNoVcankop2ilG7yWHmis+VmjdEgb4c44ieclkoT+oTTBG2MfoNQ+yUE4RydYW+qIt7MNM1/63c7qasTl9YMqfRB/cmyIA9F4jmHWrKhD3gfteze/+JfAQd0MIDoDa/2v/YPQbrXIkHXKcoI6iMBITUiw+/T/pItej1vJDUYUDaRuGqZ2wp8bR87yTLWfcBEVbR/LXjEmOMvPOk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779417195; c=relaxed/relaxed;
	bh=PJskQkzEXcKmwKbi50aKVJcncb0pn8mjKGrAaOB03qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzBVrp+iQQC1mWNtGCx1ZGjxi1oJfkNC9NBhNGPOCSSHpUk8Gq1a8u/TxIFHy3A6EHZoX7aV/7YKYRIDBBYWmGl2XG+rB9bfwDdnTXSPbJP9sdiIhcS2um0dgXj0RrpCFZUsH7MSQDuKur9AyMzrl8Z+dHfmjYDtjJEKCXdiGgs0jKyyUDnxOl6ybMgYRNs6e6ie5KMj0DvmxAX9lYSh+bQJbsLZO8Nh+xc3e2xohyV3B4f/lPMdevRWE8xzEGu46bucrNUgNA7qAKDGUjCb1YZ3dG4WnZTUNlJMDB94O+oMJeKlMbQ7vMFfB3Jy+ilG3KLV+wPLNjxeqf56P7622Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeKgLmEu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeKgLmEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gM8TR09P2z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 12:33:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B82EF41976;
	Fri, 22 May 2026 02:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D771F000E9;
	Fri, 22 May 2026 02:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417192;
	bh=PJskQkzEXcKmwKbi50aKVJcncb0pn8mjKGrAaOB03qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeKgLmEuttrABY4GEK31DGR0wtvJQrbUrhDPjYBD0fAY03yRd26tJZ2eDRLS+BsTj
	 Jc8ZK+9ymsTG20hwtzOzSZUvyudQMej6Bcon1ca6XsG1grJ2wrlF+v08Krpa2XNaB9
	 Ogvd1UMp4/wjQovEhihOm0Mu8C20O7Ia2iMmYnfKXWWDLPzC/a4o6aaU0wXG7HysH/
	 6AnP+a6YdbcY2AEFhFpvHwLkkxaP+4/nZe5g9D/5FY0ux2dCqHaAtBygGeBMOESKzX
	 Tt0YzWQyecsO9FINPUXBNfRbkfWKeNeWGARhT827Jk3NyexG0cbCk3pdahcQv7TUVx
	 TSkNLfO2phPKw==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chentao@kylinos.cn,
	chrisl@kernel.org,
	david@kernel.org,
	jack@suse.cz,
	kasong@tencent.com,
	kunwu.chan@gmail.com,
	liam@infradead.org,
	lianux.mm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	liyangouwen1@oppo.com,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	mhocko@suse.com,
	nphamcs@gmail.com,
	nzzhao@126.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	vbabka@kernel.org,
	wanglian@kylinos.cn,
	youngjun.park@lge.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page fault performance
Date: Fri, 22 May 2026 10:33:05 +0800
Message-Id: <20260522023305.98223-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <ag4kj84EcKqamdB-@casper.infradead.org>
References: <ag4kj84EcKqamdB-@casper.infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, May 21, 2026 at 5:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> > My understanding is that we should not blame applications here. This is 2026:
> > there are basically only two kinds of applications — single-threaded and
> > multi-threaded — and single-threaded applications are nearly extinct.
>
> all of the applications i run are either single threaded or don't fork.
> what multithreaded applications call fork?

As I replied to David [1], we cannot control what those apps do.
Technically, I agree with you that calling fork() within a
multithreaded app may not be a good idea. But in such a complex
ecosystem, we cannot simply say no to those apps.

Especially when our phones are improving the kernel with this fix,
our customers may instead complain that our phones regress their
apps first. That feels unfair.

I can offer a two-step plan. For the first step, we keep the
current approach of dropping the VMA lock and retrying page faults,
while trying to make the smallest possible change.
As discussed with Suren, the draft code is being changed from a
whitelist approach to a blacklist approach. This way, we do not
need to touch `filemap.c` at all (probably because you are already
maintaining `filemap.c` perfectly):

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 63de8e8684f2..4101d5fa7a82 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1322,6 +1322,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -1351,6 +1352,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 						 ARCH_DEFAULT_PKEY);
 		return;
 	}
+	if (!(fault & VM_FAULT_RETRY_HARD))
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..eeb7d6091bef 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1659,6 +1659,7 @@ typedef __bitwise unsigned int vm_fault_t;
  * @VM_FAULT_NOPAGE:		->fault installed the pte, not return page
  * @VM_FAULT_LOCKED:		->fault locked the returned page
  * @VM_FAULT_RETRY:		->fault blocked, must retry
+ * @VM_FAULT_RETRY_HARD:	->fault blocked, must retry via mmap_lock
  * @VM_FAULT_FALLBACK:		huge page fault failed, fall back to small
  * @VM_FAULT_DONE_COW:		->fault has fully handled COW
  * @VM_FAULT_NEEDDSYNC:		->fault did not modify page tables and needs
@@ -1678,10 +1679,11 @@ enum vm_fault_reason {
 	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
 	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
 	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_RETRY_HARD     = (__force vm_fault_t)0x000800,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x001000,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x002000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x004000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index 7c020995eafc..b3e7ffdd83f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3797,7 +3797,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 	if (vma->vm_ops->map_pages || !(vmf->flags & FAULT_FLAG_VMA_LOCK))
 		return 0;
 	vma_end_read(vma);
-	return VM_FAULT_RETRY;
+	return VM_FAULT_RETRY | VM_FAULT_RETRY_HARD;
 }
 
 /**
@@ -3824,7 +3824,7 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		if (!mmap_read_trylock(vma->vm_mm))
-			return VM_FAULT_RETRY;
+			return VM_FAULT_RETRY | VM_FAULT_RETRY_HARD;
 	}
 	if (__anon_vma_prepare(vma))
 		ret = VM_FAULT_OOM;
@@ -4778,7 +4778,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				 * under VMA lock.
 				 */
 				vma_end_read(vma);
-				ret = VM_FAULT_RETRY;
+				ret = VM_FAULT_RETRY | VM_FAULT_RETRY_HARD;
 				goto out;
 			}
 

For the second step, we can move forward with your approach of
ripping out the PF retry code, after getting in touch with the
owners of those popular apps one by one to understand why they are
doing this and whether they can find a different approach. In
short, this would allow for a one- or two-year transition period.

What do you think about that?

[1] https://lore.kernel.org/linux-mm/CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com/

