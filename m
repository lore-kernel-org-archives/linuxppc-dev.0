Return-Path: <prvs=42551c893=jschoenh@amazon.com>
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvk3X5hcDzDrnf
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 06:13:11 +1000 (AEST)
From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sachinp@linux.vnet.ibm.com, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 kvm@vger.kernel.org
Subject: [PATCH] Revert "KVM: Don't accept obviously wrong gsi values via
 KVM_IRQFD"
Date: Sat, 16 Sep 2017 22:12:24 +0200
Message-Id: <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
In-Reply-To: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
References: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 36ae3c0a36b7456432fedce38ae2f7bd3e01a563.

The commit broke compilation on !CONFIG_HAVE_KVM_IRQ_ROUTING. Also,
there may be cases with CONFIG_HAVE_KVM_IRQ_ROUTING, where larger
gsi values make sense.

As the commit was meant as an early indicator to user space that
something is wrong, reverting just restores the previous behavior
where overly large values are ignored when encountered (without
any direct feedback).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 virt/kvm/eventfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index c608ab4..f2ac53a 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -565,8 +565,6 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
 {
 	if (args->flags & ~(KVM_IRQFD_FLAG_DEASSIGN | KVM_IRQFD_FLAG_RESAMPLE))
 		return -EINVAL;
-	if (args->gsi >= KVM_MAX_IRQ_ROUTES)
-		return -EINVAL;
 
 	if (args->flags & KVM_IRQFD_FLAG_DEASSIGN)
 		return kvm_irqfd_deassign(kvm, args);
-- 
2.3.1.dirty
