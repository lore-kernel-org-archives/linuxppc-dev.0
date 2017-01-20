Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4q0M4sxnzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:26:11 +1100 (AEDT)
Subject: [PATCH 06/11] KVM: PPC: Book3S HV: Use kcalloc() in
 kvmppc_alloc_host_rm_ops()
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <62a8df66-ab16-8f93-8acd-20fb461fd7de@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Jan 2017 16:20:43 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Delete the local variable "size" which became unnecessary
  with this refactoring.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/book3s_hv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3122998f6a32..596201b3f22e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3199,7 +3199,6 @@ void kvmppc_alloc_host_rm_ops(void)
 	struct kvmppc_host_rm_ops *ops;
 	unsigned long l_ops;
 	int cpu, core;
-	int size;
 
 	/* Not the first time here ? */
 	if (kvmppc_host_rm_ops_hv)
@@ -3209,9 +3208,9 @@ void kvmppc_alloc_host_rm_ops(void)
 	if (!ops)
 		return;
 
-	size = cpu_nr_cores() * sizeof(struct kvmppc_host_rm_core);
-	ops->rm_core = kzalloc(size, GFP_KERNEL);
-
+	ops->rm_core = kcalloc(cpu_nr_cores(),
+			       sizeof(*ops->rm_core),
+			       GFP_KERNEL);
 	if (!ops->rm_core) {
 		kfree(ops);
 		return;
-- 
2.11.0
