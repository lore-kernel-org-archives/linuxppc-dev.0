Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3949A679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 15:27:29 +1000 (EST)
In-Reply-To: <20050506200338.GC14486@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <50058b517f42f09720e6c8086bf294e0@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 01:27:17 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
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



The last patch I just sent isn't quite sufficient.  We still have
to fix this:

On May 6, 2005, at 4:03 PM, Marcelo Tosatti wrote:

>         /* get the PTE for the bootpage */
>         if (!get_pteptr(&init_mm, bootpage, &pte))
>                panic("get_pteptr failed\n");
>
>         /* and make it uncachable */
>         pte_val(*pte) |= _PAGE_NO_CACHE;
>         _tlbie(bootpage);


One of things that was corrected in linuxppc-2.4, that never made
if forward.  I did a late consistent_alloc() on the first call to
hostmem_alloc().  I'm looking for a similar solution in 2.6.

Thanks.


	-- Dan
