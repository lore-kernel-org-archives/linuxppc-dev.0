Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DAA767A6F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 09:09:13 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
In-Reply-To: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D634E@caribou.pc.tundra.com>
References: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D634E@caribou.pc.tundra.com>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 09:08:58 +1000
Message-Id: <1149635338.27572.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-06 at 10:45 -0400, Alexandre Bounine wrote:

> We have a level-signalled irq from the cascaded PCI interrupt controller. If I do EOI at 
> this time, level request will not have chance to be cleared (unless all PCI interrupts have
> an SA_INTERRUPT flag) and result in recurring interrupts. 

Hrm... Ok, when the cascade is a 8259 or an MPIC, we don't have that
problem despite the output also being level... I think that's because
the cascade handler itself will mask the cascade interrupt (on MPIC,
reading the irq does an ack which will mask that priority level). If
your cascaded controller doesn't act this way, you may need something a
bit different in your cascade handler rather than changing mpic.

However, I wouldn't bother too much. As I said, this is all changing a
lot at the moment as I'm porting powerpc to Ingo Molnar and Thomas
Gleixner's new "genirq" layer. Cascade handling will be different and
taken out of MPIC, so you'll be able to implement it the way your want
(with much greater control on what happens) without changing the MPIC
driver.

I'll have patches posted on the list in a few days hopefully.

> I chose to have an individual flag instead of checking model ID to avoid multiple checks within ISR
> (in case if we have more that one mpic version requiring this option). I also expect that it may be
> useful for any external level-signalling cascades connected to MPIC.      

As I said above, I think it can just go away with the port to genirq.

> Motivation is the same as above - I just do not want to have multiple ID checks here. I agree that it is
> driven by mpic type (model ID) only. I can remove this one if you do not expect any
> new "broken" MPICs on horizon.  

Well, I do expect broken ones but not with that specific issue :)

Cheers,
Ben.
