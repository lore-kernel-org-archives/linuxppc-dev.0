Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CA671A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 14:11:10 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id y13so9168781pdi.39
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jul 2014 21:11:08 -0700 (PDT)
Message-ID: <53D5CD55.9050909@ozlabs.ru>
Date: Mon, 28 Jul 2014 14:11:01 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v3 02/18] KVM: PPC: Use RCU when adding to
 arch.spapr_tce_tables
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>	
 <1406191691-31441-3-git-send-email-aik@ozlabs.ru>
 <1406508047.4935.21.camel@pasglop>
In-Reply-To: <1406508047.4935.21.camel@pasglop>
Content-Type: text/plain; charset=koi8-r
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2014 10:40 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-07-24 at 18:47 +1000, Alexey Kardashevskiy wrote:
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> You need a much better changeset here, explaining what you are
> protecting against and why just changing that one list_add is
> sufficient.



===
At the moment the spapr_tce_tables list is not protected against races
which may happen if the userspace issues the KVM_CREATE_SPAPR_TCE ioctl
to KVM from different threads.

This makes use of _rcu helpers for list_add()/list_del().
===

and it is missing this bit as well (was under impression that all tables
get freed at once at KVM exit but this might not be the case for malicious
guest):

--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -211,7 +211,7 @@ static void release_spapr_tce_table(struct
kvmppc_spapr_tce_table *stt)
        long npages = kvmppc_stt_npages(stt->size);

        mutex_lock(&kvm->lock);
-       list_del(&stt->list);
+       list_del_rcu(&stt->list);



Would this be sufficient?



> 
> Cheers,
> Ben.
> 
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 54cf9bc..516f2ee 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -131,7 +131,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>  	kvm_get_kvm(kvm);
>>  
>>  	mutex_lock(&kvm->lock);
>> -	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
>> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>>  
>>  	mutex_unlock(&kvm->lock);
>>  
> 
> 


-- 
Alexey
