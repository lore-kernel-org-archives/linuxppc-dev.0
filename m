Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ECC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Mar 2022 05:17:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KR3xK3rK8z3c4m
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Mar 2022 16:17:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p1RRPdi5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b;
 helo=mail-pl1-x62b.google.com; envelope-from=xiam0nd.tong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=p1RRPdi5; dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KR3wY5jpzz2xf9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2022 16:17:00 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so9556320plg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2022 22:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=v6BSL8VhVmwIej2fDS4fILub4T69woLAa8tFuzppLBk=;
 b=p1RRPdi5pT7hK/9+H4XP2JjJHVZf5LxJOg8oRMScYDqznggSSt6DW7OpAdLqP4W8AO
 QWWXECWxX9RPOiBmnLcGSoeUAuH1F+eyyngCzsyhHkZijHQoVL9KbaZwV9fGF305+GcJ
 KQ3lX6EwP13jR2+yq49xM5HsChFGhq36v/XvVksErbSWaX6jJWgE1FVl4GfE6ZGDp/ME
 zuCOEEjiXqpFYeQgPcQWuFdbX097X4/JPAM0o/UjSHybVTDj/5lDfa+2lsiPJUw6JxuM
 exi7XYluIPx9OcyFwBgAHJMqZ3Sg1+1ssX6ot4argKFyWxlQSjKuvG+YfQKY4uDl0/u6
 BxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=v6BSL8VhVmwIej2fDS4fILub4T69woLAa8tFuzppLBk=;
 b=AKbx/ud6POrNFlVxRSlBI3cSOXt3YzuiQi9iMJnqfyCwGIJuVyiWSMwJqARuXbFD+T
 oUzszaBQOHd3TccZHc6n/X52YqmGSXQ4R/FA2GyISE4eVZ2XynWTZC5pwCBFrrclB7MD
 UQqt5ObDfLc/yB49AVyfNvizwkSDsilPXZxnFIJmZgS2rlRGWy+f1NjVT94o/haSp2NR
 GtEk/gcrLS0Tx1NDihyeHLlLNNKVYn7o3/n/H0hEEzozQ1YSEIBxBcQAFpt3V7yqDZ9O
 8Vmft2VOukwl5/tH1kjQCYn/f+LdIUA9/iyZdZzQKrF1k+IQhptTDwsoQ/hC6iq8BIgA
 1Enw==
X-Gm-Message-State: AOAM530eQ95CeFYPaw7a8F1DAK6wffskoTZJZ+CRwwy2z6H9rSadi8Li
 UJcrbAW2oCEGeRhGVASzPyg=
X-Google-Smtp-Source: ABdhPJy4t0oQf/ADzsmcEEOjd/bCRxwrxMcaQ4ZDD2+D52Gbr5tPv/h47XDsREiddKHMcr1Fn6Xu5w==
X-Received: by 2002:a17:902:b906:b0:14f:76a0:ad48 with SMTP id
 bf6-20020a170902b90600b0014f76a0ad48mr20445815plb.79.1648358215837; 
 Sat, 26 Mar 2022 22:16:55 -0700 (PDT)
Received: from localhost.localdomain ([115.220.243.108])
 by smtp.googlemail.com with ESMTPSA id
 d11-20020a056a00198b00b004fa7da68465sm11290361pfl.60.2022.03.26.22.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Mar 2022 22:16:55 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: mpe@ellerman.id.au
Subject: [PATCH] kvm: fix incorrect NULL check on list iterator
Date: Sun, 27 Mar 2022 13:16:46 +0800
Message-Id: <20220327051646.1856-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: david@redhat.com, maz@kernel.org, Felix.Kuehling@amd.com,
 apopple@nvidia.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 liam.howlett@oracle.com, bharata@linux.ibm.com, paulus@samba.org,
 stable@vger.kernel.org, Xiaomeng Tong <xiam0nd.tong@gmail.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 maciej.szmigiero@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The bug is here:
	if (!p)
                return ret;

The list iterator value 'p' will *always* be set and non-NULL by
list_for_each_entry(), so it is incorrect to assume that the iterator
value will be NULL if the list is empty or no element is found.

To fix the bug, Use a new value 'iter' as the list iterator, while use
the old value 'p' as a dedicated variable to point to the found element.

Cc: stable@vger.kernel.org
Fixes: dfaa973ae9605 ("KVM: PPC: Book3S HV: In H_SVM_INIT_DONE, migrate remaining normal-GFNs to secure-GFNs")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index e414ca44839f..0cb20ee6a632 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -360,13 +360,15 @@ static bool kvmppc_gfn_is_uvmem_pfn(unsigned long gfn, struct kvm *kvm,
 static bool kvmppc_next_nontransitioned_gfn(const struct kvm_memory_slot *memslot,
 		struct kvm *kvm, unsigned long *gfn)
 {
-	struct kvmppc_uvmem_slot *p;
+	struct kvmppc_uvmem_slot *p = NULL, *iter;
 	bool ret = false;
 	unsigned long i;
 
-	list_for_each_entry(p, &kvm->arch.uvmem_pfns, list)
-		if (*gfn >= p->base_pfn && *gfn < p->base_pfn + p->nr_pfns)
+	list_for_each_entry(iter, &kvm->arch.uvmem_pfns, list)
+		if (*gfn >= iter->base_pfn && *gfn < iter->base_pfn + iter->nr_pfns) {
+			p = iter;
 			break;
+		}
 	if (!p)
 		return ret;
 	/*
-- 
2.17.1

