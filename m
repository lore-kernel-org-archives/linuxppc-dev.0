Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 357E12C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 16:15:27 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Oct 2012 10:45:20 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9H5FHJE32768014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 10:45:18 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9HAj8hK002911
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 21:45:08 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Build fix for powerpc KVM
In-Reply-To: <26771.1350425721@neuling.org>
References: <1350389744-24627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <26771.1350425721@neuling.org>
Date: Wed, 17 Oct 2012 10:45:15 +0530
Message-ID: <87fw5dhe70.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: schwab@linux-m68k.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Fix build failure for powerpc KVM
>
> What was the failure?


arch/powerpc/kvm/book3s_32_mmu_host.c: In function 'kvmppc_mmu_map_page':
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: 'VPN_SHIFT' undeclared (first use in this function)
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: (Each undeclared identifier is reported only once
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: for each function it appears in.)
arch/powerpc/kvm/book3s_32_mmu_host.c:178: error: expected ';' before 'next_pteg'
arch/powerpc/kvm/book3s_32_mmu_host.c:190: error: label 'next_pteg' used but not defined
make[1]: *** [arch/powerpc/kvm/book3s_32_mmu_host.o] Error 1


>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_book3s_32.h |    1 +
>>  arch/powerpc/kvm/book3s_32_mmu_host.c    |    4 ++--
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/kvm_book3s_32.h b/arch/powerpc/include/asm/kvm_book3s_32.h
>> index 38040ff..ce0ef6c 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s_32.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s_32.h
>> @@ -42,5 +42,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
>>  #define SID_SHIFT	28
>>  #define ESID_MASK	0xf0000000
>>  #define VSID_MASK	0x00fffffff0000000ULL
>> +#define VPN_SHIFT	12
>
> Is this the fix?
>
>>  
>>  #endif /* __ASM_KVM_BOOK3S_32_H__ */
>> diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
>> index 00aa612..b0f625a 100644
>> --- a/arch/powerpc/kvm/book3s_32_mmu_host.c
>> +++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
>> @@ -173,8 +173,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>>  	BUG_ON(!map);
>>  
>>  	vsid = map->host_vsid;
>> -	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
>> -
>> +	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) |
>> +		((eaddr & ~ESID_MASK) >> VPN_SHIFT);
>
> This just seems to be a white space change.

There is a missing ';'


-aneesh
