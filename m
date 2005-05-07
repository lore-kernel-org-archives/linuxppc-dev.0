Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFA6A679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 15:56:04 +1000 (EST)
In-Reply-To: <50058b517f42f09720e6c8086bf294e0@embeddededge.com>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<50058b517f42f09720e6c8086bf294e0@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3f2c550d3f7f5028c8e687d6b9b8f794@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 01:55:24 -0400
To: Dan Malek <dan@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On May 6, 2005, at 4:03 PM, Marcelo Tosatti wrote:
>
>>         /* get the PTE for the bootpage */
>>         if (!get_pteptr(&init_mm, bootpage, &pte))
>>                panic("get_pteptr failed\n");
>>
>>         /* and make it uncachable */
>>         pte_val(*pte) |= _PAGE_NO_CACHE;
>>         _tlbie(bootpage);

Can someone explain to me why this was necessary,
along with the weird hacks in the serial driver to
hostmem_alloc() if we are using the console and
dma_alloc_consistent() if we aren't?


This bootmem page stuff should not be necessary,
the cpm_reset() doesn't need to allocate the host
buffer, and it should be done the first time hostmem_alloc()
is called.

I don't have an 8xx handy.  Can someone remove all of this:

         /* get the PTE for the bootpage */
         if (!get_pteptr(&init_mm, bootpage, &pte))
                panic("get_pteptr failed\n");


         /* and make it uncachable */
         pte_val(*pte) |= _PAGE_NO_CACHE;
         _tlbie(bootpage);

         host_buffer = bootpage;
         host_end = host_buffer + PAGE_SIZE;


from arch/ppc/8xx_io/commproc.c and let me know
if the system still works?

Thanks.


	-- Dan
