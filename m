Return-Path: <ibmirkin@gmail.com>
Received: from mail-oa0-x22f.google.com (mail-oa0-x22f.google.com
 [IPv6:2607:f8b0:4003:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EF412C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 02:28:40 +1100 (EST)
Received: by mail-oa0-f47.google.com with SMTP id k1so3988169oag.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Dec 2013 07:28:36 -0800 (PST)
MIME-Version: 1.0
Sender: ibmirkin@gmail.com
In-Reply-To: <CAM9eBokeHwgDnddrH5PVNK9bCT7b1_7GA98DsJaUwKPJfLCvgw@mail.gmail.com>
References: <1386377017-909-1-git-send-email-imirkin@alum.mit.edu>
 <CAM9eBokeHwgDnddrH5PVNK9bCT7b1_7GA98DsJaUwKPJfLCvgw@mail.gmail.com>
Date: Mon, 9 Dec 2013 10:28:36 -0500
Message-ID: <CAKb7UviP4mc=eHi5_3h_WL+KNEf-Uyk=+49QRT=D4a9baO-Dbw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: fix ocm_block allocation
From: Ilia Mirkin <imirkin@alum.mit.edu>
To: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 9, 2013 at 3:38 AM, Vinh Huu Tuong Nguyen <vhtnguyen@apm.com> wrote:
>
> Hi Ilia Mirkin,
> Thanks for your info. I did investigated why our test didn't detect it and found out that
> the struct ocm_block is only used on ocm_debugfs_show function when we want to
> know information about ocm and it's available when we enable debugfs. But our test
> only tried to use the OCM block functions and didn't care about the OCM information.
> So I think we should apply your patch to solve this issue instead of removing ocm part.
>

OK, perhaps there's something clever gong on. However on my git tree
(updated as of a few days ago):

$ git grep ppc4xx_ocm_alloc
arch/powerpc/include/asm/ppc4xx_ocm.h:void
*ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
arch/powerpc/include/asm/ppc4xx_ocm.h:#define ppc4xx_ocm_alloc(phys,
size, align, flags, owner) NULL
arch/powerpc/sysdev/ppc4xx_ocm.c:void *ppc4xx_ocm_alloc(phys_addr_t
*phys, int size, int align,

So... no users. Unless there's macro-related cleverness going on (I'll
freely admit to not having read/understood the full code, so could
well be.) Perhaps it was meant to be used but the call got lost?

  -ilia

>
>
>
> On Sat, Dec 7, 2013 at 7:43 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>>
>> Allocate enough memory for the ocm_block structure, not just a pointer
>> to it.
>>
>> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
>> ---
>>
>> I have neither the hardware to test nor the toolchain to even build-test
>> this. However this seems like a fairly obvious fix (and I have to wonder how
>> this ever worked at all). Found with spatch.
>>
>> Actually further investigation makes it seem like this function is never
>> called, perhaps it should just be removed? If it is kept around though, would
>> be nice to apply this patch so that tools don't trip over this wrong code.
>>
>>  arch/powerpc/sysdev/ppc4xx_ocm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4xx_ocm.c
>> index b7c4345..85d9e37 100644
>> --- a/arch/powerpc/sysdev/ppc4xx_ocm.c
>> +++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
>> @@ -339,7 +339,7 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
>>                 if (IS_ERR_VALUE(offset))
>>                         continue;
>>
>> -               ocm_blk = kzalloc(sizeof(struct ocm_block *), GFP_KERNEL);
>> +               ocm_blk = kzalloc(sizeof(struct ocm_block), GFP_KERNEL);
>>                 if (!ocm_blk) {
>>                         printk(KERN_ERR "PPC4XX OCM: could not allocate ocm block");
>>                         rh_free(ocm_reg->rh, offset);
>> --
>> 1.8.3.2
>>
>
>
>
> --
>
> Vinh Nguyen Huu Tuong | Staff SW Engineer
>
> C: 090.335.7841 | O: 083.770.0640 ext: 3719
>
> F: 083.770.0641 | vhtnguyen@apm.com
>
>
>
>
>
>
>
>
