Return-Path: <cmurch@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 6C72D680F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 23:49:48 +1000 (EST)
Received: from ltnmail.xyplex.com (ltnmail.xyplex.com [140.179.176.25])
	by mailman.xyplex.com (8.9.3+Sun/8.9.3) with ESMTP id JAA11682
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 09:52:00 -0400 (EDT)
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A02FA2402@ltnmail.xyplex.com>
From: "Murch, Christopher" <cmurch@mrv.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 12 Sep 2005 09:47:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE: [PATCH] cpm_uart: Made non-console uart work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Our IMAP_ADDR is not a constant and is set according to which platform we
are running.  On our 885 platforms its 0xE0000000.  On our 857T platforms
its 0xFF000000.
CONSISTENT_START is 0xC8000000 and that was a guess on our part.
So it seems that our choices for these addresses may have contributed to the
issue we observed.

Is there work being done to remove the use of virt_to_bus() and
bus_to_virt() in the future?

Thanks for your help.
Chris
cmurch@mrv.com

-----Original Message-----
From: Pantelis Antoniou [mailto:pantelis.antoniou@gmail.com]
Sent: Friday, September 09, 2005 4:00 PM
To: linuxppc-embedded@ozlabs.org
Cc: Murch, Christopher
Subject: Re: [PATCH] cpm_uart: Made non-console uart work


On Friday 09 September 2005 22:21, Murch, Christopher wrote:
> We've recently applied the 2.6.13 patch.  We're running on an embedded
> platform using 3 of the cpm uart ports on an 8xx cpu.  After applying the
> 2.6.13 patch the non-console uarts no longer work.  Upon investigation, we
> have found that cpu2cpm_addr() is giving us invalid results for memory
> addresses derived from dma_alloc_coherent().  This causes the cpm to hang.
> We believe that the better approach would be to use the dma address
> supplied by the call to dma_alloc_coherent() instead of trying to convert
> using bus_to_virt() and virt_to_bus().  We believe this is the approach
> taken by other drivers in the 2.6 kernel.  Any comments?
> Thanks for your help.
>

Yes, it would be proper. This is a temporary hack.

What is the IMAP_ADDR value?

And where is the consistent pool located at your board?

> -Chris
> cmurch@mrv.com

Regards

Pantelis
