Return-Path: <bharata.rao@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4B4A1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 16:31:18 +1100 (AEDT)
Received: by padet14 with SMTP id et14so73348418pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 22:31:16 -0700 (PDT)
From: bharata.rao@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [RFC v0 PATCH] kvm: powerpc: Allow reuse of vCPU object
Date: Mon,  9 Mar 2015 11:00:55 +0530
Message-Id: <1425879055-20628-1-git-send-email-bharata.rao@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bharata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Since KVM isn't equipped to handle closure of vcpu fd from userspace(QEMU)
correctly, certain work arounds have to be employed to allow reuse of
vcpu array slot in KVM during cpu hot plug/unplug from guest. One such
proposed workaround is to park the vcpu fd in userspace during cpu unplug
and reuse it later during next hotplug.

More details can be found here:
KVM: https://www.mail-archive.com/kvm@vger.kernel.org/msg102839.html
QEMU: http://lists.gnu.org/archive/html/qemu-devel/2014-12/msg00859.html

In order to support this workaround with PowerPC KVM, don't create or
initialize ICP if the vCPU is found to be already associated with an ICP.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
Note: It is not sure at the moment if "park vcpu and reuse" approach will
be acceptable to KVM/QEMU community, but nevertheless I wanted to check
if this little patch is harmful or not.

 arch/powerpc/kvm/book3s_xics.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index a4a8d9f..ead3a35 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1313,8 +1313,13 @@ int kvmppc_xics_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
 		return -EPERM;
 	if (xics->kvm != vcpu->kvm)
 		return -EPERM;
-	if (vcpu->arch.irq_type)
-		return -EBUSY;
+
+	/*
+	 * If irq_type is already set, don't reinialize but
+	 * return success allowing this vcpu to be reused.
+	 */
+	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
+		return 0;
 
 	r = kvmppc_xics_create_icp(vcpu, xcpu);
 	if (!r)
-- 
2.1.0
