Return-Path: <mikpe@it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 092B4DDFAA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:58:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18573.10107.853761.684410@harpo.it.uu.se>
Date: Mon, 28 Jul 2008 03:57:15 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: David Miller <davem@davemloft.net>
Subject: Re: mISDN still breaking the allmodconfig build...
In-Reply-To: <20080727.180736.74131389.davem@davemloft.net>
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
	<20080727.180736.74131389.davem@davemloft.net>
Cc: sfr@canb.auug.org.au, kkeil@suse.de, marcel@holtmann.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:
 > From: Marcel Holtmann <marcel@holtmann.org>
 > Date: Mon, 28 Jul 2008 03:03:04 +0200
 > 
 > > > More fallout from the premature mISDN driver merge:
 > > >
 > > > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not  
 > > > running on big endian machines now"
 > > 
 > > is that only the HFC driver or the whole mISDN stack?
 > > 
 > > I know that the two old ISDN stacks where really bad on big endian,  
 > > but my assumption was that we did sort this out in the end.
 > 
 > One of the two mISDN drivers uses the deprecated virt_to_bus()
 > interface for handling DMA addresses (that doesn't even work on many
 > x86 systems these days) and the other mISDN driver gives the above
 > big-endian compile time error.
 > 
 > In short, this driver was not ready for merging at all.

Why on earth does a generic (I hope) protocol driver (some ISDN
thingy in this case) care about endianess at all?

Or has things come to a "the world's an x86" ("the world's a VAX" for
old-timers but add 25+ years or so) situation where the majority of
coders don't even consider that machines might be different from what
they use? If so, a deep sigh of sadness.

(Not that I prefer a particular endianess. My point being that coders
shouldn't make endianess assumptions unless they're really^3 important.)>
