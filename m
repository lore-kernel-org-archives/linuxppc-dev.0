Return-Path: <linuxppc-dev+bounces-18555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB60BFC72AA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 05:43:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdlZy39Rkz2yjV;
	Sun, 22 Mar 2026 16:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1249"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774158202;
	cv=none; b=aANbugJxSRAjvb8lSwGWpjNmdBKeFNi1RnTF12RwFAn/rbUhcBgHMKNaHY+n5Ie6WAIPzNEVq21kUz+oPfwIPTfdq4DRrk8z/Y7LKW52zUK71xhBQnxCQj6OA9R6s7BPwCsGMycM/4VDdt0ZXXds2bVUziXOOFMxbVNTV1iSdsJuzhKvfZKluvSSwErTj/BW7g8jnX2ik5WQuyzCfLlgkWD5UUAPl+L/GMEFhqKPQBxWcN1jEuOJQhAyTfDTX6Ft9T73h7kliYPC3E7TKQHSGWLOR3NO9xlkbraDKny/hCfEoM5SitjG99WDBcnRFURFvgC2HXDOveid+A3rgYSbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774158202; c=relaxed/relaxed;
	bh=GvTHfHDaEeYEd5IaJalf0yvJB887/iPHMmYQM447rIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUWFNtgJ0Np9EhJ5bEk/dGdGREhPTYK64mqdY3a33DcQo37D3DHYijUA67tA+gvbdZ+CTSp6eaNpg2FTwSMafmKZ4pSAjgMD8Aax6in/jFOIHthaLfkyGJ5PHVeBs3PYj2IaU0wGUAVCAEJwtDuqcGk/5OvIk4tiBG9RRno2S03nY2P/0JyA4lB0+Fs77ly/eWT/hj8l0j4teuqdUyMPXTOtJv/cgQy9cmEts57F83bh0u1QsC88PM7CQH0bBqYPzyLxa5GGfEpQArDqhB3ZTu1Bdjap44vu4AlWsj5PqgHzSNPHBnbg8QV67sJAB2v3/2bUuhzRjqzuLFumJcZheQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JLGvYsov; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3d4g_aqykdmwac9w5ty66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JLGvYsov;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com; envelope-from=3d4g_aqykdmwac9w5ty66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com [IPv6:2607:f8b0:4864:20::1249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdlZx5bgwz2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 16:43:21 +1100 (AEDT)
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-127337c8e52so16082511c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158200; x=1774763000; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTHfHDaEeYEd5IaJalf0yvJB887/iPHMmYQM447rIU=;
        b=JLGvYsovH5g4zgjJpxdjQVW+P/I4vI3ae6hqhGG48b+ZQ26OBqSi/DMVpvc8jedljk
         23wShNAVI2CwW/jFzzehm+uKiWwu0HB5r/JIfkLGTdbt9VyRB/diW2CqRBOdTPojKinl
         dMLu3ZWi/6rLYkWr6i1M3eZh0y3/bkTiNjY0KWHIkUWYvV7d6yWgFMz8SD50wrPE6Bw1
         FOS2WcmwCyy6M8XV5OBFsrP1i9346u3VtXvOJfToxiZxieGxL0Xfj0Y/Xcus65c5waUm
         ElDeYZqLpcAVcPCGvdEyo+DSOPSxdyI//G8BXYXp5KYvMt3OvQ/1OrI2Pvtl7mr6Lg0Y
         SS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158200; x=1774763000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTHfHDaEeYEd5IaJalf0yvJB887/iPHMmYQM447rIU=;
        b=O98/VMemAWfPxCnKQHW5GIPjLuD526g7xFWG/qDVGGtvnLJ3ITRi+pDwO6ZGfJpktC
         ZZElX0trfddK/FnBrAM7Hy2AEfskFwrBt9LvuX/ArTY56lIQGtX98+9orxb55CPhmVQC
         RCe7SYFya5LPESGdJ9j39RdyoLF7zzkW4GVrFDVfsV7Q9Krnl11+83HXTMeDbbG39pwN
         y25+8zdMCkrad5tD0HjC7+gLQlHKfWL1om/t5VQyJyAzZ7gY8ABcutWaijePXmsrP/LI
         5bC41IoCdLzilHA63FeDiz6zQidYmbtIbQEnLZBUsv7ltLfSAtzHt+0OFDMwvfNsJ4kQ
         2SrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Rh01v5d7JwbEsChVOTGzXtrLrufU7w7Da/gNW4liV6wEpFTbt3MGZS0djGbwrijMGxV8d1Aj1PgBuVU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7c9PhnORUbUsV501YJCP1hV86XpxuaFep7lH6oeCKrkGE+IRH
	5WSzg8EGWF4p9NsnSakHV4fAQAnJYYoAFm6TnWVUbx5OnTq8yxfC9KpT37gMkY2aoMW0OrBrP5Y
	D+HReKA==
X-Received: from dlbvg27.prod.google.com ([2002:a05:7022:7f1b:b0:128:d754:39d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a8:b0:127:33e0:ea33
 with SMTP id a92af1059eb24-12a726b3177mr4054533c88.22.1774158199330; Sat, 21
 Mar 2026 22:43:19 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:07 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
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
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-4-surenb@google.com>
Subject: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
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

If kvm_s390_handle_pv() call fails its error code gets recorded but
execution proceeds as if the call was successful. If the next call to
copy_to_user() fails then the original error is overwritten.
The follow-up patch adds fatal signal checks during VMA walk, which
makes it possible for kvm_s390_handle_pv() to return EINTR error.
Without this fix any error including EINTR can be overwritten and
original error will be lost.

Change error handling for kvm_s390_handle_pv() to alter normal flow
once failure happens. This is consistent with how kvm_arch_vm_ioctl
handles errors for other ioctl commands.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3eb60aa932ec..ddad08c0926f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		}
 		/* must be called without kvm->lock */
 		r = kvm_s390_handle_pv(kvm, &args);
+		if (r)
+			break;
 		if (copy_to_user(argp, &args, sizeof(args))) {
 			r = -EFAULT;
 			break;
-- 
2.53.0.1018.g2bb0e51243-goog


