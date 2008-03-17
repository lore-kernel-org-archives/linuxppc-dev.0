Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9DFBDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 02:33:59 +1100 (EST)
Date: Mon, 17 Mar 2008 10:33:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Message-ID: <20080317153326.GA2644@loki.buserror.net>
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<20080307162135.GC10545@ld0162-tx32.am.freescale.net>
	<200803101317.04455.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803101317.04455.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 10, 2008 at 01:17:01PM +0100, Laurent Pinchart wrote:
> On Friday 07 March 2008 17:21, Scott Wood wrote:
> > cpm2_reset() doesn't currently actually reset the CPM, for some reason
> > (unlike cpm1).  This should probably be fixed, though then we'd have to
> > deal with assigning SMC parameter RAM addresses ourselves.
> 
> I had overlooked that. Resetting the CPM in cpm2_reset() helps. Is there any 
> reason not to rset the CPM in cpm2_reset() ?

The only issue I'm aware of other than the SMC parameter RAM relocation is
that the reset can't happen if the early udbg printk is being used.

> How should SMC parameter RAM assignment be handled ? I'm not very familiar 
> with the CPM1, 

CPM1 has hardcoded SMC parameter RAM addresses, so it's not relevant here.

> but for CPM2 the cpm_uart driver could easily cpm_dpalloc() parameter RAM.

It can, yes.  Patches welcome. :-)

-Scott
