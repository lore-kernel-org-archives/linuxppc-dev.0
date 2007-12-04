Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AEDEDDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 18:52:19 +1100 (EST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1196746689.20158.4.camel@concordia>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196746689.20158.4.camel@concordia>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 18:51:57 +1100
Message-Id: <1196754717.13230.286.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>,
	Li Li <r64360@freescale.com>, Li Tony <Tony.Li@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not sure what you mean? For MSI there is only one MSI per device,
> but this code is used also for MSI-X which supports > 1 MSI per device.

Or more specifically, for MSI, -linux- supports only one per device (in
theory, it's possible to have multiple MSI non-X but it's a mess).

> Either way we shouldn't be incrementing hwirq by hand, it's reassigned
> at the top of the loop. I think that's left over from old code that
> allocated nvec hwirqs in a block and then created virq mappings for each
> one, whereas the new code allocates each hwirq separately.
> 
> cheers
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
