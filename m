Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDXNt6TwQzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 20:54:54 +1000 (AEST)
Subject: PAGE_GUARDED
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
Date: Tue, 24 May 2016 12:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <1463990507.3078.16.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Thanks for the hint. I'm sorry I don't know how pgprot_noncached() works.

I tried:

1) range.size, pgprot_noncached()

2) range.size, pgprot_val(pgprot_noncached(__pgprot(0))));

3) range.size, pgprot_val(pgprot_noncached_wc(__pgprot(0))));

Unfortunately without any success.

I'd like to modify the following code for the ATi SB600 southbridge chipset:

/* Workaround for lack of device tree */
                        if (primary) {
                                __ioremap_at(range.cpu_addr, (void 
*)ISA_IO_BASE,
                                range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
                                hose->io_base_virt = (void *)_IO_BASE;
                                printk("Initialised io_base_virt 0x%lx 
_IO_BASE 0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long 
long)_IO_BASE);
                     }

This workaround works with the kernel 4.6 final. After the commit 
powerpc-4.7-1, the computer doesn't boot anymore.

Last message in the CFE firmware:

Booting Linux via __start()...

Cheers,

Christian


On 23 May 2016 at 10:01 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2016-05-23 at 06:38 +0200, Christian Zigotzky wrote:
>> Hi All,
>>
>> You removed PAGE_GUARDED in the commit
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
>> t/?id=c04a5880299eab3da8c10547db96ea9cdffd44a6
>>
>> We use
>>
>> range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
>>
>> This doesn't work anymore. What can we use instead?
> You should just use pgprot_noncached()
>
> Cheers,
> Ben.
>
>
