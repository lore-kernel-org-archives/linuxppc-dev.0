Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1DC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:32:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F363B20815
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F363B20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tQY66QRszDq7F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.249; helo=6.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo177.mail-out.ovh.net (6.mo177.mail-out.ovh.net
 [46.105.51.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tQWJ5bRGzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 22:30:51 +1100 (AEDT)
Received: from player718.ha.ovh.net (unknown [10.109.160.251])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 96E63E2BD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 12:30:47 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id 68B18242DC79;
 Mon,  4 Feb 2019 11:30:39 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org> <20190204044531.GB1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
Date: Mon, 4 Feb 2019 12:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204044531.GB1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2478950119999048583
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/4/19 5:45 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:18PM +0100, Cédric Le Goater wrote:
>> This will let the guest create a memory mapping to expose the ESB MMIO
>> regions used to control the interrupt sources, to trigger events, to
>> EOI or to turn off the sources.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>>  2 files changed, 101 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 8c876c166ef2..6bb61ba141c2 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>>  
>> +/* POWER9 XIVE Native Interrupt Controller */
>> +#define KVM_DEV_XIVE_GRP_CTRL		1
>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> 
> Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
> to both with an mmap() directly on the xive device fd?  Using the
> offset to distinguish which one to map, obviously.

The page offset would define some sort of user API. It seems feasible.
But I am not sure this would be practical in the future if we need to 
tune the length.

The TIMA has two pages that can be exposed at guest level for interrupt 
management : the OS and the USER page. That should be OK.

But we might want to map only portions of the interrupt ESB space, for 
PCI passthrough for instance as Paul proposed. I am still looking at that.

Thanks,

C.

>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index 115143e76c45..e20081f0c8d4 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -153,6 +153,85 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>>  	return rc;
>>  }
>>  
>> +static int xive_native_esb_fault(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct kvmppc_xive *xive = vma->vm_file->private_data;
>> +	struct kvmppc_xive_src_block *sb;
>> +	struct kvmppc_xive_irq_state *state;
>> +	struct xive_irq_data *xd;
>> +	u32 hw_num;
>> +	u16 src;
>> +	u64 page;
>> +	unsigned long irq;
>> +
>> +	/*
>> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
>> +	 * one for EOI
>> +	 */
>> +	irq = vmf->pgoff / 2;
>> +
>> +	sb = kvmppc_xive_find_source(xive, irq, &src);
>> +	if (!sb) {
>> +		pr_err("%s: source %lx not found !\n", __func__, irq);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +
>> +	state = &sb->irq_state[src];
>> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
>> +
>> +	arch_spin_lock(&sb->lock);
>> +
>> +	/*
>> +	 * first/even page is for trigger
>> +	 * second/odd page is for EOI and management.
>> +	 */
>> +	page = vmf->pgoff % 2 ? xd->eoi_page : xd->trig_page;
>> +	arch_spin_unlock(&sb->lock);
>> +
>> +	if (!page) {
>> +		pr_err("%s: acessing invalid ESB page for source %lx !\n",
>> +		       __func__, irq);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +
>> +	vmf_insert_pfn(vma, vmf->address, page >> PAGE_SHIFT);
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +
>> +static const struct vm_operations_struct xive_native_esb_vmops = {
>> +	.fault = xive_native_esb_fault,
>> +};
>> +
>> +static int xive_native_esb_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	/* There are two ESB pages (trigger and EOI) per IRQ */
>> +	if (vma_pages(vma) + vma->vm_pgoff > KVMPPC_XIVE_NR_IRQS * 2)
>> +		return -EINVAL;
>> +
>> +	vma->vm_flags |= VM_IO | VM_PFNMAP;
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +	vma->vm_ops = &xive_native_esb_vmops;
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations xive_native_esb_fops = {
>> +	.mmap = xive_native_esb_mmap,
>> +};
>> +
>> +static int kvmppc_xive_native_get_esb_fd(struct kvmppc_xive *xive, u64 addr)
>> +{
>> +	u64 __user *ubufp = (u64 __user *) addr;
>> +	int ret;
>> +
>> +	ret = anon_inode_getfd("[xive-esb]", &xive_native_esb_fops, xive,
>> +				O_RDWR | O_CLOEXEC);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return put_user(ret, ubufp);
>> +}
>> +
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -162,12 +241,30 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> +	struct kvmppc_xive *xive = dev->private;
>> +
>> +	switch (attr->group) {
>> +	case KVM_DEV_XIVE_GRP_CTRL:
>> +		switch (attr->attr) {
>> +		case KVM_DEV_XIVE_GET_ESB_FD:
>> +			return kvmppc_xive_native_get_esb_fd(xive, attr->addr);
>> +		}
>> +		break;
>> +	}
>>  	return -ENXIO;
>>  }
>>  
>>  static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> +	switch (attr->group) {
>> +	case KVM_DEV_XIVE_GRP_CTRL:
>> +		switch (attr->attr) {
>> +		case KVM_DEV_XIVE_GET_ESB_FD:
>> +			return 0;
>> +		}
>> +		break;
>> +	}
>>  	return -ENXIO;
>>  }
>>  
> 

