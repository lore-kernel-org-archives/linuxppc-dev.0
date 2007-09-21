Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06780DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 15:42:54 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8L5gsrS005076
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 15:42:54 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8L5kRj2235796
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 15:46:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8L5fNR5014378
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 15:41:23 +1000
Date: Fri, 21 Sep 2007 15:42:18 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: 44x bug: funny TLB writes?
Message-ID: <20070921054218.GA13470@localhost.localdomain>
References: <1190345652.25483.6.camel@basalt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1190345652.25483.6.camel@basalt>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 10:34:12PM -0500, Hollis Blanchard wrote:
> I seem to have come across a strange bug while doing KVM development. It
> seems that the final tlbwe in finish_tlb (head_44x.S) is actually
> leaking RPN bits into the "attribute" word.
> 
> When I set a breakpoint there and press enter on the serial console, I
> see r12=ef600703, which is the physical address of the UART on this chip
> (440EP), plus the correct permission bits at the bottom.
> 
> Am I crazy? I'm not really looking to step through that assembly right
> now... Clearly (current) hardware is just ignoring these errant writes,
> but it should be fixed.

A quick glance at the code suggests this is indeed wrong.  Hurrah.
Another reason to rewrite the 44x tlb miss handling.

PS.  "errant" and "error" are not cognate, even if the chip doc
writers think so...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
