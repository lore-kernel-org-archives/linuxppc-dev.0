Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNGX73XGMzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 10:57:59 +1000 (AEST)
Message-ID: <1465174679.12265.4.camel@ellerman.id.au>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 darren@stevens-zone.net, Michael Ellerman <michaele@au1.ibm.com>, Julian
 Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 rtd@a-eon.com, rtd2@xtra.co.nz,  pjwall@mac.com, pjwall@me.com,
 matthew@a-eon.biz, intermediadc@hotmail.com,  contact@a-eon.com,
 info@xenosoft.de
Date: Mon, 06 Jun 2016 10:57:59 +1000
In-Reply-To: <053dd416-a9ab-5b06-5c3b-1acefb53fd3b@xenosoft.de>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-06-05 at 18:09 +0200, Christian Zigotzky wrote:

> All,
> 
> I need an answer because I think Darren's guess is correct. It isn't a 
> problem in the pci code. I replaced the file head_64.S that Darren 
> mentioned with the one from the kernel 4.6 and it compiled but 
> unfortunately it doesn't boot. We know "head_64.S" is one file for the 
> early boot phase but I think there are some other files.

There's lots of files used in the early boot, you can't revert individual files
and expect it to work.

> On 28 May 2016 at 8:51 PM, Darren Stevens wrote:
> > You can see from this that the 4.7 kernel hangs right after the booting linux
> > via __start(), whereas in the 4.4 there's about 29 lines of output before it
> > gets to the Initialised io_base_virt printk in our patch.

If the last thing you see is "booting linux via __start()" that means the kernel
crashed early, before it could detect and initialise the console.

Do you have a serial or other console in that machine at a known location? If so
you can hard-code the kernel to use that console, which means you can get
messages earlier in boot. See udbg_early_init() for starters.

cheers
