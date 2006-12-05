Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E124267B8B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 08:59:07 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1165263946.29784.13.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
	<1165060484.4380.18.camel@localhost.localdomain>
	<1165092773.22108.47.camel@localhost.localdomain>
	<1165239794.17906.14.camel@localhost.localdomain>
	<1165263946.29784.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 09:00:02 +1100
Message-Id: <1165356002.5469.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > If ppc_md.power_save is NULL, then the idle loop does not touch the flag
> > word of the idle thread, and everything works.
> 
> Good to know, there might be other cases of performance issues due to
> touching that flag in a loop...

More specifically... that means we have the same performance problem on
SMP PowerMacs (dual G4s & Xserve G4s)... on those machines, there's a
firmware property telling us not to use NAP mode and we do so by
clearing powersave_nap.

Paul, do you reckon the best solution here is to clear ppc_md.power_save
when detecting an SMP powermac ? (Or the flush-on-lock property)

Ben.
