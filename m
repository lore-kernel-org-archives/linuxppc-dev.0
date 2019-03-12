Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AF7C10F00
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B599C20883
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B599C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JXjK3dV2zDqCT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:26:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.39.61; helo=2.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo178.mail-out.ovh.net (2.mo178.mail-out.ovh.net
 [46.105.39.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JXg56p4czDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 22:24:14 +1100 (AEDT)
Received: from player168.ha.ovh.net (unknown [10.109.159.69])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id CAD7B57F8E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:14:50 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 441AC37D8EB4;
 Tue, 12 Mar 2019 11:14:42 +0000 (UTC)
Subject: Re: [PATCH v2 02/16] KVM: PPC: Book3S HV: add a new KVM device for
 the XIVE native exploitation mode
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-3-clg@kaod.org> <20190225000848.GF7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c74f2fd3-97ec-6dc9-5490-4e828684a7ef@kaod.org>
Date: Tue, 12 Mar 2019 12:14:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225000848.GF7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10712374666258451335
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeekgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/25/19 1:08 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:26PM +0100, Cédric Le Goater wrote:
>> This is the basic framework for the new KVM device supporting the XIVE
>> native exploitation mode. The user interface exposes a new KVM device
>> to be created by QEMU when running on a L0 hypervisor only. Support
>> for nested guests is not available yet.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h        |   1 +
>>  arch/powerpc/include/asm/kvm_ppc.h         |   8 +
>>  arch/powerpc/include/uapi/asm/kvm.h        |   3 +
>>  include/uapi/linux/kvm.h                   |   2 +
>>  arch/powerpc/kvm/book3s.c                  |   7 +-
>>  arch/powerpc/kvm/book3s_xive_native.c      | 191 +++++++++++++++++++++
>>  Documentation/virtual/kvm/devices/xive.txt |  19 ++
>>  arch/powerpc/kvm/Makefile                  |   2 +-
>>  8 files changed, 231 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
>>  create mode 100644 Documentation/virtual/kvm/devices/xive.txt
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 091430339db1..9f75a75a07f2 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -220,6 +220,7 @@ extern struct kvm_device_ops kvm_xics_ops;
>>  struct kvmppc_xive;
>>  struct kvmppc_xive_vcpu;
>>  extern struct kvm_device_ops kvm_xive_ops;
>> +extern struct kvm_device_ops kvm_xive_native_ops;
>>  
>>  struct kvmppc_passthru_irqmap;
>>  
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index b3bf4f61b30c..4b72ddde7dc1 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -593,6 +593,10 @@ extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
>>  extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
>>  			       int level, bool line_status);
>>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
>> +
>> +extern void kvmppc_xive_native_init_module(void);
>> +extern void kvmppc_xive_native_exit_module(void);
>> +
>>  #else
>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>>  				       u32 priority) { return -1; }
>> @@ -616,6 +620,10 @@ static inline int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval) { retur
>>  static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
>>  				      int level, bool line_status) { return -ENODEV; }
>>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
>> +
>> +static inline void kvmppc_xive_native_init_module(void) { }
>> +static inline void kvmppc_xive_native_exit_module(void) { }
>> +
>>  #endif /* CONFIG_KVM_XIVE */
>>  
>>  #ifdef CONFIG_PPC_POWERNV
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 8c876c166ef2..b002c0c67787 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -675,4 +675,7 @@ struct kvm_ppc_cpu_char {
>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>>  
>> +/* POWER9 XIVE Native Interrupt Controller */
>> +#define KVM_DEV_XIVE_GRP_CTRL		1
>> +
>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 6d4ea4b6c922..e6368163d3a0 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1211,6 +1211,8 @@ enum kvm_device_type {
>>  #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
>>  	KVM_DEV_TYPE_ARM_VGIC_ITS,
>>  #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
>> +	KVM_DEV_TYPE_XIVE,
>> +#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>>  	KVM_DEV_TYPE_MAX,
>>  };
>>  
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index 601c094f15ab..96d43f091255 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -1040,6 +1040,9 @@ static int kvmppc_book3s_init(void)
>>  	if (xics_on_xive()) {
>>  		kvmppc_xive_init_module();
>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
>> +		kvmppc_xive_native_init_module();
>> +		kvm_register_device_ops(&kvm_xive_native_ops,
>> +					KVM_DEV_TYPE_XIVE);
>>  	} else
>>  #endif
>>  		kvm_register_device_ops(&kvm_xics_ops, KVM_DEV_TYPE_XICS);
>> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>>  static void kvmppc_book3s_exit(void)
>>  {
>>  #ifdef CONFIG_KVM_XICS
>> -	if (xics_on_xive())
>> +	if (xics_on_xive()) {
>>  		kvmppc_xive_exit_module();
>> +		kvmppc_xive_native_exit_module();
>> +	}
>>  #endif
>>  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
>>  	kvmppc_book3s_exit_pr();
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> new file mode 100644
>> index 000000000000..e475ce83ad14
>> --- /dev/null
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2017-2019, IBM Corporation.
>> + */
>> +
>> +#define pr_fmt(fmt) "xive-kvm: " fmt
>> +
>> +#include <linux/anon_inodes.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/err.h>
>> +#include <linux/gfp.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/delay.h>
>> +#include <linux/percpu.h>
>> +#include <linux/cpumask.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/kvm_book3s.h>
>> +#include <asm/kvm_ppc.h>
>> +#include <asm/hvcall.h>
>> +#include <asm/xics.h>
>> +#include <asm/xive.h>
>> +#include <asm/xive-regs.h>
>> +#include <asm/debug.h>
>> +#include <asm/debugfs.h>
>> +#include <asm/time.h>
>> +#include <asm/opal.h>
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include "book3s_xive.h"
>> +
>> +static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	switch (attr->group) {
>> +	case KVM_DEV_XIVE_GRP_CTRL:
>> +		break;
>> +	}
>> +	return -ENXIO;
>> +}
>> +
>> +static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	switch (attr->group) {
>> +	case KVM_DEV_XIVE_GRP_CTRL:
>> +		break;
>> +	}
>> +	return -ENXIO;
>> +}
>> +
>> +static void kvmppc_xive_native_free(struct kvm_device *dev)
>> +{
>> +	struct kvmppc_xive *xive = dev->private;
>> +	struct kvm *kvm = xive->kvm;
>> +
>> +	debugfs_remove(xive->dentry);
>> +
>> +	pr_devel("Destroying xive native device\n");
>> +
>> +	if (kvm)
>> +		kvm->arch.xive = NULL;
>> +
>> +	if (xive->vp_base != XIVE_INVALID_VP)
>> +		xive_native_free_vp_block(xive->vp_base);
>> +
>> +	kfree(xive);
>> +	kfree(dev);
>> +}
>> +
>> +static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
>> +{
>> +	struct kvmppc_xive *xive;
>> +	struct kvm *kvm = dev->kvm;
>> +	int ret = 0;
>> +
>> +	pr_devel("Creating xive native device\n");
>> +
>> +	if (kvm->arch.xive)
>> +		return -EEXIST;
>> +
>> +	xive = kzalloc(sizeof(*xive), GFP_KERNEL);
>> +	if (!xive)
>> +		return -ENOMEM;
>> +
>> +	dev->private = xive;
>> +	xive->dev = dev;
>> +	xive->kvm = kvm;
>> +	kvm->arch.xive = xive;
>> +
>> +	/* We use the default queue size set by the host */
> 
> IIUC the queue is examined directly by the guest, so the guest must
> know its size.  In which case letting the host decide the size would
> be a problem for migration.

yes. This is a left over from the XICS-over-XIVE KVM device. I will 
remove the code, we don't use it.

Thanks,

C. 

>> +	xive->q_order = xive_native_default_eq_shift();
>> +	if (xive->q_order < PAGE_SHIFT)
>> +		xive->q_page_order = 0;
>> +	else
>> +		xive->q_page_order = xive->q_order - PAGE_SHIFT;
>> +
>> +	/*
>> +	 * Allocate a bunch of VPs. KVM_MAX_VCPUS is a large value for
>> +	 * a default. Getting the max number of CPUs the VM was
>> +	 * configured with would improve our usage of the XIVE VP space.
>> +	 */
>> +	xive->vp_base = xive_native_alloc_vp_block(KVM_MAX_VCPUS);
>> +	pr_devel("VP_Base=%x\n", xive->vp_base);
>> +
>> +	if (xive->vp_base == XIVE_INVALID_VP)
>> +		ret = -ENOMEM;
>> +
>> +	xive->single_escalation = xive_native_has_single_escalation();
>> +
>> +	if (ret)
>> +		kfree(xive);
>> +
>> +	return ret;
>> +}
>> +
>> +static int xive_native_debug_show(struct seq_file *m, void *private)
>> +{
>> +	struct kvmppc_xive *xive = m->private;
>> +	struct kvm *kvm = xive->kvm;
>> +
>> +	if (!kvm)
>> +		return 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int xive_native_debug_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, xive_native_debug_show, inode->i_private);
>> +}
>> +
>> +static const struct file_operations xive_native_debug_fops = {
>> +	.open = xive_native_debug_open,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek,
>> +	.release = single_release,
>> +};
>> +
>> +static void xive_native_debugfs_init(struct kvmppc_xive *xive)
>> +{
>> +	char *name;
>> +
>> +	name = kasprintf(GFP_KERNEL, "kvm-xive-%p", xive);
>> +	if (!name) {
>> +		pr_err("%s: no memory for name\n", __func__);
>> +		return;
>> +	}
>> +
>> +	xive->dentry = debugfs_create_file(name, 0444, powerpc_debugfs_root,
>> +					   xive, &xive_native_debug_fops);
>> +
>> +	pr_debug("%s: created %s\n", __func__, name);
>> +	kfree(name);
>> +}
>> +
>> +static void kvmppc_xive_native_init(struct kvm_device *dev)
>> +{
>> +	struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
>> +
>> +	/* Register some debug interfaces */
>> +	xive_native_debugfs_init(xive);
>> +}
>> +
>> +struct kvm_device_ops kvm_xive_native_ops = {
>> +	.name = "kvm-xive-native",
>> +	.create = kvmppc_xive_native_create,
>> +	.init = kvmppc_xive_native_init,
>> +	.destroy = kvmppc_xive_native_free,
>> +	.set_attr = kvmppc_xive_native_set_attr,
>> +	.get_attr = kvmppc_xive_native_get_attr,
>> +	.has_attr = kvmppc_xive_native_has_attr,
>> +};
>> +
>> +void kvmppc_xive_native_init_module(void)
>> +{
>> +	;
>> +}
>> +
>> +void kvmppc_xive_native_exit_module(void)
>> +{
>> +	;
>> +}
>> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
>> new file mode 100644
>> index 000000000000..fdbd2ff92a88
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/devices/xive.txt
>> @@ -0,0 +1,19 @@
>> +POWER9 eXternal Interrupt Virtualization Engine (XIVE Gen1)
>> +==========================================================
>> +
>> +Device types supported:
>> +  KVM_DEV_TYPE_XIVE     POWER9 XIVE Interrupt Controller generation 1
>> +
>> +This device acts as a VM interrupt controller. It provides the KVM
>> +interface to configure the interrupt sources of a VM in the underlying
>> +POWER9 XIVE interrupt controller.
>> +
>> +Only one XIVE instance may be instantiated. A guest XIVE device
>> +requires a POWER9 host and the guest OS should have support for the
>> +XIVE native exploitation interrupt mode. If not, it should run using
>> +the legacy interrupt mode, referred as XICS (POWER7/8).
>> +
>> +* Groups:
>> +
>> +  1. KVM_DEV_XIVE_GRP_CTRL
>> +  Provides global controls on the device
>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
>> index 64f1135e7732..806cbe488410 100644
>> --- a/arch/powerpc/kvm/Makefile
>> +++ b/arch/powerpc/kvm/Makefile
>> @@ -99,7 +99,7 @@ endif
>>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
>>  	book3s_xics.o
>>  
>> -kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) += book3s_xive.o
>> +kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) += book3s_xive.o book3s_xive_native.o
>>  kvm-book3s_64-objs-$(CONFIG_SPAPR_TCE_IOMMU) += book3s_64_vio.o
>>  
>>  kvm-book3s_64-module-objs := \
> 

