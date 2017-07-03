Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1CVT4cx4zDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 13:36:49 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id p21so22554017qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Jul 2017 20:36:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <316b2400-6be8-2772-e307-0fa6447ccaa9@linux.vnet.ibm.com>
References: <20170630065235.752-1-oohall@gmail.com>
 <316b2400-6be8-2772-e307-0fa6447ccaa9@linux.vnet.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 3 Jul 2017 13:36:46 +1000
Message-ID: <CAOSf1CG63M9V-si7ewm6xY3ow8FN_GY7RdR4XsXuNKkTb72uRA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/hugetlbfs: Export HPAGE_SHIFT
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 30, 2017 at 7:28 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> On 06/30/2017 12:22 PM, Oliver O'Halloran wrote:
>> Export it so it can be referenced inside a module.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>>  arch/powerpc/mm/hugetlbpage.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index ceeab69cf7fc..96293560f294 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -34,6 +34,7 @@
>>  #define PAGE_SHIFT_16G       34
>>
>>  unsigned int HPAGE_SHIFT;
>> +EXPORT_SYMBOL(HPAGE_SHIFT);
>
> Why would you need this in a driver ? This represents the
> default HugeTLB page size.

Libnvdimm uses HPAGE_SIZE for a few things that it probably shouldn't.
I have sent a fix for libnvdimm, but that hasn't been merged yet and
this was breaking mpe's -next builds in the mean time. I agree it's
kind of bad, but we needed ZONE_DEVICE support to be in 4.13.

Oliver
