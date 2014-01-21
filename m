Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E26EB2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 08:24:24 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/73] powerpc: kvm e500/44x is not modular,
 so don't use module_init
Date: Tue, 21 Jan 2014 16:22:15 -0500
Message-ID: <1390339396-3479-13-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc, CONFIG_KVM is bool, and  so are these three subarch
options, for the 44x and e500 variants.  This means that any
module_exit() calls and functions used by them such as the
kvmppc_booke_exit() are dead code.  Here we remove them.

In addition, rather than use module_init, which is just
__initcall for non-modules, we update those as well.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of subsys_initcall (which
seems to make sense for netfilter code) will thus change this
registration from level 6-device to level 4-subsys (i.e. slightly
earlier).

However no impact of that small difference is expected,
since the arch independent kvm code doesn't trigger any init;
it is the arch initcalls here which actually call kvm_init.

Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  1 -
 arch/powerpc/kvm/44x.c             | 10 +---------
 arch/powerpc/kvm/booke.c           |  6 ------
 arch/powerpc/kvm/e500.c            | 10 +---------
 arch/powerpc/kvm/e500mc.c          | 10 +---------
 5 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c8317fb..8466df5 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -109,7 +109,6 @@ extern void kvmppc_core_flush_tlb(struct kvm_vcpu *vcpu);
 extern int kvmppc_core_check_requests(struct kvm_vcpu *vcpu);
 
 extern int kvmppc_booke_init(void);
-extern void kvmppc_booke_exit(void);
 
 extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
 extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 93221e8..2129fc1 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -222,12 +222,4 @@ static int __init kvmppc_44x_init(void)
 err_out:
 	return r;
 }
-
-static void __exit kvmppc_44x_exit(void)
-{
-	kvmppc_pr_ops = NULL;
-	kvmppc_booke_exit();
-}
-
-module_init(kvmppc_44x_init);
-module_exit(kvmppc_44x_exit);
+subsys_initcall(kvmppc_44x_init);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0591e05..49dffa2 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1995,9 +1995,3 @@ int __init kvmppc_booke_init(void)
 #endif /* !BOOKE_HV */
 	return 0;
 }
-
-void __exit kvmppc_booke_exit(void)
-{
-	free_pages(kvmppc_booke_handlers, VCPU_SIZE_ORDER);
-	kvm_exit();
-}
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 497b142..115ef12 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -564,12 +564,4 @@ static int __init kvmppc_e500_init(void)
 err_out:
 	return r;
 }
-
-static void __exit kvmppc_e500_exit(void)
-{
-	kvmppc_pr_ops = NULL;
-	kvmppc_booke_exit();
-}
-
-module_init(kvmppc_e500_init);
-module_exit(kvmppc_e500_exit);
+subsys_initcall(kvmppc_e500_init);
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 4132cd2..612c216 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -382,12 +382,4 @@ static int __init kvmppc_e500mc_init(void)
 err_out:
 	return r;
 }
-
-static void __exit kvmppc_e500mc_exit(void)
-{
-	kvmppc_pr_ops = NULL;
-	kvmppc_booke_exit();
-}
-
-module_init(kvmppc_e500mc_init);
-module_exit(kvmppc_e500mc_exit);
+subsys_initcall(kvmppc_e500mc_init);
-- 
1.8.4.1
