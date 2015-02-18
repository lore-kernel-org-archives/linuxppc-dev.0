Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C9E51A0146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 20:33:06 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
 <bigeasy@linutronix.de>, <agraf@suse.de>, <pbonzini@redhat.com>
Subject: [PATCH 1/2] powerpc/kvm: Convert openpic lock to raw_spinlock
Date: Wed, 18 Feb 2015 09:32:34 +0000
Message-ID: <1424251955-308-2-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, mihai.caraman@freescale.com,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables running intensive I/O workloads, e.g. netperf, in a guest
deployed on a RT host. It also enable guests to be SMP.

The openpic spinlock becomes a sleeping mutex on a RT system. This no longer
guarantees that EPR is atomic with exception delivery. The guest VCPU thread
fails due to a BUG_ON(preemptible()) when running netperf.

In order to make the kvmppc_mpic_set_epr() call safe on RT from non-atomic
context, convert the openpic lock to a raw_spinlock. A similar approach can
be seen for x86 platforms in the following commit [1].

Here are some comparative cyclitest measurements run inside a high priority RT
guest run on a RT host. The guest has 1 VCPU and the test has been run for 15
minutes. The guest runs ~750 hackbench processes as background stress.

                  spinlock  raw_spinlock
Min latency (us)  4         4
Avg latency (us)  15        19
Max latency (us)  70        62

[1] https://lkml.org/lkml/2010/1/11/289

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Reviewed-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kvm/mpic.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 39b3a8f..9fad0aa 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -196,7 +196,7 @@ struct openpic {
 	int num_mmio_regions;
 
 	gpa_t reg_base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	/* Behavior control */
 	struct fsl_mpic_info *fsl;
@@ -1108,9 +1108,9 @@ static int openpic_cpu_write_internal(void *opaque, gpa_t addr,
 			mpic_irq_raise(opp, dst, ILR_INTTGT_INT);
 		}
 
-		spin_unlock(&opp->lock);
+		raw_spin_unlock(&opp->lock);
 		kvm_notify_acked_irq(opp->kvm, 0, notify_eoi);
-		spin_lock(&opp->lock);
+		raw_spin_lock(&opp->lock);
 
 		break;
 	}
@@ -1185,12 +1185,12 @@ void kvmppc_mpic_set_epr(struct kvm_vcpu *vcpu)
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
@@ -1390,9 +1390,9 @@ static int kvm_mpic_read(struct kvm_io_device *this, gpa_t addr,
 		return -EINVAL;
 	}
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 	ret = kvm_mpic_read_internal(opp, addr - opp->reg_base, &u.val);
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 
 	/*
 	 * Technically only 32-bit accesses are allowed, but be nice to
@@ -1430,10 +1430,10 @@ static int kvm_mpic_write(struct kvm_io_device *this, gpa_t addr,
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
@@ -1504,14 +1504,14 @@ static int access_reg(struct openpic *opp, gpa_t addr, u32 *val, int type)
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
 
@@ -1548,9 +1548,9 @@ static int mpic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		if (attr32 != 0 && attr32 != 1)
 			return -EINVAL;
 
-		spin_lock_irq(&opp->lock);
+		raw_spin_lock_irq(&opp->lock);
 		openpic_set_irq(opp, attr->attr, attr32);
-		spin_unlock_irq(&opp->lock);
+		raw_spin_unlock_irq(&opp->lock);
 		return 0;
 	}
 
@@ -1595,9 +1595,9 @@ static int mpic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		if (attr->attr > MAX_SRC)
 			return -EINVAL;
 
-		spin_lock_irq(&opp->lock);
+		raw_spin_lock_irq(&opp->lock);
 		attr32 = opp->src[attr->attr].pending;
-		spin_unlock_irq(&opp->lock);
+		raw_spin_unlock_irq(&opp->lock);
 
 		if (put_user(attr32, (u32 __user *)(long)attr->addr))
 			return -EFAULT;
@@ -1673,7 +1673,7 @@ static int mpic_create(struct kvm_device *dev, u32 type)
 	opp->kvm = dev->kvm;
 	opp->dev = dev;
 	opp->model = type;
-	spin_lock_init(&opp->lock);
+	raw_spin_lock_init(&opp->lock);
 
 	add_mmio_region(opp, &openpic_gbl_mmio);
 	add_mmio_region(opp, &openpic_tmr_mmio);
@@ -1746,7 +1746,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
 	if (cpu < 0 || cpu >= MAX_CPU)
 		return -EPERM;
 
-	spin_lock_irq(&opp->lock);
+	raw_spin_lock_irq(&opp->lock);
 
 	if (opp->dst[cpu].vcpu) {
 		ret = -EEXIST;
@@ -1769,7 +1769,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
 		vcpu->arch.epr_flags |= KVMPPC_EPR_KERNEL;
 
 out:
-	spin_unlock_irq(&opp->lock);
+	raw_spin_unlock_irq(&opp->lock);
 	return ret;
 }
 
@@ -1799,9 +1799,9 @@ static int mpic_set_irq(struct kvm_kernel_irq_routing_entry *e,
 	struct openpic *opp = kvm->arch.mpic;
 	unsigned long flags;
 
-	spin_lock_irqsave(&opp->lock, flags);
+	raw_spin_lock_irqsave(&opp->lock, flags);
 	openpic_set_irq(opp, irq, level);
-	spin_unlock_irqrestore(&opp->lock, flags);
+	raw_spin_unlock_irqrestore(&opp->lock, flags);
 
 	/* All code paths we care about don't check for the return value */
 	return 0;
@@ -1813,14 +1813,14 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
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
