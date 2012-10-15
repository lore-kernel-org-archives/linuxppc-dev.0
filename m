Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F6E12C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 03:28:45 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Oct 2012 21:58:38 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9FGSYB757278532
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2012 21:58:34 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9FLwFMh032425
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 08:58:15 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH -V8 04/11] arch/powerpc: Convert virtual address to vpn
In-Reply-To: <87wqyrpvod.fsf@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346945351-7672-5-git-send-email-aneesh.kumar__43423.5424655073$1346945525$gmane$org@linux.vnet.ibm.com>
 <m2y5j8qft0.fsf@igel.home> <87wqyrpvod.fsf@linux.vnet.ibm.com>
Date: Mon, 15 Oct 2012 21:58:30 +0530
Message-ID: <87vceb3djl.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>
>>> diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
>>> index 837f13e..00aa612 100644
>>> --- a/arch/powerpc/kvm/book3s_32_mmu_host.c
>>> +++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
>>> @@ -141,7 +141,7 @@ extern char etext[];
>>>  int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>>>  {
>>>  	pfn_t hpaddr;
>>> -	u64 va;
>>> +	u64 vpn;
>>>  	u64 vsid;
>>>  	struct kvmppc_sid_map *map;
>>>  	volatile u32 *pteg;
>>> @@ -173,7 +173,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>>>  	BUG_ON(!map);
>>>  
>>>  	vsid = map->host_vsid;
>>> -	va = (vsid << SID_SHIFT) | (eaddr & ~ESID_MASK);
>>> +	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
>>
>> Where is VPN_SHIFT?  Where is the semicolon?
>
> I had done a kvm build test with the changes, but missed the fact that
> this is !SMP and PPC_BOOK3S_32. Will send a follow up patch.

How about the below ? Any help on how to get this tested ?

diff --git a/arch/powerpc/include/asm/kvm_book3s_32.h b/arch/powerpc/include/asm/kvm_book3s_32.h
index 38040ff..ce0ef6c 100644
--- a/arch/powerpc/include/asm/kvm_book3s_32.h
+++ b/arch/powerpc/include/asm/kvm_book3s_32.h
@@ -42,5 +42,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 #define SID_SHIFT	28
 #define ESID_MASK	0xf0000000
 #define VSID_MASK	0x00fffffff0000000ULL
+#define VPN_SHIFT	12
 
 #endif /* __ASM_KVM_BOOK3S_32_H__ */
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 00aa612..b0f625a 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -173,8 +173,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	BUG_ON(!map);
 
 	vsid = map->host_vsid;
-	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
-
+	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) |
+		((eaddr & ~ESID_MASK) >> VPN_SHIFT);
 next_pteg:
 	if (rr == 16) {
 		primary = !primary;
