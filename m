Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id C51D12BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 02:43:30 +1000 (EST)
Date: Tue, 28 Sep 2004 09:43:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
Message-ID: <20040928094327.B1532@home.com>
References: <20040928064442.A31883@home.com>
	<Pine.LNX.4.21.0409281735560.6394-100000@aqua.aspd.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0409281735560.6394-100000@aqua.aspd.pwr.wroc.pl>;
	from peri@aqua.aspd.pwr.wroc.pl on Tue, Sep 28, 2004 at
	05:47:57PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 05:47:57PM +0200, Piotr Perak wrote:
> On Tue, 28 Sep 2004, Matt Porter wrote:
> > Hrm, I see. Did your firmware change between your working 2.4 kernel
> > and your non-working 2.6 kernel?  If you're failing in there that would
> > be my first thought. I suppose that's probably not that case though.
> 
> 2.4.23 still runs on board I try to port 2.6.8.1 to. So I guess firmware
> is not the problem?

In that case, it shouldn't be.
 
> > then you're an interesting spot.  Can you trace it down to the exact
> > failure in __alloc_bootmem_core?
> I already did it. Can you please read
> http://ozlabs.org/pipermail/linuxppc-dev/2004-September/000104.html? I
> described there what weird things are happening in __alloc_bootmem_core.

I see. Can you move the reset instruction to isolate the offending
instruction? 
 
BTW, it's not clear how you are guaranteeing that the processor has
bit 2 or 3 asserted before the dbcr0 load. If you preloaded r12 out of
the scope of the code fragments shown, it's clear that r12 is getting
clobbered in the subf instruction of the 2.6.8.1 fragment.

Is this a hobby project or a "for profit" project? If it's for profit,
then consider investing in a JTAG emulator (like BDI2000)...it'll pay
for itself many times over.

-Matt
