Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzCC5HrBzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:46:47 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 19 Apr 2016 18:46:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7DAB03578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:46:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J8kYlG7274974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:46:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J8k6wT028349
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:46:06 +1000
Message-ID: <1461055540.2801.10.camel@au1.ibm.com>
Subject: Re: Trouble with DMA on PPC linux question
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Bruce_Leonard@selinc.com, linuxppc-dev@lists.ozlabs.org
Date: Tue, 19 Apr 2016 18:45:40 +1000
In-Reply-To: <OFDB971D2B.A484FAC0-ON88257F99.0075C134-88257F99.00786154@selinc.com>
References: <OFDB971D2B.A484FAC0-ON88257F99.0075C134-88257F99.00786154@selinc.com>
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

On Mon, 2016-04-18 at 14:54 -0700, Bruce_Leonard@selinc.com wrote:
> 
> On the DMA transactions that work, the virtual address I hand to 
> dma_map_single() is something like 0xe0840000 and the dma_addr_t result is 
> 0x10840000 which is less than my 512Mb limit.  On the transactions that 
> don't work, the virtual address is 0xd5390000 with the mapped result being 
> 0x25390000, which is past my upper bound on my RAM.  In fact it's not even 
> in my memory map, there's a hole there. 

Where does this virtual address come from ?

The kernel has two types of virtual addresses. Those coming from the
linear mapping (the stuff you get from kmalloc() for example, or
get_pages()) which can be translated using that simple substraction.

The other is the vmalloc space, and that is a non-linear mapping of
random pages.

If your vaddr comes from the latter it can't be passed to
dma_map_single as-is, you need to get to the underlying pages first.

Ben.
