Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F389ADDFDF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 05:03:50 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l8KJ3j5Y022310
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:03:45 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8KJ3i6l029872
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 14:03:45 -0500 (CDT)
Subject: Re: [PATCH] [POWERPC] Fix QEIC->MPIC cascading
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <46F2B8FD.7040501@freescale.com>
References: <20070920130244.GA18043@localhost.localdomain>
	<46F2A7CC.1040106@freescale.com>
	<20070920174159.GA10765@localhost.localdomain>
	<46F2B8FD.7040501@freescale.com>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 15:03:43 -0400
Message-Id: <1190315023.14673.9.camel@udp097531uds.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-09-20 at 13:16 -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > I don't know (didn't look) why this works for 83xx w/o ack()...
> > maybe IPIC don't need this. Or maybe there is a bug hiding.
> 
> Scott W told me that me that the IPIC doesn't have the concept of EOI ack.  It 
> just has IRQ masks.

That's true for IPIC, but MPIC has the concept of EOI ack - "An
interrupt is considered in-service from the time its vector is read
(through an IACK cycle) until the end of interrupt (EOI) register is
written. generating what the PIC considers an EOI signal."

On MPC8568, QEIC is a interrupt source of MPIC, so it must send a EOI
signal after the interrupt is served. otherwise, the QEIC interrupt is
always in-service.

Haiying
