Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A7F0679F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 14:39:16 +1000 (EST)
In-Reply-To: <20050506230523.GA15908@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6f231f4afce0886929ca99426a86b47a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 00:39:02 -0400
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


On May 6, 2005, at 7:05 PM, Marcelo Tosatti wrote:

> Do you have any practical example which you are certain is going
> to break?

Not at the moment, but that doesn't mean we shouldn't maintain
consistency for anyone that wants to do so.

> I dont remember any, and I dont think any software should be walking
> kernel pte's directly...

Anyone can call get_pteptr and should get the proper information.

> It is not possible to have the 8Mbyte pinned TLB and 4kb pagetables
> mapping the same kernel virtual addresses.

I know, but we don't do that.  Like I said, if the 8M pinned entry is
in the TLB, we don't get exceptions for this space and we don't look
up PTEs and replace them.

> You can't have both a 4kb page and a 8Mbyte page mapping the virtual
> address KERNELBASE + 0.
>
> Do you agree?

Yes, but that isn't what we are doing.  We can have the 8M page
mapping virtual address 0xc0000000 to 0x0000000, and also another
4k page, at say 0xd0000000 map the same 0x00000000 physical page.
There are many circumstances when we have a kernel VM address
and a user VM address map the same physical page.  This is also
what we do to get uncached VM addresses for DMA.

> Right - I'm talking about kernel virtual addresses: in this specific 
> case,
> we can't have more than one mapping for the first page at KERNELBASE.

You can't do that in any case for anything, and I'm confused why you
keep mentioning this :-)

> So you do agree that pte's should not be created for the first
> 8MBytes if CONFIG_PIN_TLB is set? :)

NO.  Just leave that code alone.  I don't understand why you think
doing this will have any effect on the system operation.  If you are
able to run a system without creating these tables, then the pinned
TLBs must be working.  If pinned TLBs weren't working, the kernel
would crash.

Thanks.


	-- Dan
