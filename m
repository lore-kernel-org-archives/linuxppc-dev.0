Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C63C52BDB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 14:39:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jonathan@jonmasters.org
In-Reply-To: <35fb2e590410011454270f2698@mail.gmail.com>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<1096602008.14803.16.camel@gaston> <415D3C2C.7050704@jonmasters.org>
	<35fb2e590410011454270f2698@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1096691732.11996.6.camel@gaston>
Mime-Version: 1.0
Date: Sat, 02 Oct 2004 14:35:32 +1000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> 
> ppc64 head.S and startup looks quite fun. After jumping through a few
> hoops you eventually end up in prom_init and start setting up the OF
> device-tree (btw it looks like at least one call to prom_panic doesn't
> relocate the string it wants to print to real memory - is this what
> the comments are referring to out of sheer interest?). I am assuming
> that you always expect to see an Open Firmware on ppc64 and simply use
> bi_recs to pass accross additional information from the bootloader,
> but I've only had a cursory look on the train on the way home from
> work this evening so please be gentle.
> 
> I'll give this a go through over the weekend and figure out how to get
> this hooked in to the ppc32 tree.

bi_recs have been removed completely from ppc64. head.S explains
how the entry is done. You can enter the kernel with r5=NULL if
you provide the flattened device-tree in r3. prom_init does just
that in fact (re-enters the kernel with that setup).

Ben.
 
