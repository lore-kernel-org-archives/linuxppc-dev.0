Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 210F0DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 07:47:37 +1000 (EST)
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit
	DMA	mapping"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20070806135124.GA2900@suse.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 07:47:28 +1000
Message-Id: <1186436848.938.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	Stefan Richter <stefanr@s5r6.in-berlin.de>, stable@kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-08-06 at 15:51 +0200, Olaf Hering wrote:
> On Mon, Aug 06, Benjamin Herrenschmidt wrote:
> 
> > BTW. Any reason why you don't set the DMA mask in the ohci driver rather
> > than the sbp2 one ?
> 
> I used this patch, and the attached CD was found.
> What dma mask should be used in ohci_probe()?

Allright. So I see two problems here:

 - in the code that powerpc uses to generate the PCI tree based on the
open firmware device-tree (instead of probing the bus), we don't set the
dma mask to the default ffffffff.

 - our implementation of dma_supported() incorrectly tests against the
-previous- dma mask instead of the one we pass in as an argument.

I'll send a patch later today for you guys to test.

In addition, make sure that ieee1394 properly uses the parent PCI dev
and not some other intermediary struct device for the dma mask. Oh and,
don't do the set_dma_mask() in sbp2, it has nothing to do there. It
should be in the ohci1394 driver.

Cheers,
Ben.
