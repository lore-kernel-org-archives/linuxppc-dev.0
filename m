Return-Path: <aik@ozlabs.ru>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421m326nyCzF36f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:04:45 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id l9-v6so4860579pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 21:04:45 -0700 (PDT)
Subject: Re: [PATCH kernel 1/4] KVM: PPC: Validate all tces before updating
 tables
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
References: <20180830031647.34134-1-aik@ozlabs.ru>
 <20180830031647.34134-2-aik@ozlabs.ru>
 <20180830040101.GG2222@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6454a70e-0d74-23cd-be4d-67c8780e6ddd@ozlabs.ru>
Date: Fri, 31 Aug 2018 14:04:38 +1000
MIME-Version: 1.0
In-Reply-To: <20180830040101.GG2222@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 30/08/2018 14:01, David Gibson wrote:
> On Thu, Aug 30, 2018 at 01:16:44PM +1000, Alexey Kardashevskiy wrote:
>> The KVM TCE handlers are written in a way so they fail when either
>> something went horribly wrong or the userspace did some obvious mistake
>> such as passing a misaligned address.
>>
>> We are going to enhance the TCE checker to fail on attempts to map bigger
>> IOMMU page than the underlying pinned memory so let's valitate TCE
>> beforehand.
>>
>> This should cause no behavioral change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> With one misgiving..
> 
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 4 ++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 9a3f264..0fef22b 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -599,6 +599,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>  		ret = kvmppc_tce_validate(stt, tce);
>>  		if (ret != H_SUCCESS)
>>  			goto unlock_exit;
>> +	}
>> +
>> +	for (i = 0; i < npages; ++i) {
>> +		if (get_user(tce, tces + i)) {
> 
> This looks unsafe, because we validate, then regrab the TCE from
> userspace which could have been changed by another thread.
> 
> But it actually is safe, because the relevant checks will be
> re-executed in the following code.  If userspace tries to change this
> dodgily it will result in a messier failure mode but won't threaten
> the host.


I have put this to 3/4 for this get_user() while it should have been here:
+		/*
+		 * This get_user() may produce a different result than few
+		 * lines in the validation loop above but we translate it
+		 * again little later anyway and if that fails, we simply stop
+		 * and return error as it is likely the userspace shooting
+		 * itself in a foot.
+		 */

Might repost, testing that THP+realmode patch....


> 
> Long term, I think we would be better off copying everything into
> kernel space then doing the validation just once.  But the difference
> should only become apparent with a malicious or badly broken guest,
> and in the meantime this series addresses a real problem.
> 
> So, I think we should go ahead with it despite that imperfection.
> 
> 
>> +			ret = H_TOO_HARD;
>> +			goto unlock_exit;
>> +		}
>> +		tce = be64_to_cpu(tce);
>>  
>>  		if (kvmppc_gpa_to_ua(vcpu->kvm,
>>  				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 506a4d4..7ab6f3f 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -501,6 +501,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>  		ret = kvmppc_tce_validate(stt, tce);
>>  		if (ret != H_SUCCESS)
>>  			goto unlock_exit;
>> +	}
>> +
>> +	for (i = 0; i < npages; ++i) {
>> +		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
>>  
>>  		ua = 0;
>>  		if (kvmppc_gpa_to_ua(vcpu->kvm,
> 

-- 
Alexey
