Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8HF5KLjzDt0Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:53:45 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so6052183pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:53:45 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/6] kvm: export kvm module parameter variables
Date: Fri, 14 Oct 2016 11:53:19 +1100
Message-Id: <1476406404-32752-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kvm module has the parameters halt_poll_ns, halt_poll_ns_grow, and
halt_poll_ns_shrink. Halt polling was recently added to the powerpc kvm-hv
module and these parameters were essentially duplicated for that. There is
no benefit to this duplication and it can lead to confusion when trying to
tune halt polling.

Thus move the definition of these variables to kvm_host.h and export them.
This will allow the kvm-hv module to use the same module parameters by
accessing these variables, which will be implemented in the next patch,
meaning that they will no longer be duplicated.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 include/linux/kvm_host.h | 4 ++++
 virt/kvm/kvm_main.c      | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01c0b9c..29b500a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1107,6 +1107,10 @@ static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
 
 extern bool kvm_rebooting;
 
+extern unsigned int halt_poll_ns;
+extern unsigned int halt_poll_ns_grow;
+extern unsigned int halt_poll_ns_shrink;
+
 struct kvm_device {
 	struct kvm_device_ops *ops;
 	struct kvm *kvm;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 81dfc73..675d7b5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -70,16 +70,19 @@ MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
 /* Architectures should define their poll value according to the halt latency */
-static unsigned int halt_poll_ns = KVM_HALT_POLL_NS_DEFAULT;
+unsigned int halt_poll_ns = KVM_HALT_POLL_NS_DEFAULT;
 module_param(halt_poll_ns, uint, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL_GPL(halt_poll_ns);
 
 /* Default doubles per-vcpu halt_poll_ns. */
-static unsigned int halt_poll_ns_grow = 2;
+unsigned int halt_poll_ns_grow = 2;
 module_param(halt_poll_ns_grow, uint, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL_GPL(halt_poll_ns_grow);
 
 /* Default resets per-vcpu halt_poll_ns . */
-static unsigned int halt_poll_ns_shrink;
+unsigned int halt_poll_ns_shrink;
 module_param(halt_poll_ns_shrink, uint, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
 
 /*
  * Ordering of locks:
-- 
2.5.5
