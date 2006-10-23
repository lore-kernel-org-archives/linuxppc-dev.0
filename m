Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64C4C67BC5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 03:52:28 +1000 (EST)
In-Reply-To: <453CDD70.9010100@freescale.com>
References: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
	<17724.15919.790114.628418@cargo.ozlabs.ibm.com>
	<453CDD70.9010100@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E8190CD2-1898-473E-812A-AE2CBD85D73A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Mon, 23 Oct 2006 12:52:26 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2006, at 10:19 AM, Scott Wood wrote:

> Paul Mackerras wrote:
>> Hmmm.  In general a sync having completed doesn't mean that previous
>> MMIO stores have actually got to the device.  Reading from a device
>> register generally does ensure that previous writes have actually got
>> to the device though - could you do that instead?  I'm concerned that
>> adding the sync is not a robust fix and is possibly only working due
>> to fortuitous timing.
>
> Possibly -- but the only problem on the rare occasions where the  
> timing
> is not fortuitous is a spurious interrupt; the only reason the sync
> needs to be there at all is to avoid the overhead of the extra  
> interrupt
> (and to avoid user complaints that they're getting "BAD" interrupts).

Why wouldn't the read accomplish the same thing in a more robust way  
than the sync?

- k
