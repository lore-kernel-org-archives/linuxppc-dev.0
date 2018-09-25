Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRqX1VKqzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:49:12 +1000 (AEST)
Subject: Re: [PATCH v4 15/20] powerpc/mm: Avoid useless lock with single page
 fragments
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
 <7efec0c76fa692513c806871151a7ae20e99fe05.1537288312.git.christophe.leroy@c-s.fr>
 <78cb82d6-1a13-150d-9daa-021bd2f98e7a@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0c09b968-b3ef-ca89-9bd4-bf9df353ff50@c-s.fr>
Date: Tue, 25 Sep 2018 18:49:07 +0200
MIME-Version: 1.0
In-Reply-To: <78cb82d6-1a13-150d-9daa-021bd2f98e7a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2018 à 04:56, Aneesh Kumar K.V a écrit :
> On 9/18/18 10:27 PM, Christophe Leroy wrote:
>> There is no point in taking the page table lock as
>> pte_frag is always NULL when we have only one fragment.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/pgtable-frag.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable-frag.c 
>> b/arch/powerpc/mm/pgtable-frag.c
>> index bc924822dcd6..ab4910e92aaf 100644
>> --- a/arch/powerpc/mm/pgtable-frag.c
>> +++ b/arch/powerpc/mm/pgtable-frag.c
>> @@ -85,6 +85,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
>>   {
>>       void *pte_frag, *ret;
>>
>> +    if (PTE_FRAG_NR == 1)
>> +        return NULL;
>> +
>>       spin_lock(&mm->page_table_lock);
>>       ret = mm->context.pte_frag;
>>       if (ret) {
>>
> 
> May be update get_pmd_from_cache too?
> 

Ok, done in v5

Christophe
