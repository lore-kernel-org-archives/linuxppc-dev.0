Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72ED067D11
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 22:12:23 +1100 (EST)
In-Reply-To: <1162890963.28571.465.camel@localhost.localdomain>
References: <20061107072126.C586067CD6@ozlabs.org>
	<93F89F52-7ED9-48F3-AE7A-15CDF5AB8E25@kernel.crashing.org>
	<1162888963.28571.459.camel@localhost.localdomain>
	<3210FBE5-5F22-4759-A728-A98175A435D6@kernel.crashing.org>
	<1162890963.28571.465.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <681D17CC-F4F3-4119-81CF-5FA8837226D3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 6/7] MPIC MSI backend
Date: Tue, 7 Nov 2006 12:12:05 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Not only, even with the current code... basically keep the
> sense/polarity flags of the LSI intact in the irq_desc, just add the
> IRQF_MSI bit to "override" them when we configure the interrupt to  
> be an
> MSI. Then, irq_chip->startup() instead of set_irq_type() does the  
> actual
> configuration of the MPIC and, seeing the IRQF_MSI flags, does the  
> right
> thing.
>
> That way, when restoring the IRQ back to LSI, we just clear  
> IRQF_MSI and
> the old sense/polarity settings will still be there in the descriptor
> and MPIC will do the right thing on the next startup().

Cute trick, and not MPIC (or even PowerPC) specific either :-)

> Are you sure about that ?

Yes.  "Legacy PCI" INTx interrupts are send as "virtual wire"
interrupts over PCIe; Attu asserts interrupt #3 on Kodiak's
MPIC if any of INTA..INTD is hot (I have no idea how to
distinguish between those four, though -- and that seems to be
pretty important, heh).

> In this case, we need a special kludge for
> now. I though the MSI stuff could override any of the MPIC vectors,  
> but
> you might well be right there, it might not work with the U4 internal
> ones.

U4 interrupts 0..7 from HT (or PCIe) are not decoded on U4;
0..3 on U3 (which supports MSI-via-HT just fine).

> Yes, I know :-) We need specific code to discover that a device is
> hanging off the Attu instead of HT. I already explained it all to
> Michael, it shouldn't be too hard. I even have a card setup to test  
> it,
> just didn't have time to do it just yet.

I never tested Attu interrupts at all (just the MSI write
port), glad _someone_ is testing it :-)


Segher
