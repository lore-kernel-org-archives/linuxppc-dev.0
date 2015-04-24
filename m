Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 881711A0C40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 01:53:30 +1000 (AEST)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <tglx@linutronix.de>, <bigeasy@linutronix.de>, <pbonzini@redhat.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mihai.caraman@freescale.com>, <b10716@freescale.com>
Subject: [PATCH v2 1/2] powerpc/kvm: Convert openpic lock to raw_spinlock
Date: Fri, 24 Apr 2015 15:53:12 +0000
Message-ID: <1429890793-19487-2-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lock in the KVM openpic emulation on PPC is a spinlock_t, meaning it becomes
a sleeping mutex under PREEMPT_RT_FULL. This yields to a situation where this
non-raw lock is grabbed with interrupts already disabled by hard_irq_disable():

kvmppc_prepare_to_enter()
  hard_irq_disable()
  kvmppc_core_prepare_to_enter()
    kvmppc_core_check_exceptions()
      kvmppc_booke_irqprio_deliver()
        kvmppc_mpic_set_epr()
          spin_lock_irqsave()
            ...

This happens for guest interrupts that go through this openpic emulation code.
The result is a kernel crash on guest enter (include/linux/kvm_host.h:784).

Converting the lock to a raw_spinlock fixes the issue and enables the guest to
run I/O intensive workloads in a SMP configuration. A similar fix can be found
for the i8254 PIT emulation on x86 [1].

[1] https://lkml.org/lkml/2010/1/11/289

v2:
- updated commit message

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/kvm/mpic.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 6249cdc..2f70660 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -196,7 +196,7 @@ struct openpic {
 	int num_mmio_regions;
 
 	gpa_t reg_base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	/* Behavior control */
 	struct fsl_mpic_info *fsl;
@@ -1103,9 +1103,9 @@ static int openpic_cpu_write_internal(void *opaque, gpa_t addr,
 			mpic_irq_raise(opp, dst, ILR_INTTGT_INT);
 		}
 
-		spin_unlock(&opp->lock);
+		raw_spin_unlock(&opp->lock);
 		kvm_notify_acked_irq(opp->kvm, 0, notify_eoi);
-		spin_lock(&opp->lock);
+		raw_spin_lock(&opp->lock);
 
 		break;
 	}
@@ -1180,12 +1180,12 @@ void kvmppc_mpic_set_epr(struct kvm_vcpu *vcpu)
 	int cpu = vcpu->arch.irq_cpu_id;
 	unsigned long flags;
 
-	spin_lock_irqsave(&opp->lock, flags);
+	raw_spin_lock_irqsave(&opp->lock, flags);
 
 	if ((opp->gcr & opp->mpic_mode_mask) == GCR_MODE_PROXY)
 		kvmppc_set_epr(vcpu, openpic_iack(opp, &opp->dst[cpu], cpu));
 
-	spin_unlock_irqrestore(&opp->lock, flags);
+	raw_spin_unlock_irqrestore(&opp->lock, flags);
 }
 
 static int openpic_cpu_read_internal(void *opaque, gpa_t addr,
@@ -1386,9 +1386,9 @@ static int kvm_mpic_read(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 	}
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 	ret = kvm_mpic_read_internal(opp, addr - opp->reg_base, &u.val);
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 
 	/*
 	 * Technically only 32-bit accesses are allowed, but be nice to
@@ -1427,10 +1427,10 @@ static int kvm_mpic_write(struct kvm_vcpu *vcpu,
 		return -EOPNOTSUPP;
 	}
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 	ret = kvm_mpic_write_internal(opp, addr - opp->reg_base,
 				      *(const u32 *)ptr);
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 
 	pr_debug("%s: addr %llx ret %d val %x\n",
 		 __func__, addr, ret, *(const u32 *)ptr);
@@ -1501,14 +1501,14 @@ static int access_reg(struct openpic *opp, gpa_t addr, u32 *val, int type)
 	if (addr & 3)
 		return -ENXIO;
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 
 	if (type == ATTR_SET)
 		ret = kvm_mpic_write_internal(opp, addr, *val);
 	else
 		ret = kvm_mpic_read_internal(opp, addr, val);
 
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 
 	pr_debug("%s: type %d addr %llx val %x\n", __func__, type, addr, *val);
 
@@ -1545,9 +1545,9 @@ static int mpic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		if (attr32 != 0 && attr32 != 1)
 			return -EINVAL;
 
-		spin_lock_irq(&opp->lock);
+		raw_spin_lock_irq(&opp->lock);
 		openpic_set_irq(opp, attr->attr, attr32);
-		spin_unlock_irq(&opp->lock);
+		raw_spin_unlock_irq(&opp->lock);
 		return 0;
 	}
 
@@ -1592,9 +1592,9 @@ static int mpic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		if (attr->attr > MAX_SRC)
 			return -EINVAL;
 
-		spin_lock_irq(&opp->lock);
+		raw_spin_lock_irq(&opp->lock);
 		attr32 = opp->src[attr->attr].pending;
-		spin_unlock_irq(&opp->lock);
+		raw_spin_unlock_irq(&opp->lock);
 
 		if (put_user(attr32, (u32 __user *)(long)attr->addr))
 			return -EFAULT;
@@ -1670,7 +1670,7 @@ static int mpic_create(struct kvm_device *dev, u32 type)
 	opp->kvm = dev->kvm;
 	opp->dev = dev;
 	opp->model = type;
-	spin_lock_init(&opp->lock);
+	raw_spin_lock_init(&opp->lock);
 
 	add_mmio_region(opp, &openpic_gbl_mmio);
 	add_mmio_region(opp, &openpic_tmr_mmio);
@@ -1743,7 +1743,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
 	if (cpu < 0 || cpu >= MAX_CPU)
 		return -EPERM;
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 
 	if (opp->dst[cpu].vcpu) {
 		ret = -EEXIST;
@@ -1766,7 +1766,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
 		vcpu->arch.epr_flags |= KVMPPC_EPR_KERNEL;
 
 out:
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 	return ret;
 }
 
@@ -1796,9 +1796,9 @@ static int mpic_set_irq(struct kvm_kernel_irq_routing_entry *e,
 	struct openpic *opp = kvm->arch.mpic;
 	unsigned long flags;
 
-	spin_lock_irqsave(&opp->lock, flags);
+	raw_spin_lock_irqsave(&opp->lock, flags);
 	openpic_set_irq(opp, irq, level);
-	spin_unlock_irqrestore(&opp->lock, flags);
+	raw_spin_unlock_irqrestore(&opp->lock, flags);
 
 	/* All code paths we care about don't check for the return value */
 	return 0;
@@ -1810,14 +1810,14 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	struct openpic *opp = kvm->arch.mpic;
 	unsigned long flags;
 
-	spin_lock_irqsave(&opp->lock, flags);
+	raw_spin_lock_irqsave(&opp->lock, flags);
 
 	/*
 	 * XXX We ignore the target address for now, as we only support
 	 *     a single MSI bank.
 	 */
 	openpic_msi_write(kvm->arch.mpic, MSIIR_OFFSET, e->msi.data);
-	spin_unlock_irqrestore(&opp->lock, flags);
+	raw_spin_unlock_irqrestore(&opp->lock, flags);
 
 	/* All code paths we care about don't check for the return value */
 	return 0;
-- 
2.1.4
