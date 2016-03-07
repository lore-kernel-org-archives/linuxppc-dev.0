Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4161A0225
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 20:38:21 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id q129so7774706pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Mar 2016 01:38:21 -0800 (PST)
Subject: Re: [PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest
 view of TCE table
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-7-git-send-email-aik@ozlabs.ru>
 <20160307062523.GN22546@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56DD4C05.4060109@ozlabs.ru>
Date: Mon, 7 Mar 2016 20:38:13 +1100
MIME-Version: 1.0
In-Reply-To: <20160307062523.GN22546@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/07/2016 05:25 PM, David Gibson wrote:
> On Mon, Mar 07, 2016 at 02:41:14PM +1100, Alexey Kardashevskiy wrote:
>> The existing in-kernel TCE table for emulated devices contains
>> guest physical addresses which are accesses by emulated devices.
>> Since we need to keep this information for VFIO devices too
>> in order to implement H_GET_TCE, we are reusing it.
>>
>> This adds IOMMU group list to kvmppc_spapr_tce_table. Each group
>> will have an iommu_table pointer.
>>
>> This adds kvm_spapr_tce_attach_iommu_group() helper and its detach
>> counterpart to manage the lists.
>>
>> This puts a group when:
>> - guest copy of TCE table is destroyed when TCE table fd is closed;
>> - kvm_spapr_tce_detach_iommu_group() is called from
>> the KVM_DEV_VFIO_GROUP_DEL ioctl handler in the case vfio-pci hotunplug
>> (will be added in the following patch).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/kvm_host.h |   8 +++
>>   arch/powerpc/include/asm/kvm_ppc.h  |   6 ++
>>   arch/powerpc/kvm/book3s_64_vio.c    | 108 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 122 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 2e7c791..2c5c823 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -178,6 +178,13 @@ struct kvmppc_pginfo {
>>   	atomic_t refcnt;
>>   };
>>
>> +struct kvmppc_spapr_tce_group {
>> +	struct list_head next;
>> +	struct rcu_head rcu;
>> +	struct iommu_group *refgrp;/* for reference counting only */
>> +	struct iommu_table *tbl;
>> +};
>> +
>>   struct kvmppc_spapr_tce_table {
>>   	struct list_head list;
>>   	struct kvm *kvm;
>> @@ -186,6 +193,7 @@ struct kvmppc_spapr_tce_table {
>>   	u32 page_shift;
>>   	u64 offset;		/* in pages */
>>   	u64 size;		/* window size in pages */
>> +	struct list_head groups;
>>   	struct page *pages[0];
>>   };
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index 2544eda..d1482dc 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -164,6 +164,12 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>>   			struct kvm_memory_slot *memslot, unsigned long porder);
>>   extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
>>
>> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
>> +				unsigned long liobn,
>> +				phys_addr_t start_addr,
>> +				struct iommu_group *grp);
>> +extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
>> +				struct iommu_group *grp);
>>   extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>   				struct kvm_create_spapr_tce_64 *args);
>>   extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 2c2d103..846d16d 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/list.h>
>>   #include <linux/anon_inodes.h>
>> +#include <linux/iommu.h>
>>
>>   #include <asm/tlbflush.h>
>>   #include <asm/kvm_ppc.h>
>> @@ -95,10 +96,18 @@ static void release_spapr_tce_table(struct rcu_head *head)
>>   	struct kvmppc_spapr_tce_table *stt = container_of(head,
>>   			struct kvmppc_spapr_tce_table, rcu);
>>   	unsigned long i, npages = kvmppc_tce_pages(stt->size);
>> +	struct kvmppc_spapr_tce_group *kg;
>>
>>   	for (i = 0; i < npages; i++)
>>   		__free_page(stt->pages[i]);
>>
>> +	while (!list_empty(&stt->groups)) {
>> +		kg = list_first_entry(&stt->groups,
>> +				struct kvmppc_spapr_tce_group, next);
>> +		list_del(&kg->next);
>> +		kfree(kg);
>> +	}
>> +
>>   	kfree(stt);
>>   }
>>
>> @@ -129,9 +138,15 @@ static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
>>   static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
>>   {
>>   	struct kvmppc_spapr_tce_table *stt = filp->private_data;
>> +	struct kvmppc_spapr_tce_group *kg;
>>
>>   	list_del_rcu(&stt->list);
>>
>> +	list_for_each_entry_rcu(kg, &stt->groups, next)	{
>> +		iommu_group_put(kg->refgrp);
>> +		kg->refgrp = NULL;
>> +	}
>
> What's the reason for this kind of two-phase deletion?  Dereffing the
> group here, and setting to NULL, then actually removing from the liast above.

Well, this way I have only one RCU-delayed release_spapr_tce_table(). The 
other option would be to call for each @kg:
- list_del(&kg->next);
- call_rcu()

as release_spapr_tce_table() won't be able to delete them - they are not in 
the list anymore.

I suppose I can reuse kvm_spapr_tce_put_group(), this looks inaccurate...



>
>>   	kvm_put_kvm(stt->kvm);
>>
>>   	kvmppc_account_memlimit(
>> @@ -146,6 +161,98 @@ static const struct file_operations kvm_spapr_tce_fops = {
>>   	.release	= kvm_spapr_tce_release,
>>   };
>>
>> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
>> +				unsigned long liobn,
>> +				phys_addr_t start_addr,
>> +				struct iommu_group *grp)
>> +{
>> +	struct kvmppc_spapr_tce_table *stt = NULL;
>> +	struct iommu_table_group *table_group;
>> +	long i;
>> +	bool found = false;
>> +	struct kvmppc_spapr_tce_group *kg;
>> +	struct iommu_table *tbltmp;
>> +
>> +	/* Check this LIOBN hasn't been previously allocated */
>
> This comment does not appear to be correct.
>
>> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
>> +		if (stt->liobn == liobn) {
>> +			if ((stt->offset << stt->page_shift) != start_addr)
>> +				return -EINVAL;
>> +
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found)
>> +		return -ENODEV;
>> +
>> +	/* Find IOMMU group and table at @start_addr */
>> +	table_group = iommu_group_get_iommudata(grp);
>> +	if (!table_group)
>> +		return -EFAULT;
>> +
>> +	tbltmp = NULL;
>> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +		struct iommu_table *tbl = table_group->tables[i];
>> +
>> +		if (!tbl)
>> +			continue;
>> +
>> +		if ((tbl->it_page_shift == stt->page_shift) &&
>> +				(tbl->it_offset == stt->offset)) {
>> +			tbltmp = tbl;
>> +			break;
>> +		}
>> +	}
>> +	if (!tbltmp)
>> +		return -ENODEV;
>> +
>> +	list_for_each_entry_rcu(kg, &stt->groups, next) {
>> +		if (kg->refgrp == grp)
>> +			return -EBUSY;
>> +	}
>> +
>> +	kg = kzalloc(sizeof(*kg), GFP_KERNEL);
>> +	kg->refgrp = grp;
>> +	kg->tbl = tbltmp;
>> +	list_add_rcu(&kg->next, &stt->groups);
>> +
>> +	return 0;
>> +}
>> +
>> +static void kvm_spapr_tce_put_group(struct rcu_head *head)
>> +{
>> +	struct kvmppc_spapr_tce_group *kg = container_of(head,
>> +			struct kvmppc_spapr_tce_group, rcu);
>> +
>> +	iommu_group_put(kg->refgrp);
>> +	kg->refgrp = NULL;
>> +	kfree(kg);
>> +}
>> +
>> +extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
>> +				struct iommu_group *grp)
>
> Hrm.  attach takes an explicit liobn, but this one iterates over all
> liobns.  Why the asymmetry?


For attach(), LIOBN is specified in an additional (to VFIO KVM device's 
"add group") ioctl(). There is no need for "detach" ioctl() as we only want 
this detach() to happen when a group is removed from a container, and in 
this case the usual KVM_DEV_VFIO_GROUP_DEL is good enough hint that we need 
to detach LIOBN. Since _DEL does not take LIOBN, here I have a loop.

I'll put this in the commit log next time.


>
>> +{
>> +	struct kvmppc_spapr_tce_table *stt;
>> +	struct iommu_table_group *table_group;
>> +	struct kvmppc_spapr_tce_group *kg;
>> +
>> +	table_group = iommu_group_get_iommudata(grp);
>> +	if (!table_group)
>> +		return;
>> +
>> +	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
>> +		list_for_each_entry_rcu(kg, &stt->groups, next) {
>> +			if (kg->refgrp == grp) {
>> +				list_del_rcu(&kg->next);
>> +				call_rcu(&kg->rcu, kvm_spapr_tce_put_group);
>> +				break;
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>   				   struct kvm_create_spapr_tce_64 *args)
>>   {
>> @@ -181,6 +288,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>   	stt->offset = args->offset;
>>   	stt->size = size;
>>   	stt->kvm = kvm;
>> +	INIT_LIST_HEAD_RCU(&stt->groups);
>>
>>   	for (i = 0; i < npages; i++) {
>>   		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
>


-- 
Alexey
