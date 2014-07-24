Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E17191A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 15:49:08 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bj1so3171967pad.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 22:49:06 -0700 (PDT)
Message-ID: <53D09E4B.1010904@ozlabs.ru>
Date: Thu, 24 Jul 2014 15:48:59 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 03/18] KVM: PPC: Account TCE pages in locked_vm
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
 <1406084764-24685-4-git-send-email-aik@ozlabs.ru>
 <20140723033652.GC5208@shangw>
In-Reply-To: <20140723033652.GC5208@shangw>
Content-Type: text/plain; charset=koi8-r
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2014 01:36 PM, Gavin Shan wrote:
> On Wed, Jul 23, 2014 at 01:05:49PM +1000, Alexey Kardashevskiy wrote:
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++++++++++++++++++++++-
>> 1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 516f2ee..48b7ed4 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -45,18 +45,48 @@ static long kvmppc_stt_npages(unsigned long window_size)
>> 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>> }
>>
>> +/*
>> + * Checks ulimit in order not to let the user space to pin all
>> + * available memory for TCE tables.
>> + */
>> +static long kvmppc_account_memlimit(long npages)
>> +{
>> +	unsigned long ret = 0, locked, lock_limit;
>> +
>> +	if (!current->mm)
>> +		return -ESRCH; /* process exited */
>> +
>> +	down_write(&current->mm->mmap_sem);
>> +	locked = current->mm->locked_vm + npages;
>> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> 
> I took a look on mm/mlock.c::mlock() where the mlock operation
> is allowd while we have one of following conditions (not &&) :-)
> 
>         /* check against resource limits */
>         if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
>                 error = do_mlock(start, len, 1);


So? if() that you posted does lock, the if() I posted does completely
opposite operation. It is not just || vs. &&, other conditions changed too.


drivers/vfio/vfio_iommu_spapr_tce.c has the same chunk which I copied here,
for example.


> 
> Thanks,
> Gavin
> 
>> +		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
>> +				rlimit(RLIMIT_MEMLOCK));
>> +		ret = -ENOMEM;
>> +	} else {
>> +		current->mm->locked_vm += npages;
>> +	}
>> +	up_write(&current->mm->mmap_sem);
>> +
>> +	return ret;
>> +}
>> +
>> static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
>> {
>> 	struct kvm *kvm = stt->kvm;
>> 	int i;
>> +	long npages = kvmppc_stt_npages(stt->window_size);
>>
>> 	mutex_lock(&kvm->lock);
>> 	list_del(&stt->list);
>> -	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
>> +	for (i = 0; i < npages; i++)
>> 		__free_page(stt->pages[i]);
>> +
>> 	kfree(stt);
>> 	mutex_unlock(&kvm->lock);
>>
>> +	kvmppc_account_memlimit(-(npages + 1));
>> +
>> 	kvm_put_kvm(kvm);
>> }
>>
>> @@ -112,6 +142,9 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>> 	}
>>
>> 	npages = kvmppc_stt_npages(args->window_size);
>> +	ret = kvmppc_account_memlimit(npages + 1);
>> +	if (ret)
>> +		goto fail;
>>
>> 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
>> 		      GFP_KERNEL);
>> -- 
>> 2.0.0
>>
> 


-- 
Alexey
