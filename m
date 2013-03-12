Return-Path: <zhangyanfei@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 0FA062C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 15:55:45 +1100 (EST)
Message-ID: <513EB4EE.1040300@cn.fujitsu.com>
Date: Tue, 12 Mar 2013 12:54:06 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/18] powerpc: remove cast for kmalloc/kzalloc return value
References: <513EB23D.7020303@cn.fujitsu.com>
In-Reply-To: <513EB23D.7020303@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

remove cast for kmalloc/kzalloc return value.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/nvram_64.c |    3 +--
 arch/powerpc/kvm/book3s_pr.c   |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index bec1e93..48fbc2b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -511,8 +511,7 @@ int __init nvram_scan_partitions(void)
 			       "detected: 0-length partition\n");
 			goto out;
 		}
-		tmp_part = (struct nvram_partition *)
-			kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
+		tmp_part = kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
 		err = -ENOMEM;
 		if (!tmp_part) {
 			printk(KERN_ERR "nvram_scan_partitions: kmalloc failed\n");
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 5e93438..dbdc15a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1039,7 +1039,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (!vcpu_book3s)
 		goto out;
 
-	vcpu_book3s->shadow_vcpu = (struct kvmppc_book3s_shadow_vcpu *)
+	vcpu_book3s->shadow_vcpu =
 		kzalloc(sizeof(*vcpu_book3s->shadow_vcpu), GFP_KERNEL);
 	if (!vcpu_book3s->shadow_vcpu)
 		goto free_vcpu;
-- 
1.7.1
