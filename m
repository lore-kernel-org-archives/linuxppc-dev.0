Return-Path: <hollisb@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 150F9DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 16:38:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L6csSO031011
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 02:38:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8L6csYx495484
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 00:38:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8L6cslV030880
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 00:38:54 -0600
Subject: Re: 44x bug: funny TLB writes?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070921054218.GA13470@localhost.localdomain>
References: <1190345652.25483.6.camel@basalt>
	<20070921054218.GA13470@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 01:38:34 -0500
Message-Id: <1190356714.25483.19.camel@basalt>
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

Just a quick fix would be fine too... ;)

I'm just glad it's not a KVM bug, because when I dumped the TLB state
and saw bizarre values I was getting really worried.

> PS.  "errant" and "error" are not cognate, even if the chip doc
> writers think so...

According to Merriam Webster, errant 2c is "c : behaving wrongly <an
errant child>", so I'm OK with it.

-- 
Hollis Blanchard
IBM Linux Technology Center
