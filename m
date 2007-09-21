Return-Path: <hollisb@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 984E1DDEB7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 03:38:01 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8LHbv4n031470
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:37:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8LHbv0M512820
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:37:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8LHbu02001497
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:37:56 -0400
Subject: Re: 44x bug: funny TLB writes?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070921054218.GA13470@localhost.localdomain>
References: <1190345652.25483.6.camel@basalt>
	<20070921054218.GA13470@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 12:37:36 -0500
Message-Id: <1190396256.13762.3.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-09-21 at 15:42 +1000, David Gibson wrote:
> On Thu, Sep 20, 2007 at 10:34:12PM -0500, Hollis Blanchard wrote:
> > I seem to have come across a strange bug while doing KVM development. It
> > seems that the final tlbwe in finish_tlb (head_44x.S) is actually
> > leaking RPN bits into the "attribute" word.
> > 
> > When I set a breakpoint there and press enter on the serial console, I
> > see r12=ef600703, which is the physical address of the UART on this chip
> > (440EP), plus the correct permission bits at the bottom.
> > 
> > Am I crazy? I'm not really looking to step through that assembly right
> > now... Clearly (current) hardware is just ignoring these errant writes,
> > but it should be fixed.
> 
> A quick glance at the code suggests this is indeed wrong.  Hurrah.
> Another reason to rewrite the 44x tlb miss handling.

Actually it's slightly worse than I thought. Not only are we setting "0"
bits in the TLB word, I'm also seeing mappings like this:

pid      word0    word1    word2
00000001 7fe4f210 00209000 00200349

That means WIMG=0011, which seems inappropriate for userspace mappings.
(Oh and we're also writing to the only reserved bit in word2.)

-- 
Hollis Blanchard
IBM Linux Technology Center
