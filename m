Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 633E6DDF33
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 16:22:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n265M5Jg001162
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 22:22:05 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n265M4Hq022171
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 23:22:04 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Fri, 6 Mar 2009 13:22:03 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
In-Reply-To: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Ben Menchaca" <ben.menchaca@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP]
and PEX_RDMA_CTRL[SNOOP]?

What is the freq settings? CORE/CSB bus.

Thanks, Dave

________________________________

	From: linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Ben Menchaca
	Sent: Friday, March 06, 2009 12:33 PM
	To: linuxppc-dev@ozlabs.org
	Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
=09
=09
	I am working on a Freescale 8314e design, and the embedded
device is configured as a PCI-e endpoint running a 2.6.27-5 kernel.  For
context, we have written a kernel module which, among other things, uses
the RDMA/WDMA engine in the PCI-e IP block.  On the host side, these
DMAs are coherent.  However, on the embedded side, things are quite a
bit less rosy; we must manually flush/invalidate cache lines for
WDMA/RDMAs to occur successfully.  After speaking with (several) FAEs at
Freescale, we believe there is a configuration issue that is the cause,
but we have yet to have anyone successfully point to it. =20
=09
	Disabling the data cache altogether resolves the issue entirely,
but of course, also completely tanks performance.  As a temporary
workaround, I would like to simply mark the pages (obtained currently
via dma_alloc_coherent) involved as cache-inhibited.  I have attempted
to do this via some snippets remaining in fec.c (va_to_pte, uncache_pte
to set _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is
almost certainly braindead; va_to_pte is not a part of the 83xx source,
as far as I can tell; 8xx only.
=09
	A quick pointer in the correct direction for marking pages as
cache-inhibited on a 2.6.27-5 kernel would be appreciated, or if my
approach to a workaround is flawed, a pointer to the correct way would
be great.
=09
	Ben Menchaca
=09
