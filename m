Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D0D54DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 11:46:31 +1000 (EST)
Date: Tue, 2 Jun 2009 11:46:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kvm: fix some init/exit annotations
Message-Id: <20090602114614.50f8f0dd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Liu Yu <yu.liu@freescale.com>, kvm@vger.kernel.org,
	Hollis Blanchard <hollisb@us.ibm.com>, kvm-ppc@vger.kernel.org,
	Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes a couple of warnings like this one:

WARNING: arch/powerpc/kvm/kvm-440.o(.text+0x1e8c): Section mismatch in reference from the function kvmppc_44x_exit() to the function .exit.text:kvmppc_booke_exit()
The function kvmppc_44x_exit() references a function in an exit section.
Often the function kvmppc_booke_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of kvmppc_booke_exit.

Also add some __init annotations on obvious routines.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kvm/44x.c   |    4 ++--
 arch/powerpc/kvm/booke.c |    2 +-
 arch/powerpc/kvm/e500.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 0cef809..f4d1b55 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -138,7 +138,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 }
 
-static int kvmppc_44x_init(void)
+static int __init kvmppc_44x_init(void)
 {
 	int r;
 
@@ -149,7 +149,7 @@ static int kvmppc_44x_init(void)
 	return kvm_init(NULL, sizeof(struct kvmppc_vcpu_44x), THIS_MODULE);
 }
 
-static void kvmppc_44x_exit(void)
+static void __exit kvmppc_44x_exit(void)
 {
 	kvmppc_booke_exit();
 }
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 642e420..e7bf4d0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -520,7 +520,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	return kvmppc_core_vcpu_translate(vcpu, tr);
 }
 
-int kvmppc_booke_init(void)
+int __init kvmppc_booke_init(void)
 {
 	unsigned long ivor[16];
 	unsigned long max_ivor = 0;
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index d8067fd..674e796 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -132,7 +132,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
 }
 
-static int kvmppc_e500_init(void)
+static int __init kvmppc_e500_init(void)
 {
 	int r, i;
 	unsigned long ivor[3];
@@ -160,7 +160,7 @@ static int kvmppc_e500_init(void)
 	return kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), THIS_MODULE);
 }
 
-static void kvmppc_e500_exit(void)
+static void __init kvmppc_e500_exit(void)
 {
 	kvmppc_booke_exit();
 }
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
