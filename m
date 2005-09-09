Return-Path: <cmurch@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 64FA6681D1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 05:32:24 +1000 (EST)
Received: from ltnmail.xyplex.com (ltnmail.xyplex.com [140.179.176.25])
	by mailman.xyplex.com (8.9.3+Sun/8.9.3) with ESMTP id PAA20607
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Sep 2005 15:25:49 -0400 (EDT)
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A02FA20CD@ltnmail.xyplex.com>
From: "Murch, Christopher" <cmurch@mrv.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 9 Sep 2005 15:21:10 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [PATCH] cpm_uart: Made non-console uart work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We've recently applied the 2.6.13 patch.  We're running on an embedded
platform using 3 of the cpm uart ports on an 8xx cpu.  After applying the
2.6.13 patch the non-console uarts no longer work.  Upon investigation, we
have found that cpu2cpm_addr() is giving us invalid results for memory
addresses derived from dma_alloc_coherent().  This causes the cpm to hang.
We believe that the better approach would be to use the dma address supplied
by the call to dma_alloc_coherent() instead of trying to convert using
bus_to_virt() and virt_to_bus().  We believe this is the approach taken by
other drivers in the 2.6 kernel.  Any comments?
Thanks for your help.

-Chris
cmurch@mrv.com
