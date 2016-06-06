Return-Path: <runaway@candw.ms>
Received: from smtp618.redcondor.net (smtp618.redcondor.net [208.80.206.18])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNH7K2zkVzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 11:25:00 +1000 (AEST)
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
From: Julian Margetson <runaway@candw.ms>
Message-ID: <5fb9d8e9-d456-0537-ef77-82658e4538cd@candw.ms>
Date: Sun, 5 Jun 2016 21:23:49 -0400
MIME-Version: 1.0
In-Reply-To: <1465174679.12265.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/5/2016 8:57 PM, Michael Ellerman wrote:
> On Sun, 2016-06-05 at 18:09 +0200, Christian Zigotzky wrote:
>
>> All,
>>
>> I need an answer because I think Darren's guess is correct. It isn't a
>> problem in the pci code. I replaced the file head_64.S that Darren
>> mentioned with the one from the kernel 4.6 and it compiled but
>> unfortunately it doesn't boot. We know "head_64.S" is one file for the
>> early boot phase but I think there are some other files.
> There's lots of files used in the early boot, you can't revert individual files
> and expect it to work.
>
>> On 28 May 2016 at 8:51 PM, Darren Stevens wrote:
>>> You can see from this that the 4.7 kernel hangs right after the booting linux
>>> via __start(), whereas in the 4.4 there's about 29 lines of output before it
>>> gets to the Initialised io_base_virt printk in our patch.
> If the last thing you see is "booting linux via __start()" that means the kernel
> crashed early, before it could detect and initialise the console.
>
> Do you have a serial or other console in that machine at a known location? If so
> you can hard-code the kernel to use that console, which means you can get
> messages earlier in boot. See udbg_early_init() for starters.
>
> cheers
>
>
>
> Julian Margetson <runaway@candw.ms> writes:
>
>> Hi Christian,
>>
>> I am also having a problem with _PAGE_NO_CACHE on Sam460ex.
>>
>> Regards
>> Julian
>>
>> ï»¿drivers/gpu/drm/drm_vm.c: In function â€˜drm_dma_protâ€™:
>> drivers/gpu/drm/drm_vm.c:83:6: error: invalid operands to binary | 
>> (have â€˜pgprot_t {aka struct <anonymous>}â€™ and â€˜intâ€™)
>>     tmp |= _PAGE_NO_CACHE;
>>         ^
>> scripts/Makefile.build:289: recipe for target 
>> 'drivers/gpu/drm/drm_vm.o' failed
>> make[3]: *** [drivers/gpu/drm/drm_vm.o] Error 1
>> scripts/Makefile.build:440: recipe for target 'drivers/gpu/drm' failed
>> make[2]: *** [drivers/gpu/drm] Error 2
>> scripts/Makefile.build:440: recipe for target 'drivers/gpu' failed
>> make[1]: *** [drivers/gpu] Error 2
>> Makefile:985: recipe for target 'drivers' failed
>> make: *** [drivers] Error 2
>>
>>
> That is because that usage is wrong based on type. _PAGE_NO_CACHE is not
> of type pgprot_t. What you really need there is
>
> tmp = __pgprot(pgprot_val(tmp) | _PAGE_NO_CACHE);
>
> or a better option would be
>
> tmp = pgprot_noncached_wc(tmp);
>
> -aneesh
>
> @Julian
>
> What about the issues with the Sam460ex? Have you solved the problem 
> with the commit powerpc-4.7-1?
>
> Cheers,
>
> Christian
>
> On 04 June 2016 at 5:25 PM, Christian Zigotzky wrote:
>

tmp = pgprot_noncached_wc(tmp);

compiles but  I then run in to the following

  CC      drivers/gpu/drm/drm_scatter.o
drivers/gpu/drm/drm_scatter.c: In function â€˜drm_vmalloc_dmaâ€™:
drivers/gpu/drm/drm_scatter.c:44:49: error: invalid operands to binary | 
(have â€˜pgprot_t {aka struct <anonymous>}â€™ and â€˜intâ€™)
   return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL | _PAGE_NO_CACHE);
                                                  ^
drivers/gpu/drm/drm_scatter.c:48:1: warning: control reaches end of 
non-void function [-Wreturn-type]
  }
  ^
scripts/Makefile.build:289: recipe for target 
'drivers/gpu/drm/drm_scatter.o' failed
make[3]: *** [drivers/gpu/drm/drm_scatter.o] Error 1
scripts/Makefile.build:440: recipe for target 'drivers/gpu/drm' failed
make[2]: *** [drivers/gpu/drm] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/gpu' failed
make[1]: *** [drivers/gpu] Error 2
Makefile:985: recipe for target 'drivers' failed
make: *** [drivers] Error 2

Regards

Julian
