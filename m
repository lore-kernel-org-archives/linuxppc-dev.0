Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yBhfH3FXczDrFZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 16:01:43 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: [PATCH kernel] KVM: PPC: Enable in-kernel TCE handlers for PR KVM
Date: Wed, 11 Oct 2017 16:01:08 +1100
Message-Id: <20171011050108.37980-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The handlers support PR KVM from the day one; however the PR KVM's
enable/disable hcalls handler missed these ones.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_pr_papr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 8a4205fa774f..dae3be5ff42b 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -419,6 +419,8 @@ int kvmppc_hcall_impl_pr(unsigned long cmd)
 	case H_PROTECT:
 	case H_BULK_REMOVE:
 	case H_PUT_TCE:
+	case H_PUT_TCE_INDIRECT:
+	case H_STUFF_TCE:
 	case H_CEDE:
 	case H_LOGICAL_CI_LOAD:
 	case H_LOGICAL_CI_STORE:
-- 
2.11.0
