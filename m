Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D1F3FDDFAC
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:07:37 +1000 (EST)
Date: Sun, 27 Jul 2008 18:07:36 -0700 (PDT)
Message-Id: <20080727.180736.74131389.davem@davemloft.net>
To: marcel@holtmann.org
Subject: Re: mISDN still breaking the allmodconfig build...
From: David Miller <davem@davemloft.net>
In-Reply-To: <93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 28 Jul 2008 03:03:04 +0200

> > More fallout from the premature mISDN driver merge:
> >
> > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not  
> > running on big endian machines now"
> 
> is that only the HFC driver or the whole mISDN stack?
> 
> I know that the two old ISDN stacks where really bad on big endian,  
> but my assumption was that we did sort this out in the end.

One of the two mISDN drivers uses the deprecated virt_to_bus()
interface for handling DMA addresses (that doesn't even work on many
x86 systems these days) and the other mISDN driver gives the above
big-endian compile time error.

In short, this driver was not ready for merging at all.
