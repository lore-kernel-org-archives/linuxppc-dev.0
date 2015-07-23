Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43E871A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:45:53 +1000 (AEST)
Received: by pacan13 with SMTP id an13so156586093pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 02:45:51 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Fix calculation for memory
 allocated for TCE table
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
 <1437459841.30722.9.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55B0B7C8.8030804@ozlabs.ru>
Date: Thu, 23 Jul 2015 19:45:44 +1000
MIME-Version: 1.0
In-Reply-To: <1437459841.30722.9.camel@ellerman.id.au>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 04:24 PM, Michael Ellerman wrote:
> On Mon, 2015-07-20 at 20:45 +1000, Alexey Kardashevskiy wrote:
>> The existing code stores the amount of memory allocated for a TCE table.
>> At the moment it uses @offset which is a virtual offset in the TCE table
>> which is only correct for a one level tables and it does not include
>> memory allocated for intermediate levels. When multilevel TCE table is
>> requested, WARN_ON in tce_iommu_create_table() prints a warning.
>>
>> This adds an additional counter to pnv_pci_ioda2_table_do_alloc_pages()
>> to count actually allocated memory.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> I was sure I sent it already but could not find it anywhere so reposting.
>> Sorry if it is a duplicate.
>
> Stable?

No, this is for DDW patchset I recently posted and which did not get to any 
release yet.



-- 
Alexey
