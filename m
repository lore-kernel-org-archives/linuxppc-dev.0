Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0EB79DDEBD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:32:16 +1000 (EST)
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce
	32bit	DMA	mapping"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Hancock <hancockr@shaw.ca>
In-Reply-To: <46B79FD7.9020801@shaw.ca>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
	<46B79F25.50205@s5r6.in-berlin.de>  <46B79FD7.9020801@shaw.ca>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 08:32:09 +1000
Message-Id: <1186439529.938.95.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-08-06 at 16:25 -0600, Robert Hancock wrote:
> > Anyway.  For now I will simply go with what 2.6.23-rc has and what
> > 2.6.21 had:  No dma_set_mask anywhere in the 1394 subsystem.  We can
> > revisit this whenever an actual need arises.
> 
> Not sure this is a very good idea. This seems rather likely to fail on
> x86_64 machines with >4GB of RAM for example.. 

Would it ? Isn't the default DMA mask for PCI devices set to 32 bits
anyway ? In which case, swiotlb will take care of the matter.

Cheers,
Ben.
