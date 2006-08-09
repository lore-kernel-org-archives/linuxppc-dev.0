Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BF0C67BE5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 22:35:34 +1000 (EST)
Subject: Re: [PATCH] SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20060805124544.GB23494@lst.de>
References: <20060804055323.1A9BE679FB@ozlabs.org>
	<20060805124544.GB23494@lst.de>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 13:22:59 +0200
Message-Id: <1155122580.4040.96.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org, anton@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-08-05 at 14:45 +0200, Christoph Hellwig wrote:
> On Fri, Aug 04, 2006 at 03:53:19PM +1000, Michael Neuling wrote:
> > This adds a shadow buffer for the SLBs and regsiters it with PHYP.
> > Only the bolted SLB entries (first 3) are saved.
> 
> What is a SLB shadow buffer and why do we need it?  (I don't want to
> question the patch but rather learn a little more about lowlevel ppc64
> mmu details)

Yeah, same question :) I don't have my PAPR at hand and I'm still
travellling but I'm curious about that one... 

I would suspect it allows the HV to save/restore SLBs when sharing a
processor between partitions but then... the kernel requires that anyway
so either the current code is bogus and that's pretty bad (which I don't
think so) or maybe the fact that we didn't register the shadow caused HV
to always save/restore the entire SLB, while by using the shadow, we let
it save/restore only the bolted entries we put in there (and just
re-fault the other ones). If it's not that, then what ? :)

Ben.
