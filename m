Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3F57DDF07
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 20:51:15 +1000 (EST)
Subject: Re: mISDN still breaking the allmodconfig build...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 20:50:53 +1000
Message-Id: <1217242253.11188.197.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-28 at 03:03 +0200, Marcel Holtmann wrote:
> Hi Dave,
> 
> > More fallout from the premature mISDN driver merge:
> >
> > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not  
> > running on big endian machines now"
> 
> is that only the HFC driver or the whole mISDN stack?
> 
> I know that the two old ISDN stacks where really bad on big endian,  
> but my assumption was that we did sort this out in the end.

Well, I got it working well enough (the old one) on a ppc405 about 5 or
6 years ago... It did require some endian & dma mapping fixing, iirc, in
the hisax pci driver, but nothing very tricky.

What bugs me is that we -fixed- at least some of these things in the old
stack, up to the point where I could use it reliably in some commercial
products, and now we are merging a new stack which, in that area, is a
clear regression over the old code.

One basic premise to me for replacing a whole stack with a new one is
that the new one should be -at-least- as good as the old one in all
areas, and those (virt_to_bus and endianness) are pretty major.

Ben.
