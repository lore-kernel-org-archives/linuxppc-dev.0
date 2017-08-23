Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcgVM311gzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 18:25:47 +1000 (AEST)
Subject: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
To: Paul Mackerras <paulus@ozlabs.org>, Nixiaoming <nixiaoming@huawei.com>
Cc: "agraf@suse.com" <agraf@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170822142823.69425-1-nixiaoming@huawei.com>
 <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
 <8fd9a878-a8ce-5576-9a5c-1c221ff6ded7@redhat.com>
 <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
 <20170823060624.GA13958@fergus.ozlabs.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aa600c47-d6d5-161d-419d-51ac30d67ee4@redhat.com>
Date: Wed, 23 Aug 2017 10:25:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170823060624.GA13958@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.08.2017 08:06, Paul Mackerras wrote:
> On Wed, Aug 23, 2017 at 01:43:08AM +0000, Nixiaoming wrote:
>>> On 22.08.2017 17:15, David Hildenbrand wrote:
>>>> On 22.08.2017 16:28, nixiaoming wrote:
>>>>> miss kfree(stt) when anon_inode_getfd return fail so add check 
>>>>> anon_inode_getfd return val, and kfree stt
>>>>>
>>>>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
>>>>> ---
>>>>>  arch/powerpc/kvm/book3s_64_vio.c | 5 ++++-
>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c 
>>>>> b/arch/powerpc/kvm/book3s_64_vio.c
>>>>> index a160c14..a0b4459 100644
>>>>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>>>>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>>>>> @@ -341,8 +341,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm 
>>>>> *kvm,
>>>>>  
>>>>>  	mutex_unlock(&kvm->lock);
>>>>>  
>>>>> -	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>>>>> +	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>>>>>  				stt, O_RDWR | O_CLOEXEC);
>>>>> +	if (ret < 0)
>>>>> +		goto fail;
>>>>> +	return ret;
>>>>>  
>>>>>  fail:
>>>>>  	if (stt) {
>>>>>
>>>>
>>>>
>>>> stt has already been added to kvm->arch.spapr_tce_tables, so freeing 
>>>> it is evil IMHO. I don't know that code, so I don't know if there is 
>>>> some other place that will make sure that everything in
>>>> kvm->arch.spapr_tce_tables will properly get freed, even when no 
>>>> kvm->release
>>>> function has been called (kvm_spapr_tce_release).
>>>>
>>>
>>> If it is really not freed, than also kvm_put_kvm(stt->kvm) is missing.
>>>
>>> -- 
>>>
>>> Thanks,
>>>
>>> David
>>>
>>
>> if (!stt) return -ENOMEM;
>> kvm_get_kvm(kvm);
>> if anon_inode_getfd return -ENOMEM
>> The user can not determine whether kvm_get_kvm has been called
>> so need add kvm_pet_kvm when anon_inode_getfd fail
>>
>> stt has already been added to kvm->arch.spapr_tce_tables,
>> but if anon_inode_getfd fail, stt is unused val, 
>> so call list_del_rcu, and  free as quickly as possible
>>
>> new patch:
>>
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index a160c14..e2228f1 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -341,8 +341,16 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>
>>         mutex_unlock(&kvm->lock);
>>
>> -       return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>> +       ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>>                                 stt, O_RDWR | O_CLOEXEC);
>> +       if (ret < 0) {
>> +               mutex_lock(&kvm->lock);
>> +               list_del_rcu(&stt->list);

... don't we have to take care of rcu synchronization before freeing it?

>> +               mutex_unlock(&kvm->lock);
>> +               kvm_put_kvm(kvm);
>> +               goto fail;
>> +       }
>> +       return ret;

of simply

if (!ret)
	return 0;

mutex_lock(&kvm->lock);
list_del_rcu(&stt->list);
mutex_unlock(&kvm->lock);
kvm_put_kvm(kvm);


> 
> It seems to me that it would be better to do the anon_inode_getfd()
> call before the kvm_get_kvm() call, and go to the fail label if it
> fails.

I would have suggested to not add it to the list before it has been
fully created (so nobody can have access to it). But I guess than we
need another level of protection(e.g. kvm->lock).

Am I missing something, or is kvm_vm_ioctl_create_spapr_tce() racy?

The -EBUSY check is done without any locking, so two parallel creators
could create an inconsistency, no? Shouldn't this all be protected by
kvm->lock?

> 
> Paul.
> 

Independent of the fix, I'd suggest the following cleanup.


>From 979f55083ee965e25827a8743e8a9fdb85231a6f Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Aug 2017 10:08:58 +0200
Subject: [PATCH v1 1/1] KVM: PPC: cleanup kvm_vm_ioctl_create_spapr_tce

Let's simplify error handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c
b/arch/powerpc/kvm/book3s_64_vio.c
index a160c14304eb..6bac49292296 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -295,8 +295,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	unsigned long npages, size;
-	int ret = -ENOMEM;
-	int i;
+	int i, ret;

 	if (!args->size)
 		return -EINVAL;
@@ -310,16 +309,13 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	size = _ALIGN_UP(args->size, PAGE_SIZE >> 3);
 	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
-	if (ret) {
-		stt = NULL;
-		goto fail;
-	}
+	if (ret)
+		return ret;

-	ret = -ENOMEM;
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
 	if (!stt)
-		goto fail;
+		return -ENOMEM;

 	stt->liobn = args->liobn;
 	stt->page_shift = args->page_shift;
@@ -331,7 +327,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	for (i = 0; i < npages; i++) {
 		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!stt->pages[i])
-			goto fail;
+			goto fail_free;
 	}

 	kvm_get_kvm(kvm);
@@ -344,15 +340,12 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
 				stt, O_RDWR | O_CLOEXEC);

-fail:
-	if (stt) {
-		for (i = 0; i < npages; i++)
-			if (stt->pages[i])
-				__free_page(stt->pages[i]);
-
-		kfree(stt);
-	}
-	return ret;
+fail_free:
+	for (i = 0; i < npages; i++)
+		if (stt->pages[i])
+			__free_page(stt->pages[i]);
+	kfree(stt);
+	return -ENOMEM;
 }

 static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entry)
-- 
2.13.5


-- 

Thanks,

David
