Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDFAD1A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:54:44 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 04:54:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AF82D2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:54:08 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6MIrqVh5701960
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:53:52 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6MIs8i5014583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:54:08 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the valid
 bit
In-Reply-To: <1406006862.22200.7.camel@pasglop>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406006862.22200.7.camel@pasglop>
Date: Wed, 23 Jul 2014 00:23:57 +0530
Message-ID: <8761iptebe.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2014-07-15 at 20:22 +0530, Aneesh Kumar K.V wrote:
>> With hugepages, we store the hpte valid information in the pte page
>> whose address is stored in the second half of the PMD. Use a
>> write barrier to make sure that clearing pmd busy bit and updating
>> hpte valid info are ordered properly.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pgtable-ppc64.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
>> index eb9261024f51..558beb760062 100644
>> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
>> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
>> @@ -394,6 +394,12 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>>  					unsigned int index, unsigned int hidx)
>>  {
>>  	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
>> +	/*
>> +	 * The hpte valid is stored in the pgtable whose address is in the
>> +	 * second half of the PMD. Order this against clearing of the busy bit in
>> +	 * huge pmd.
>> +	 */
>> +	smp_wmb();
>>  }
>
> A better place for this would be right before the last write to the PMD
> (that's also clearing BUSY) in __hash_page_thp(). Basically, it's the
> normal lock ordering that's missing here, nothing specific to
> mark_hpte_slot_valid() but instead, any state relative to the BUSY bit
> in the PMD (including the actual hash writes in update_pp etc...)
>

IIUC updatepp already have required barriers. ie in updatepp we do tlbie
which should take care of the ordering right ?

Now the reason i moved that spm_wmb() to mark_hpte_slot_valid was to
pair it with smb_rmb() in get_hpte_slot_array().

-aneesh
