Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqs6f3nFtzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 20:16:10 +1000 (AEST)
Date: Thu, 14 Jul 2016 13:15:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexander Graf <agraf@suse.com>, Bharat Bhushan <r65777@freescale.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [patch] KVM: PPC: fix a sanity check
Message-ID: <20160714101545.GB18175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use logical negate where bitwise negate was intended.  It means that
we never return -EINVAL here.

Fixes: ce11e48b7fdd ('KVM: PPC: E500: Add userspace debug stub support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 02b4672..df3f270 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -2038,7 +2038,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		if (type == KVMPPC_DEBUG_NONE)
 			continue;
 
-		if (type & !(KVMPPC_DEBUG_WATCH_READ |
+		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
 			     KVMPPC_DEBUG_WATCH_WRITE |
 			     KVMPPC_DEBUG_BREAKPOINT))
 			return -EINVAL;
