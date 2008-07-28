Return-Path: <kkeil@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13CECDDF29
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 20:26:37 +1000 (EST)
Date: Mon, 28 Jul 2008 12:26:29 +0200
From: Karsten Keil <kkeil@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: mISDN still breaking the allmodconfig build...
Message-ID: <20080728102629.GA25509@pingi.kke.suse.de>
References: <20080727.170235.97056809.davem@davemloft.net>
	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
	<20080727.180736.74131389.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080727.180736.74131389.davem@davemloft.net>
Cc: sfr@canb.auug.org.au, marcel@holtmann.org, linux-kernel@vger.kernel.org,
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

On Sun, Jul 27, 2008 at 06:07:36PM -0700, David Miller wrote:
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

OK this was forgotten to change in a printk from the old driver, the new allocation
code should be OK it use pci_alloc_consistent().
I think it should simple use the returned dmahandle in this printk.

-- 
Karsten Keil
SuSE Labs
ISDN and VOIP development
SUSE LINUX Products GmbH, Maxfeldstr.5 90409 Nuernberg, GF: Markus Rex, HRB 16746 (AG Nuernberg)
