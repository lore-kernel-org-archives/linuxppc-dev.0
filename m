Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQrJJ32TszDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 10:28:15 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id f46so10792616uae.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 16:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d145cb52-5321-49fa-e33a-16a40bb00640@gmail.com>
References: <20171030123820.29392-1-bsingharora@gmail.com>
 <d145cb52-5321-49fa-e33a-16a40bb00640@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 31 Oct 2017 10:28:12 +1100
Message-ID: <CAKTCnzniKEDx27rp16ZApnK0PXK+47HBBBQcyeHrZu2zw86etA@mail.gmail.com>
Subject: Re: [rfc] powerpc/npu: Cleanup MMIO ATSD flushing
To: "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Reza Arbab <arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2017 at 3:03 AM, Aneesh Kumar K.V
<aneeshkumar.opensource@gmail.com> wrote:
>
>
> On 10/30/2017 06:08 PM, Balbir Singh wrote:
>>
>> +
>> +static void pnv_npu2_invalidate_helper(struct npu_context *npu_context,
>> +               struct mm_struct *mm, unsigned long start,
>> +               unsigned long end, bool flush)
>> +{
>> +       unsigned long address;
>> +       bool is_thp;
>> +       unsigned int hshift, shift;
>> +
>> +       address = start;
>> +       do {
>> +               local_irq_disable();
>> +               find_linux_pte(mm->pgd, address, &is_thp, &hshift);
>> +               if (!is_thp)
>> +                       shift = PAGE_SHIFT;
>> +               else
>> +                       shift = hshift;
>
>
> Is that correct? if is_thp is 0 can we derive shift from hshift? IIUC we set
> hshift only
> if it is a hugepage.

OK.. I assumed that it'll be set. So I've got to check for


if (is_thp)
      shift = mmu_psize_defs[MMU_PAGE_2M].shift
else if (hshift)
    shift = hshift
else
    shift = PAGE_SHIFT

>
>
>> +               mmio_invalidate(npu_context, address > 0, address, flush,
>> +                               shift);
>> +               local_irq_enable();
>> +               address += (1ull << shift);
>> +       } while (address < end);
>>   }
>>

Thanks for the review!

Balbir Singh.
