Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x231.google.com (mail-qc0-x231.google.com
 [IPv6:2607:f8b0:400d:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 515382C030D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:50:08 +1100 (EST)
Received: by mail-qc0-f177.google.com with SMTP id m20so4795301qcx.22
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:50:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87a9gfva9n.fsf@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <87a9gfva9n.fsf@linux.vnet.ibm.com>
Date: Wed, 11 Dec 2013 16:50:04 +0800
Message-ID: <CAFgQCTtd1v+ANEy899_Tk2UmYsAL1Lxe8t6WuMxFvjXk5rtn_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 5, 2013 at 6:53 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Liu Ping Fan <kernelfans@gmail.com> writes:
>
>> To enable the do_numa_page(), we should not fix _PAGE_NUMA in
>> hash_page(), so bail out for the case of pte_numa().
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash_utils_64.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index fb176e9..9bf1195 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1033,7 +1033,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>>
>>       /* Get PTE and page size from page tables */
>>       ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
>> -     if (ptep == NULL || !pte_present(*ptep)) {
>> +     if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
>>               DBG_LOW(" no PTE !\n");
>>               rc = 1;
>>               goto bail;
>
> why ? , All the hash routines do check for _PAGE_PRESENT via access
> variable.
>
Going through __hash_page_4K(4k on 4k HW), I do not find such check.
Am I wrong? Or I will send out a patch to fix that.

Thanks and regards,
Pingfan
> -aneesh
>
