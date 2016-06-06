Return-Path: <runaway@candw.ms>
Received: from smtp687.redcondor.net (smtp687.redcondor.net [208.80.206.87])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNTF75ZPlzDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 19:00:43 +1000 (AEST)
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>, Adrian Cox <adrian@humboldt.co.uk>,
 rtd@a-eon.com, rtd2@xtra.co.nz, pjwall@mac.com, pjwall@me.com,
 matthew@a-eon.biz, intermediadc@hotmail.com, contact@a-eon.com,
 info@xenosoft.de
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
 <871t4dui4g.fsf@skywalker.in.ibm.com>
 <2bf8f412-2631-75b4-70a3-cb5ecee5cf48@xenosoft.de>
 <2FB13B5B-42F0-4396-AD29-70924D2710CC@xenosoft.de>
 <053dd416-a9ab-5b06-5c3b-1acefb53fd3b@xenosoft.de>
 <1465174679.12265.4.camel@ellerman.id.au>
 <5fb9d8e9-d456-0537-ef77-82658e4538cd@candw.ms>
 <1465178406.12265.6.camel@ellerman.id.au>
From: Julian Margetson <runaway@candw.ms>
Message-ID: <2ea9f99f-d54c-b32f-dac9-71c50cc4a684@candw.ms>
Date: Mon, 6 Jun 2016 04:59:48 -0400
MIME-Version: 1.0
In-Reply-To: <1465178406.12265.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/5/2016 10:00 PM, Michael Ellerman wrote:
> On Sun, 2016-06-05 at 21:23 -0400, Julian Margetson wrote:
>>>> ï»¿drivers/gpu/drm/drm_vm.c: In function â€˜drm_dma_protâ€™:
>>>> drivers/gpu/drm/drm_vm.c:83:6: error: invalid operands to binary |
>>>> (have â€˜pgprot_t {aka struct <anonymous>}â€™ and â€˜intâ€™)
>>>>      tmp |= _PAGE_NO_CACHE;
>>>>          ^
>>>>
>>> That is because that usage is wrong based on type. _PAGE_NO_CACHE is not
>>> of type pgprot_t. What you really need there is
>>>
>>> tmp = __pgprot(pgprot_val(tmp) | _PAGE_NO_CACHE);
>>>
>>> or a better option would be
>>>
>>> tmp = pgprot_noncached_wc(tmp);
>>>
>>> -aneesh
>> tmp = pgprot_noncached_wc(tmp);
>>
>> compiles but  I then run in to the following
>>
>>    CC      drivers/gpu/drm/drm_scatter.o
>> drivers/gpu/drm/drm_scatter.c: In function â€˜drm_vmalloc_dmaâ€™:
>> drivers/gpu/drm/drm_scatter.c:44:49: error: invalid operands to binary |
>> (have â€˜pgprot_t {aka struct <anonymous>}â€™ and â€˜intâ€™)
>>     return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL | _PAGE_NO_CACHE);
>>                                                    ^
>> drivers/gpu/drm/drm_scatter.c:48:1: warning: control reaches end of
>> non-void function [-Wreturn-type]
>>    }
>>    ^
> Aneesh showed you how to fix that in his reply above.
>
>      return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
>
> cheers
>
>
>
Thanks .

With the two adjustment

tmp = pgprot_noncached_wc(tmp);

and

return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));

The rc2 builds and boots  on Sam460ex

Regards

Julian
