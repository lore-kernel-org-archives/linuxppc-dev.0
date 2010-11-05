Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 03/49] arch/powerpc: Use vzalloc
Date: Thu,  4 Nov 2010 20:07:27 -0700
Message-Id: <5da00d7f95b5c7a96fbfa8420f5e3a8ef33e01e6.1288925424.git.joe@perches.com>
In-Reply-To: <alpine.DEB.2.00.1011031108260.11625@router.home>
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
In-Reply-To: <cover.1288925424.git.joe@perches.com>
References: <cover.1288925424.git.joe@perches.com>
Cc: cbe-oss-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
	Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kvm/book3s.c                       |    6 ++----
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index e316847..4275463 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1307,13 +1307,11 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err = -ENOMEM;
 	unsigned long p;
 
-	vcpu_book3s = vmalloc(sizeof(struct kvmppc_vcpu_book3s));
+	vcpu_book3s = vzalloc(sizeof(struct kvmppc_vcpu_book3s));
 	if (!vcpu_book3s)
 		goto out;
 
-	memset(vcpu_book3s, 0, sizeof(struct kvmppc_vcpu_book3s));
-
-	vcpu_book3s->shadow_vcpu = (struct kvmppc_book3s_shadow_vcpu *)
+	vcpu_book3s->shadow_vcpu =
 		kzalloc(sizeof(*vcpu_book3s->shadow_vcpu), GFP_KERNEL);
 	if (!vcpu_book3s->shadow_vcpu)
 		goto free_vcpu;
diff --git a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
index a101abf..3b894f5 100644
--- a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
+++ b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
@@ -36,10 +36,9 @@ static int spu_alloc_lscsa_std(struct spu_state *csa)
 	struct spu_lscsa *lscsa;
 	unsigned char *p;
 
-	lscsa = vmalloc(sizeof(struct spu_lscsa));
+	lscsa = vzalloc(sizeof(struct spu_lscsa));
 	if (!lscsa)
 		return -ENOMEM;
-	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
 
 	/* Set LS pages reserved to allow for user-space mapping. */
-- 
1.7.3.1.g432b3.dirty
