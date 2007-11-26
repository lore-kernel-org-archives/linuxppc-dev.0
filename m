Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D425BDDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:26:03 +1100 (EST)
Date: Mon, 26 Nov 2007 10:24:46 -0600
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
Message-ID: <20071126162446.GA4408@loki.buserror.net>
References: <4745BB5F.6060002@scram.de>
	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
	<20071123005121.4d38d877@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071123005121.4d38d877@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2007 at 12:51:21AM +0300, Vitaly Bordug wrote:
> Even that might be not enough - we may have simultaneous call of this func
> in non-smp case...

Do you really think that every piece of code that uses spinlocks in the
kernel is broken on non-SMP?

> I was thinking of some kind of refcount, so one that is going to issue CPM
> command, must do say pq_cpmp_get() and another driver won't be able to
> mangle with cpcr while it's not done with previous request.

How on earth are you going to effect mutual exclusion using reference
counting?

-Scott
