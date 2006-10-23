Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 04524679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 01:19:15 +1000 (EST)
Message-ID: <453CDD70.9010100@freescale.com>
Date: Mon, 23 Oct 2006 10:19:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
References: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
	<17724.15919.790114.628418@cargo.ozlabs.ibm.com>
In-Reply-To: <17724.15919.790114.628418@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Hmmm.  In general a sync having completed doesn't mean that previous
> MMIO stores have actually got to the device.  Reading from a device
> register generally does ensure that previous writes have actually got
> to the device though - could you do that instead?  I'm concerned that
> adding the sync is not a robust fix and is possibly only working due
> to fortuitous timing.

Possibly -- but the only problem on the rare occasions where the timing 
is not fortuitous is a spurious interrupt; the only reason the sync 
needs to be there at all is to avoid the overhead of the extra interrupt 
(and to avoid user complaints that they're getting "BAD" interrupts).

Note that many/most interrupt controller drivers don't even do that 
much; they just have more fortuitous timing than the QE (and/or the 
spurious interrupt is non-cascaded, and thus gets caught in 
handle_level_irq and doesn't increment the spurious interrupt count).

-Scott
