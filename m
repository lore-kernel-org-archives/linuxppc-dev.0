Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 86EBD67BAD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 04:23:01 +1000 (EST)
Message-ID: <453D0881.500@freescale.com>
Date: Mon, 23 Oct 2006 13:22:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
References: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
	<17724.15919.790114.628418@cargo.ozlabs.ibm.com>
	<453CDD70.9010100@freescale.com>
	<E8190CD2-1898-473E-812A-AE2CBD85D73A@kernel.crashing.org>
In-Reply-To: <E8190CD2-1898-473E-812A-AE2CBD85D73A@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 23, 2006, at 10:19 AM, Scott Wood wrote:
>> Possibly -- but the only problem on the rare occasions where the  timing
>> is not fortuitous is a spurious interrupt; the only reason the sync
>> needs to be there at all is to avoid the overhead of the extra  interrupt
>> (and to avoid user complaints that they're getting "BAD" interrupts).
> 
> 
> Why wouldn't the read accomplish the same thing in a more robust way  
> than the sync?

It would.  However, it also adds a small amount of overhead to every QE 
interrupt, and the only thing that that overhead buys is avoiding 
possible but empirically very rare spurious interrupts; it'd cost more 
than simply accepting that a spurious interrupt might happen once in a 
great while.

Without any type of sync, spurious interrupts happen fairly regularly 
(about 5-10% of legitimate interrupts), so adding the sync should be a 
net gain over doing nothing.

If the consensus is that a read should be done anyway, I can resumbit 
the patch that way; I just think it's overkill given that a 100% 
guarantee isn't required for correctness.

-Scott
