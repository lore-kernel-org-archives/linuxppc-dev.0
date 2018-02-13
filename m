Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgQNk2DNDzF0t2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 12:45:50 +1100 (AEDT)
Date: Tue, 13 Feb 2018 02:45:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Message-ID: <20180213014546.GB3303@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 10:52:46PM +0200, Meelis Roos wrote:
> I tested 4.16-rc1 on my PowerMac G4 and got the following warning from 
> macio pata driver. Since pata-macio has no recent changes, dma-mapping.h 
> changes seem to be related.

Thje are, as they add just that warning.  But the root cause looks
older, and that is that the macio bus doesn't seem to to set the
dma coherent mask, which could cause all kinds of hidden issues.

I'm travelling right now, but unless someone beats me to it I'll look
into a patch to properly set the coherent mask ASAP.
