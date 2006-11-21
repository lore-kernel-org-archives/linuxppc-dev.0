Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D806167E51
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 18:20:00 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAL7JtUR002653
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 16:19:55 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAL7JudX020584
	for linuxppc-dev@ozlabs.org; Tue, 21 Nov 2006 16:19:56 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAL7JtnZ010027
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 16:19:55 +0900 (JST)
Message-Id: <200611210719.kAL7JsJR006985@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 21 Nov 2006 16:22:44 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: (Your message of "Thu, 16 Nov 2006 22:32:03 +1100")
	<1163676724.5940.378.camel@localhost.localdomain>
References: <200611160939.kAG9dqre027595@toshiba.co.jp>
	<1163676724.5940.378.camel@localhost.localdomain>
Subject: Re: [PATCH 11/16] PATA driver
	for Celleb
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> We use the PRD transfer end read function on SCC IDE controller
>> to handle this issue.
>> This function guarantees that issue of DMA End interrupt and
>> setting the interrupt bit of status register are done after 
>> the outstanding write data to memory was pushed. Pushing is 
>> implemented by the dummy read of IDE controller, which reads 
>> the same path as the path of the write data. 
>> Therefore this function is same as the flush of outstanding DMAs.
>> To use this function, we specify the PRD table address(dmatable_dma) 
>> in PRD Transfer End Read Base Address Register(dma_base + 0x018) as
>> the path. Of course it also requires to set a strong order in 
>> the IOIF space.
>
>I haven't seem the dummy read in your code.. where is it ?

The dummy read of this function is done autonomously by IDE controller
when memory write was performed. It differs from the dummy read function
in PCI module.
Therefore the corresponding code does not exist.

>
>> > - Regarding PCI and PCIe on SCC, I didn't see any code in your PCI
>> >support code for handling that issue. Is it fixed ? If not, then I
>> >suppose you'll have problem with most PCI device/drivers on the field as
>> >they do rely on such ordering to be provided. There was also an issue
>> >with prefetch on PCI, for which I currently disable the prefetch in the
>> >workarounds for the cell blade. I don't know if you handle that at all
>> >neither.
>> 
>> We've noticed the problem you mentioned, and been developing the support
>> for dummy read(please refer to previous comments for IDE) and etc. to solve
>> the problem, but we haven't finished yet.  We also currently  disable the
>> prefetch by initial setup of SCC.  We are trying now so that we can post
>> the fixed driver code in next patch.
>
>Ok. Can you confirm that the prefetch disable is the same was what I'm
>doing for Spider ? (see my patch about IO workarounds posted last week).
>
>The patch I posted handles both the dummy read and the prefetch disable.
>I've added a mecanism to hook on all MMIO accesses to make that
>possible. You may want to do something very similar.

We read your IO workaroud patch for spider. The method for disabling prefetch
is same as we suppose. And the method for dummy read may be available, 
or be a good reference for us.
We found a mistake in our patch at disabling prefetch. We set the prefetch
enable bit wrongly.  We'll correct it in the next patch.


Best regards,
Akira Iguchi
Toshiba
