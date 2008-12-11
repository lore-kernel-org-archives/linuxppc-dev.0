Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75963DDFD2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 08:00:16 +1100 (EST)
Subject: Re: MPC5200 VIRQ question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49412AD4.1070403@mlbassoc.com>
References: <4937E048.90206@mlbassoc.com> <1228723422.7101.35.camel@pasglop>
	<49406730.8040609@mlbassoc.com> <1228960758.22413.134.camel@pasglop>
	<49412AD4.1070403@mlbassoc.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 08:00:09 +1100
Message-Id: <1229029209.22413.179.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-11 at 07:59 -0700, Gary Thomas wrote:
> 
> Notice that of_irq_map_one() can fail for a myriad of reasons - all quiet
> (without debugging on).  This function simply masks those into "sorry..."

Right, it's not verbose on failure for various reasons. Most failures
because something went wrong -before- the failure. IE. Your missing
interrupt parent would make it go to the parent etc... and it would fail
later on for a totally different reason than the original missing
interrupt parent.

Also, there's a number of older machines out there with crap
device-trees on which we know it will fail. The PCI code has a fallback
mechanism for them.

However, there's pretty extensive debug output that you can enable
explicitely in that file.

Cheers,
Ben.
