Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E9ABDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 21:58:28 +1000 (EST)
Date: Mon, 6 Aug 2007 13:58:04 +0200
From: Olaf Hering <olh@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit
	DMA	mapping"
Message-ID: <20070806115804.GA1734@suse.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46B5824B.1000103@s5r6.in-berlin.de>
Cc: Robert Hancock <hancockr@shaw.ca>, stable@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 05, Stefan Richter wrote:

> Benjamin Herrenschmidt wrote:
> >>> If setting 32-bit DMA mask fails on ppc64, that sounds like a problem
> >>> with the DMA implementation on that architecture. There are enough cards
> >>> out there that only support 32-bit DMA that this really needs to work..
> >> Yes, could the PPC folks please have a look at it?  Thanks.
> > 
> > Smells like we may have a bug there. No worries though, all current PPC
> > machines have an iommu that will not give out addresses above 32 bits
> > anyway, but I'll double check what's up.
> > 
> > Do you see something in dmesg when that happens ?
> 
> There was nothing in Olaf's report, except for trouble in sbp2 _after_
> the failure.  http://lkml.org/lkml/2007/8/1/344  (I don't have a PMac.)

sbp2util_remove_command_orb_pool() does not check for lu->hi being NULL.

dev->dma_mask is NULL too, thats why dma_direct_dma_supported() returns
false, and dma_set_mask() will return -EIO.
