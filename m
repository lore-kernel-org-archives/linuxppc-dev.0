Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 197E6DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 03:54:08 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2NGs3LN004047
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 09:54:04 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2NGs31S025045
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 11:54:03 -0500 (CDT)
Date: Mon, 23 Mar 2009 11:54:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
Message-ID: <20090323165402.GC25217@ld0162-tx32.am.freescale.net>
References: <49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 22, 2009 at 10:45:23PM -0700, Li Yang-R58472 wrote:
> > I don't think so, in this case.  The user is not asking for 
> > "sleep" or deep sleep"; they are asking for a power state 
> > that meets the definition of "standby" (which sleep does) or 
> > which meets the definition of "mem" 
> > (which both sleep and deep sleep do).  When the user asks for 
> > "mem", we provide the lowest power mode that qualifies.
> 
> In my understanding, "mem" which is suspend-to-ram means all CPU states
> and registers are kept in memory and the CPU is completely off during
> suspension.  I don't think the sleep mode of 8349 qualifies, does it?

Is there a difference visible to software or to the user (other than not
achieving power savings that the board does not support)?  It seems
simpler for userspace to just specify the "heaviest" sleep state it wants
deal with (though some feedback to an administrator of what actually
happens would be nice).  

And if we want to be really pedantic, neither sleep nor deep sleep meet
the definitions for either "standby" or "mem", because they specify
acceptable latency ranges in seconds, and (in the absence of a disk) we
are much faster than that (it doesn't say "up to 1-2 seconds"). :-)

Are there any existing suspend drivers that suppord standby but not mem? 
I see omap1 as a counterexample that treats them both the same.

-Scott
