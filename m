Return-Path: <Bruce_Leonard@selinc.com>
Received: from valiant.selinc.com (valiant.selinc.com [74.117.214.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qqBPw0XKDzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 03:11:47 +1000 (AEST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
 by valiant.selinc.com (8.16.0.11/8.16.0.11) with ESMTP id u3JHBkZq012666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 10:11:46 -0700
In-Reply-To: <1461055540.2801.10.camel@au1.ibm.com>
References: <OFDB971D2B.A484FAC0-ON88257F99.0075C134-88257F99.00786154@selinc.com>
 <1461055540.2801.10.camel@au1.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Re: Trouble with DMA on PPC linux question
Message-ID: <OF1B7D552A.E30361EF-ON88257F9A.005E3646-88257F9A.005E7647@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 19 Apr 2016 10:11:45 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Benjamin Herrenschmidt <benh@au1.ibm.com> wrote on 04/19/2016 01:45:40 AM:

> From: Benjamin Herrenschmidt <benh@au1.ibm.com>
> To: Bruce_Leonard@selinc.com, linuxppc-dev@lists.ozlabs.org
> Date: 04/19/2016 01:46 AM
> Subject: Re: Trouble with DMA on PPC linux question
> 
> On Mon, 2016-04-18 at 14:54 -0700, Bruce_Leonard@selinc.com wrote:
> > 
> > On the DMA transactions that work, the virtual address I hand to 
> > dma_map_single() is something like 0xe0840000 and the dma_addr_t 
result is 
> > 0x10840000 which is less than my 512Mb limit.  On the transactions 
that 
> > don't work, the virtual address is 0xd5390000 with the mapped result 
being 
> > 0x25390000, which is past my upper bound on my RAM.  In fact it's not 
even 
> > in my memory map, there's a hole there. 
> 
> Where does this virtual address come from ?
> 
> The kernel has two types of virtual addresses. Those coming from the
> linear mapping (the stuff you get from kmalloc() for example, or
> get_pages()) which can be translated using that simple substraction.
> 
> The other is the vmalloc space, and that is a non-linear mapping of
> random pages.
> 
> If your vaddr comes from the latter it can't be passed to
> dma_map_single as-is, you need to get to the underlying pages first.
> 
> Ben.
> 

That's a good question.  I'm not sure where the addresses come from right 
now (they're handed to me from the MTD layer), but I'll certainly dig into 
that and see.

Thanks for the help!  I appreciate the pointer.

Bruce
