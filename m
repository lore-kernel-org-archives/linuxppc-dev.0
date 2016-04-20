Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqWxn6FbvzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 16:22:05 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id c20so14861058pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 23:22:05 -0700 (PDT)
Subject: Re: [PATCH V2 23/68] powerpc/mm: Make page table size a variable
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <570C5437.1070900@gmail.com> <87fuuka5ts.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57171FFA.4070301@gmail.com>
Date: Wed, 20 Apr 2016 16:21:46 +1000
MIME-Version: 1.0
In-Reply-To: <87fuuka5ts.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/04/16 20:27, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>>> index 2f818cbd8aa6..dcb9d6e94a0c 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> @@ -5,48 +5,20 @@
>>>   * for each page table entry.  The PMD and PGD level use a 32b record for
>>>   * each entry by assuming that each entry is page aligned.
>>>   */
>>> -#define PTE_INDEX_SIZE  9
>>> -#define PMD_INDEX_SIZE  7
>>> -#define PUD_INDEX_SIZE  9
>>> -#define PGD_INDEX_SIZE  9
>>> +#define H_PTE_INDEX_SIZE  9
>>> +#define H_PMD_INDEX_SIZE  7
>>> +#define H_PUD_INDEX_SIZE  9
>>> +#define H_PGD_INDEX_SIZE  9
>>>  
>>
>> Any comments on where these numbers came from?
>>
>> From these numbers for 4K pages we have
>>
>> Each PMD is 2M
>> Each PUD is 256M
>> Each PGD is 128G
> 
> I am not sure I understand. We are updating linux page table details for
> hash config here. This patch doesn't make any functionality change, it
> just make sure few #defines are marked as a variable.
> 

I was just stating that we need some comments about why we chose a particular
split. It just helps to understand that we use. My comment was just stating
that we need some additional comments and not necessarily due to your change

Balbir
