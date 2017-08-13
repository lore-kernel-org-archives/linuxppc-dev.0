Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLr70sMhzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:15 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p13so6784947pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 1/9] KVM: PPC: Book3S HV: Fix H_REGISTER_VPA VPA size
 validation
Date: Sun, 13 Aug 2017 11:33:38 +1000
Message-Id: <20170813013346.14002-1-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM currently validates the size of the VPA registered by the client
against sizeof(struct lppaca), however we align (and therefore size)
that struct to 1kB to avoid crossing a 4kB boundary in the client.

PAPR calls for sizes >= 640 bytes to be accepted. Hard code this with
a comment.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 359c79cdf0cc..1182cfd79857 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -485,7 +485,13 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 
 	switch (subfunc) {
 	case H_VPA_REG_VPA:		/* register VPA */
-		if (len < sizeof(struct lppaca))
+		/*
+		 * The size of our lppaca is 1kB because of the way we align
+		 * it for the guest to avoid crossing a 4kB boundary. We only
+		 * use 640 bytes of the structure though, so we should accept
+		 * clients that set a size of 640.
+		 */
+		if (len < 640)
 			break;
 		vpap = &tvcpu->arch.vpa;
 		err = 0;
-- 
2.13.3
