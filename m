Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41N2S66pnPzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 16:56:06 +1000 (AEST)
From: Nicholas Mc Guire <hofrat@osadl.org>
To: "Author: Paul Mackerras" <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] KVM: PPC: Book3S HV: add of_node_put() in success path
Date: Sat,  7 Jul 2018 08:53:07 +0200
Message-Id: <1530946387-6607-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 The call to of_find_compatible_node() is returning a pointer with
incremented refcount so it must be explicitly decremented after the
last use. As here it is only being used for checking of node presence
but the result is not actually used in the success path it can be
dropped immediately.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9")
---
Problem found by experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies CONFIG_KVM=y,
CONFIG_KVM_BOOK3S_64_HV=m)
with many sparse warnings though not related to the proposed change

Patch is against 4.18-rc3 (localversion-next is next-20180705)

 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ee4a885..8680fb9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4561,6 +4561,8 @@ static int kvmppc_book3s_init_hv(void)
 			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
 			return -ENODEV;
 		}
+		/* presence of intc confirmed - node can be dropped again */
+		of_node_put(np);
 	}
 #endif
 
-- 
2.1.4
