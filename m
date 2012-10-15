Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 241532C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 03:06:10 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Oct 2012 02:03:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9FFu8EW23003322
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 02:56:09 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9FG64EG016063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 03:06:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH -V8 04/11] arch/powerpc: Convert virtual address to vpn
In-Reply-To: <m2y5j8qft0.fsf@igel.home>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346945351-7672-5-git-send-email-aneesh.kumar__43423.5424655073$1346945525$gmane$org@linux.vnet.ibm.com>
 <m2y5j8qft0.fsf@igel.home>
Date: Mon, 15 Oct 2012 21:35:54 +0530
Message-ID: <87wqyrpvod.fsf@linux.vnet.ibm.com>
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

Andreas Schwab <schwab@linux-m68k.org> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
>> index 837f13e..00aa612 100644
>> --- a/arch/powerpc/kvm/book3s_32_mmu_host.c
>> +++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
>> @@ -141,7 +141,7 @@ extern char etext[];
>>  int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>>  {
>>  	pfn_t hpaddr;
>> -	u64 va;
>> +	u64 vpn;
>>  	u64 vsid;
>>  	struct kvmppc_sid_map *map;
>>  	volatile u32 *pteg;
>> @@ -173,7 +173,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>>  	BUG_ON(!map);
>>  
>>  	vsid = map->host_vsid;
>> -	va = (vsid << SID_SHIFT) | (eaddr & ~ESID_MASK);
>> +	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
>
> Where is VPN_SHIFT?  Where is the semicolon?

I had done a kvm build test with the changes, but missed the fact that
this is !SMP and PPC_BOOK3S_32. Will send a follow up patch.

-aneesh
