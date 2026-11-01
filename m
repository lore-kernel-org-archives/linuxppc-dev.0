Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D18606A326
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VczBXSB+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd3C0Czwz3bbf;
	Mon, 02 Nov 2026 01:47:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544438;
	cv=none; b=Q/+rG9yNMERKt3sX3nzrxwhKnenwmjI7Nd3NPrAlQqxbwcjpcbGBt67WS9uxmw2zqQmiCOQQG1DkXG4IVZJpV2hDRDhfNKRtTVjLK9nGkoBxcI5VV7YLlv/vtqhpeawsEr/jz4TafSs5PVMuFIlLCR1d+Lvqohk8VOGKUJnJUEmJePPF8ux8pQAK4pPqE1no5y4xnMROFnQxbVZDodERdqGP1tsrGhqDUHcxodQgepqb8VNosLujtJxxpmAnTTNaR52aS/okRUklyhoVIFLZH+QyWDT7mBWrvN4DCNbVsWhcVJ+XngmakwqJX/HWf2Xpc8VwxfZAoZTEZ32ihF8TEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544438; c=relaxed/relaxed;
	bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoZybDWB5PR9Gd2tAaX7u3J+RJQJ5KGhCQYTAgIsO73MYhddLlPq0aXQYVhUCEcXlXxeoshHRwKr/ciSFpX0zrk3ERcjjWtPt9HwPIxnsZgASbiX+qyV01p6jVdusBLAKwYn0z6Oj5pVSpNpk5PN8r/jloRKNq/RIst3EpnR106/IVr9aa75foKHfRKyY5PrFfqjJnaZAtM4OdYFlB7RuAsh0EhVp68Kh61m4lUgmgJoOgi9JxPYGjtHFR6kFMi9biTWBHCCLIp1I9f17ixNvEnBYKthigk8EO+XdQbkdo1bOkwzuo9r75PWMrGCH0XFjgnNZ/DXDXjbrQptsdrELA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VczBXSB+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VczBXSB+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd3B2HJ4z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:18 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-35c76e9614aso3134411eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544436; x=1794149236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
        b=VczBXSB+ExArK4OhPAHoVL8CktTTPr5I0r3Ho+Nv1oWI/hBqgZAEvDXK9akCJgyLHu
         uyYN2ZBu7eBIJEuu6ajIznKTEcbMEC+9J23XgKDZ+1UMTCtKQ3jERlbVkcliuHOSVVlp
         pHh188A2udzwU4R0boK0uj/ajZJ9Ry4TQTj6DQfjBfhMhlUsTyUQKt0Lfy1kwRija+Gv
         e78OI5elZKxAxQurcnTtAb6zi202rvjd3LkvDzUB6pCmO40ZLXrs3AqT46SjCKBQf9Zz
         oXjva9rUG6mp9At4uzS+kocrZOo/w4+Yx4VK2nF3S8DdjaE0K5PDVzgjj+ZksqL8f4M1
         x3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544436; x=1794149236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
        b=uRNd3z2QA3qNEuNrlHCwid1RGt2gQha7FJtsJ1KdZ91QqquQSLEx67l83ohCOmz1xJ
         ilUCRRjK2L0A75p7RKyOjxRZZTz+wH5hvM45r5kEc/FL72dEzZKnCExFeOn/BlpmchhS
         AwfQItjW796S2G+r6woVB1s7cDA4xH2LW7AoPqAh7fAgR9K2fcgrTK0xPxkibnyajm00
         NIMOsUEzQ/NQVAJ/3uPxR0EWn2lhn52NVNbQFnhqPzJgLRh4Q+tqj89yYMR4zSAZWFSr
         IAnA1smcn9nGQRdx23gdaRhYdtcP79eJWf1stXS2ok37dgnB/nHC+b8issHaaNRpJACQ
         ATpQ==
X-Gm-Message-State: AFq9FYJWeMqKWY0JLwrj5PacQ6uBQl0NgpG2/FWtDWMIotSKaPHHTIQn
	NmMWgVrFWacmASfe8f8373lQ+kFMFEwTf14K91lzgXQKFqAQ4uXoK81okD3MuQ==
X-Gm-Gg: AYBFou2pSBX2wnj0rksbWPCNP/ahzyq6bIrrA1mSyY6/QWe88PN7W9Xx6AJAjuXN9zI
	l0WbPh4nOd6uFO/zpEJWFYB8cCgkOkKW94G5Ma1xHyebFTqD9IiAv6FvC4LBZ+h8ml4TB62LL4K
	2i/uY0WLfMfCOcu09gptGnf7z+dNav7hB1sm4LokFM9/n0sH57CLuVgv+6Rx56oh7MvtJmZWeX3
	sqwWqjYSheZdkTTClpl7YSKAByY6BsWJU/nY1ev9avg1kc/2Gn5rXuM3ub1IOfTaIQGcMnaPRqc
	EwrNhiEEOLDz6d6KXMHgU2scyudWVCi2oblQXC5ZBzAIGPXDAYt/2v7a3WqiljbbJhwE1Mut4TU
	DkEkScJbz/K21ZcXXNn/A4hh5oZTdnVKwKH2zflQ0jx+T0cnU9kYST36cg6FAHx1D9les3wOlA+
	90yDIQdg/8/O4t+2h38dvJeJxfTAKHLku+VrYu6MA9yBC7t9RSIfZOe3pSGh96XcnGqvmtePxn7
	sPSedQrH0Zmb1cQBlDu6l3wmLwPGqC+jVeVX+5tym2y4qz5NGg5SpJ8IH0WjTXBsXaTpG2pZU+W
	EKNIVAwsT1JHOaku58Q/VbGbH86lH195GQ==
X-Received: by 2002:a05:693c:639a:20b0:359:1b05:ed30 with SMTP id 5a478bee46e88-36a42203bc1mr11532986eec.4.1793544436256;
        Sun, 01 Nov 2026 06:47:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:15 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 6/7] KVM: PPC: Book3S HV: Fix error handling during vcore create
Date: Sun,  1 Nov 2026 20:16:31 +0530
Message-Id: <ca419693358e3af49b1dfa7887b34b8ef91a5daf.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kvmppc_vcore_create() can fail and return NULL, this patch fixes the
error handling when this happens.

vcore and online_vcores count should only be updated when vcore was
actually created, otherwise it's state gets messed up for the VM run.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..7975e5de89d0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3090,10 +3090,12 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			err = -ENOMEM;
 			vcore = kvmppc_vcore_create(kvm,
 					id & ~(kvm->arch.smt_mode - 1));
-			mutex_lock(&kvm->arch.mmu_setup_lock);
-			kvm->arch.vcores[core] = vcore;
-			kvm->arch.online_vcores++;
-			mutex_unlock(&kvm->arch.mmu_setup_lock);
+			if (!vcore) {
+				mutex_lock(&kvm->arch.mmu_setup_lock);
+				kvm->arch.vcores[core] = vcore;
+				kvm->arch.online_vcores++;
+				mutex_unlock(&kvm->arch.mmu_setup_lock);
+			}
 		}
 	}
 
-- 
2.39.5


