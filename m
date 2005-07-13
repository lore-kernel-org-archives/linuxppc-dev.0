Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C248B67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 07:27:20 +1000 (EST)
In-Reply-To: <20050713201022.69351.qmail@web61023.mail.yahoo.com>
References: <20050713201022.69351.qmail@web61023.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2c008f2a8b3ef3ba33ec3d0f8a5c3390@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Jul 2005 14:27:08 -0700
To: ming lei <mlei30@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 13, 2005, at 1:10 PM, ming lei wrote:

> Question: does the linux ever touch this section of
> page table(virt address from PAGE_OFFSET to
> PAGE_OFFSET+A) again? like remove or modify one of the
> entry?

Not usually.  We used to do it on 8xx for mapping
uncached pages for coherent DMA.

> Question: For every physical page, it should already
> be mapped in #1, but vmalloc maps it again to a virt
> address higher. Does it mean in kernel page table, we
> may have two PTE entries pointing to the same physical
> page, even their virt addresses are different?

Yep.

> Last question:
> If this is true, is this platform implemention
> specific? Does i386 implemention have same situation?

Other architectures will do the same, yes.  The
level to which they do this will vary depending upon
architectural features we have to hide/expose to
other functions.

One potential problem that arises is you have to be
careful about the virtual address access path to these
pages.  All processors will behave errantly if you
access the same physical page, but with different
attributes, through the different VAs.  How they behave
will depend upon the attributes.  If the PTEs have
different cache modes or page sizes, it's usually
a big problem.  If they just share different write
permissions, it's usually OK.  These problems usually
arise when device driver writers either don't understand
the mapping issues or try something that may work
on one architecture but not on another.


	-- Dan
