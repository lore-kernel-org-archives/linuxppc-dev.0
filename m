Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF3071A0707
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:49:55 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 18:49:53 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C64E619D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:37:49 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1I1npne29622432
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 01:49:51 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1I1nocT013850
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:49:51 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 20/35] powerpc/mm: Don't track subpage valid bit in
 pte_t
In-Reply-To: <20160218011152.GA2765@fergus.ozlabs.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160218011152.GA2765@fergus.ozlabs.ibm.com>
Date: Thu, 18 Feb 2016 07:19:45 +0530
Message-ID: <87vb5m9492.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Dec 01, 2015 at 09:06:45AM +0530, Aneesh Kumar K.V wrote:
>> This free up 11 bits in pte_t. In the later patch we also change
>> the pte_t format so that we can start supporting migration pte
>> at pmd level. We now track 4k subpage valid bit as below
>> 
>> If we have _PAGE_COMBO set, we override the _PAGE_F_GIX_SHIFT
>> and _PAGE_F_SECOND. Together we have 4 bits, each of them
>> used to indicate whether any of the 4 4k subpage in that group
>> is valid. ie,
>> 
>> [ group 1 bit ]   [ group 2 bit ]  ..... [ group 4 ]
>> [ subpage 1 - 4]  [ subpage 5- 8]  ..... [ subpage 13 - 16]
>> 
>> We still track each 4k subpage slot number and secondary hash
>> information in the second half of pgtable_t. Removing the subpage
>> tracking have some significant overhead on aim9 and ebizzy benchmark and
>> to support THP with 4K subpage, we do need a pgtable_t of 4096 bytes.
>
> I know this has already been applied, but this hunk looks wrong:
>
>> @@ -102,7 +131,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  	 */
>>  	if (!(old_pte & _PAGE_COMBO)) {
>>  		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
>> -		old_pte &= ~_PAGE_HPTE_SUB;
>> +		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
>
> Shouldn't this be:
>
> +		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
>
> instead?

Thanks for checking this closely. Yes it should be what you suggested. I
will do a patch for this.

-aneesh
